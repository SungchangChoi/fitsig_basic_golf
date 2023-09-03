import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

//==============================================================================
// GvControl
//==============================================================================
class GvControl {
  int d = 0; //device index
  //----------------------------------------------------------------------------
  // 초기화 상태 관리
  //----------------------------------------------------------------------------
  bool flagAppInitComplete = false;

  //----------------------------------------------------------------------------
  // 화면 갱신
  //----------------------------------------------------------------------------
  RxInt refreshPageWhenSettingChange = 0.obs; //설정 변경 시 화면 갱신

  //----------------------------------------------------------------------------
  // 측정 제어
  //----------------------------------------------------------------------------
  // Rx<EmlStateMeasure> stateMeasure = EmlStateMeasure.idle.obs;
  // RxInt measureTime = 0.obs;

  //----------------------------------------------------------------------------
  // 근육 class 데이터 제어
  //----------------------------------------------------------------------------
  RxInt idxMuscle = 0.obs; //선택 된 근육 index
  RxInt numOfRecordPresentMuscle = 0.obs; //현재 선택된 근육관련 레코드 수
  double greatestEverMvcMv = 0.0; // 현재 선택된 근육의 역대 최대 1RM

  Future updateIdxMuscle(int value) async {
    // 근육 수 보다는 작아야 함
    int index = value;
    index = min(gv.dbmMuscle.numberOfData - 1, index);
    // 0 보다는 커야 함
    index = max(index, 0);
    // print('GvControl :: updateIdxMuscle :: newIndex=$value');
    // 변경 후에는 dbMap 데이터를 class 데이터로 변환
    // gv.dbMuscleIndexes[idxMuscle.value].mapToClassData();
    //--------------------------------------------------------------------------
    // map data 특정 index 를 class data 로 전환
    // 초기에는 모두 불러서 저장. dB가 새로 추가된 경우 필요한 기능
    // dB가 추가되지 않은 경우 불필요 할 수도... (향후 시간나면 재 체크 필요)
    // 신규 데이터 저장 단계에서 class 데이터에는 저장되지 않았을 수 있음
    idxMuscle.value = index;
    indexMapToMuscleIndexObject(idxMuscle.value);
    //--------------------------------------------------------------------------
    // 변경된 index 정보에 따라 상세 DB 읽어 온 후 class 데이터로 변환하기
    await gv.dbmMuscle.readDataContents(index: idxMuscle.value);
    contentsMapToMuscleContentsObject();
    //--------------------------------------------------------------------------
    // 공유 메모리에 index 기록
    gv.spMemory.write('idxMuscle.value', idxMuscle.value);
    //--------------------------------------------------------------------------
    // 각 근육 관련 종속변수 갱신
    // 근육 부위와 좌우 추가 (230306)
    gv.deviceData[d].muscleName.value = gv.dbMuscleIndexes[index].muscleName;
    gv.deviceData[d].muscleTypeIndex.value =
        gv.dbMuscleIndexes[index].muscleTypeIndex;
    gv.deviceData[d].isLeft.value = gv.dbMuscleIndexes[index].isLeft;
    dvSetting.isViewLeft = gv.deviceData[d].isLeft.value;
    gv.deviceData[d].targetPrm.value = gv.dbMuscleIndexes[index].targetPrm;
    gv.deviceData[d].targetCount.value = gv.dbMuscleIndexes[index].targetCount;

    // 근육 사진 파일명 추가(230315)
    String tempPath = gv.dbMuscleIndexes[index].imageFileName;
    // print('GvControl :: updateIdxMuscle :: tempPath=$tempPath');
    if (tempPath != '') {
      gv.deviceData[d].imagePath.value =
          await getImagePath(gv.dbMuscleIndexes[index].imageFileName);
      gv.deviceData[d].imageBytes =
          File(gv.deviceData[d].imagePath.value).readAsBytesSync();
    } else {
      gv.deviceData[d].imagePath.value = '';
      gv.deviceData[d].imageBytes = null as Uint8List?;
    }
    // print(
    //     'GvControl :: updateIdxMuscle :: Index[$value] 근육의 이미지 경로=${gv.deviceData[d].imagePath.value}');

    gv.deviceData[d].mvc.value = gv.dbMuscleIndexes[index].mvcMv;
    gv.deviceData[d].muscleTypeIndex.value =
        gv.dbMuscleIndexes[index].muscleTypeIndex;
    //--------------------------------------------------------------------------
    // 최대근력 관련 갱신

    //--------------------------------------------------------------------------
    // 선택된 근육의 역대 최대 1MR 찾기 (통계 기록에서 해당 근육의 측정 record 중 최대 1RM,)
    greatestEverMvcMv = findGreatestEver1Rm(idxMuscle.value);
  }

  //--------------------------------------------------------------------------
  // 선택된 근육의 역대 최대 1MR 찾는 메서드 - 선택 근육이 변경 되었을 때 실행
  //----------------------------------------------------------------------------
  double findGreatestEver1Rm(int idxMuscle){
    double result = 0.0;

    for(int index = 0; index < gv.dbRecordIndexes.length; index++){
      if(gv.dbRecordIndexes[index].idxMuscle == idxMuscle){
        if(gv.dbRecordIndexes[index].greatestEverMvcMv == 0){
          result = gv.dbRecordIndexes[index].mvcMv > result ? gv
              .dbRecordIndexes[index].mvcMv : result;
        }else {
          result = gv.dbRecordIndexes[index].greatestEverMvcMv > result ? gv
              .dbRecordIndexes[index].greatestEverMvcMv : result;
        }
      }
    }
    return result;
  }

  //----------------------------------------------------------------------------
  // 기록 class 데이터 제어
  //----------------------------------------------------------------------------
  RxInt idxRecord = 0.obs; //선택 된 근육 index
  Future updateIdxRecord(int value) async {
    if (gv.dbmRecord.numberOfData > 0) {
      idxRecord.value = value;
      // 근육 수 보다는 작아야 함
      idxRecord.value = min(gv.dbmRecord.numberOfData - 1, idxRecord.value);
      // 0 보다는 커야 함
      idxRecord.value = max(gv.control.idxRecord.value, 0);
      // 변경 후에는 dbMap 데이터를 class 데이터로 변환
      indexMapToRecordIndexObject(idxRecord.value);
      //--------------------------------------------------------------------------
      // 변경된 index 정보에 따라 상세 DB 읽어 온 후 class 데이터로 변환하기
      await gv.dbmRecord.readDataContents(index: idxRecord.value);
      contentsMapToRecordContentsObject();
    }
  }
//----------------------------------------------------------------------------
// 통계 class 데이터 제어
//----------------------------------------------------------------------------
// int idxStatistics = 0; //선택 된 통계 index (통계는 항상 1개)
// void updateIdxStatistics() {
//   mapToDbDataStatistics();
//   // gv.dataStatistics.mapToClassData();
// }

}

Future<void> removeImageFiles({String? filePath}) async {
  Directory imageDirectory;
  if (Platform.isIOS) {
    imageDirectory = await getApplicationSupportDirectory();
  } else {
    imageDirectory = await getApplicationDocumentsDirectory();
  }

  // 입력 파라미터에 삭제할 파일경로가 없을 경우, 모든 이미지 파일을 삭제
  if (filePath == null) {
    List<FileSystemEntity> fileLists = imageDirectory
        .listSync()
        .where((element) => element.path.endsWith('.jpg'))
        .toList();

    for (var element in fileLists) {
      print('gv_control :: removeImageFiles() : ${element.path} 파일을 삭제합니다');
      File(element.path).deleteSync();
    }
    return;
  }

  if (File(filePath).existsSync()) {
    print('gv_control :: removeImageFiles() : $filePath 파일을 삭제합니다');
    File(filePath).deleteSync();
  }
}

Future<String> getImagePath(String imageFileName) async {
  String picturePath;
  Directory imageDirectory;
  if (Platform.isAndroid) {
    imageDirectory = await getApplicationDocumentsDirectory();
    picturePath = '${imageDirectory.path}/$imageFileName';
  } else if (Platform.isIOS) {
    imageDirectory = await getApplicationSupportDirectory();
    picturePath = '${imageDirectory.path}/$imageFileName';
  } else {
    print('gv_control :: getImagePath() : Not supported Platform');
    picturePath = '';
  }
  return picturePath;
}
