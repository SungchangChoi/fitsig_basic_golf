import '/F0_BASIC/common_import.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//==============================================================================
// 기록 그래프
//==============================================================================

class RecordChart extends StatelessWidget {
  final double width;
  final double height;
  final List<String> xLabel;
  final List<List<double>> yDataListBundle;
  final double? visibleMinimum;
  final double? visibleMaximum;
  final double xAxisInterval;
  final String? yAxisTitle;
  final List<Color>? lineColorList;
  final String unit;
  final bool isTrendLineOn;

  const RecordChart({
    this.width = 200,
    this.height = 200,
    this.xLabel = const <String>[],
    this.yDataListBundle = const <List<double>>[],
    this.visibleMinimum,
    this.visibleMaximum,
    this.xAxisInterval = 1,
    this.yAxisTitle,
    this.lineColorList,
    this.unit = '',
    this.isTrendLineOn = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //--------------------------------------------------------------------------
    // 그래프 데이터 입력
    return SizedBox(
      width: width,
      height: height,
      child: BasicRecordChart(
        //------------------------------- data
        xLabel: xLabel,
        //라벨과 데이터는 길이가 동일해야 함
        dataListBundle: yDataListBundle,
        //------------------------------- layout
        backgroundColor: Colors.transparent,
        //------------------------------- grid, axis
        axisLineWidth: 0,
        // axisLineColor: tm.grey03,
        gridLineColor: Colors.transparent,
        //tm.grey02,

        //------------------------------- data bar
        barWidthRatio: 0.65,
        barColor: tm.grey02,
        barRadius: asWidth(5),
        //------------------------------- data line
        lineWidth: 4,
        lineColorList: lineColorList,

        isTrendLineOn: isTrendLineOn,
        isViewDataLabel: false,
        //데이터 라벨 보기
        dataLabelTextSize: tm.s14,
        dataLabelTextColor: tm.mainBlue,
        //------------------------------- spot
        markColor: tm.pointOrange,
        markSize: asWidth(12),
        //------------------------------- x-label
        xLabelTextSize: tm.s16,
        xLabelTextColor: tm.grey04,
        xLabelTextFontWeight: FontWeight.bold,

        //------------------------------- y-label
        yLabelTextSize: tm.s16,
        yLabelTextColor: tm.grey03,

        // ------------------------------- x-axis title
        yAxisTitle: yAxisTitle != null
            ? AxisTitle(
                text: yAxisTitle,
                textStyle: TextStyle(color: tm.grey03, fontSize: tm.s12))
            : null,

        //------------------------------- 초기 화면에 보여지는 data 시작 index
        visibleMinimum: visibleMinimum,
        //------------------------------- 초기 화면에 보여지는 data 마지막 index
        visibleMaximum: visibleMaximum,
        xAxisInterval: xAxisInterval,

        //화면에서 손가락을 땔때 호출되는 callback 함수. (손가락을 땐 곳의 좌표를 얻을 수 있음)
        onChartTouchInteractionUp: (ChartTouchInteractionArgs tabArgs) {
          //화면에 터치후 손가락을 땐 곳의 좌표를 얻을 수 있음
          gvRecord.graphTimeRangeUpdateCount.value++;
        },

        // 그래프 data range 가 변할때 호출되는 callback 함수. (그래프에 현재 보여지는 data index 값의 min, max 을 double 형태로 얻을 수 있음)
        onActualRangeChanged: (ActualRangeChangedArgs rangeChangedArgs) {
          gvRecord.visibleMinIndex = (rangeChangedArgs.visibleMin is double)
              ? rangeChangedArgs.visibleMin.ceil()
              : rangeChangedArgs.visibleMin;
          gvRecord.visibleMaxIndex = (rangeChangedArgs.visibleMax is double)
              ? rangeChangedArgs.visibleMax.toInt()
              : rangeChangedArgs.visibleMax;

          // print(
          //     'RecordChart :: build :: visibleMinIndex=${gvRecord.visibleMinIndex}   visibleMaxIndex=${gvRecord.visibleMaxIndex}');
        },

        // x 축에 출력되는 label 을 customizing 할 수 있는 callback 함수
        xAxisLabelFormatter: (AxisLabelRenderDetails axisLabelRenderArgs) {
          String text = axisLabelRenderArgs.text;

          // int year = int.parse(text.substring(0, 4));
          int month = int.parse(text.substring(4, 6));
          int day = int.parse(text.substring(6, 8));
          TextStyle style = TextStyle(
              color: tm.grey04, fontSize: tm.s12, fontWeight: FontWeight.bold);
          if (gvRecord.graphTimePeriod.value == GraphTimePeriod.aWeek) {
            // 1일일 경우, 월만 붙임
            if (day == 1) {
              text = '$month월';
              // style = TextStyle(color: tm.grey04, fontSize: tm.s12, fontWeight: FontWeight.bold);
            } else {
              text = '$day일';
            }
          } else if (gvRecord.graphTimePeriod.value == GraphTimePeriod.aMonth) {
            // 1일일 경우, 월만 붙임
            if (day == 1) {
              text = '$month월';
              // style = TextStyle(color: tm.grey04, fontSize: tm.s12, fontWeight: FontWeight.bold);
            } else {
              if (day <= 25 && day % 5 == 0) {
                text = '$day일';
              } else {
                text = '';
              }
            }
          } else if (gvRecord.graphTimePeriod.value ==
                  GraphTimePeriod.threeMonths ||
              gvRecord.graphTimePeriod.value == GraphTimePeriod.sixMonths) {
            // 1째주일 경우 월이 바뀌었으므로 앞에 월을 추가
            int week = int.parse(text.substring(9, 10));
            if (week == 1) {
              text = '$month월';
              // style = TextStyle(color: tm.grey03, fontSize: tm.s14, fontWeight: FontWeight.w500);
            } else {
              // if(week%3==0) {
              //   text = '$week주';
              // }
              // else{
              text = '';
              // }
            }
          } else if (gvRecord.graphTimePeriod.value == GraphTimePeriod.aYear) {
            text = '$month월';
          }
          return ChartAxisLabel(text, style);
        },

        // 각각의 label 에 대해서 적용을 하다보니, 어떤어떤 label 은 분,  라벨은 시간 단위로 표시되게됨
        yAxisLabelFormatter: (AxisLabelRenderDetails axisLabelRenderArgs) {
          String text = axisLabelRenderArgs.text;
          if (axisLabelRenderArgs.value == 0) {
            text = '${axisLabelRenderArgs.text}$unit';
          }
          TextStyle style = TextStyle(
              color: tm.grey03, fontSize: tm.s12, fontWeight: FontWeight.bold);
          return ChartAxisLabel(text, style);
        },

        // TrendLine 정보를 가져오는 callback
        onRenderDetailsUpdate: (TrendlineRenderParams args) {
          List<List<double>> pointList = <List<double>>[];
          args.calculatedDataPoints?.forEach((element) {
            CartesianChartPoint<dynamic> chartPoint = gvRecord.trendLineController!.pixelToPoint(element);
            // print('Record_chart :: calculated point value: ' + chartPoint.x.toString() +' '+chartPoint.y.toString());
            pointList.add([chartPoint.x, chartPoint.y]);
          });
          gvRecord.trendLinePointList = pointList;
          WidgetsBinding.instance.addPostFrameCallback((_) => gvRecord.trendLineUpdateCount.value++);
        },

        // 그래프 정보를 저장하고 있는 controller 를 받아와서, onRenderDetailsUpdate 에 있는 pixelToPoint 함수 호출에 사용
        onRendererCreated:  (ChartSeriesController controller) {
          gvRecord.trendLineController = controller;
        },
      ),
    );
  }
}
