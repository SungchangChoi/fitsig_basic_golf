import '/F0_BASIC/common_import.dart';

//==============================================================================
// emg 타임챠트 그래프
//==============================================================================

class LiveEmgTimeChartOnlyLine extends StatelessWidget {
  final double width;
  final double height;

  const LiveEmgTimeChartOnlyLine(
      {this.width = 200, this.height = 100, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int d = 0;
    //---------------------------------- layout
    double radiusOutBorder = asHeight(15);
    double radiusInnerBorder = 0;
    double yAxisWidth = width * 0.13;
    double yAxisPadding = 0;
    double chartWidth = width * 0.87;
    double chartHeight = height - radiusOutBorder; //최대 값 라인
    //---------------------------------- chart

    //---------------------------------- yAxis
    return Obx(() {
      int refresh = _refreshTimeChart.value;
      List<double> yData = gv.deviceData[d].yData;
      List<double> xData = gv.deviceData[d].xData;

      //--------------------------------------------------------------------
      // 최대 최소
      double yMax = dm[d].g.parameter.mvcRefRt; //npMax(yData);
      double yMin = 0;
      double xMax = npMax(xData);
      double xMin = npMin(xData);

      //--------------------------------------------------------------------
      // 목표영역 (비율로)
      double targetHigh =
          (dm[d].g.parameter.targetP1Rm + DspCommonParameter.targetPRange) /
              100;
      double targetLow =
          (dm[d].g.parameter.targetP1Rm - DspCommonParameter.targetPRange) /
              100;

      ChartCommonVariable cv = ChartCommonVariable();
      cv.chartCoreWidth = chartWidth; //전체 넓이
      cv.chartCoreHeight = chartHeight; //전체 높이
      cv.lineYData = yData;
      cv.lineXData = xData;
      cv.lineYMax = yMax;
      cv.lineYMin = yMin;
      cv.lineXMax = xMax;
      cv.lineXMin = xMin;
      cv.lineWidth = 4;
      cv.lineColor = tm.white;
      cv.linePointSize = 0;
      cv.linePointColor = Colors.transparent;
      return basicOnlyLineChartLive(
        cv: cv,
        // //------------------- total layout
        // padXAxis: 0,
        // padYAxis: yAxisPadding,
        // //------------------- chart layout
        // chartWidth: chartWidth,
        // //전체 넓이
        // chartHeight: chartHeight,
        // //전체 높이
        // //------------------- line data
        // yData: yData,
        // xData: xData,
        // yMax: yMax,
        // yMin: yMin,
        // xMax: xMax,
        // xMin: xMin,
        // lineWidth: 4,
        // lineColor: tm.white,
        // pointSize: 0,
        // pointColor: Colors.transparent,
      );
    }); //배경
  }
}

//==============================================================================
// 화면 갱신
//==============================================================================
RxInt _refreshTimeChart = 0.obs;

class RefreshLiveEmgTimeChartOnlyLine {
  static chart() {
    _refreshTimeChart.value++;
  }
}
