import '/F0_BASIC/common_import.dart';

//==============================================================================
// measure detail
// todo : 앱의 백 버튼 대응 stateful 변경 후 dispose 에 종료 절차 추가 (강제 종료 처리 검토)
//==============================================================================

class MeasureDetail extends StatelessWidget {
  const MeasureDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wakelock.enable(); //화면 켜짐 유지 - 측정 중에는 꺼지지 않음
    return Material(
      color: tm.white,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            //------------------------------------------------------------------
            // 목표 영역 성공 애니메이션
            // ripplesAnimationDetail(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //--------------------------------------------------------------
                // 상단 바
                topBarGuide(context),
                //--------------------------------------------------------------
                // 중간 그래프
                // Expanded(child: asSizedBox(height: 70)),
                _detailGraphChart(context),
                //--------------------------------------------------------------
                // 운동량 바
                // asSizedBox(height: 30),
                // _exerciseGaugeBar(),
                //--------------------------------------------------------------
                // 목표달성 바
                // asSizedBox(height: 18),
                // _targetGaugeBar(),
                //--------------------------------------------------------------
                // 주파수 바
                // asSizedBox(height: 17),
                // _frequencyBar(),

                //----------------------------------------------------------------------
                // 중간 여유
                // asSizedBox(height: 43),
                //----------------------------------------------------------------------
                // 반복 횟수 및 묙포 카운트
                // Obx(() {
                //   int countNum = gv.deviceData[0].countNum.value;
                //   int repNum = gv.deviceData[0].targetCount.value;
                //   // gv.dbMuscleIndexes[gv.control.idxMuscle.value].targetCount;
                //   return SizedBox(
                //     height: asHeight(16),
                //     child: TextN(
                //       '$countNum / $repNum',
                //       color: tm.mainBlue.withOpacity(0.5),
                //       fontSize: tm.s16,
                //       fontWeight: FontWeight.bold,
                //       height: 1,
                //     ),
                //   );
                // }),
                //--------------------------------------------------------------
                // 간단히 보기 버튼
                // _buttonSimpleView(context),
                //--------------------------------------------------------------
                // 하단 버튼 영역
                const BottomButtonControl(),
              ],
            ),
            //------------------------------------------------------------------
            // 전극 접촉 불량 경고문구
            // ElectrodeWarning(),

            //------------------------------------------------------------------
            // 블루투스 연결 불량
            // btLinkBad(height: asHeight(300), opacity: 0.8),

            //------------------------------------------------------------------
            // 1RM을 현재 값으로 갱신(reset)
            // Positioned(
            //   top: asHeight(103),
            //   left: asWidth(0),
            //   child: Container(
            //     // color: Colors.yellow,
            //     width: asWidth(360),
            //     padding: EdgeInsets.symmetric(horizontal: asWidth(8)),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         //--------------------------------------------------------------
            //         // 최대근력 재설정
            //         Obx(() {
            //           bool isVisible = !gv.deviceData[0].disableReset1RM.value &&
            //               (gv.deviceData[0].mvc.value <= dm[0].g.parameter.mvcRef);
            //           return Visibility(
            //             visible: isVisible,
            //             child: reset1RM(), // asHeight(103)),
            //           );
            //         }),
            //         //--------------------------------------------------------------
            //         // 심박 (감지된 경우에만 표시)
            //         const HeartRateDisplay(),
            //       ],
            //     ),
            //   ),
            // ),

            //------------------------------------------------------------------
            // 최대근력 갱신!, 1셋트 완료! 애니메이션 위젯
            // Obx(() {
            //   return AnimatedPositioned(
            //     duration: const Duration(milliseconds: 300),
            //     top: gvMeasure.isGuideDownPosition == false
            //         ? asHeight(83)
            //         : gvMeasure.isMvcChanged.value
            //             ? asHeight(105)
            //             : asHeight(83),
            //     width: asWidth(360),
            //     height: gvMeasure.guideWidgetHeight,
            //     child: IgnorePointer(
            //       child: AnimatedOpacity(
            //         opacity: gvMeasure.isShowingGuide.value ? 1.0 : 0.0,
            //         //점점 안보이게
            //         duration: const Duration(milliseconds: 800),
            //         child: Container(
            //           color: gvMeasure.guideBackgroundColor,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               if (gvMeasure.guideImage != null)
            //                 gvMeasure.guideImage!,
            //               SizedBox(
            //                 width: asWidth(8),
            //               ),
            //               TextN(
            //                 gvMeasure.guideText,
            //                 fontSize: tm.s16,
            //                 fontWeight: FontWeight.bold,
            //                 color: tm.white,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}

//==============================================================================
// barChart
//==============================================================================
Widget _detailGraphChart(BuildContext context) {
  return Container(
    height: asHeight(180),
    padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //------------------------------------------------------------------------
        // 그래프
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //--------------------------------------------------------------------
            // time 그래프
            //--------------------------------------------------------------------
            LiveEmgTimeChart(
              width: asWidth(234),
              height: asHeight(180),
            ),

            //--------------------------------------------------------------------
            // emg 바 그래프
            //--------------------------------------------------------------------
            asSizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LiveEmgBar(
                  width: asWidth(80),
                  height: asHeight(180),
                  radiusTop: asHeight(15),
                  radiusBottom: asHeight(15),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

//==============================================================================
// 운동량 가로 바
//==============================================================================
Widget _exerciseGaugeBar() {
  return Container(
    height: asHeight(37),
    padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
    // color: Colors.yellow,
    child: Row(
      children: [
        //------------------------------------------------------------------------
        // 제목과 바
        Obx(() {
          double aoeSet = gv.deviceData[0].aoeSet.value;
          // RxDouble exerciseGauge = 0.5.obs; //신호처리 결과값 연결
          return SizedBox(
            width: asWidth(324),
            child: Column(
              children: [
                //------------------------------------------ 제목
                Container(
                  height: asHeight(16),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //--------------------------- 운동량 제목
                      TextN(
                        '1세트 운동량'.tr,
                        fontSize: tm.s16,
                        color: tm.black,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                      //--------------------------- % 표시
                      TextN(
                        '${toStrFixedAuto(aoeSet * 100)}%',
                        fontSize: tm.s18,
                        color: tm.mainGreen,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                asSizedBox(height: 9),
                //------------------------------------------ bar
                basicHorizontalBarLive(
                  value: aoeSet,
                  //exerciseGauge.value,
                  width: asWidth(324),
                  height: asHeight(6),
                  backgroundColor: tm.grey02,
                  barColor: tm.mainGreen,
                  isViewMaxLine: aoeSet <= 1 ? false : true,
                  maxLineColor: tm.mainGreen,
                  maxLineHeight: asHeight(6) * 2,
                  maxLineWidth: 3,
                  thumbSize: asHeight(6) * 2,
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

//==============================================================================
// 목표달성 가로 바
//==============================================================================
Widget _targetGaugeBar() {
  return Container(
    height: asHeight(37),
    padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
    child: Row(
      children: [
        //------------------------------------------------------------------------
        // 제목과 바
        Obx(() {
          double aoeTargetSet = gv.deviceData[0].aoeTargetSet.value;
          return SizedBox(
            width: asWidth(324),
            child: Column(
              children: [
                //------------------------------------------ 제목
                Container(
                  height: asHeight(16),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //--------------------------- 운동량 제목
                      TextN(
                        '목표달성'.tr,
                        fontSize: tm.s16,
                        color: tm.black,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                      //--------------------------- % 표시
                      TextN(
                        '${toStrFixedAuto(aoeTargetSet * 100)}%',
                        fontSize: tm.s18,
                        color: tm.mainBlue,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                asSizedBox(height: 9),
                //------------------------------------------ bar
                basicHorizontalBarLive(
                  value: aoeTargetSet,
                  width: asWidth(324),
                  height: asHeight(6),
                  backgroundColor: tm.grey02,
                  barColor: tm.mainBlue,
                  isViewMaxLine: aoeTargetSet <= 1 ? false : true,
                  maxLineColor: tm.mainBlue,
                  maxLineHeight: asHeight(6) * 2,
                  maxLineWidth: 3,
                  thumbSize: asHeight(6) * 2,
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

//==============================================================================
// 주파수 바
//==============================================================================
Widget _frequencyBar() {
  return Container(
    height: asHeight(16),
    // width: asWidth(360-36),
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //--------------------------------------------------------------------
            // 제목
            SizedBox(
              width: asWidth(107),
              height: asHeight(16),
              child: TextN(
                '주파수 변화(Hz)'.tr,
                fontSize: tm.s16,
                color: tm.black,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ],
        ),
        Obx(() {
          //-------------------- 주파수 최대 최소
          double freqBegin = gv.deviceData[0].freqBegin.value;
          double freqEnd = gv.deviceData[0].freqEnd.value;

          double valueH = max(freqBegin, freqEnd);
          double valueL = min(freqBegin, freqEnd);

          //-------------------- 바 최대 영역 : 보통 고정이지만, 필요에 따라 조절
          double barMax = max(GvDef.freqDisplayMax, valueH); //가장 큰 값
          double barMin = min(GvDef.freqDisplayMin, valueL); //가장 작은 값

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //------------------------------------------------------------------
              // 그래프
              rangePatternHorizontalBar(
                  width: asWidth(100),
                  height: asHeight(14),
                  valueHigh: valueH,
                  valueLow: valueL,
                  barMax: barMax,
                  barMin: barMin,
                  numberOfBar: 30,
                  barRadius: 10,
                  intervalWidthRatioVsBar: 1,
                  barColor: freqBegin > freqEnd
                      ? tm.mainBlue //감소하면 blue
                      : tm.mainGreen,
                  //주파수가 증가하면 black
                  barBackgroundColor: tm.grey02),
              //------------------------------------------------------------------
              // Text
              asSizedBox(width: 13),
              Row(
                children: [
                  Container(
                    width: asWidth(36),
                    height: asHeight(16),
                    alignment: Alignment.center,
                    child: FittedBoxN(
                      child: TextN(
                        '$freqBegin',
                        fontSize: tm.s14,
                        color: tm.grey03,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                  asSizedBox(width: 3),
                  Icon(
                    Icons.double_arrow_rounded,
                    size: tm.s16,
                    color: tm.grey03,
                  ),
                  asSizedBox(width: 3),
                  Container(
                    width: asWidth(36),
                    height: asHeight(16),
                    alignment: Alignment.center,
                    child: FittedBoxN(
                      child: TextN(
                        '$freqEnd',
                        fontSize: tm.s14,
                        color: tm.black,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        })
      ],
    ),
  );
}

//==============================================================================
// barChart
//==============================================================================
Widget _buttonSimpleView(BuildContext context) {
  return textButtonG(
    title: '간단히 보기'.tr,
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
      Get.off(() => const MeasureSimple());
      gvMeasure.isViewMeasureSimple = true;
      // 공유메모리 저장
      gv.spMemory.write('isViewMeasureSimple', gvMeasure.isViewMeasureSimple);
    }),
  );
}

// //==============================================================================
// // 주파수 바
// //==============================================================================
// Widget _frequencyBar() {
//   //--------------------------- 크기
//   double barWidth = Get.width * 154 / 360;
//   double barHeight = Get.height * 14 / 800;
//   //--------------------------- 공간 조절
//   double padWidth18 = Get.width * 18 / 360;
//   double padHeight4 = Get.height * 4 / 800;
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           //--------------------------------------------------------------------
//           // 시작 여유공간
//           SizedBox(width: padWidth18),
//           //--------------------------------------------------------------------
//           // 제목
//           TextN(
//             '주파수 변화(Hz)'.tr,
//             fontSize: tm.s16,
//             color: tm.black,
//             fontWeight: FontWeight.w400,
//           ),
//         ],
//       ),
//       Obx(() {
//         //-------------------- 주파수 최대 최소
//         RxDouble maxFreq = (81.0).obs;
//         RxDouble minFreq = (80.0).obs;
//
//         maxFreq.value = max(maxFreq.value, minFreq.value); //크기 역전 방지
//
//         //-------------------- 바 최대 영역 : 보통 고정이지만, 필요에 따라 조절
//         double barMax = 85;
//         double barMin = 70;
//         barMax = max(barMax, maxFreq.value);
//         barMin = min(barMin, minFreq.value);
//         //-------------------- 글씨 위치 계산
//         double rangeTotal = barMax - barMin;
//         double textLeftRatio = (minFreq.value - barMin) / rangeTotal;
//         double textRightRatio = 1 - ((maxFreq.value - barMin) / rangeTotal);
//
//
//
//         //-------------------- 글씨 중첩 방지
//         // 원 디자인에서 글씨가 한쪽으로 쏠린경우,좁은 경우 등에스 텍스트 위치가 불분명
//         // 가로 나란히로 디자인 변경 후 진행
//         // print(textLeftRatio);
//         // print(textRightRatio);
//         // double textWidth = tm.s14 * 8 + tm.s6;
//         // double textRatio = textWidth / barWidth;
//         // print(textRatio);
//
//         // if (textLeftRatio + textRightRatio > textRatio){
//         //   double padScale = textRatio / (textLeftRatio + textRightRatio);
//         //   textLeftRatio = textLeftRatio  * padScale;
//         //   textRightRatio = textRightRatio * padScale;
//         // }
//         // print(textLeftRatio);
//         // print(textRightRatio);
//
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 //--------------------------------------------------------------
//                 // 주파수 바
//                 rangePatternHorizontalBar(
//                     width: barWidth,
//                     height: barHeight,
//                     valueHigh: maxFreq.value,
//                     valueLow: minFreq.value,
//                     barMax: barMax,
//                     barMin: barMin,
//                     numberOfBar: 20,
//                     barRadius: 10,
//                     intervalWidthRatioVsBar: 1.5,
//                     barBackgroundColor: tm.grey02),
//                 //--------------------------------------------------------------
//                 // 텍스트
//                 SizedBox(height: padHeight4),
//
//                 SizedBox(
//                   width: barWidth,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       //--------------------------------------------------------
//                       // 왼쪽 텍스트
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(width: barWidth * textLeftRatio),
//                           TextN(
//                             minFreq.value.toStringAsFixed(1),
//                             fontSize: tm.s14,
//                             color: tm.grey03,
//                             fontWeight: FontWeight.w400,
//                           )
//                         ],
//                       ),
//                       SizedBox(width: tm.s6),
//                       //--------------------------------------------------------
//                       // 오른쪽 텍스트
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           TextN(
//                             maxFreq.value.toStringAsFixed(1),
//                             fontSize: tm.s14,
//                             color: tm.grey03,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           SizedBox(width: barWidth * textRightRatio),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             //--------------------------------------------------------------------
//             // 끝 여유공간
//             SizedBox(width: padWidth18),
//           ],
//         );
//       })
//     ],
//   );
// }
