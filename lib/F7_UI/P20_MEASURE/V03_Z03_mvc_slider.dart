import '/F0_BASIC/common_import.dart';

GlobalKey<_MvcSliderState> keyMvcSlider = GlobalKey();
//외부 갱신 제어용 글로벌 key
//==============================================================================
// mvc slider
//==============================================================================

class MvcSlider extends StatefulWidget {
  const MvcSlider({Key? key}) : super(key: key);

  @override
  State<MvcSlider> createState() => _MvcSliderState();
}

class _MvcSliderState extends State<MvcSlider> {
  @override
  void initState() {
    initSliderValue();
    super.initState();
  }

  @override
  void dispose() {
    // 왜 아래 구문이 있는가?
    // 슬라이드 값 반영이 안되는 현상이 있어 주석처리 (220920)
    // 이전에 아래 구문을 넣은 이유를 찾지 못하여 주석처리
    // gvMeasure.sliderValueMvc = gv.deviceData[0].mvcLevel.value;
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  //-------------------------------------------------------
  // 슬라이드 관련 값 외부 초기화를 위한 함수
  void initSliderValue() {
    // index = gv.control.idxMuscle.value;
    // 기존 설정 된 근력운동 강도 값 읽어오기
    gvMeasure.sliderValueMvc = gv.deviceData[0].mvc.value;
    if (gvMeasure.sliderValueMvc < 0.0) {
      gvMeasure.sliderValueMvc = 0.01;
    } else if (gvMeasure.sliderValueMvc > 4.0) {
      gvMeasure.sliderValueMvc = 4.0;
    }
    // 슬라이더 범위 설정하기
    // if (gvMeasure.sliderValueMvc > 3) {
    //   gvMeasure.sliderMvcMaxRange = 3;
    // }
    // else if (gvMeasure.sliderValueMvc > 2) {
    //   gvMeasure.sliderMvcMaxRange = 2;
    // }
    // else if (gvMeasure.sliderValueMvc > 1) {
    //   gvMeasure.sliderMvcMaxRange = 1;
    // }

    if (gvMeasure.sliderValueMvc > 1) {
      gvMeasure.sliderMvcMaxRange = 4.0;
    } else {
      gvMeasure.sliderMvcMaxRange = 1.0; //대부분 여기 사용
    }
    // _division = gvMeasure.sliderMvcMaxRange * 100 + 99;
  }

  static int _division = 0; //gvMeasure.sliderMvcMaxRange * 100 + 99;

  @override
  Widget build(BuildContext context) {
    _division = (gvMeasure.sliderMvcMaxRange * 100).toInt();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            //----------------------------------------------------------------------
            // 슬라이더
            //----------------------------------------------------------------------
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: tm.mainBlue,
                    inactiveTrackColor: tm.grey01,
                    thumbColor: tm.fixedWhite,
                    trackHeight: asHeight(5),
                    overlayColor: Colors.transparent,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: asHeight(17),
                      elevation: 3,
                    ),
                    valueIndicatorShape:
                        const PaddleSliderValueIndicatorShape(),
                  ),
                  child: Slider(
                    value: gvMeasure.sliderValueMvc,
                    min: 0.00,
                    max: gvMeasure.sliderMvcMaxRange,
                    divisions: _division,
                    onChanged: ((double value) {
                      setState(() {
                        gvMeasure.sliderValueMvc = value.toPrecision(2);
                        if (gvMeasure.sliderValueMvc == 0.0) {
                          gvMeasure.sliderValueMvc = 0.01;
                        }
                        RefreshSetMuscle.setMvc(); //근육설정 팝업만 갱신
                      });
                    }),
                  ),
                ),
              ],
            ),
            //----------------------------------------------------------------------
            // 하단 작은 버튼
            //----------------------------------------------------------------------
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: tm.mainBlue,
                    inactiveTrackColor: tm.grey01,
                    thumbColor: tm.mainBlue,
                    trackHeight: asHeight(0),
                    overlayColor: tm.softBlue,
                    overlayShape:
                        RoundSliderOverlayShape(overlayRadius: asHeight(17)),
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: asHeight(6),
                      elevation: 0,
                    ),
                    valueIndicatorShape:
                        const PaddleSliderValueIndicatorShape(),
                  ),
                  child: Slider(
                    value: gvMeasure.sliderValueMvc,
                    min: 0.00,
                    max: gvMeasure.sliderMvcMaxRange,
                    divisions: _division,
                    onChanged: ((double value) {
                      setState(() {
                        gvMeasure.sliderValueMvc = value.toPrecision(2);
                        if (gvMeasure.sliderValueMvc == 0.0) {
                          gvMeasure.sliderValueMvc = 0.01;
                        }
                        RefreshSetMuscle.setMvc(); //근육설정 팝업만 갱신
                      });
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),

        // SliderTheme(
        //   data: SliderThemeData(
        //     activeTrackColor: tm.blue,
        //     inactiveTrackColor: tm.grey01,
        //     thumbColor: tm.blue,
        //     trackHeight: asHeight(5),
        //     // trackShape: CustomTrackShape(),
        //     overlayColor: tm.blue.withOpacity(0.2),
        //     overlayShape: RoundSliderOverlayShape(overlayRadius: asHeight(17)),
        //     thumbShape: RoundSliderThumbShape(
        //       enabledThumbRadius: asHeight(10),
        //       elevation: 0,
        //     ),
        //     valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        //   ),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(asHeight(2)),
        //     child: Slider(
        //       value: gvMeasure.sliderValueMvc,
        //       min: 0.00,
        //       max: gvMeasure.sliderMvcMaxRange,
        //       //maxLevel,
        //       divisions: _division,
        //       // label: gvMeasure.sliderValueTargetPrm.value.round().toString(),
        //       onChanged: ((double value) {
        //         setState(() {
        //           gvMeasure.sliderValueMvc = value.toPrecision(2);
        //           if (gvMeasure.sliderValueMvc == 0.0) {
        //             gvMeasure.sliderValueMvc = 0.01;
        //           }
        //           RefreshSetMuscle.setMvc(); //근육설정 팝업만 갱신
        //           // RefreshSetMuscle.all();
        //         });
        //       }),
        //     ),
        //   ),
        // ),

        asSizedBox(height: 26),
        Align(
          alignment: Alignment.centerLeft,
          child: TextN(
            '조절 범위',
            fontSize: tm.s14,
            fontWeight: FontWeight.bold,
            color: tm.black,
          ),
        ),
        asSizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textButtonI(
              width: asWidth(158),
              height: asHeight(58),
              radius: asHeight(8),
              backgroundColor: (gvMeasure.sliderMvcMaxRange == 1.0)
                  ? tm.softBlue
                  : tm.grey01,
              borderColor: (gvMeasure.sliderMvcMaxRange == 1.0)
                  ? tm.mainBlue
                  : Colors.transparent,
              onTap: () async {
                gvMeasure.sliderMvcMaxRange = (1).toDouble().toPrecision(2);
                if (gvMeasure.sliderMvcMaxRange < gvMeasure.sliderValueMvc) {
                  gvMeasure.sliderValueMvc = gvMeasure.sliderMvcMaxRange;
                  RefreshSetMuscle.setMvc(); //근육설정 팝업만 갱신
                }
                //--------------------------------------------
                // 범위에 따라 분할 값 조절
                _division = (gvMeasure.sliderMvcMaxRange * 100).toInt();
                setState(() {});
              },
              title: '0~${convertMvcToDisplayValue(1, fractionDigits: 0)}',
              textColor:
                  (gvMeasure.sliderMvcMaxRange == 1.0) ? tm.mainBlue : tm.grey03,
              fontSize: tm.s14,
              fontWeight: FontWeight.bold,
              borderLineWidth: asWidth(2),
            ),
            SizedBox(width: asWidth(8.0)),
            textButtonI(
              width: asWidth(158),
              height: asHeight(58),
              radius: asHeight(8),
              backgroundColor: (gvMeasure.sliderMvcMaxRange == 4.0)
                  ? tm.softBlue
                  : tm.grey01,
              borderColor: (gvMeasure.sliderMvcMaxRange == 4.0)
                  ? tm.mainBlue
                  : Colors.transparent,
              onTap: () {
                gvMeasure.sliderMvcMaxRange = (4).toDouble().toPrecision(2);
                if (gvMeasure.sliderMvcMaxRange < gvMeasure.sliderValueMvc) {
                  gvMeasure.sliderValueMvc = gvMeasure.sliderMvcMaxRange;
                  RefreshSetMuscle.setMvc(); //근육설정 팝업만 갱신
                }

                //--------------------------------------------
                // 범위에 따라 분할 값 조절
                _division = (gvMeasure.sliderMvcMaxRange * 100).toInt();
                setState(() {});
              },
              title: '0~${convertMvcToDisplayValue((4), fractionDigits: 0)}'.tr,
              textColor:
                  (gvMeasure.sliderMvcMaxRange == 4.0) ? tm.mainBlue : tm.grey03,
              fontSize: tm.s14,
              fontWeight: FontWeight.bold,
              borderLineWidth: asWidth(2),
            ),
          ],
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: List.generate(
        //     2,
        //     (index) => textButtonBasic(
        //       title:
        //           '0~${convertMvcToDisplayValue((index * 3 + 1), fractionDigits: 0)}',
        //       fontSize: tm.s16,
        //       radius: asHeight(8),
        //       borderColor: gvMeasure.sliderMvcMaxRange == (index * 3 + 1)
        //           ? tm.blue.withOpacity(0.5)
        //           : tm.grey02,
        //       textColor: gvMeasure.sliderMvcMaxRange == (index * 3 + 1)
        //           ? tm.blue
        //           : tm.grey03,
        //       backgroundColor:
        //           gvMeasure.sliderMvcMaxRange == (index * 3 + 1)
        //               ? tm.blue.withOpacity(0.1)
        //               : Colors.transparent,
        //       onTap: (() {
        //         gvMeasure.sliderMvcMaxRange =
        //             (index * 3 + 1).toDouble().toPrecision(2);
        //         if (gvMeasure.sliderMvcMaxRange <
        //             gvMeasure.sliderValueMvc) {
        //           gvMeasure.sliderValueMvc = gvMeasure.sliderMvcMaxRange;
        //           RefreshSetMuscle.setMvc(); //근육설정 팝업만 갱신
        //         }
        //
        //         //--------------------------------------------
        //         // 범위에 따라 분할 값 조절
        //         _division = (gvMeasure.sliderMvcMaxRange * 100).toInt();
        //         setState(() {});
        //       }),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

//==============================================================================
// refresh slider
//==============================================================================
// refreshMvcSlider() {
//   // keyMvcSlider.currentState?.refresh();
// }

initMvcSlider() {
  keyMvcSlider.currentState?.initSliderValue();
}
