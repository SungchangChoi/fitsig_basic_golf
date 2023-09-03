import '/F0_BASIC/common_import.dart';

//==============================================================================
// 시간 그래프
//==============================================================================

class MeasureEndSimpleTimeChart extends StatefulWidget {
  final double width;
  final double height;

  const MeasureEndSimpleTimeChart({
    this.width = 200,
    this.height = 200,
    Key? key,
  }) : super(key: key);

  @override
  State<MeasureEndSimpleTimeChart> createState() =>
      _MeasureEndSimpleTimeChartState();
}

class _MeasureEndSimpleTimeChartState extends State<MeasureEndSimpleTimeChart> {
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
    //------------------------------------------------------------------------
    // report data에서 읽기
    //------------------------------------------------------------------------
    var gr = dm[0].g.report;
    int setIdx = 0;

    //------------------------------------------------------------------------
    // 그래프 데이터 입력
    //------------------------------------------------------------------------
    List<double> xTime = gr.emgTimeBuff[setIdx];
    List<double> data = gr.emgPowBuff[setIdx];

    // 측정 시작 후 1.5초 이내에 종료될 경우, xTime 과 data 가 empty 라 진행 아래 진행과정에서 에러 발생
    // 따라서 xTime 과 data 가 empty 일 경우, 임의로 [0.0] 을 입력 (2023.08.23)
    if(data.isEmpty){
      data = [0.0];
    }
    // %MVC로 보기
    data = npDiv(data, dm[0].g.parameter.mvcRefRt);
    data = npMultFixed(data, 100, 0); //소수점 없이 표현

    // 측정 시작 후 1.5초 이내에 종료될 경우, xTime 과 data 가 empty 라 진행 아래 진행과정에서 에러 발생
    // 따라서 xTime 과 data 가 empty 일 경우, 임의로 [0.0] 을 입력 (2023.08.23)
    if(xTime.isEmpty){
      xTime = [0.0];
    }
    double timeOffset = xTime.first;
    //------------------------------- 시간  : 0초부터 시작하게
    xTime = npSubFixed(xTime, timeOffset, 2);

    //------------------------------------------------------------------------
    // 마크 데이터 입력
    //------------------------------------------------------------------------
    List<double> xTimeMark =
        gr.countTimeBuff[setIdx]; //  gv.dbRecordContents.markTime;
    xTimeMark = npSubFixed(xTimeMark, timeOffset, 2); //시작시간 보정
    List<double> dataMark = gr.countPowBuff[setIdx];
    dataMark = npDiv(dataMark, dm[0].g.parameter.mvcRefRt);
    dataMark = npMultFixed(dataMark, 100, 0); //소수점 없이 표현

    List<EmlTargetResult> targetResult = gr.targetResultBuff[setIdx];

    //------------------------------------------------------------------------
    // 가이드라인 및 목표 영역
    //------------------------------------------------------------------------
    double oneRm = 100;
    double targetHigh =
        gv.deviceData[0].targetPrm.value + DspCommonParameter.targetPRange;
    double targetLow =
        gv.deviceData[0].targetPrm.value - DspCommonParameter.targetPRange;

    //------------------------------------------------------------------------
    // 심전도 데이터
    // 시간은 근전도(40ms)의 2배 용량 데이터 (20ms = 0.02 주기로 저장되었음)
    // 근전도 데이터 최대눈금에 맞추어 크기 조절 필요
    //------------------------------------------------------------------------
    List<double> ecgXTime = List<double>.generate(
        gr.ecgDataBuff[setIdx].length, (index) => xTime[0] + index * 0.02);
    List<double> ecgData = gr.ecgDataBuff[setIdx];
    // 크기 보정
    ecgData = npMult(ecgData, oneRm );
    ecgData = npAdd(ecgData, oneRm / 2); // 0V가 중앙에 오도록 수정

    //syncfusion 원활한 줌 동작을 위해 오버되는 값 잘라내기
    ecgData = npClipping(ecgData, 0, oneRm);
    //------------------------------------------------------------------------
    // 심박 카운트 데이터
    // 심박 카운트가 있을 경우 1로 기술
    // 검증단계에서는 표시 안함
    //------------------------------------------------------------------------

    return Column(
      children: [
        //--------------------------------------------------------------------
        // 그래프
        //--------------------------------------------------------------------
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: BasicTimeChart(
            //------------------------------- data
            xTime: xTime,
            data: data,
            //------------------------------- ecg data
            isViewEcg: gvMeasure.isViewEcg,
            ecgXTime: ecgXTime,
            ecgData: ecgData,
            ecgLineColor: tm.red.withOpacity(0.2),
            ecgLineWidth: 2,
            //------------------------------- data line
            lineWidth: 2,
            lineColor: Colors.blue,
            isViewDataLabel: false,
            dataLabelTextSize: tm.s12,
            dataLabelTextColor: Colors.blue,

            //------------------------------- mark
            xTimeMark: xTimeMark,
            dataMark: dataMark,
            targetResult: targetResult,

            //------------------------------- latest data mark
            isViewMark: false,
            //true, //gvRecord.isSelectedViewMark.value,
            markWidth: 8,
            markHeight: 8,
            markSuccessColor: tm.mainBlue,
            markGeneralColor: tm.grey03,
            markTextColor: tm.mainBlue,
            markTextSize: tm.s12,
            //------------------------------- guide line
            isViewGuide: true,
            oneRm: oneRm,
            targetHigh: targetHigh,
            targetLow: targetLow,

            //------------------------------- guide shape
            oneRmLineColor: tm.mainBlue.withOpacity(0.3),
            targetAreaColor: tm.softBlue,

            //------------------------------- layout
            backgroundColor: Colors.transparent,
            //tm.grey01,
            borderLineWidth: 0,
            borderLineColor: Colors.transparent,
            plotAreaBorderColor: Colors.transparent,
            // plotAreaBorderWidth: 200,

            //------------------------------- axis, grid
            axisLineWidth: 0,
            gridLineColor: Colors.transparent,
            axisLineColor: Colors.transparent,

            //------------------------------- xy-label
            xLabelTextSize: tm.s12,
            xLabelTextColor: tm.grey03,
            yLabelTextSize: tm.s12,
            yLabelTextColor: tm.grey03,
          ),
        ),
      ],
    );
  }
}
