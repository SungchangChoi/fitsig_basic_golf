import '/F0_BASIC/common_import.dart';
import 'package:fitsig_basic_golf/F6_WIDGET/POPUP/ble_dialog.dart'; //bleAdaptor 연결 다이얼로그. 다른곳에서는 필요 없으므로 common_import 에 입력 안함
import 'package:fitsig_basic_golf/F6_WIDGET/POPUP/device_control_dialog.dart';

//==============================================================================
// measure main
//==============================================================================

class MeasureIdle extends StatelessWidget {
  const MeasureIdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int refresh = gv.control.refreshPageWhenSettingChange.value;
      int d = 0;
      return Material(
        color: tm.white,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: gv.setting.skinColor.value < 2
              ? SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                )
              : SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                ),
          child: SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                //----------------------------------------------------------------
                // 기본 대기화면
                //----------------------------------------------------------------
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //------------------------------------------------------------
                    // 상단 바
                    topBarBasic(context),
                    // SizedBox(
                    //   width: asWidth(300),
                    //     height: asHeight(250),
                    //     // 010 (손목굽힘근) 덤벨 리스트 컬
                    //     child: const VideoPlayerScreen(fileName: '010운동')),
                    // ElevatedButtonN(
                    //   child: const TextN('Set notification'),
                    //   onPressed: (() {
                    //     BleManager.setRoemNotification(deviceIndex: 0);
                    //   }),
                    // ),
                    // ElevatedButtonN(
                    //   child: const TextN('Cancel notification'),
                    //   onPressed: (() {
                    //     BleManager.cancelRoemNotification(deviceIndex: 0);
                    //   }),
                    // ),
                    //
                    // ElevatedButtonN(
                    //   child: const TextN('Clear GATT Cache : 추가 시험 필요'),
                    //   onPressed: (() {
                    //     BleManager.clearGattCache(deviceIndex: 0);
                    //   }),
                    // ),

                    //------------------------------------------------------------------
                    // 상부 영역 : 근육 선택
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: asHeight(342), //360 - 18
                    //   child: _topArea(context),
                    // ),
                    //------------------------------------------------------------------
                    // 중간 영역 : 운동기록 확인
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: asHeight(90),
                    //   child: _middleAreaButton(context),
                    // ),
                    //------------------------------------------------------------------
                    // 하단 영역 : 운동 시작
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity, //Get.height * 310/800,
                        child: _bottomArea(context),
                      ),
                    ),
                  ],
                ),
                //----------------------------------------------------------------
                // stack
                // 튜토리얼 하나씩 추가
                //----------------------------------------------------------------
                if (dvIntro.cntIsViewTutorial > 0) tutorialMessage(),
                Obx(
                  () {
                    gvMeasure.showBubble.value;
                    return IgnorePointer(
                      ignoring: true,
                      child: AnimatedOpacity(
                        opacity: gvMeasure.showBubble.value ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: showConnectionButtonBubble(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

//==============================================================================
// top area
//==============================================================================
Widget _topArea(BuildContext context) {
  double markSize = asHeight(8);
  double opacity = 1;

  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //--------------------------------------------------------------------
          // 근육 가이드 버튼
          //--------------------------------------------------------------------
          asSizedBox(height: 18),
          Padding(
            padding: EdgeInsets.only(right: asWidth(8)),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (() {
                  if (gv.deviceData[0].muscleTypeIndex.value != 0) {
                    openMuscleGuide(
                        muscleTypeIndex:
                            gv.deviceData[0].muscleTypeIndex.value);
                  }
                }),
                borderRadius: BorderRadius.circular(asHeight(8)),
                child: Container(
                  width: asWidth(48),
                  //height: asHeight(50),
                  // color: Colors.yellow,
                  padding: EdgeInsets.symmetric(vertical: asHeight(10)),
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity:
                        gv.deviceData[0].muscleTypeIndex.value == 0 ? 0.2 : 1,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/icons/ic_근육 가이드.png',
                          height: asHeight(28),
                          // color : gv.deviceData[0].muscleTypeIndex.value == 0 ? tm.grey02 : tm.blue,
                          // color: tm.blue, //todo : 투명 이미지로 변경 필요 (비활성 회색변경)
                        ),
                        asSizedBox(height: 6),
                        TextN(
                          '가이드',
                          fontSize: tm.s12,
                          color: tm.mainBlue,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //--------------------------------------------------------------------
          // 상단 위치 표시
          //--------------------------------------------------------------------
          asSizedBox(height: 0),
          musclePositionTrack(),
          asSizedBox(height: 20),
          //------------------------------------------------------------------------
          // 근육 이름
          //------------------------------------------------------------------------
          _muscleBox(context),
          asSizedBox(height: 20),
          //------------------------------------------------------------------------
          // 근육 설정 버튼
          //------------------------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              wButtonGeneral(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/ic_path.png',
                      height: asHeight(16),
                      color: tm.grey03,
                    ),
                    asSizedBox(width: 8),
                    TextN(
                      '근육설정'.tr,
                      fontSize: tm.s16,
                      color: tm.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                borderColor: tm.grey02,
                width: asWidth(108),
                //위젯에서 자동 스케일
                height: asHeight(40),
                touchWidth: asWidth(128),
                touchHeight: asHeight(60),
                onTap: (() async {
                  // Navigator.of(context).push(pageRouteAnimationSimple(
                  //     const SetMuscle(), EmlMoveDirection.rightToLeft));
                  //현재의 index 업데이트

                  //------------------------------------------------------------------
                  // 설정 할 근육 정보 읽은 후 화면 갱신
                  //------------------------------------------------------------------
                  await gv.control.updateIdxMuscle(
                      gv.control.idxMuscle.value); //관련 class 데이터 갱신
                  // RefreshSetMuscle.muscle();
                  RefreshMuscleNameTextField.refresh();
                  RefreshSetMuscle.all();
                  // 슬라이더 값 새로 불러오기
                  gvMeasure.sliderValueTargetPrm =
                      gv.deviceData[0].targetPrm.value.toDouble();
                  // gvMeasure.sliderValueMvc = gv.deviceData[0].mvc.value;
                  initMvcSlider(); //슬라이더 범위 등의 값 초기화
                  //------------------------------------------------------------------
                  // 페이지 이동
                  //------------------------------------------------------------------
                  Get.to(() => setMuscle());
                }),
              ),
            ],
          ),

          //------------------------------------------------------------------
          // 사진 표시 위젯
          //------------------------------------------------------------------
          // if (gv.deviceData[0].imageBytes.value != null)
          //   SizedBox(
          //     width: asWidth(50),
          //     height: asHeight(100),
          //     child: Obx(() {
          //       String imagePath = gv.deviceData[0].imagePath;
          //       return InkWell(
          //         child: Image.memory(gv.deviceData[0].imageBytes.value!),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => PreviewPage(
          //                 pictureFile: XFile.fromData(
          //                     gv.deviceData[0].imageBytes.value!,
          //                     path: imagePath),
          //               ),
          //             ),
          //           );
          //         },
          //       );
          //     }),
          //   ),
        ],
      ),
      //------------------------------------------------------------------
      // 휴식 - 쉬는 시간 남아 있을 때에만 표시
      // 쉬는 시간은 각 근육별로 주어짐
      //------------------------------------------------------------------
      Column(
        children: [
          asSizedBox(height: 304),

          //---------------------------------------------------------
          // (1) 휴식 시간이 남은 경우에만 표시
          // (2) 휴식하고 있는 근육이 현재 근육과 같을 때에만 표시
          (DspManager.timeSetRelax >= 0 &&
                  DspManager.idxMuscleRelax == gv.control.idxMuscle.value)
              ? Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // todo : 추후에 아이콘 변경 후 컬러 지정
                      Image.asset(
                        'assets/icons/ic_rest.png',
                        height: asHeight(20),
                      ),
                      asSizedBox(width: 6),
                      TextN(
                        '휴식 ${timeToStringColon(timeSec: DspManager.timeSetRelax.value)}',
                        fontSize: tm.s16,
                        fontWeight: FontWeight.bold,
                        color: tm.mainBlue,
                      ),
                    ],
                  );
                })
              //---------------------------------------------------------
              // 현재 근육이 아니건,  휴식 시간이 남지 않은 경우 표시 안함
              : Container(),
        ],
      ),
    ],
  );
}

//==============================================================================
// muscle title box - 데이터베이스 map 파일에서 불러오기
//==============================================================================
Widget _muscleBox(BuildContext context) {
  return Obx(() {
    int index = gv.control.idxMuscle.value;
    int targetPrm = gv.deviceData[0].targetPrm.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //------------------------------------------------------------------------
        // 좌측 화살표
        IgnorePointer(
          ignoring: index - 1 < 0,
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(asHeight(25)),
                child: Image.asset(
                  'assets/icons/ic_banner_arrow_l.png',
                  fit: BoxFit.scaleDown,
                  height: asWidth(50),
                  color: index == 0
                      ? Colors.transparent
                      : tm.grey03.withOpacity(0.7), // tm.blue.withOpacity(0.3),
                ),
                onTap: (() async {
                  await gv.control.updateIdxMuscle(index - 1);
                  // RefreshMeasureIdle.muscleName();
                  RefreshMeasureIdle.muscleTrack();
                  await changeGraphMuscle();
                }),
              ),
            ],
          ),
        ),

        //------------------------------------------------------------------------
        // 근육 이름 및 목표
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //---------------------- 근육 이름
            Container(
              width: asWidth(180), //max 260
              height: asHeight(28), //45
              alignment: Alignment.center,
              // color: Colors.green,
              child: FittedBoxN(
                child: TextN(
                  // gv.dbMuscleIndexes[index].muscleName,
                  gv.deviceData[0].muscleName.value,
                  fontSize: tm.s28, //30
                  fontWeight: FontWeight.bold,
                  color: tm.black,
                  height: 1,
                ),
              ),
            ),
            asSizedBox(height: 18),
            //---------------------- 목표 설정 값
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextN(
                  // '${(gv.deviceData[0].mvc.value).toStringAsFixed(gv.setting.isViewUnitKgf.value ? 1 : 2)}'
                  // ' ${gv.setting.isViewUnitKgf.value ? 'kgf' : 'mV'}',
                  convertMvcToDisplayValue(gv.deviceData[0].mvc.value,
                      isViewUnit: false),
                  fontSize: tm.s20,
                  fontWeight: FontWeight.bold,
                  color: tm.grey03,
                ),
                TextN(gv.setting.isViewUnitKgf.value ? 'kgf' : 'mV',
                    fontSize: tm.s14, color: tm.grey03), //간격

                TextN('   ', fontSize: tm.s20), //간격

                // TextN(
                //   '힘 목표: '.tr,
                //   fontSize: tm.s20,
                //   fontWeight: FontWeight.w400,
                //   color: tm.grey03,
                // ),

                TextN('$targetPrm',
                    fontSize: tm.s20,
                    fontWeight: FontWeight.bold,
                    color: tm.grey03),
                TextN('%   ', fontSize: tm.s14, color: tm.grey03),
                TextN('${gv.deviceData[0].targetCount.value}',
                    fontSize: tm.s20,
                    fontWeight: FontWeight.bold,
                    color: tm.grey03),
                TextN('RM', fontSize: tm.s14, color: tm.grey03),
                // TextN(
                //   '$targetPrm% ${gv.deviceData[0].targetCount.value}' +
                //       'RM'.tr +
                //       '',
                //   fontSize: tm.s20,
                //   fontWeight: FontWeight.bold,
                //   color: tm.grey03,
                // ),
              ],
            ),
          ],
        ),

        //------------------------------------------------------------------------
        // 우측 화살표
        IgnorePointer(
          ignoring: index + 1 > gv.dbmMuscle.numberOfData - 1,
          child: Row(
            // alignment: Alignment.centerLeft,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(asHeight(25)),
                child: Image.asset(
                  'assets/icons/ic_banner_arrow_r.png',
                  fit: BoxFit.scaleDown,
                  height: asWidth(50),
                  color: index == gv.dbmMuscle.numberOfData - 1
                      ? Colors.transparent
                      : tm.grey03.withOpacity(0.7), // tm.blue.withOpacity(0.3),
                ),
                onTap: (() async {
                  await gv.control.updateIdxMuscle(index + 1);
                  // RefreshMeasureIdle.muscleName();
                  RefreshMeasureIdle.muscleTrack();
                  await changeGraphMuscle();
                }),
              ),
            ],
          ),
        ),
      ],
    );
  });
}

//==============================================================================
// middle button - 운동기록 확인 버튼
//==============================================================================
Widget _middleAreaButton(BuildContext context) {
  return InkWell(
    // splashColor: tm.red, //계속 누를 경우의 컬러
    // highlightColor: tm.blue.withOpacity(0.3), //클릭 시의 기본 컬러
    onTap: (() {
      // 사용자 선택을 공유메모리에 기억하여 기록 그래프 혹은 기록 리스트로 이동
      Get.to(() => const RecordMain());
    }),
    child: Ink(
      color: tm.mainBlue,
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/ic_list.png',
              height: asHeight(16),
              color: tm.fixedGrey01,
            ),
            asSizedBox(width: 10),
            TextN(
              '운동 기록 확인'.tr,
              color: tm.fixedGrey01,
              fontSize: tm.s20,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    ),
  );
}

//==============================================================================
// bottom area - 운동대기/시작 버튼
//==============================================================================
Widget _bottomArea(BuildContext context) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      //----------------------------------------------------------------------
      // 배경 근전도 그래프
      //----------------------------------------------------------------------
      Container(
        alignment: Alignment.center,
        color: tm.mainGreen,
        child: LiveEmgTimeChartOnlyLine(
          width: asWidth(360),
          height: asHeight(260), //280
        ),
      ),
      //----------------------------------------------------------------------
      // 기본 바탕 그래프
      //----------------------------------------------------------------------
      Obx(() {
        int d = 0;

        return Container(
          alignment: Alignment.center,
          //--------------------------------------------------------------------
          // 상태에 따른 색상 변화
          color:tm.white,
              // gv.deviceStatus[d].isDeviceBtConnected.value == false
              // gv.deviceStatus[d].isAppConnected.value == false //연결 없을 때
              //     ? tm.white
              //     : BleManager.fitsigDeviceAck[d].usbVoltage.value > 3 //충전 중일때
              //         ? tm.fixedBlack
              //         : gv.deviceStatus[d].electrodeStatus.value !=
              //                 EmlElectrodeStatus.attachGood
              //             ? tm.fixedBlack //tm.red.withOpacity(0.7) //부착상태 안좋을 때 약한 그린
              //             : tm.mainGreen.withOpacity(0.8),
          //정상 시작 가능
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (() async {
                // 실시간 리포트 파일 모두 삭제
                if (DspManager.enableRtDataReport) {
                  gvMeasure.externalDirectoryUri = await selectFileDirectory();
                  List<String> fileNames =
                      List.generate(10, (index) => 'test$index.csv');
                  await deleteFileAtVisibleDirectory(
                      newFileNames: fileNames,
                      externalDirectoryUri: gvMeasure.externalDirectoryUri);
                }

                //----------------------------------------------------------------
                // 현재의 근육 값에서 다시 불러오기
                // 특히 1RM 값을 다시 읽어야
                await gv.control.updateIdxMuscle(gv.control.idxMuscle.value);

                //----------------------------------------------------------------
                // 화면에 보여 줄 값들 초기화
                gv.deviceData[d].aoeSet.value = 0;
                gv.deviceData[d].aoeTargetSet.value = 0;
                gv.deviceData[d].countNum.value = 0;
                gv.deviceData[d].freqBegin.value = GvDef.freqInit;
                gv.deviceData[d].freqEnd.value = GvDef.freqInit;

                //----------------------------------------------------------------
                // 최대근력 관련 갱신
                // mvcLevel to mV -> 1/10
                // double mvcMv = gv.deviceData[d].mvcLevel.value / GvDef.convLv;
                // // print('gv.deviceData[d].mvcLevel.value ${gv.deviceData[d].mvcLevel.value}');
                // // print('mvcMv ${mvcMv}');
                // // print('1Rm ${dm[0].g.parameter.mvcRef}');
                // DspManager.update1Rm(deviceIndex: d, value: mvcMv);
                // // print('1Rm after set ${dm[0].g.parameter.mvcRef}');
                //----------------------------------------------------------------
                // 조건부 실시간 최대근력 갱신 (기능 삭제) 측정 중 MVC 재계산 기능에 따라, 시작할때 작은 값 출발 기능은 삭제
                // late double oneRmRt;

                // if (gv.setting.isMeasureStartWithDefault.value == true) {
                //   oneRmRt = gv.setting.mvcDefaultValue.value / GvDef.convLv;
                //   gv.deviceData[d].mvc.value = gv.setting.mvcDefaultValue.value;
                //   // double mvcMv = gv.deviceData[d].mvcLevel.value / GvDef.convLv;
                //   DspManager.update1Rm(
                //       deviceIndex: d, value: gv.deviceData[d].mvc.value);
                // }
                // // 재출발 설정되지 않은 경우 기존 근력 값으로 세팅
                // else {
                //   // double mvcMv = gv.deviceData[d].mvcLevel.value / GvDef.convLv;
                //   DspManager.update1Rm(
                //       deviceIndex: d, value: gv.deviceData[d].mvc.value);
                //   oneRmRt = gv.deviceData[d].mvc.value;
                // }
                //----------------------------------------------------------------
                // 기준 값으로 시작
                DspManager.update1Rm(
                    deviceIndex: d, value: gv.deviceData[d].mvc.value);
                double oneRmRt = gv.deviceData[d].mvc.value;
                DspManager.update1RmRt(deviceIndex: 0, value: oneRmRt);

                // print('mvcRef : ${dm[0].g.parameter.mvcRef}');
                // print('mvcRefRt : ${dm[0].g.parameter.mvcRefRt}');

                //----------------------------------------------------------------
                // 시작 명령
                bool isMeasureStart = DspManager.commandMeasureStart(context);

                //----------------------------------------------------------------
                // 측정 화면에서 UI 관련 변수 초기화
                initMeasure();

                //----------------------------------------------------------------
                // 측정이 시작 되었으면 페이지 이동
                if (isMeasureStart == true) {
                  // if (gvMeasure.isViewMeasureSimple == true) {
                  //   Get.to(() => const MeasureSimple());
                  //   DspManager.isMeasureOnScreen =
                  //       true; //화면상 측정 시작 (애니메이션 에러 방지 목적)
                  // } else {
                    Get.to(() => const MeasureDetail());
                    DspManager.isMeasureOnScreen =
                        true; //화면상 측정 시작 (애니메이션 에러 방지 목적)
                  // }
                }
              }),
              child: SizedBox(
                width: asWidth(GvDef.widthRef),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //--------------------------------------------------------------
                    // 장비 미연결 이미지
                    //AniIconNoConnection
                    //------------------------------ 장비 미 연결 상태
                    // gv.deviceStatus[0].isAppConnected.value == false
                    //     ? (gv.setting.isBluetoothAutoConnect.value
                    //         ? Image.asset(
                    //             'assets/icons/ic_전원.png', //device_white_256.png',
                    //             fit: BoxFit.scaleDown,
                    //             height: asHeight(60),
                    //             color: tm.fixedWhite,
                    //           )
                    //         : Image.asset(
                    //             'assets/icons/ic_블루투스.png', //device_white_256.png',
                    //             fit: BoxFit.scaleDown,
                    //             height: asHeight(60),
                    //             color: tm.fixedWhite,
                    //           ))
                    //     //AniIconNoConnection(height: asHeight(100))
                    //     //------------------------------ 장비 충전 중
                    //     : BleManager.fitsigDeviceAck[d].usbVoltage.value > 3
                    //         ? Image.asset(
                    //             'assets/icons/ic_충전.png', //device_white_256.png',
                    //             fit: BoxFit.scaleDown,
                    //             height: asHeight(60),
                    //             color: tm.fixedGrey01.withOpacity(0.5),
                    //           )
                    //         //------------------------------ 접촉 불량 상태
                    //         : gv.deviceStatus[0].electrodeStatus.value !=
                    //                 EmlElectrodeStatus.attachGood
                    //             ? Image.asset(
                    //                 'assets/icons/ic_부착.png', //device_white_256.png',
                    //                 fit: BoxFit.scaleDown,
                    //                 height: asHeight(60),
                    //                 color: tm.fixedWhite,
                    //               )
                    //             // AniIconNotGoodAttach(height: asHeight(100))
                    //             //------------------------------ 시작 준비가 된 상태
                    //             : Image.asset(
                    //                 'assets/images/ic_connected.png',
                    //                 fit: BoxFit.scaleDown,
                    //                 height: asHeight(100),
                    //                 color: tm.fixedWhite,
                    //               ),
                    //--------------------------------------------------------------
                    // 간격 (설정에 따라 높이 조절)
                    // gv.deviceStatus[0].isAppConnected.value == false
                    //     ? asSizedBox(height: 32)
                    //     : BleManager.fitsigDeviceAck[d].usbVoltage.value > 3
                    //         ? asSizedBox(height: 42)
                    //         : gv.deviceStatus[0].electrodeStatus.value !=
                    //                 EmlElectrodeStatus.attachGood
                    //             ? asSizedBox(height: 42)
                    //             : asSizedBox(height: 28),
                    //운동 시작

                    //--------------------------------------------------------------
                    // 하단 운동 시작 (장비연결 및 부착 상태에 따라 다르게 표현)
                    InkWell(
                      onTap: (() async {
                        // 실시간 리포트 파일 모두 삭제
                        if (DspManager.enableRtDataReport) {
                          gvMeasure.externalDirectoryUri =
                              await selectFileDirectory();
                          List<String> fileNames =
                              List.generate(10, (index) => 'test$index.csv');
                          await deleteFileAtVisibleDirectory(
                              newFileNames: fileNames,
                              externalDirectoryUri:
                                  gvMeasure.externalDirectoryUri);
                        }

                        //----------------------------------------------------------------
                        // 현재의 근육 값에서 다시 불러오기
                        // 특히 1RM 값을 다시 읽어야
                        await gv.control
                            .updateIdxMuscle(gv.control.idxMuscle.value);

                        //----------------------------------------------------------------
                        // 화면에 보여 줄 값들 초기화
                        gv.deviceData[d].aoeSet.value = 0;
                        gv.deviceData[d].aoeTargetSet.value = 0;
                        gv.deviceData[d].countNum.value = 0;
                        gv.deviceData[d].freqBegin.value = GvDef.freqInit;
                        gv.deviceData[d].freqEnd.value = GvDef.freqInit;

                        //----------------------------------------------------------------
                        // 최대근력 관련 갱신
                        // mvcLevel to mV -> 1/10
                        // double mvcMv = gv.deviceData[d].mvcLevel.value / GvDef.convLv;
                        // // print('gv.deviceData[d].mvcLevel.value ${gv.deviceData[d].mvcLevel.value}');
                        // // print('mvcMv ${mvcMv}');
                        // // print('1Rm ${dm[0].g.parameter.mvcRef}');
                        // DspManager.update1Rm(deviceIndex: d, value: mvcMv);
                        // // print('1Rm after set ${dm[0].g.parameter.mvcRef}');
                        //----------------------------------------------------------------
                        // 조건부 실시간 최대근력 갱신 (기능 삭제) 측정 중 MVC 재계산 기능에 따라, 시작할때 작은 값 출발 기능은 삭제
                        // late double oneRmRt;

                        // if (gv.setting.isMeasureStartWithDefault.value == true) {
                        //   oneRmRt = gv.setting.mvcDefaultValue.value / GvDef.convLv;
                        //   gv.deviceData[d].mvc.value = gv.setting.mvcDefaultValue.value;
                        //   // double mvcMv = gv.deviceData[d].mvcLevel.value / GvDef.convLv;
                        //   DspManager.update1Rm(
                        //       deviceIndex: d, value: gv.deviceData[d].mvc.value);
                        // }
                        // // 재출발 설정되지 않은 경우 기존 근력 값으로 세팅
                        // else {
                        //   // double mvcMv = gv.deviceData[d].mvcLevel.value / GvDef.convLv;
                        //   DspManager.update1Rm(
                        //       deviceIndex: d, value: gv.deviceData[d].mvc.value);
                        //   oneRmRt = gv.deviceData[d].mvc.value;
                        // }
                        //----------------------------------------------------------------
                        // 기준 값으로 시작
                        DspManager.update1Rm(
                            deviceIndex: d, value: gv.deviceData[d].mvc.value);
                        double oneRmRt = gv.deviceData[d].mvc.value;
                        DspManager.update1RmRt(deviceIndex: 0, value: oneRmRt);

                        // print('mvcRef : ${dm[0].g.parameter.mvcRef}');
                        // print('mvcRefRt : ${dm[0].g.parameter.mvcRefRt}');

                        //----------------------------------------------------------------
                        // 시작 명령
                        bool isMeasureStart =
                            DspManager.commandMeasureStart(context);

                        //----------------------------------------------------------------
                        // 측정 화면에서 UI 관련 변수 초기화
                        initMeasure();

                        //----------------------------------------------------------------
                        // 측정이 시작 되었으면 페이지 이동
                        if (isMeasureStart == true) {
                            Get.to(() => const MeasureDetail());
                            DspManager.isMeasureOnScreen =
                                true; //화면상 측정 시작 (애니메이션 에러 방지 목적)
                        }
                      }),
                      borderRadius: BorderRadius.circular(asHeight(10)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: asWidth(18), vertical: asHeight(18)),
                        child: TextN(
                          // gv.deviceStatus[0].isDeviceBtConnected.value == false
                          gv.deviceStatus[0].isAppConnected.value == false
                              ? (gv.setting.isBluetoothAutoConnect.value
                                  ? '장비의 전원을 켜세요'.tr
                                  : '장비를 연결하세요'.tr)
                              : BleManager.fitsigDeviceAck[d].usbVoltage.value >
                                      3
                                  ? '장비 충전 중입니다'.tr
                                  : gv.deviceStatus[0].electrodeStatus.value !=
                                          EmlElectrodeStatus.attachGood
                                      ? '장비를 부착하세요'.tr
                                      : '운동시작'.tr,
                          fontSize: tm.s20,
                          fontWeight: FontWeight.bold,
                          color: tm.fixedBlack,
                        ),
                      ),
                      // ),
                    ),
                    //--------------------------------------------------------------
                    // 간격 (설정에 따라 높이 조절)
                    // gv.deviceStatus[0].isAppConnected.value == false
                    //     ? asSizedBox(height: 16)
                    //     : BleManager.fitsigDeviceAck[d].usbVoltage.value > 3
                    //         ? Container()
                    //         : gv.deviceStatus[0].electrodeStatus.value !=
                    //                 EmlElectrodeStatus.attachGood
                    //             ? Container()
                    //             : Container(),
                    //--------------------------------------------------------------
                    // 하단 설명
                    // TextN(
                    //   // gv.deviceStatus[0].isDeviceBtConnected.value == false
                    //   gv.deviceStatus[0].isAppConnected.value == false
                    //       ? (gv.setting.isBluetoothAutoConnect.value
                    //           ? '전원을 켜면 자동연결됩니다'.tr
                    //           : '장비를 켜고 상단 아이콘을 눌러주세요'.tr)
                    //       : BleManager.fitsigDeviceAck[d].usbVoltage.value > 3
                    //           ? '장비 충전 중입니다'.tr
                    //           : gv.deviceStatus[0].electrodeStatus.value !=
                    //                   EmlElectrodeStatus.attachGood
                    //               ? ''.tr
                    //               : ''.tr,
                    //   fontSize: tm.s14,
                    //   fontWeight: FontWeight.bold,
                    //   color: tm.grey03,
                    // ),

                    //text
                    //const ElectrodeContactStatus(),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    ],
  );
}
