import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:shared_storage/shared_storage.dart' as ss;
import 'package:permission_handler/permission_handler.dart';
import 'package:mime/mime.dart';
import '/F0_BASIC/common_import.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

//==============================================================================
// setting 관련 전역 함수(메소드)
//==============================================================================

//------------------------------------------------
// DB 파일 명
//------------------------------------------------
List<String> dBFileNameList = [
  'muscle.hive',
  'record.hive',
  'lazyrecord.hive',
  'lazymuscle.hive'
];

//------------------------------------------------------------------------------
// Db 파일을 선택한 폴더로 내보내기
//------------------------------------------------------------------------------
Future<void> exportDbAndPicture() async {
  dvSetting.exportProgressStatus.value = 0.0; // 진행상태 값 초기화

  // Android 11 이상일 경우, 저장할 디렉토리 선택 받기
  Uri? externalDirectoryUri;
  if (Platform.isAndroid && int.parse(gv.system.osVersion!) > 10) {
    externalDirectoryUri = await selectFileDirectory();

    //사용자로부터 입력받은 폴더가 없을 경우, 프로세스 종료
    if (externalDirectoryUri == null) {
      openSnackBarBasic('내보내기 실패', '선택된 저장 폴더가 없어 내보내기를 종료합니다.');
      return;
    }
  }

  // 내보내기를 진행하는 동안 progress indicator 팝업하여 진행상황 표시
  Get.dialog(
    AlertDialog(
      iconPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: const ProgressIndicatorDialog(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(asWidth(20)),
      ),
    ),
    barrierDismissible: false,
  );

  // Hive 가 db box 를 저장하는 디렉토리
  Directory dbDirectory = Platform.isIOS
      ? await getApplicationSupportDirectory()
      : await getApplicationDocumentsDirectory();
  List<File> exportingFiles = <File>[];

  List<String> dbFilePaths = List.generate(dBFileNameList.length,
      (index) => join(dbDirectory.path, dBFileNameList[index]));

  // 내보내려는 DB 파일이 모두 존재하는지 확인
  for (int index = 0; index < dbFilePaths.length; index++) {
    var result = await File(dbFilePaths[index]).exists();
  }

  // 내보내려는 사진이 모두 존재하는지 확인
  List<String> pictureFilePaths = <String>[];
  for (int index = 0; index < gv.dbMuscleIndexes.length; index++) {
    if (gv.dbMuscleIndexes[index].imageFileName != '') {
      String filePath =
          join(dbDirectory.path, gv.dbMuscleIndexes[index].imageFileName);
      if (File(filePath).existsSync()) {
        pictureFilePaths.add(filePath); // 존재하는 파일만 사진경로 리스트에 저장하여 압축 할 때 참고
      }
    }
  }

  dvSetting.exportProgressStatus.value = 0.05; // 진행상태 5%

  // DB 파일들을 하나의 압축 파일(Zip)로 압축
  ZipFileEncoder encoder = ZipFileEncoder();

  // dB 파일
  encoder.create(join(dbDirectory.path, 'dbFiles.zip'));
  for (int index = 0; index < dbFilePaths.length; index++) {
    encoder.addFile(File(dbFilePaths[index]));
  }

  // 사진 파일
  for (int index = 0; index < pictureFilePaths.length; index++) {
    encoder.addFile(File(pictureFilePaths[index]));
  }
  encoder.close(); // 압축 파일 만들기 종료

  //----------------------------------------------------------------------------
  // 모든 파일을 제대로 압축 하였는지 확인 (원본 파일 크기와 압축된 파일에 저장된 원본 파일 크기 정보를 비교하여 같으면 pass)
  File archiveFile = File(encoder.zipPath);
  var bytes = archiveFile.readAsBytesSync();
  var archive = ZipDecoder().decodeBytes(bytes);
  for (int index = 0; index < dBFileNameList.length; index++) {
    String dbFileName = dBFileNameList[index];
    var archivedFile = archive.findFile(dbFileName);
    if (archivedFile != null) {
      int tempFileSize = archivedFile.size;
      String dbFilePath = join(dbDirectory.path, dbFileName);
      int dbFileSize = File(dbFilePath).lengthSync();
      if (tempFileSize != dbFileSize) {
        openSnackBarBasic('내보내기 실패', '압축 파일에 문제가 있어 내보내기를 종료합니다.');
        return;
      }
    }
  }
  dvSetting.exportProgressStatus.value = 0.9; // 진행상태 90%

  // 생성한 압축 파일을 복사할 파일 리스트에 추가
  if (await File(encoder.zipPath).exists()) {
    exportingFiles.add(File(encoder.zipPath));
  }

  //파일명에 사용할 생성 날짜 및 시간
  String now = DateFormat('yyMMdd_HHmmss').format(DateTime.now());

  // DB 폴더 에있는 zip 파일을 사용자가 원하는 폴더 하위에 복사
  dvSetting.exportDbDirectoryString.value = await saveFileAtVisibleDirectory(
      newFileNames: ['backup_$now.zip'],
      files: exportingFiles,
      externalDirectoryUri: externalDirectoryUri);

  // DB 폴더에 있는 zip 파일 삭제
  for (File file in exportingFiles) {
    file.deleteSync();
  }

  // progress indicator 창 닫기
  await Future.delayed(const Duration(microseconds: 500));
  dvSetting.exportProgressStatus.value = 1;
  await Future.delayed(
      const Duration(microseconds: 500)); // 진행이 완료되고 약간의 delay를 추가.
  Get.back();

  // 스낵바로 프로세스 완료를 알림
  openSnackBarBasic(
      '내보내기 완료', '운동기록 파일 내보내기를 성공하였습니다.');
}

//------------------------------------------------------------
// 현재 설절된 근육의 통계 데이터로 Excel 파일을 생성하여 내보내는 메소드
//-------------------------------------------------------------
Future<void> exportExcel() async {
  // Android 11 이상일 경우, 저장할 디렉토리 선택 받기
  Uri? externalDirectoryUri;
  if (Platform.isAndroid && int.parse(gv.system.osVersion!) > 10) {
    externalDirectoryUri = await selectFileDirectory();

    //사용자로부터 입력받은 폴더가 없을 경우, 프로세스 종료
    if (externalDirectoryUri == null) {
      openSnackBarBasic('내보내기 실패', '선택된 폴더가 없어 내보내기를 종료합니다.');
      return;
    }
  }

  //현재 저장된 근육들에 대한 데이터를 하나씩 불러오기전, 기존에 설정된 근육 저장 (엑셀 출력작업이 끝나면 원래대로 되돌리기 위해)
  int originalIdxMuscle = gv.control.idxMuscle.value;

  // final permission = GetPlatform.isAndroid ? Permission.
  var dbDirectory = Platform.isIOS
      ? await getApplicationSupportDirectory()
      : await getApplicationDocumentsDirectory();
  String filePath = '${dbDirectory.path}/excelFile.xlsx';
  File excelFile;
  // 앱 임시 디렉토리에 같은 이름의 파일이 존재 할 경우, 덮어쓰고 없으면 생성
  // if (await File(filePath).exists()) {
  //   excelFile = File(filePath);
  //   // 파일이 이미 존재한다면 해당 파일에서 불러와서 excel 에 넣어야함
  // } else {

  // iOS 일 경우 applicationDocumentDirectory 로 받아온 경로가 유저들이 접근할 수 있는 경로라서 현재의 메소드가 끝날때 이 경로에 만들어놓은 excel 파일을
  // 삭제하지 않음. 따라서 '엑셀로 내보내기' 버튼을 클릭할 경우 이 경로에 엑셀 파일이 존재 한다면 지워줘야함.
  // if (gv.system.isIos == true) {
  //   if (await File(filePath).exists()) {
  //     File(filePath).deleteSync();
  //   }
  // }

  excelFile = await File(filePath).create();
  // }

  // 기존에 엑셀 파일이 있다면 불러와서 엑셀 파일에 로딩 해야, 데이터가 누적됨
  final Excel excel =
      Excel.createExcel(); // 디폴트로 1개의 빈 sheet 를 생성. sheet 명은 'Sheet1'
  CellStyle itemTitleStyle = CellStyle(
    bold: true,
    horizontalAlign: HorizontalAlign.Center,
    textWrapping: TextWrapping.WrapText,
    verticalAlign: VerticalAlign.Center,
    //backgroundColorHex: 'FF71fcd2',
  );
  CellStyle contentsStyle = CellStyle(
    bold: false,
    horizontalAlign: HorizontalAlign.Center,
    textWrapping: TextWrapping.WrapText,
    verticalAlign: VerticalAlign.Center,
    //backgroundColorHex: 'FF71fcd2',
  );

  //----------------------------------------------------------------------------
  // 근육수만큼 반복
  for (int sheetIndex = 0;
      sheetIndex < gv.dbmMuscle.numberOfData;
      sheetIndex++) {
    await gv.control.updateIdxMuscle(sheetIndex);
    final sheet = excel[gv.deviceData[0].muscleName
        .value]; // '근육명' sheet 가 생성됨. sheet1 뒤에 추가됨. 같은 이름의 sheet 해당 sheet 를 return
    // print(
    //     'df_setting :: exportExcelFile() : sheet(index=$sheetIndex)=${gv.deviceData[0].muscleName.value}');
    var sheetList = excel.tables.keys; // 현재 존재하는 table 명 가져오기 (table = sheet)
    if (sheetList.contains('Sheet1')) {
      excel.delete('Sheet1'); // sheet1 뿐일때는 삭제 안됨. 다른 sheet 가 1개 이상 있어야 삭제 됨
    }

    for (int index = 0; index < excelColumnItemText.length; index++) {
      // 엑셀 시트의 x축 항목 입력
      writeCell(
        sheet: sheet,
        columnIndex: index,
        rowIndex: 0,
        value: excelColumnItemText[index],
        cellStyle: itemTitleStyle,
      );
    }

    // 엑셀 시트에 일간 분석 data 입력
    for (int contentsIndex = 0;
        contentsIndex < gv.dbMuscleContents.dateStats.length;
        contentsIndex++) {
      for (int index = 0; index < excelColumnItemText.length; index++) {
        writeCell(
            sheet: sheet,
            columnIndex: index,
            rowIndex: contentsIndex + 1,
            value: getValue(index, contentsIndex),
            cellStyle: contentsStyle);
      }
    }
  }

  //Saving the file
  excelFile.writeAsBytesSync(excel.save()!, mode: FileMode.append);

  // 생성한 excel 파일을 공유가능한 외부 폴더에 저장
  dvSetting.exportExcelDirectoryString.value = await saveFileAtVisibleDirectory(
      newFileNames: ['statistics.xlsx'],
      files: [excelFile],
      externalDirectoryUri: externalDirectoryUri);

  await gv.control.updateIdxMuscle(originalIdxMuscle);

  // Download 폴더(iOS 는 Documents 폴더) 에 생성한 파일을 복사하였으므로 Application Documents 폴더(iOS 는 Application Support 폴더)의 파일은 삭제
  excelFile.deleteSync();

  openSnackBarBasic('내보내기 성공', '통계 자료를 엑셀 파일로 저장하였습니다.');
}

dynamic getValue(int index, int contentsIndex) {
  num result;
  switch (index) {
    case 0:
      result = gv.dbMuscleContents.dateStats[contentsIndex];
      break;
    case 1:
      result = gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 2:
      result = gv.dbMuscleContents.mvcMvMaxStats[contentsIndex];
      break;
    case 3:
      result = gv.dbMuscleContents.measuredMvcMvMaxStats[contentsIndex];
      break;
    case 4:
      result = gv.dbMuscleContents.measuredMvcMvAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 5:
      result = gv.dbMuscleContents.exerciseTimeAccStats[contentsIndex];
      break;
    case 6:
      result = gv.dbMuscleContents.aoeSetAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 7:
      result = gv.dbMuscleContents.aoeTargetAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 8:
      result = gv.dbMuscleContents.freqBeginAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 9:
      result = gv.dbMuscleContents.freqEndAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 10: // 주파수 차이

      result = (gv.dbMuscleContents.freqEndAccStats[contentsIndex] -
              gv.dbMuscleContents.freqBeginAccStats[contentsIndex]) /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 11:
      result = gv.dbMuscleContents.emgCountMaxStats[contentsIndex];
      break;
    case 12: // 근활성도 비율 (최대,횟수)
      result = gv.dbMuscleContents.emgCountMaxStats[contentsIndex] /
          gv.dbMuscleContents.mvcMvMaxStats[contentsIndex] *
          100;
      break;
    case 13:
      result = gv.dbMuscleContents.emgCountAvAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 14: // 근활성도 비율 (평균,횟수)
      result = gv.dbMuscleContents.emgCountAvAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex] /
          gv.dbMuscleContents.mvcMvMaxStats[contentsIndex] *
          100;
      break;
    case 15:
      result = gv.dbMuscleContents.emgTimeMaxStats[contentsIndex];
      break;
    case 16: // 근활성도 비율 (최대,시간)
      result = gv.dbMuscleContents.emgTimeMaxStats[contentsIndex] /
          gv.dbMuscleContents.mvcMvMaxStats[contentsIndex] *
          100;
      break;
    case 17:
      result = gv.dbMuscleContents.emgTimeAvAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 18: // 근활성도 비율 (평균,시간)
      result = gv.dbMuscleContents.emgTimeAvAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex] /
          gv.dbMuscleContents.mvcMvMaxStats[contentsIndex] *
          100;
      break;
    case 19:
      result = gv.dbMuscleContents.repetitionAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    case 20:
      result = gv.dbMuscleContents.repetitionTargetAccStats[contentsIndex] /
          gv.dbMuscleContents.recordNumStats[contentsIndex];
      break;
    default:
      result = -1;
      if (kDebugMode) {
        print('df_setting :: non available Switch statement argument : $index');
      }
      break;
  }
  return result;
}

//-------------------------------------------------------------------------
// Excel sheet 를 구성하는 cell 의 입력값과 styling 하는 method
//-------------------------------------------------------------------------
void writeCell(
    {required Sheet sheet,
    required int columnIndex,
    required int rowIndex,
    required dynamic value,
    CellStyle? cellStyle}) {
  sheet
      .cell(CellIndex.indexByColumnRow(
          columnIndex: columnIndex, rowIndex: rowIndex))
      .value = value;
  sheet
      .cell(CellIndex.indexByColumnRow(
          columnIndex: columnIndex, rowIndex: rowIndex))
      .cellStyle = cellStyle;
}

//-------------------------------------------------------------------------
// root directory 를 return 하는 메소드
//-------------------------------------------------------------------------
Directory findRoot(FileSystemEntity entity) {
  final Directory parent = entity.parent;
  // android Mobile device 일 경우에만 해당
  if (Platform.isAndroid) {
    if (parent.path == '/storage/emulated') return Directory(entity.path);
    return findRoot(parent);
  } else {
    return Directory(entity.path);
  }
}

//------------------------------------------------------------------------------
// 안드로이드 11 이상에서는 앱 폴더 밖의 디렉토리에 파일을 write 하려면 사용자의 permission 을 받아야함
//------------------------------------------------------------------------------
Future<Uri?> selectFileDirectory() async {
  Uri? externalDirectoryUri;
  var uriList = await ss.persistedUriPermissions();
  if (uriList!.isNotEmpty) {
    // print(
    //     'df_measure :: selectFileDirectory :: 이전에 선택한 폴더가 있음(${uriList[0].uri.path.split('%3A').last.replaceAll('%2F', '/')})');
    Uri lastUri = uriList[0].uri;
    bool? canWrite = await ss.canWrite(lastUri);
    if (canWrite != null) {
      if (canWrite == true) {
        // print(
        //     'df_measure :: selectFileDirectory :: 해당 폴더의 write 권한이 아직 유효하므로 Uri 를 사용합니다.');
        return lastUri;
      }
    }
    // print(
    //     'df_measure :: selectFileDirectory :: 해당 폴더에 write 권한이 없으므로 새로운 디렉토리를 선택해야합니다.');
    externalDirectoryUri = await ss.openDocumentTree(
      initialUri: Uri(
          scheme: 'content',
          host: 'com.android.externalstorage.documents',
          path: lastUri.path),
    );
  } else {
    externalDirectoryUri = await ss.openDocumentTree(
      initialUri: Uri(
          scheme: 'content',
          host: 'com.android.externalstorage.documents',
          path: '/tree/primary%3ADownload'),
    );
  }
  return externalDirectoryUri;
}

// //-------------------------------------------------------------------------
// // Download 폴더 하위 디렉토리에 파일이 저장하고 스낵바로 알리는 메소드
// //-------------------------------------------------------------------------
Future<String> saveFileAtVisibleDirectory(
    {required List<String> newFileNames,
    required List<File> files,
    Uri? externalDirectoryUri}) async {
  List<String> fileNames = newFileNames;
  PermissionStatus status;

  if (Platform.isAndroid) {
    // 안드로이드 버전9 일경우
    // 안드로이드 버전 10인 기기에서 기존 코드로 내보내기가 동작하지 않는다고해서 버전 10 이하는 아래 if 문으로 들어가도록 수정
    if (int.parse(gv.system.osVersion!) <= 10) {
      Directory targetDirectory; // 파일을 저장할 디렉토리를 저장하기 위한 변수
      Directory? externalDirectory = await getExternalStorageDirectory();
      if (externalDirectory == null) {
        return '';
      }

      await Permission.storage.request(); // android 버전 9
      status = await Permission.storage.status;
      if (status.isGranted) {
        Directory rootDirectory = findRoot(externalDirectory);
        targetDirectory =
            await Directory('${rootDirectory.path}/Download/Fitsig_golf')
                .create(recursive: true);

        for (int fileCount = 0; fileCount < files.length; fileCount++) {
          files[fileCount].copySync(
              '${targetDirectory.path}/${fileNames[fileCount]}'); // 해당 디렉토리에 같은 이름의 파일이 있을 경우, 덮어 쓰기됨
          // dvSetting.permittedExternalPath.value =
          //     targetDirectory.path; // 파일을 저장한 위치를 저장
        }
        return targetDirectory.path; // 파일을 저장한 경로
      }
      return '';
    }

    // 안드로이드 버전11 이상 일 경우
    else {
      if (externalDirectoryUri == null) {
        return '';
      }

      //----------------------------------------------------
      // 저장할 디렉토리에 저장하려는 파일명과 같은 파일이 있는지 확인, 존재하면 삭제
      for (int fileCount = 0; fileCount < files.length; fileCount++) {
        try {
          final existingFile =
              await ss.findFile(externalDirectoryUri, fileNames[fileCount]);
          if (existingFile != null && existingFile.isFile!) {
            debugPrint("Found existing file ${existingFile.uri}");
            await ss.delete(existingFile.uri);
          }
          String fileMimeType = lookupMimeType(files[fileCount].path) ??
              'application/octet-stream';
          await ss.createFileAsBytes(
            externalDirectoryUri,
            mimeType: fileMimeType,
            bytes: Uint8List.fromList(files[fileCount].readAsBytesSync()),
            displayName: fileNames[fileCount],
          );
        } catch (e) {
          debugPrint("Exception while create new file: ${e.toString()}");
        }
      }
      return externalDirectoryUri.path.split('%3A').last.replaceAll('%2F', '/');
    }
  } else if (Platform.isIOS) {
    Directory externalDirectory = await getApplicationDocumentsDirectory();
    File? result;
    if (!externalDirectory.existsSync()) {
      print(
          'df_setting :: saveFileAtVisibleDirectory :  ${externalDirectory.path} 경로가 존재하지 않음');
    }
    for (int fileCount = 0; fileCount < files.length; fileCount++) {
      result = files[fileCount].copySync(
          '${externalDirectory.path}/${fileNames[fileCount]}'); // 해당 디렉토리에 같은 이름의 파일이 있을 경우, 덮어 쓰기됨
    }
    if (result != null) {
      print(
          'df_setting :: saveFileAtVisibleDirectory :  ${externalDirectory.path} 경로에 파일 생성 완료');
    } else {
      print(
          'df_setting :: saveFileAtVisibleDirectory :  ${externalDirectory.path} 경로에 파일 생성을 실패');
    }
    return externalDirectory.path;
  } else {
    return '';
  }
}


// //-------------------------------------------------------------------------
// // Download 폴더 하위 디렉토리에 파일에 파일 삭제
// //-------------------------------------------------------------------------
Future<void> deleteFileAtVisibleDirectory(
    {required List<String> newFileNames,
      Uri? externalDirectoryUri}) async {
  List<String> fileNames = newFileNames;
  PermissionStatus status;

  if (Platform.isAndroid) {
    // 안드로이드 버전9 일경우
    // 안드로이드 버전 10인 기기에서 기존 코드로 내보내기가 동작하지 않는다고해서 버전 10 이하는 아래 if 문으로 들어가도록 수정
    if (int.parse(gv.system.osVersion!) <= 10) {
      Directory targetDirectory; // 파일을 저장할 디렉토리를 저장하기 위한 변수
      Directory? externalDirectory = await getExternalStorageDirectory();
      if (externalDirectory == null) {
        return;
      }
      await Permission.storage.request(); // android 버전 9
      status = await Permission.storage.status;
      if (status.isGranted) {
        Directory rootDirectory = findRoot(externalDirectory);
        targetDirectory =
        await Directory('${rootDirectory.path}/Download/Fitsig_golf')
            .create(recursive: true);
        for (int fileCount = 0; fileCount < fileNames.length; fileCount++) {
          String filePath = join(targetDirectory.path, fileNames[fileCount]);
          if(File(filePath).existsSync()){
            File(filePath).deleteSync();
          }
        }
      }
    }

    // 안드로이드 버전11 이상 일 경우
    else {
      if (externalDirectoryUri == null) {
        return ;
      }
      //----------------------------------------------------
      // 저장할 디렉토리에 저장하려는 파일명과 같은 파일이 있는지 확인, 존재하면 삭제
      for (int fileCount = 0; fileCount < fileNames.length; fileCount++) {
        try {
          final existingFile =
          await ss.findFile(externalDirectoryUri, fileNames[fileCount]);
          if (existingFile != null && existingFile.isFile!) {
            await ss.delete(existingFile.uri);
          }
        } catch (e) {
          debugPrint("Exception while create new file: ${e.toString()}");
        }
      }
      return;
    }
  } else if (Platform.isIOS) {
    Directory externalDirectory = await getApplicationDocumentsDirectory();
    if (!externalDirectory.existsSync()) {
      print(
          'df_setting :: deleteFileAtVisibleDirectory :  ${externalDirectory.path} 경로가 존재하지 않음');
    }
    for (int fileCount = 0; fileCount < fileNames.length; fileCount++) {
      String filePath = join(externalDirectory.path, fileNames[fileCount]);
      if(File(filePath).existsSync()){
        File(filePath).deleteSync();
      }
    }
  }
}


//-------------------------------------------------------------------------
// Download 폴더 하위 디렉토리에 파일이 저장하고 스낵바로 알리는 메소드
//-------------------------------------------------------------------------
Future<void> importDbAndPicture() async {
  //----------------------------------------------------------------------------
  // file picker 를 이용해서 특정 파일을 선택하는 방법
  //----------------------------------------------------------------------------
  await FilePicker.platform
      .clearTemporaryFiles(); // cache 정리 안하면, 같은 이름의 파일을 선택했을 때 기존의 것을 유지하는 문제 있음
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, allowedExtensions: ['zip'], withData: true);

  if (result != null && result.files.isNotEmpty) {
    PlatformFile file = result.files.single;

    // 앱 DB 경로 받아오기
    Directory dbDirectory = Platform.isIOS
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();

    // 앱 DB 디렉토리에 복사(생성하여 내용쓰기)
    File newDBArchive = File(join(dbDirectory.path, file.name));
    Uint8List? contents = file.bytes;

    // 압축 파일에 내용이 없을 경우 프로세스 종료
    if (contents == null) {
      openSnackBarBasic('불러오기 실패', '선택한 파일이 비어있어 불러오기를 종료합니다.');
      return;
    }
    // 앱 내부 폴더에 생성한 파일에, 선택한 (zip)파일의 내용을 복사
    newDBArchive.writeAsBytesSync(contents);

    // zip 파일을 내용을 보기 위해 decode
    var bytes = newDBArchive.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);

    // dBFileNameList 에 명시된 파일들이 zip 파일에 있는지, 용량이 0 인지 체크
    for (int index = 0; index < dBFileNameList.length; index++) {
      String dbFileName = dBFileNameList[index];
      var archivedFile = archive.findFile(dbFileName);
      print('df_setting :: importDbAndPicture :: ${archivedFile!.name}= ${archivedFile.size}');
      if (archivedFile == null) {
        openSnackBarBasic(
            '불러오기 실패', '압축 파일에 $dbFileName 이 존재하지 않아 불러오기를 종료합니다.');
        return;
      } else if (archivedFile.size == 0) {
        openSnackBarBasic('불러오기 실패', '압축 파일에 $dbFileName 의 데이터가 없어 불러오기를 종료합니다.');
        return;
      }
    }

    // 압축을 푼 파일들의 용량 총합을 저장하기 위한 변수
    int unZippedFileSizeSum = 0;

    // 압축 파일의 용량을 저장하는 변수
    int archiveFileSize = 0;

    // zip 에  db 파일이 모두 존재함을 확인 했으므로, 기존의 db 파일 삭제 및 box close
    await gv.dbmMuscle.closeAndDeleteBox();
    await gv.dbmRecord.closeAndDeleteBox();

    for (var file in archive) {
      var fileName = '${dbDirectory.path}/${file.name}';
      if (file.isFile && !fileName.contains("__MACOSX")) {
        File outFile = File(fileName);
        //print('File:: ' + outFile.path);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
        unZippedFileSizeSum = unZippedFileSizeSum + outFile.lengthSync();
      }
    }
    archiveFileSize = newDBArchive.lengthSync(); // 압축 해제한 파일의 크기

    // DB 압축 파일의 해제가 끝나면, 압축 파일 삭제
    newDBArchive.deleteSync();

    // Hive db 파일이 교체되었으므로 초기화 및 변수 갱신
    await dbInitMuscle(); // HiveDB 근육 data 초기화(box 들 다시 오픈)
    await dbInitRecord(); // HiveDB 측정 data 초기화(box 들 다시 오픈)

    await gv.control.updateIdxMuscle(gv.control.idxMuscle.value); //관련 종속변수 갱신
    await gv.control.updateIdxRecord(gv.control.idxRecord.value); //관련 종속변수 갱신

    // Muscle 데이터가 변경되었으므로, 통계 그래프 그리는데 사용되는 값들을 갱신
    gvRecord.init();
    if (archiveFileSize < unZippedFileSizeSum) {
      openSnackBarBasic('불러오기 완료', '운동 기록 불러오기를 완료하였습니다.');
    }
  } else {
    openSnackBarBasic('불러오기 실패', '선택한 운동 기록 파일이 없어 불러오기를 종료합니다');
    return;
  }

  // //----------------------------------------------------------------------------
  // // shared storage 를 이용한 방법
  // //----------------------------------------------------------------------------
  // // 백업 파일이 있는 폴더를 선택하게 하기
  // var dbBackupFileUri = await ss.openDocumentTree();
  //
  // // DB 백업 파일이 있는 폴더의 입력이 없을 경우 종료
  // if (dbBackupFileUri == null) {
  //   return;
  // }
  //
  // // 선택한 폴더에 DB 압축 파일이 있는지 확인
  // DocumentFile? dbArchiveFile = await ss.findFile(dbBackupFileUri,'dbFiles.zip');
  // if (dbArchiveFile == null) {
  //   return ;
  // }
  //
  // // 기존의 hive db 파일 삭제 및 box close
  // await gv.dbmMuscle.closeAndDeleteBox();
  // await gv.dbmRecord.closeAndDeleteBox();
  //
  // // 앱 DB 디렉토리 받아오기
  // Directory dbDirectory = await getApplicationDocumentsDirectory();
  //
  // // DB 가져오기를 위해 필요한 파일을 앱 DB 디렉토리에 복사
  // // for (int index = 0; index < dBFileNameList.length; index++) {
  //   if (dbArchiveFile.isFile!) {
  //     // db 파일의 내용을 memory 를 읽어 들임
  //     Uint8List? documentContent =
  //         await ss.getDocumentContent(dbArchiveFile.uri);
  //
  //     // db 파일 내용이 null 이 아닐 경우, 앱 DB 디렉토리에 복사(생성하여 내용쓰기)
  //     if (documentContent != null) {
  //       File newDBArchive =
  //           File(join(dbDirectory.path, dbArchiveFile.name));
  //       newDBArchive.writeAsBytesSync(documentContent);
  //       var bytes = newDBArchive.readAsBytesSync();
  //       var archive = ZipDecoder().decodeBytes(bytes);
  //       for(var file in archive){
  //         var fileName = '${dbDirectory.path}/${file.name}';
  //         print("upZipped fileName=$fileName");
  //         if (file.isFile && !fileName.contains("__MACOSX")) {
  //           var outFile = File(fileName);
  //           //print('File:: ' + outFile.path);
  //           outFile = await outFile.create(recursive: true);
  //           await outFile.writeAsBytes(file.content);
  //         }
  //       }
  //       // DB 압축 파일의 해제가 끝나면, 압축 파일 삭제
  //       newDBArchive.deleteSync();
  //     }
  //   }
  // // }
  //
  // // Hive db 파일이 교체되었으므로 초기화 및 변수 갱신
  // await dbInitMuscle(); // HiveDB 근육 data 초기화(box 들 다시 오픈)
  // await dbInitRecord(); // HiveDB 측정 data 초기화(box 들 다시 오픈)
  //
  // await gv.control.updateIdxMuscle(gv.control.idxMuscle.value); //관련 종속변수 갱신
  // await gv.control.updateIdxRecord(gv.control.idxRecord.value); //관련 종속변수 갱신
  //
  // // Muscle 데이터가 변경되었으므로, 통계 그래프 그리는데 사용되는 값들을 갱신
  // gvRecord.init();
}

// Firmware update 버튼을 눌렀을 때 실행 되는 메소드
Future<void> updateFirmware() async {
  int d = 0;
  //--------------------------------------------
  // OTA 파일 선택 방법 1 - 직접 OTS 파일 선택 (FilePicker 패키지 사용)
  //--------------------------------------------

  // FilePickerResult? selectedFile = await FilePicker.platform.pickFiles();
  // otaFilePath = selectedFile!.files.single.path!;
  // if (selectedFile != null) {
  //   await gv.bleManager[0].device1?.openOTAFile(otaFilePath);
  // }

  //--------------------------------------------
  // OTA 파일 선택 방법 2 - assets/firmware/ 폴더에 있는 파일 선택 (FilePicker 패키지 사용)
  // todo : 장비별로 실행하지 않고 독립적으로 1회 실행하도록 변경
  //--------------------------------------------
  // if (dvSetting.firmwareFilePath.isNotEmpty) {
  //   await bt[d].openOTAFile(dvSetting.firmwareFilePath);
  // } else {
  //   return;
  // }

  // device 의 현재 battery 값
  int batteryValue = gv.deviceStatus[0].batteryCapacity.value;

  // device 의 FW version 은 4 bytes 이며 첫번째 byte 에 hex 값으로 01 이 왜 들어가는데 이유를 아직 모름,
  // OTA file version 의 buildVersion (3 bytes)와 형식부터 다름. 두 값의 하위 2 byte 만 뽑아서 사용
  String fwVersionMask = '0000ffff';
  int fwVersionMaskAsInt = int.parse(fwVersionMask, radix: 16);

  // 현재 장치의 firmware 버전
  // int deviceFwVersion = fitsigDeviceAck[0].qnFwVersion & fwVersionMaskAsInt;
  int deviceFwVersion = BleManager.fitsigDeviceAck[d].qnFwVersion;
  int deviceHwVersion = BleManager.fitsigDeviceAck[d].hwVersion;

  // 선택한 OTA 파일에 있는 firmware 버전과 hardware 버전
  int otaFileFwVersion =
      bleCommonData.otaFileVersion!.buildVersion & fwVersionMaskAsInt;
  int otaFileHwVersion = bleCommonData.otaFileVersion!.hardwareVersion;

  print(
      'df_setting.dart :: device FW version : ${deviceFwVersion.toRadixString(16)},  device HW version : ${deviceHwVersion.toRadixString(16)}');
  print(
      'df_setting.dart :: ota FW version : ${otaFileFwVersion.toRadixString(16)},  ota HW version : ${otaFileHwVersion.toRadixString(16)}');

  // ------ 여기서 부터 끝까지 주석처리 ----
  //-----------------------------------------------------------------------------
  // Firmware 업데이트를 위한 조건
  // 1. usb(충전)에 연결되어 있거나, 베터리 용량이 5 보다 커야함
  // 2. 장치의 qnFwVersion 버전보다 ota file 의  build 버전이 커야함  (fitsigDeviceAck.qnFwVersion = OtaFileVersion.buildVersion = 펌웨어 버전을 의미)
  // 3. [현재는 무시] 장치의 하드웨어 버전보다 ota file 의 hardware 버전이 같거나 커야함 ( Todo: hardware version? )
  //     - device 의 hardware version 은 000100 (3 bytes) 로 예상대로 나오는데
  //     - OTA file version 의 hardwareVersion 이 010023 으로 나와서 원인 분석 전까지 하드웨어 버전 조건은 생략
  //-----------------------------------------------------------------------------
  // bool isOtaUpdatable = (batteryValue >= 5) &&
  //     (otaFileFwVersion > deviceFwVersion) &&
  //     (otaFileHwVersion >= deviceHwVersion);
  bool isOtaUpdatable = true;

  if (isOtaUpdatable) {
    // update 중으로 상태를 변경
    // print('df_setting.dart :: updateFirmware() : 현재 firmwareStatus=${dvSetting.firmwareStatus.value}');
    dvSetting.firmwareStatus.value = EmaFirmwareStatus.isUpdating;

    // firmware update 시작
    bt[d].otaUpdate();
  }
}

// Firmware update 중 닫기 버튼을 눌렀을 때, 또는 업데이트 진행 중 팝업을 닫았을 때 실행 되는 메소드
Future<void> stopUpdatingFirmware() async {
  int d = 0;
  // firmware update 종료
  bt[d].stopOta(firstCmdData: gv.deviceControl[d].getControlPacketData());
  // stopOta( ) 메소드에서 실행해는 notification 등록 후, 실제 data 가 오기까지 시간차가 있어서 guard time 으로 2초 delay
  await Future.delayed(const Duration(milliseconds: 4000));
  // gv.deviceStatus[d].initMeasureData(); //
  dvSetting.firmwareStatus.value = EmaFirmwareStatus.needUpdate;
}

//
// //------------------------------------------------
// // DB 데이터를 json 파일로 생성하여 내보내는 메소드
// //------------------------------------------------
// Future<void> exportJsonFile() async {
//   Directory dir = await getApplicationDocumentsDirectory();
//   String filePath;
//   File file;
//   RandomAccessFile randomAccessFile;
//   int position;
//
//   int recordDBLength = gv.dbmRecord.numberOfData; // 레코드 수
//   int muscleDBLength = gv.dbmMuscle.numberOfData; // 근육 수
//   if (kDebugMode) {
//     print('df_setting.dart :: 현재 저장되어있는 근육수: $muscleDBLength');
//   }
//
//   //-----------------------
//   //--------- 1. 사용자 정보
//
//   //-----------------------------
//   //--------- 2. db_record_index
//   filePath = '${dir.path}/dbBackup_record_index.json';
//   if (await File(filePath).exists()) {
//     file = File(filePath);
//   } else {
//     file = await File(filePath).create();
//   }
//   List<Map<String, dynamic>> recordIndexData =
//       gv.dbmRecord.indexData; // Map 형식으로 return 됨
//   String jsonRecordIndexData =
//       jsonEncode(recordIndexData); // Map 을 Json 형식으로 변환
//   file.writeAsStringSync(jsonRecordIndexData + '\n',
//       mode: FileMode.write); // Json 형식으로 변환한 String 을 파일에 쓰기
//   await createFileAtDownload(
//       newFileNames: ['record_index.json'], files: [file]); // Download 폴더에 파일 저장
//
//   //-------------------------------
//   //--------- 3. db_record_contents
//   filePath = '${dir.path}/dbBackup_record_contents.json';
//   // 어플리케이션의 임시 디렉토리에 같은 이름의 파일이 존재 할 경우, 덮어쓰고 없으면 생성
//   if (await File(filePath).exists()) {
//     file = File(filePath);
//   } else {
//     file = await File(filePath).create();
//   }
//   // 근육 data 를 하나씩 불러와서 파일에 입력하기 때문에 사전에 이 데이터가 리스트라는 것을 json 파일에 표시하기 위해
//   // '['를 처음에 입력하고  마지막에 ']'를 입력
//   file.writeAsStringSync('[\n',
//       mode: FileMode.write); // Json 형식으로 변환한 String 을 파일에 쓰기
//   for (int index = 0; index < recordDBLength; index++) {
//     // Lazy 박스에서는 하나씩 불러 올 수 있으므로, db 에 저장되어있는  근육 수 만큼 반복
//     Map<String, dynamic> recordContentsData =
//         await gv.dbmRecord.readDataContents(index: index); // Map 형식으로 return 됨
//     //가져온 muscle contents 를 Json 형식의 String 으로 파일에 이어쓰기
//     String jsonRecordContentsData =
//         jsonEncode(recordContentsData); // Map 을 Json 형식으로 변환
//     file.writeAsStringSync(jsonRecordContentsData + ',\n',
//         mode: FileMode.append); // Json 형식으로 변환한 String 을 파일에 쓰기
//   }
//   randomAccessFile = file.openSync(mode: FileMode.append);
//   position = randomAccessFile.positionSync();
//   randomAccessFile.setPositionSync(position - 2);
//   randomAccessFile.writeStringSync('\n]'); // 마지막 콤마(,) 삭제하고 다음 라인에 ']'입력
//   randomAccessFile.closeSync();
//   await createFileAtDownload(
//       newFileNames: ['record_contents.json'], files: [file]);
//
//   //-----------------------------
//   //--------- 4. db_muscle_index
//   filePath = '${dir.path}/dbBackup_muscle_index.json';
//   // 어플리케이션의 임시 디렉토리에 같은 이름의 파일이 존재 할 경우, 덮어쓰고 없으면 생성
//   if (await File(filePath).exists()) {
//     file = File(filePath);
//     // 파일이 이미 존재한다면 해당 파일을 사용
//   } else {
//     file = await File(filePath).create();
//   }
//
//   // muscle index list 는 메모리에 load 되어 있으므로  바로 사용 가능
//   List<Map<String, dynamic>> muscleIndexData =
//       gv.dbmMuscle.indexData; // Map 형식으로 return 됨
//   //가져온 값을 파일에 이어쓰기
//   String jsonMuscleIndexData =
//       jsonEncode(muscleIndexData); // Map 을 Json 형식으로 변환
//   file.writeAsStringSync(jsonMuscleIndexData + '\n',
//       mode: FileMode.write); // Json 형식으로 변환한 String 을 파일에 쓰기
//   await createFileAtDownload(
//       newFileNames: ['muscle_index.json'], files: [file]); // Download 폴더에 파일 저장
//
//   //---------------------------------
//   //--------- 5. db_muscle_contents
//   filePath = '${dir.path}/dbBackup_muscle_contents.json';
//   // 어플리케이션의 임시 디렉토리에 같은 이름의 파일이 존재 할 경우, 덮어쓰고 없으면 생성
//   if (await File(filePath).exists()) {
//     file = File(filePath);
//   } else {
//     file = await File(filePath).create();
//   }
//   // 근육 data 를 하나씩 불러와서 파일에 입력하기 때문에 사전에 이 데이터가 리스트라는 것을 json 파일에 표시하기 위해
//   // '['를 처음에 입력하고  마지막에 ']'를 입력
//   file.writeAsStringSync('[\n',
//       mode: FileMode.write); // Json 형식으로 변환한 String 을 파일에 쓰기
//   for (int index = 0; index < muscleDBLength; index++) {
//     // Lazy 박스에서는 하나씩 불러 올 수 있으므로, db 에 저장되어있는  근육 수 만큼 반복
//     Map<String, dynamic> muscleContentsData =
//         await gv.dbmMuscle.readDataContents(index: index); // Map 형식으로 return 됨
//     //가져온 muscle contents 를 Json 형식의 String 으로 파일에 이어쓰기
//     String jsonMuscleContentsData =
//         jsonEncode(muscleContentsData); // Map 을 Json 형식으로 변환
//     file.writeAsStringSync(jsonMuscleContentsData + ',\n',
//         mode: FileMode.append); // Json 형식으로 변환한 String 을 파일에 쓰기
//   }
//
//   randomAccessFile = file.openSync(mode: FileMode.append);
//   position = randomAccessFile
//       .positionSync(); //open 한 파일의 현재 cursor(?) 위치. 처음에는 파일 내용의 끝부분을 가리킴.
//   randomAccessFile.setPositionSync(position - 2);
//   randomAccessFile.writeStringSync('\n]'); // 마지막 콤마(,) 삭제
//   randomAccessFile.closeSync();
//   await createFileAtDownload(
//       newFileNames: ['muscle_contents.json'], files: [file]);
// }
