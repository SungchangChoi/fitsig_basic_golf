import '/F0_BASIC/common_import.dart';

//==============================================================================
// emg 바 그래프
//==============================================================================
class LiveAoeBar extends StatelessWidget {
  final double width;
  final double height;

  const LiveAoeBar({this.height = 200, this.width = 100, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //-------------------------- 레이아웃 / 모양
    double radiusTop = 30;
    double radiusBottom = 30;
    int d = 0;

    return Stack(
      alignment: Alignment.bottomCenter, //밑바닥에서 정렬
      children: [
        //----------------------------------------------------------------------
        // 라이브 그래프 - 실시간 변화 영역
        //----------------------------------------------------------------------
        Obx(() {
          double  aoeSet = gv.deviceData[d].aoeSet.value;
          return basicGaugeBarLive(
            //--------------------- value
            gaugeValue: aoeSet,
            //--------------------- emg bar shape
            width: width,
            height: height,
            radiusTop: radiusTop,
            radiusBottom: radiusBottom,
            backgroundColor: tm.grey02.withOpacity(0.6),
            valueBarColor: tm.mainGreen.withOpacity(0.9),
            //--------------------- guide line
            guideLineDashWidth: 2,
            guideLineThickness: 2,
            guideLineColor: tm.green01.withOpacity(0.5),
            //--------------------- text
            textSize: tm.s20,
            textColor: tm.grey04,
          );
        }),
        //----------------------------------------------------------------------
        // heart
        //----------------------------------------------------------------------
        // basicGaugeHeart(
        //   width: width,
        //   height: height,
        //   color1: tm.white.withOpacity(0.5), //맨 아래
        //   color2: tm.white.withOpacity(0.3), //중간
        //   color3: tm.white.withOpacity(0.7), //맨 위
        // ),
      ],
    );
  }
}
