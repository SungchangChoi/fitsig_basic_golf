import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';

enum ViewMode { modify, onlyView }

class PreviewPage extends StatelessWidget {
  const PreviewPage(
      {Key? key, required this.pictureFile, this.mode = ViewMode.onlyView})
      : super(key: key);

  final XFile pictureFile;
  final ViewMode mode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tm.black,
      // appBar: AppBar(title: const Text('Preview Page')),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PhotoView(
                imageProvider: FileImage(File(pictureFile.path)),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.19,
                decoration: const BoxDecoration(
                    // borderRadius:
                    //  BorderRadius.vertical(top: Radius.circular(24)),
                    color: Colors.black),
              ),
            ),
            // Image.file(File(picture.path), fit: BoxFit.cover, width: 500)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.19,
                    // (mode == ViewMode.modify ? 0.15 : 0.1),
                decoration: const BoxDecoration(
                    // borderRadius:
                    //     BorderRadius.vertical(top: Radius.circular(24)),
                    color: Colors.black),
                child: (mode == ViewMode.modify)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () async {
                              deletePreviousPicture();
                              savePicture();
                            },
                            child: TextN(
                              '저장',
                              color: tm.white,
                              fontSize: tm.s20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              deletePictureAtCache();
                              Get.back();
                            },
                            child: TextN(
                              '취소',
                              color: tm.white,
                              fontSize: tm.s20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // TextButton(
                          //   onPressed: () async {
                          //     Get.back();
                          //     await availableCameras().then(
                          //       (value) => Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) =>
                          //               CameraPage(cameras: value),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   child: TextN(
                          //     '다시 찍기',
                          //     color: tm.white,
                          //     fontSize: tm.s20,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: TextN(
                              '닫기',
                              color: tm.white,
                              fontSize: tm.s20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            // TextN(
            //   pictureFile.path,
            //   color: tm.white,
            //   fontSize: tm.s18,
            //   fontWeight: FontWeight.bold,
            // ),
          ],
        ),
      ),
    );
  }

  void deletePictureAtCache() {
    if (File(pictureFile.path).existsSync()) {
      // print(
      //     'V06_camera_preview :: deletePictureAtCache() : ${pictureFile
      //         .name}파일을 삭제 합니다. ');
      File(pictureFile.path).deleteSync();
    }
  }

  // 재촬영일 경우, 기존 파일을 삭제
  Future<void> deletePreviousPicture() async {
    String previousFileName =
        gv.dbMuscleIndexes[gv.control.idxMuscle.value].imageFileName;
    if (previousFileName == '') {
      // print('PreviewPage :: deletePreviousPicture :: 삭제할 사진 없음 ');
      return;
    }

    Directory imageDirectory;
    if (Platform.isIOS) {
      imageDirectory = await getApplicationSupportDirectory();
    } else {
      imageDirectory = await getApplicationDocumentsDirectory();
    }
    String imageFilePath = '${imageDirectory.path}/$previousFileName';

    if (File(imageFilePath).existsSync()) {
      // print('PreviewPage :: deletePreviousPicture :: 이전 파일($imageFilePath)이 존재하므로 삭제합니다 ');
      File(imageFilePath).deleteSync();
    }

  }

  Future<void> savePicture() async {
    String now = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
    String newFileName = 'muscleImage_$now.jpg'; // 사진찍은 시간을 파일명으로 설정
    Directory imageDirectory;
    String imageFilePath;
    if (Platform.isIOS) {
      imageDirectory = await getApplicationSupportDirectory();
    } else {
      imageDirectory = await getApplicationDocumentsDirectory();
    }
    imageFilePath = '${imageDirectory.path}/$newFileName';
    //db에 새 사진의 file 명을 입력
    // 새로은 사진명을 dB에 저장
    gv.dbMuscleIndexes[gv.control.idxMuscle.value].imageFileName = newFileName;

    // 데이터 베이스 갱신
    await gv.dbmMuscle.updateData(
        index: gv.control.idxMuscle.value,
        indexMap: gv.dbMuscleIndexes[gv.control.idxMuscle.value].toJson(),
        contentsMap: gv.dbMuscleContents.toJson());
    await pictureFile.saveTo(imageFilePath);
    Get.back();  // 팝업창과 사진 프리뷰창  2개가 떠 있는 상태라 Get.back() 두번 필요
    deletePictureAtCache(); // cache 에 있던 이미지 파일은 삭제
    Get.back();
    // 바로 위에 saveTo 메서드가 return 값이 없어서, 파일이 생성되었는지 직접 확인하고 생성 되었으면 경로를 저장
    if (File(imageFilePath).existsSync()) {
      gv.deviceData[0].imagePath.value = imageFilePath;
      gv.deviceData[0].imageBytes = File(imageFilePath).readAsBytesSync();
      // print('V06_camera_preview :: saveTo() : imageFilePath=$imageFilePath 에 파일 존재 확인 gv.deviceData[0].imageBytes 에 로드하고 저장 프로세스 종료 ');
    }
  }
}
