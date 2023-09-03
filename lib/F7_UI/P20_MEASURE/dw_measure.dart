import '/F0_BASIC/common_import.dart';

//==============================================================================
// 통신 불량 icon
//==============================================================================

Widget btLinkBad({double height = 80, double opacity = 1}) {
  return Obx(() {
    bool isViewBtError =
        gv.deviceStatus[0].btLinkQualityStatus.value == EmlBtLinkQualityStatus.packetError;
    bool isViewBtWarning =
        gv.deviceStatus[0].btLinkQualityStatus.value == EmlBtLinkQualityStatus.bpsLow;
    return isViewBtError
        // 패킷 에러가 발생한 경우 - 예외처리 실행
        ? BtLinkBadBlink(
            height: height,
            color: tm.red,
            opacity: opacity,
          )
        : isViewBtWarning
          // 통신 속도가 저하된 경우 - 경고만
            ? BtLinkBadBlink(
                height: height,
                color: tm.grey03,
                opacity: opacity,
              )
            : Container();
  });
}

//==============================================================================
//  1RM을 현재 값으로 갱신 버튼
//==============================================================================
Widget reset1RM() {
  return
    wButtonAwGeneral(
      onTap: () {
          // true로 설정하면, 라이브러리에서 값 낮추기 1회 실행
          dm[0].g.parameter.mlFlagMvcRefAsNew = true;
          // 한번 비활성화 하면, 전극을 새로 붙이기 전까지 계속 비활성화
          WidgetsBinding.instance.addPostFrameCallback((_) {
            gv.deviceData[0].disableReset1RM.value = true;
          });
        },
        isViewBorder: false,
        borderColor: Colors.transparent,
        height: asHeight(20),
        // width: asWidth(140),
        touchHeight: asHeight(40),
        padTouchWidth: asWidth(10),
        // touchWidth: asWidth(160),
        child: Row(
          children: [
            Container(
              width: asWidth(18),
              height: asHeight(20),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/ic_refresh.png',
                fit: BoxFit.scaleDown,
                height: asHeight(20),
              ),
            ),
            SizedBox(width: asWidth(10)),
            TextN(
              '최대근력 재설정',//'현재 값으로 갱신',
              fontWeight: FontWeight.bold,
              fontSize: tm.s16,
              color: tm.mainBlue,
            ),
          ],
        ),
      );
}

//==============================================================================
// 깜빡이는 애니메이션
//==============================================================================
late Timer _opacityTimer = Timer(const Duration(milliseconds: 1000), () {});
bool _visible = false;

class BtLinkBadBlink extends StatefulWidget {
  final double height;
  final Color color;
  final double opacity;

  const BtLinkBadBlink(
      {this.height = 40, this.opacity = 1, this.color = Colors.red, Key? key})
      : super(key: key);

  @override
  State<BtLinkBadBlink> createState() => _BtLinkBadBlinkState();
}

class _BtLinkBadBlinkState extends State<BtLinkBadBlink> {
  @override
  void initState() {
    super.initState();
    _visible = true;
    _opacityTimer.cancel();
    _opacityTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _visible = !_visible;
      });
    });
  }

  @override
  void dispose() {
    _opacityTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? widget.opacity : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Image.asset(
        'assets/icons/device_bluetooth_white_512.png',
        fit: BoxFit.fitHeight,
        height: widget.height,
        color: widget.color,
      ),
    );
  }
}
