import '/F0_BASIC/common_import.dart';

GlobalKey<_TargetSliderState> keyTargetSlider = GlobalKey();
//외부 갱신 제어용 글로벌 key

// import 'package:syncfusion_flutter_sliders/sliders.dart';
//==============================================================================
// target slider
// 적절한 슬라이더를 못찾아 일단 3개를 중첩하여 구현함
// 나중에 시간되면 별도의 슬라이더 제작도 검토 (22.7.2)
//==============================================================================
class TargetSlider extends StatefulWidget {
  const TargetSlider({Key? key}) : super(key: key);

  @override
  State<TargetSlider> createState() => _TargetSliderState();
}

class _TargetSliderState extends State<TargetSlider> {
  // int index = gv.control.idxMuscle.value; //.value;

  // 슬라이드 최대 최소 값 정의
  double sliderMin = 20;
  double sliderMax = 100;
  int sliderDivision = 100;

  @override
  void initState() {
    // 기존 설정 된 근력운동 강도 값 읽어오기
    gvMeasure.sliderValueTargetPrm =
        gv.deviceData[0].targetPrm.value.toDouble();
    super.initState();
  }

  @override
  void dispose() {
    // 나갈 때 저장하는 이유는?
    gvMeasure.sliderValueTargetPrm =
        gv.deviceData[0].targetPrm.value.toDouble();
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: asHeight(9)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //----------------------------------------------------------------------
          // 슬라이드 트랙
          //----------------------------------------------------------------------
          Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: tm.mainBlue,
                  inactiveTrackColor: tm.grey01,
                  thumbColor: tm.mainBlue,
                  trackHeight: asHeight(90),
                  trackShape: CustomTrackShape(),
                  // trackShape: const RectangularSliderTrackShape(),
                  overlayColor: Colors.transparent,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: asHeight(0),
                    elevation: 0,
                  ),
                ),
                // 슬라이드 트랙 모양 결정
                child:
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(asHeight(12)),
                ClipPath(
                  clipper: MyCustomClipper(),
                  child: Slider(
                    thumbColor: Colors.transparent,
                    value: gvMeasure.sliderValueTargetPrm,
                    min: sliderMin,
                    max: sliderMax,
                    divisions: sliderDivision,
                    onChanged: ((double value) {}),
                  ),
                ),
              ),
              //------------------------------------------------------------------
              // 하단 슬라이드 버튼 크기를 고려한 높이 맞춤
              asSizedBox(height: 17),
              //아래 측 over lay 값과 동일하게
            ],
          ),

          //----------------------------------------------------------------------
          // 하단 큰 버튼
          //----------------------------------------------------------------------
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: tm.mainBlue,
                  inactiveTrackColor: tm.grey01,
                  thumbColor: tm.fixedWhite,
                  trackHeight: asHeight(0),
                  trackShape: const RectangularSliderTrackShape(),
                  overlayColor: Colors.transparent,
                  overlayShape:
                      RoundSliderOverlayShape(overlayRadius: asHeight(17)),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: asHeight(17),
                    elevation: 3,
                  ),
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                ),
                child: Slider(
                  value: gvMeasure.sliderValueTargetPrm,
                  min: sliderMin,
                  max: sliderMax,
                  divisions: sliderDivision,
                  onChanged: ((double value) {
                    // print('target_slider :: outer slider value = $value');
                    if (gvMeasure.sliderValueTargetPrm != value) {
                      setState(() {
                        gvMeasure.sliderValueTargetPrm = value;
                        RefreshSetMuscle.all();
                      });
                      saveMuscleData();
                    }
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
              // asSizedBox(height: 73),

              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: tm.mainBlue,
                  inactiveTrackColor: tm.grey01,
                  thumbColor: tm.mainBlue,
                  trackHeight: asHeight(0),
                  // trackShape: CustomTrackShape(),
                  overlayColor: tm.softBlue,
                  overlayShape:
                      RoundSliderOverlayShape(overlayRadius: asHeight(17)),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: asHeight(6),
                    elevation: 0,
                  ),
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                ),
                child: Slider(
                  value: gvMeasure.sliderValueTargetPrm,
                  min: sliderMin,
                  max: sliderMax,
                  divisions: sliderDivision,
                  // label: gvMeasure.sliderValueTargetPrm.value.round().toString(),
                  onChanged: ((double value) {
                    // print('target_slider :: inner slider value = $value');
                    if (gvMeasure.sliderValueTargetPrm != value) {
                      setState(() {
                        gvMeasure.sliderValueTargetPrm = value;
                        RefreshSetMuscle.all();
                      });
                      saveMuscleData();
                    }
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//==============================================================================
// 슬라이드 크기를 좌우 끝까지 늘리는 기능
//==============================================================================
class CustomTrackShape extends RectangularSliderTrackShape {
  // RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx + asHeight(17);
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 2 * asHeight(17);
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = asHeight(12);
    double indentWidth = asHeight(17);
    Path path = Path()
      ..moveTo(radius + indentWidth, 0)
      ..lineTo(size.width - radius - indentWidth, 0)
      ..arcToPoint(Offset(size.width - indentWidth, radius),
          radius: Radius.circular(radius))
      ..lineTo(size.width - indentWidth, size.height - radius)
      ..arcToPoint(Offset(size.width - indentWidth-radius, size.height),
          radius: Radius.circular(radius))
      ..lineTo(radius + indentWidth, size.height)
      ..arcToPoint(Offset(indentWidth, size.height- radius),
          radius: Radius.circular(radius))
      ..lineTo(indentWidth, radius)
      ..arcToPoint(Offset(radius + indentWidth, 0),
          radius: Radius.circular(radius))
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//==============================================================================
// refresh slider
//==============================================================================
// refreshTargetSlider() {
//   keyTargetSlider.currentState?.refresh();
// }
