import '/F0_BASIC/common_import.dart';

//==============================================================================
// 시간 그래프
//==============================================================================

class ElectrodeQualityChart extends StatefulWidget {
  final double width;
  final double height;

  final List<double> etContactData;
  final List<double> buffClearData;
  final double endTime;

  const ElectrodeQualityChart({
    this.etContactData = const [0, 1, 2],
    this.buffClearData = const [0, 0, 0],
    this.endTime = 2,
    this.width = 200,
    this.height = 200,
    Key? key,
  }) : super(key: key);

  @override
  State<ElectrodeQualityChart> createState() => _ElectrodeQualityChartState();
}

class _ElectrodeQualityChartState extends State<ElectrodeQualityChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ChartCommonVariable cv = ChartCommonVariable();
    // int d = 0;
    // int setIdx = 0;

    //--------------------------------------------------------------------------
    // 변수 초기화
    cv.lineYDataList = [[], []];
    cv.lineXDataList = [[], []];
    //--------------------------------------------------------------------------
    // line 1 = electrode quality data
    // set1 data
    cv.lineYDataList[0] = widget.etContactData;
    double ts = widget.endTime / cv.lineYDataList[0].length;
    cv.lineXDataList[0] = List<double>.generate(
        cv.lineYDataList[0].length, (index) => index * ts);

    cv.lineYMax = npMax(cv.lineYDataList[0]) * 1.1; //여유공간

    //--------------------------------------------------------------------------
    // line 2 = 예외 발생 여부 데이터
    // 예외 발생 시 1 출력. 크기를 전극 데이터 최대 값 보다 조금 더 크게 설정 (보기 좋게)
    cv.lineYDataList[1] = npMult(widget.buffClearData, cv.lineYMax);
    ts = widget.endTime / cv.lineYDataList[1].length;
    cv.lineXDataList[1] = List<double>.generate(
        cv.lineYDataList[1].length, (index) => index * ts);

    //--------------------------------------------------------------------------
    // line 3 = 접촉 품질 컬러 바
    cv.barValueList = [0, 0, 0];
    cv.barValueList[0] = GvDef.electrodeContactQuality[1];
    cv.barValueList[1] = GvDef.electrodeContactQuality[3];
    cv.barValueList[2] = cv.lineYMax;

    // Y max 크기 재 설정 (그래프가 바 보다 값이 작은 경우 표시 안되는 문제 해결)
    cv.lineYMax = npMax([cv.lineYMax, npMax(cv.barValueList)]);


    //     npMax([
    //   cv.lineYMax,
    //   GvDef.electrodeContactQuality[1],
    //   GvDef.electrodeContactQuality[3]
    // ]);
    cv.barColorList = [tm.grey04, tm.grey04, tm.grey04];
    cv.barColorList[0] = tm.mainBlue;
    cv.barColorList[1] = tm.mainGreen;
    cv.barColorList[2] = tm.red;
    //--------------------------------------------------------------------------
    // 그래프 컬러 및 디자인
    // print(cv.lineYData);
    // print(cv.lineXData);
    cv.lineColorList = [tm.grey04, tm.red.withOpacity(0.1)];
    cv.lineWidthList = [2, 2];
    cv.totalBackground = Colors.transparent;
    cv.gridLineColor = tm.white;
    cv.xAxisTextColor = tm.grey03;
    cv.yAxisTextColor = tm.grey03;
    cv.xAxisTextSize = tm.s12;
    cv.yAxisTextSize = tm.s12;

    //
    //
    //
    // cv.charCoreBorderColor
    // cv.chartCoreBorderWidth
    return Column(
      children: [
        //----------------------------------------------------------------------
        // 그래프
        //----------------------------------------------------------------------
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: BasicEtQualityChart(
            cv: cv,
          ),
        ),
      ],
    );
  }
}
