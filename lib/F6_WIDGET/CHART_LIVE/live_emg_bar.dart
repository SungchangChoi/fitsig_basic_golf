import '/F0_BASIC/common_import.dart';

//==============================================================================
// emg 바 그래프
//==============================================================================
class LiveEmgBar extends StatelessWidget {
  final double width;
  final double height;
  final double radiusTop;
  final double radiusBottom;

  const LiveEmgBar(
      {this.height = 200,
      this.width = 100,
      this.radiusTop = 30,
      this.radiusBottom = 30,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int d = 0;
    double targetHigh =
        (dm[d].g.parameter.targetP1Rm + DspCommonParameter.targetPRange) / 100;
    double targetLow =
        (dm[d].g.parameter.targetP1Rm - DspCommonParameter.targetPRange) / 100;

    return Stack(
      alignment: Alignment.bottomCenter, //밑바닥에서 정렬
      children: [
        //----------------------------------------------------------------------
        // 배경 그래프 - 변화 없는 그래프
        //----------------------------------------------------------------------
        Obx(() {
          int refresh = _refreshTargetArea.value; //목표 영역이 갱신될 수 있어 obs 로
          return basicEmgBarStatic(
            targetHighValue: targetHigh,
            //목표영역 high
            targetLowValue: targetLow,
            //목표영역 low
            //--------------------- emg bar shape
            width: width,
            height: height,
            radiusTop: radiusTop,
            radiusBottom: radiusBottom,
            backgroundColor: tm.grey02.withOpacity(0.6),
            targetAreaColor: tm.softBlue,
            //--------------------- mvc line
            mvcLineThickness: 2,
            mvcLineDashWidth: 2,
            mvcLineColor: tm.mainBlue.withOpacity(0.5),
          );
        }),
        //----------------------------------------------------------------------
        // 라이브 그래프 - 실시간 변화 영역
        //----------------------------------------------------------------------
        Obx(() {
          double mlTh1rm = dm[0].g.parameter.mvcRefRt;
          double emgValue = gv.deviceData[0].emgData.value / mlTh1rm;
          double emgValueAv = gv.deviceData[0].emgDataAv / mlTh1rm;
          double emgValueMax = gv.deviceData[0].emgDataMax / mlTh1rm;
          return basicEmgBarLive(
            //--------------------- control
            isViewAvMax: gv.setting.isViewAvMax.value,
            //평균, 최대 표시 여부
            //--------------------- value
            emgValue: emgValue,
            //현재값 - 화면 갱신
            avValue: emgValueAv,
            //평균값
            maxValue: emgValueMax,
            //최대값
            //--------------------- emg bar shape
            width: width,
            height: height,
            radiusTop: radiusTop,
            radiusBottom: radiusBottom,
            valueBarColor: tm.pointBlue.withOpacity(0.9),
            //--------------------- average bar shape
            avBarWidth: width * 0.92,
            avRadiusTop: radiusTop * 0.35,
            avRadiusBottom: radiusBottom * 0,
            avBarColor: tm.softBlue.withOpacity(0.2), //tm.grey03.withOpacity(0.2),
            avBorderThickness: 1.5,
            avBorderColor:Colors.transparent, // tm.softBlue.withOpacity(0.3),
            //--------------------- max line
            maxBarHeight: 2,
            maxBarWidth: width * 0.5,
            maxBarColor: tm.mainBlue, //tm.grey03,
          );
        })
      ],
    );
  }
}

//==============================================================================
// 화면 갱신
//==============================================================================
RxInt _refreshTargetArea = 0.obs;
class RefreshLiveEmgBar {
  static void targetArea() {
    _refreshTargetArea.value++;
  }
}