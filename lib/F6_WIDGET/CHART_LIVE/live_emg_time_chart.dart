import '/F0_BASIC/common_import.dart';

//==============================================================================
// emg 타임챠트 그래프
//==============================================================================

class LiveEmgTimeChart extends StatelessWidget {
  final double width;
  final double height;

  const LiveEmgTimeChart({this.width = 200, this.height = 100, Key? key})
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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        //----------------------------------------------------------------
        // 배경
        basicEmgTimeChartStatic(
          width: width,
          height: height,
          borderRadius: radiusOutBorder,
          backgroundColor: tm.grey02.withOpacity(0.6),
        ),
        //----------------------------------------------------------------
        // 그래프 - 라이브
        Obx(() {
          int refresh = _refreshTimeChart.value;

          //--------------------------------------------------------------------
          // 근활성도  시간/평균/최대
          // gv.deviceData[0].emgTime = dm[0].g.fastData.timeFast;
          // gv.deviceData[0].emgDataAv = dm[0].g.fastData.continuousPowAv;
          // gv.deviceData[0].emgDataMax = dm[0].g.fastData.continuousPowMax;

          //--------------------------------------------------------------------
          // 데이터 버퍼링
          // gv.deviceData[0].yData.add(gv.deviceData[0].emgData.value);
          // gv.deviceData[0].yData.removeAt(0);
          // gv.deviceData[0].xData.add(gv.deviceData[0].emgTime);
          // gv.deviceData[0].xData.removeAt(0);

          // double refresh = gv.deviceData[0].emgData.value; //refresh
          // double time = gv.deviceData[0].emgTime;

          List<double> yData = gv.deviceData[d].yData;
          List<double> xData = gv.deviceData[d].xData;
          // List<double> yData = gv.deviceData[d].ecgYData;
          // List<double> xData = gv.deviceData[d].ecgXData;
          //--------------------------------------------------------------------
          // 최대 최소
          double yMax = dm[d].g.parameter.mvcRefRt; //npMax(yData);
          double yMin = 0;
          double xMax = npMax(xData);
          double xMin = npMin(xData);
          // //--------------------------------------------------------------------
          // // 오버된 마크 제거 (버퍼링은 카운트 이벤트 콜백에서)
          // if (gv.deviceData[0].xMark.isNotEmpty) {
          //   if (gv.deviceData[0].xMark.first < gv.deviceData[0].xData.first) {
          //     print(gv.deviceData[0].xMark);
          //     print(gv.deviceData[0].xData.first);
          //     print(gv.deviceData[0].xData.last);
          //     gv.deviceData[0].yMark.removeAt(0);
          //     gv.deviceData[0].xMark.removeAt(0);
          //   }
          // }

          //--------------------------------------------------------------------
          // 목표영역 (비율로)
          double targetHigh =
              (dm[d].g.parameter.targetP1Rm + DspCommonParameter.targetPRange) /
                  100;
          double targetLow =
              (dm[d].g.parameter.targetP1Rm - DspCommonParameter.targetPRange) /
                  100;

          ChartCommonVariable cv = ChartCommonVariable();
          cv.isViewYAxis = true;
          cv.yAxisWidth = yAxisWidth;
          cv.yAxisHeight = chartHeight;
          //------------------- yAxis
          cv.yAxisRightPadding = 5;
          // cv.yAxisTopPadding = topLabelHeight - tm.s12 / 2;
          // cv.yAxisBottomPadding = bottomLabelHeight - tm.s12 / 2;
          //글씨가 중간에 걸치게
          cv.yAxisLabels = const ['0', '25', '50', '75', '100'];
          cv.yAxisTextSize = tm.s12;
          cv.yAxisTextColor = tm.grey03;
          // yAxisBackgroundColor: Colors.cyan.withOpacity(0.2),

          //------------------- layout
          cv.xAxisPadBetweenChart = 0;
          cv.yAxisPadBetweenChart = yAxisPadding;
          cv.chartCoreWidth = chartWidth;
          cv.chartCoreHeight = chartHeight;
          cv.chartCoreRadius = 0;
          cv.xAxisHeight = 0;
          //------------------- line data
          cv.lineYData = yData;
          cv.lineXData = xData;
          cv.lineYMax = yMax;
          cv.lineYMin = yMin;
          cv.lineXMax = xMax;
          cv.lineXMin = xMin;
          cv.lineWidth = 4;
          cv.lineColor = tm.mainBlue;
          cv.linePointSize = 0;
          cv.linePointColor = Colors.transparent;
          //------------------- mark data
          cv.markIsViewMark = false;
          cv.markIsViewText = true;
          cv.markIsUnitPrm = true;
          //------------- 마크 데이터
          cv.markPointsY = gv.deviceData[0].yMark;
          cv.markPointsX = gv.deviceData[0].xMark;
          cv.markOneRm = dm[d].g.parameter.mvcRefRt;
          cv.markYMax = yMax;
          cv.markYMin = yMin;
          cv.markXMax = xMax;
          cv.markXMin = xMin;
          cv.markXOffset = 0;
          cv.markYOffset = -10; //마크 글씨 높이 조절

          //------------- 시간 (min : 오래된 시간, max : 최신시간)
          cv.markTextFontSize = tm.s14;
          cv.markTextColor = tm.mainBlue;
          // 마크 글씨 색
          //------------------- yAxis
          cv.isViewYAxis = true;
          cv.yAxisWidth = yAxisWidth;
          //Y axis 넓이
          cv.yAxisHeight = chartHeight;
          //Y axis 넓이
          cv.yAxisRightPadding = asWidth(5);
          cv.yAxisLabels = const ['0', '25', '50', '75', '100'];
          cv.yAxisTextSize = tm.s12;
          cv.yAxisTextColor = tm.grey03;
          // cv.yAxisBackgroundColor = tm.green; //Colors.green;
          // ------------------- mvc line
          cv.mvcLineThickness = 2;
          cv.mvcLineDashWidth = 2;
          cv.mvcLineColor = tm.mainBlue.withOpacity(0.5);
          //------------------- area
          cv.targetAreaValueHigh = targetHigh;
          cv.targetAreaValueLow = targetLow;
          cv.targetAreaColor = tm.softBlue;

          //--------------------------------------------------------------------
          // 심전도 변수
          List<double> ecgYData = gv.deviceData[d].ecgYData;
          List<double> ecgXData = gv.deviceData[d].ecgXData;
          // double ecgYMax = npMax(ecgYData) * 1.2;
          // double ecgYMin = npMin(ecgYData) * 1.2;
          // ecgYMax = max(ecgYMax, ecgYMin.abs());
          // ecgYMin = min(-ecgYMax, ecgYMin);
          // //크기 최소 (튜닝 필요)
          // ecgYMax = max(ecgYMax, 0.05); //0.05
          // ecgYMin = min(ecgYMin, -0.05); //-0.05
          // //크기 최대 (튜닝 필요)
          // ecgYMax = min(ecgYMax, 5); //5mV
          // ecgYMin = max(ecgYMin, -5); //-5mV

          //------------------------------------------
          // +- 0.5mV로 고정하여 보기
          double ecgYMax = 0.5;
          double ecgYMin = -0.5;

          //X축 최대 최소
          double ecgXMax = npMax(ecgXData);
          double ecgXMin = npMin(ecgXData);
          // ecgXMin = ecgXMax -3;

          cv.isViewEnableList[0] = gvMeasure.isViewEcg;
          cv.lineYDataList[0] = ecgYData;
          cv.lineXDataList[0] = ecgXData;
          cv.lineYMaxList[0] = ecgYMax;
          cv.lineYMinList[0] = ecgYMin;
          cv.lineXMaxList[0] = ecgXMax;
          cv.lineXMinList[0] = ecgXMin;
          cv.lineWidthList[0] = 2;
          cv.lineColorList[0] = tm.red.withOpacity(0.3);
          cv.linePointSizeList[0] = 0;
          cv.linePointColorList[0] =Colors.black;

          //--------------------------------------------------------------------
          // 심박 마크 변수 (심박이 카운트 되면 1, 아닐 때 0 입력)
          List<double> ecgCountData = gv.deviceData[d].ecgCountData;
          List<double> ecTimeData = gv.deviceData[d].ecgCountTime;

          cv.isViewEnableList[1] = gvMeasure.isViewEcg;
          cv.lineYDataList[1] = ecgCountData;
          cv.lineXDataList[1] = ecTimeData;
          cv.lineYMaxList[1] = 1; //npMax(ecgCountData);
          cv.lineYMinList[1] = 0; //npMin(ecgCountData);
          cv.lineXMaxList[1] = ecgXMax;
          cv.lineXMinList[1] = ecgXMin;
          cv.lineWidthList[1] = 0;
          cv.lineColorList[1] = tm.red.withOpacity(0.3);
          cv.linePointSizeList[1] = 8;
          cv.linePointColorList[1] = tm.red.withOpacity(0.3);

          return basicEmgTimeChartLive(cv: cv);
        }),
      ],
    ); //배경
  }
}

//==============================================================================
// 화면 갱신
//==============================================================================
RxInt _refreshTimeChart = 0.obs;

class RefreshLiveEmgTimeChart {
  static chart() {
    _refreshTimeChart.value++;
  }
}
