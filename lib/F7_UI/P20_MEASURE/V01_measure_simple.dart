import 'package:fitsig_basic_golf/F6_WIDGET/ANIMATION/bounce_circle.dart';
import '/F0_BASIC/common_import.dart';

//==============================================================================
// measure simple
// todo : 앱의 백 버튼 대응 stateful 변경 후 dispose 에 종료 절차 추가 (강제 종료 처리 검토)
//==============================================================================
class MeasureSimple extends StatelessWidget {
  const MeasureSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wakelock.enable(); //화면 켜짐 유지 - 측정 중에는 꺼지지 않음

    return Material(
      color: tm.white,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //------------------------------------------------------------------
            // 목표 영역 성공 애니메이션
            // _blinkAnimation(context),
            ripplesAnimationSimple(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //--------------------------------------------------------------
                // 상단 바
                topBarGuide(context),

                //--------------------------------------------------------------
                // 그래프
                Expanded(child: asSizedBox(height: 98)),
                _barChart(context),

                //----------------------------------------------------------------------
                // 중간 여유
                asSizedBox(height: 64),
                //----------------------------------------------------------------------
                // 반복 횟수 및 묙포 카운트
                Obx(() {
                  int countNum = gv.deviceData[0].countNum.value;
                  int repNum = gv.deviceData[0].targetCount.value;
                  // gv.dbMuscleIndexes[gv.control.idxMuscle.value].targetCount;
                  return SizedBox(
                    height: asHeight(16),
                    child: TextN(
                      '$countNum / $repNum',
                      color: tm.mainBlue.withOpacity(0.5),
                      fontSize: tm.s16,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  );
                }),
                //--------------------------------------------------------------
                // 버튼
                _buttonDetailView(context),
                //--------------------------------------------------------------
                // 하단부
                asSizedBox(height: 10),
                const BottomButtonControl(),
              ],
            ),

            //------------------------------------------------------------------
            // 전극 접촉 불량 경고문구
            // const ElectrodeWarning(),

            //------------------------------------------------------------------
            // 블루투스 연결 불량
            btLinkBad(height: asHeight(300), opacity: 0.8),

            //------------------------------------------------------------------
            // 1RM을 현재 값으로 갱신(reset)
            // [1] 전극을 떼었다가 붙였을 때 1회만 실행
            // [2] 새로운 최대근력 값이 기준 보다 작을때만 실행


            Obx(() {
              bool isVisible = !(gv.deviceData[0].disableReset1RM.value) &&
                  (gv.deviceData[0].mvc.value <= dm[0].g.parameter.mvcRef);
              print('MeasureSimple :: build :: isVisible=$isVisible  mvc=${gv.deviceData[0].mvc.value}   <   mvcRef=${dm[0].g.parameter.mvcRef}   disableReset1RM=${gv.deviceData[0].disableReset1RM.value}');
              return Visibility(
                visible: isVisible,
                child: Positioned(top: asHeight(103), child: reset1RM()),
              );
            }),

            //------------------------------------------------------------------
            // 최대근력 갱신!, 1셋트 완료! 애니메이션 위젯
            Obx(() {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: gvMeasure.isGuideDownPosition == false
                    ? asHeight(83)
                    : (gvMeasure.isMvcChanged.value
                        ? asHeight(105)
                        : asHeight(83)),
                width: asWidth(360),
                height: gvMeasure.guideWidgetHeight,
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: gvMeasure.isShowingGuide.value ? 1.0 : 0.0,
                    //점점 안보이게
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      color: gvMeasure.guideBackgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (gvMeasure.guideImage != null)
                            gvMeasure.guideImage!,
                          SizedBox(
                            width: asWidth(8),
                          ),
                          TextN(
                            gvMeasure.guideText,
                            fontSize: tm.s16,
                            fontWeight: FontWeight.bold,
                            color: tm.fixedWhite,
                            height: 1.2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

//==============================================================================
// guide
//==============================================================================
Widget _guide(BuildContext context) {
  GvDef.maxDeviceNum;
  return Container(
    alignment: Alignment.center,
    height: asHeight(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //----------------------------------------------------------------------
        // 운동 성과 - 어떻게 표시할지 고민 필요
        // ex) 바 그래프 위의 텍스트 '훌륭해요!', '좋아요!'
        SizedBox(
          height: asHeight(24),
          width: asWidth(155),
          child: Obx(
            () {
              return AnimatedOpacity(
                opacity: gvMeasure.isShowingBarText.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: TextN(
                    gvMeasure.barText,
                    color: tm.mainBlue,
                    fontSize: tm.s24,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

//==============================================================================
// 운동량 값 출력
//==============================================================================
Widget _aoeValue(BuildContext context) {
  GvDef.maxDeviceNum;
  return Container(
    alignment: Alignment.center,
    height: asHeight(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: asHeight(24),
          child: Obx(
            () => FittedBoxN(
              child: TextN(
                toStrFixedAuto(gv.deviceData[0].aoeSet.value * 100) + '%',
                fontSize: tm.s24,
                fontWeight: FontWeight.bold,
                color: tm.mainGreen,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

//==============================================================================
// barChart
//==============================================================================
Widget _barChart(BuildContext context) {
  // //-------------------------- 행 높이
  // double padHeight16 = Get.height * 16 / 800;
  // //-------------------------- 열 여유공간
  // double padWidth18 = Get.width * 18 / 360;
  // double padWidth14 = Get.width * 14 / 360;
  // //-------------------------- 바 높이
  // double barWidth = Get.width * 155 / 360;
  // double barHeight = Get.height * 200 / 800;
  // final buttonKey1 = GlobalKey();
  // final buttonKey2 = GlobalKey();

  return Row(
    children: [
      asSizedBox(width: 18),
      //--------------------------------------------------------------
      // 운동량 바 그래프
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _aoeValue(context),
          asSizedBox(height: 14),
          LiveAoeBar(
            width: asWidth(155),
            height: asHeight(200),
          ),
          asSizedBox(height: 12),
          SizedBox(
            height: asHeight(16),
            child: Tooltip(
              message: '운동량을 나타냅니다.',
              // decoration: BoxDecoration(color: tm.white),
              // textStyle: TextStyle(color: tm.grey05),
              verticalOffset: -50.0,
              child: FittedBoxN(
                child: TextN(
                  '1세트 운동량',
                  fontSize: tm.s16,
                  color: tm.mainGreen,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
      asSizedBox(width: 14),
      //--------------------------------------------------------------
      // emg 바 그래프
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _guide(context),
          asSizedBox(height: 14),
          LiveEmgBar(
            width: asWidth(155),
            height: asHeight(200),
          ),
          asSizedBox(height: 12),
          SizedBox(
            height: asHeight(16),
            child: Tooltip(
              message: '근육의 활성도를 나타냅니다.',
              // decoration: BoxDecoration(color: Colors.grey),
              // textStyle: TextStyle(color: tm.black),
              verticalOffset: -50.0,
              child: FittedBoxN(
                child: TextN(
                  '근활성도',
                  fontSize: tm.s16,
                  color: tm.mainBlue,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
      asSizedBox(width: 18),
    ],
  );
}

//==============================================================================
// barChart
//==============================================================================
Widget _buttonDetailView(BuildContext context) {
  return textButtonG(
    title: '자세히 보기'.tr,
    textColor: tm.mainBlue,
    fontSize: tm.s16,
    fontWeight: FontWeight.bold,
    borderColor: tm.softBlue,
    width: asWidth(105),
    //위젯에서 자동 스케일
    height: asHeight(40),
    touchWidth: asWidth(125),
    touchHeight: asHeight(60),
    onTap: (() {
      Get.off(() => const MeasureDetail());
      gvMeasure.isViewMeasureSimple = false;
      // 공유메모리 저장
      gv.spMemory.write('isViewMeasureSimple', gvMeasure.isViewMeasureSimple);
    }),
  );
}

//==============================================================================
// '훌룡해요!!' 애니메이션
//==============================================================================
Widget _blinkAnimation(BuildContext context) {
  return Obx(() {
    gvMeasure.animationCounter.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BounceCircle(
          radius: MediaQuery.of(context).size.width / 4,
          center: Alignment.topLeft,
          color: tm.mainBlue,
          // counter: gvMeasure.animationCounter.value
        ),
        BounceCircle(
          radius: MediaQuery.of(context).size.width / 4,
          center: Alignment.topRight,
          color: tm.mainBlue,
          // counter: gvMeasure.animationCounter.value
        ),
      ],
    );
  });
}
