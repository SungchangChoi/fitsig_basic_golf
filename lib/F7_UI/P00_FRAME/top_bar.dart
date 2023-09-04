import '/F0_BASIC/common_import.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:intl/intl.dart';

//==============================================================================
// top bar basic : 기본 대기화면
//==============================================================================
Widget topBarBasic(
  BuildContext context, {
  String title = '',
}) {
  return Container(
    // margin: EdgeInsets.only(top: asHeight(12)),
    height: asHeight(54), //30 + 12 + 12
    width: double.infinity,
    alignment: Alignment.centerRight,
    // color: tm.green,
    child: deviceIconButton(context),
  );
}

//==============================================================================
// top bar guide : 운동 가이드 화면
//==============================================================================
Widget topBarGuide(
  BuildContext context, {
  String title = '',
  bool isViewXButton = true,
  bool isMeasureEnd = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //----------------------------------------------------------------------
      // 상단 근육명 라인
      //----------------------------------------------------------------------
      SizedBox(height: asHeight(12)), //글씨 상단 여유 공간
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //------------------------------------------------------------------
          // 좌측 글씨 영역
          // Obx(() {
          //   return Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       asSizedBox(width: 18),
          //       TextN(
          //         gv.dbMuscleIndexes[gv.control.idxMuscle.value].muscleName,
          //         fontSize: tm.s16,
          //         fontWeight: FontWeight.bold,
          //         color: tm.grey03,
          //       ),
          //       TextN(' ', fontSize: tm.s18), //글씨 좌측 여유공간
          //       TextN(
          //         '운동'.tr,
          //         fontSize: tm.s16,
          //         fontWeight: FontWeight.bold,
          //         color: tm.grey03,
          //       ),
          //     ],
          //   );
          // }),

          //------------------------------------------------------------------
          // 우측 X
          // isViewXButton
          //     ? Row(
          //         children: [
          //           InkWell(
          //             onTap: (() async {
          //               DspManager.isMeasureOnScreen =
          //                   false; //화면상 측정 종료 (애니메이션 에러 방지 목적)
          //               //------------------------------------------------------
          //               // 측정 종료 명령 - 중복클릭 방지
          //               if (DspManager.stateMeasure.value ==
          //                   EmlStateMeasure.onMeasure) {
          //                 //측정 종료 명령 - 종료는 하지만 저장 안함
          //                 DspManager.commandMeasureComplete(); //측정 종료 명령
          //                 var _dialog = openPopupProcessIndicator(
          //                   context,
          //                   text: '측정 취소 중입니다',
          //                 );
          //                 //----------------------------------------------------
          //                 // 측정 종료 명령 후 상태 대기
          //                 late Timer _timer;
          //                 int cntTimeout = 0;
          //                 _timer = Timer.periodic(
          //                     const Duration(milliseconds: 100), (timer) async {
          //                   cntTimeout++; //응답 타임아웃 체크
          //                   //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
          //                   // 정상적  측정 취소
          //                   //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
          //                   if (DspManager.stateMeasure.value ==
          //                       EmlStateMeasure.idle) {
          //                     _timer.cancel();
          //                     //------------------------------------------------
          //                     // 다이올로그 닫기
          //                     Navigator.pop(context, _dialog);
          //                     // x 버튼의 경우 저정안하고 빠져 나가기 (측정 대기 페이지로 이동)
          //                     Get.back();
          //                   }
          //                   //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
          //                   // 타임아웃 종료 - 2초 이상 지난 경우
          //                   // 블루투스 연결 해제 등으로 비정상 종료 된 경우
          //                   //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
          //                   else if (cntTimeout > 20) {
          //                     _timer.cancel();
          //                     if (kDebugMode) {
          //                       print('bottom_button.dart :: 타임아웃 종료.');
          //                     }
          //                     //--------------------------------------------------
          //                     // 다이올로그 닫기
          //                     Navigator.pop(context, _dialog);
          //                     // x 버튼의 경우 저정안하고 빠져 나가기 (측정 대기 페이지로 이동)
          //                     Get.back();
          //                     // //--------------------------------------------------
          //                     // // 대기 화면으로 이동
          //                     // Get.back();
          //                   }
          //                   // //----------------------------------------------------------
          //                   // // 데모신호 생성중이 아니면서, 장비가 꺼져있다면, EmlStateMeasure.idle 를 기다리지 않고 종료
          //                   // else if ((gv.bleManager[0].device1 == null ||
          //                   //         gv.bleManager[0].device1?.wvIsConnected.value ==
          //                   //             false) &&
          //                   //     gv.setting.isEnableDemo.value == false) {
          //                   //   _timer.cancel();
          //                   //   // 장비가 꺼져서 측정을 종료하는 것이므로, 원래 값으로 복귀
          //                   //   gv.deviceData[0].mvcLevel.value = gv
          //                   //           .dbMuscleIndexes[gv.control.idxMuscle.value]
          //                   //           .mvcMv *
          //                   //       GvDef.convLv;
          //                   //   print(
          //                   //       'top_bar.dart :: gv.bleManager[0].device1=${gv.bleManager[0].device1}, wvIsConnected.value=${gv.bleManager[0].device1?.wvIsConnected.value}');
          //                   //   await Future.delayed(const Duration(seconds: 2));
          //                   //   Navigator.pop(context, _dialog);
          //                   //   Get.back();
          //                   // }
          //                 });
          //               }
          //             }),
          //             borderRadius: BorderRadius.circular(asHeight(10)),
          //             child: Container(
          //               width: asWidth(54),
          //               height: asHeight(30),
          //               alignment: Alignment.center,
          //               child: Image.asset(
          //                 'assets/icons/ic_close.png',
          //                 fit: BoxFit.scaleDown,
          //                 height: asHeight(30),
          //                 color: tm.black,
          //               ),
          //             ),
          //           ),
          //           // asSizedBox(width: 12),
          //         ],
          //       )
          //     : Container(),

          //--------------------------------------------------------------
          // 디바이스 아이콘
          //--------------------------------------------------------------
          Row(
            children: [
              Container(
                height: asHeight(30), //클릭 범위를 조금 넓혀 줌 (높이 30)
                alignment: Alignment.center,
                child: const DeviceIcon(),
              ),
              asSizedBox(width: 18),
            ],
          ),
        ],
      ),
      // SizedBox(height: asHeight(10)),
      //----------------------------------------------------------------------
      // 하단 목표 및 레벨
      //----------------------------------------------------------------------
      // Obx(() {
      //   // int index = gv.control.idxMuscle.value;
      //   int targetPrm = gv.deviceData[0].targetPrm.value;
      //   int repetition = gv.deviceData[0].targetCount.value;
      //   double mvc = gv.deviceData[0].mvc.value; //.toPrecision(1);
      //   double mvcPrevious = dm[0].g.parameter.mvcRef;
      //   // print(mvcLevel);
      //   // print(mvcLevelPrevious);
      //   // double mvcLevelPrevious = gv.dbMuscleIndexes[gv.control.idxMuscle.value].mvcLevel;
      //   return Container(
      //     width: asWidth(324), //360-36
      //     alignment: Alignment.centerLeft,
      //     child: FittedBoxN(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Row(
      //             // mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               asSizedBox(width: 18),
      //               //----------------------- 타이틀
      //               TextN(
      //                 '힘 목표'.tr,
      //                 fontSize: tm.s12,
      //                 fontWeight: FontWeight.bold,
      //                 color: tm.black,
      //               ),
      //               //----------------------- 목표 값
      //               TextN(
      //                 ': $targetPrm%'
      //                         ' $repetition'
      //                         '회'
      //                     .tr,
      //                 fontSize: tm.s12,
      //                 fontWeight: FontWeight.bold,
      //                 color: tm.black,
      //               ),
      //               asSizedBox(width: 8),
      //               // 중간 구분선 : 글씨크기 변경에 따라 함께 변함
      //               if (isMeasureEnd == false)
      //                 Container(
      //                   width: 2,
      //                   height: tm.s12,
      //                   color: tm.grey02,
      //                 ),
      //               if (isMeasureEnd == false) asSizedBox(width: 8),
      //               //----------------------- 최대근력 레벨
      //               if (isMeasureEnd == false)
      //                 TextN(
      //                   '근력:'.tr,
      //                   fontSize: tm.s12,
      //                   fontWeight: FontWeight.bold,
      //                   color: tm.black,
      //                 ),
      //               if (isMeasureEnd == false)
      //                 TextN(
      //                   // ' ${mvcLevel.toStringAsFixed(1)}',
      //                   // '${(mvcLevel).toStringAsFixed(gv.setting.isViewUnitKgf.value ? 1 : 2)}'
      //                   //     ' ${gv.setting.isViewUnitKgf.value ? 'kgf' : 'mV'}',
      //                   convertMvcToDisplayValue(mvc),
      //                   fontSize: tm.s12,
      //                   fontWeight: FontWeight.bold,
      //                   // 신규 최대근력 측정 시 붉은 색으로 표시
      //                   // color: mvc > mvcPrevious ? tm.red : tm.black,
      //                   color: tm.black,
      //                 ),
      //               // if (isMeasureEnd == false) asSizedBox(width: 8),
      //               // //----------------------- 기존 최대근력 레벨
      //               // if (mvc > mvcPrevious && isMeasureEnd == false)
      //               //   TextN(
      //               //     '(이전:'.tr,
      //               //     fontSize: tm.s12,
      //               //     fontWeight: FontWeight.bold,
      //               //     color: tm.black,
      //               //   ),
      //               // if (mvc > mvcPrevious && isMeasureEnd == false)
      //               //   TextN(
      //               //     // ' ${(mvcLevelPrevious).toStringAsFixed(1)})',
      //               //     // '${(mvcPrevious).toStringAsFixed(gv.setting.isViewUnitKgf.value ? 1 : 2)}'
      //               //     // ' ${gv.setting.isViewUnitKgf.value ? 'kgf' : 'mV'}',
      //               //     convertMvcToDisplayValue(mvcPrevious),
      //               //     fontSize: tm.s14,
      //               //     fontWeight: FontWeight.bold,
      //               //     color: tm.black,
      //               //   ),
      //               // asSizedBox(width: 8),
      //               // // 중간 구분선 : 글씨크기 변경에 따라 함께 변함
      //               // // Container(
      //               // //   width: 2,
      //               // //   height: tm.s14,
      //               // //   color: tm.grey02,
      //               // // ),
      //               // // asSizedBox(width: 8),
      //               // // TextN(
      //               // //   '운동부위: ',
      //               // //   fontSize: tm.s12,
      //               // //   fontWeight: FontWeight.bold,
      //               // //   color: tm.black,
      //               // // ),
      //               // // TextN(
      //               // //   GvDef.muscleTypeList[gv.deviceData[0].muscleTypeIndex.value],
      //               // //   fontSize: tm.s12,
      //               // //   fontWeight: FontWeight.bold,
      //               // //   color: tm.black,
      //               // // ),
      //             ],
      //           ),
      //           (mvc > mvcPrevious && isMeasureEnd == false)
      //               ? Column(
      //                   children: [
      //                     asSizedBox(height: 8),
      //                     Row(
      //                       children: [
      //                         asSizedBox(width: 18),
      //                         TextN(
      //                           '(이전: '.tr,
      //                           fontSize: tm.s12,
      //                           fontWeight: FontWeight.normal,
      //                           color: tm.grey03,
      //                         ),
      //                         TextN(
      //                           convertMvcToDisplayValue(mvcPrevious),
      //                           fontSize: tm.s12,
      //                           fontWeight: FontWeight.normal,
      //                           color: tm.grey03,
      //                         ),
      //                         asSizedBox(width: 3),
      //                         TextN(
      //                           '/',
      //                           fontSize: tm.s12,
      //                           fontWeight: FontWeight.normal,
      //                           color: tm.grey03,
      //                         ),
      //                         asSizedBox(width: 3),
      //                         TextN(
      //                           '운동부위: ',
      //                           fontSize: tm.s12,
      //                           fontWeight: FontWeight.normal,
      //                           color: tm.grey03,
      //                         ),
      //                         TextN(
      //                           GvDef.muscleListKr[
      //                               gv.deviceData[0].muscleTypeIndex.value],
      //                           fontSize: tm.s12,
      //                           fontWeight: FontWeight.normal,
      //                           color: tm.grey03,
      //                         ),
      //                         TextN(
      //                           ')'.tr,
      //                           fontSize: tm.s12,
      //                           fontWeight: FontWeight.normal,
      //                           color: tm.grey03,
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 )
      //               : Container(),
      //         ],
      //       ),
      //     ),
      //   );
      // }),
      // //----------------------------------------------------------------------
      // // 하단 f라인
      // //----------------------------------------------------------------------
      // asSizedBox(height: 16),
      // Container(
      //   height: 2,
      //   width: double.maxFinite,
      //   color: tm.softBlue,
      // )
    ],
  );
}

//==============================================================================
// top bar back : 운동기록 / 설정
//==============================================================================
Widget topBarBack(
  BuildContext context, {
  String title = '',
}) {
  return Container(
    // margin: EdgeInsets.only(top: asHeight(12)), //상단 여유
    // height: icHeight,
    height: asHeight(54), //30 + 12 + 12
    child: Stack(
      alignment: Alignment.center,
      children: [
        //------------------------------------------------------------------
        // title
        TextN(
          title,
          fontSize: tm.s14,
          color: tm.grey03,
          fontWeight: FontWeight.w400,
        ),

        //------------------------------------------------------------------
        // back & deviceIcon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //--------------------------------------------------------------
            // back
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (() async {
                    int d = 0;
                    Get.back();
                  }),
                  borderRadius: BorderRadius.circular(asHeight(15)),
                  child: Container(
                    alignment: Alignment.center,
                    height: asHeight(54),
                    width: asWidth(54), // 30 + 18 + 18
                    child: Image.asset(
                      'assets/icons/ic_banner_arrow_l.png',
                      fit: BoxFit.scaleDown,
                      height: asHeight(30),
                      color: tm.black,
                    ),
                  ),
                ),
              ],
            ),
            //--------------------------------------------------------------
            // 디바이스 아이콘
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                deviceIconButton(context),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

//==============================================================================
// 장비 부착 사진이 없을 경우 사진을 찍을지 물어보는 다이얼로그
//==============================================================================
Widget _takePicture(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
        child: TextN(
          '장비의 부착 위치를 기록하면, 다음 운동시 장비 부착위치를 참고할 수 있습니다.',
          color: tm.grey03,
          fontSize: tm.s14,
          fontWeight: FontWeight.normal,
        ),
      ),
      SizedBox(height: asHeight(60)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: asHeight(18)),
        child: textButtonI(
          width: asWidth(324),
          height: asHeight(58),
          radius: asHeight(8),
          backgroundColor: tm.mainBlue,
          onTap: () async {
            Get.back();
            await availableCameras().then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CameraPage(cameras: value))));
          },
          title: '촬영하기'.tr,
          fontSize: tm.s18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: asHeight(20))
    ],
  );
}

//==============================================================================
// 장비 부착 사진이 있을 경우 사진을 보여주는 다이얼로그
//==============================================================================
Widget _showPicture(BuildContext context){
  bool existImage = File(gv.deviceData[0].imagePath.value).existsSync();
  String date = '';
  if(existImage == true) {
    DateTime lastModifiedDate = File(gv.deviceData[0].imagePath.value)
        .lastModifiedSync();
    date = DateFormat('yyyy년 MM월 dd일 HH:mm:ss').format(lastModifiedDate);
  }

  return Column(
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          SizedBox(
            width: asWidth(360),
            height: asWidth(360),
            child: ClipRRect(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Image.memory(gv.deviceData[0].imageBytes!),
              ),
            ),
          ),

          // 사진 날짜 표시
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: tm.s18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: tm.black,
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // ),
      SizedBox(height: asHeight(40)),
      // 버튼
      Padding(
        padding: EdgeInsets.symmetric(horizontal: asHeight(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textButtonI(
              width: asWidth(156),
              height: asHeight(52),
              radius: asHeight(8),
              backgroundColor: tm.softBlue,
              onTap: () async {
                Get.back();
                await availableCameras().then(
                  (value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraPage(cameras: value),
                    ),
                  ),
                );
              },
              title: '재촬영'.tr,
              textColor: tm.mainBlue,
              fontSize: tm.s18,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: asWidth(8.0)),
            textButtonI(
              width: asWidth(156),
              height: asHeight(52),
              radius: asHeight(8),
              backgroundColor: tm.mainBlue,
              onTap: (){
                Get.back();
              },
              title: '확인'.tr,
              fontSize: tm.s18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
      SizedBox(height: asHeight(20))
    ],
  );
}

Future<void> deletePicture() async {
  try {
    // 사진 파일 삭제
    File(gv.deviceData[0].imagePath.value).deleteSync();
  } catch (e) {
    debugPrint('Error during removing image');
  }

  // 사진 파일 경로 저장 변수 초기화
  gv.deviceData[0].imagePath.value = '';
  gv.deviceData[0].imageBytes = (null as Uint8List?);

  // DB 에 자장된 파일명 저장 field 초기화
  gv.dbMuscleIndexes[gv.control.idxMuscle.value].imageFileName = '';

  // 데이터 베이스 갱신
  await gv.dbmMuscle.updateData(
      index: gv.control.idxMuscle.value,
      indexMap: gv.dbMuscleIndexes[gv.control.idxMuscle.value].toJson(),
      contentsMap: gv.dbMuscleContents.toJson());
}
