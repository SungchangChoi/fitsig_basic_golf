import '/F0_BASIC/common_import.dart';

GlobalKey<_DefaultMvcSliderState> keyDefaultMvcSlider = GlobalKey();
//외부 갱신 제어용 글로벌 key
//==============================================================================
// mvc slider
//==============================================================================

class DefaultMvcSlider extends StatefulWidget {
  const DefaultMvcSlider({Key? key}) : super(key: key);

  @override
  State<DefaultMvcSlider> createState() => _DefaultMvcSliderState();
}

class _DefaultMvcSliderState extends State<DefaultMvcSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //화면 창 사라질 때 슬라이드 값 공유메모리에 저장
    gv.spMemory.write('mvcDefaultValue', gv.setting.mvcDefaultValue.value);
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: tm.mainBlue,
            inactiveTrackColor: tm.grey01,
            thumbColor: tm.mainBlue,
            trackHeight: asHeight(5),
            // trackShape: CustomTrackShape(),
            overlayColor: tm.softBlue,
            overlayShape: RoundSliderOverlayShape(overlayRadius: asHeight(17)),
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: asHeight(10),
              elevation: 0,
            ),
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(asHeight(2)),
            child: Slider(
              value: gv.setting.mvcDefaultValue.value,
              min: 1.0,
              max: 5,
              //maxLevel,
              divisions: 90,
              // label: gvMeasure.sliderValueTargetPrm.value.round().toString(),
              onChanged: ((double value) {
                setState(() {
                  gv.setting.mvcDefaultValue.value = value;
                  // RefreshSetMuscle.mvc(); //mvc 관련 값 갱신
                });
              }),
            ),
          ),
        ),
      ],
    );
  }
}

//==============================================================================
// refresh slider
//==============================================================================
refreshDefaultMvcSlider() {
  keyDefaultMvcSlider.currentState?.refresh();
}