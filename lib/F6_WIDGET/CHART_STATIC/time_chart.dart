import '/F0_BASIC/common_import.dart';

//==============================================================================
// 시간 그래프
//==============================================================================

class ReportTimeChart extends StatefulWidget {
  final double width;
  final double height;

  const ReportTimeChart({
    this.width = 200,
    this.height = 200,
    Key? key,
  }) : super(key: key);

  @override
  State<ReportTimeChart> createState() => _ReportTimeChartState();
}

class _ReportTimeChartState extends State<ReportTimeChart> {
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
    return Obx(() {
      int d = 0; //device index
      int idx = gv.control.idxRecord.value; //선택 된 record index
      //------------------------------------------------------------------------
      // 그래프 데이터 입력
      //------------------------------------------------------------------------
      List<double> xTime = gv.dbRecordContents.emgTime;
      List<double> data = gv.dbRecordContents.emgData;

      //------------------------------- 시간  : 0초부터 시작하게
      double timeOffset = xTime.first;
      xTime = npSubFixed(xTime, timeOffset, 2);

      //------------------------------- %1RM 보기
      if (gvRecord.isSelectedViewPrm.value == true) {
        data = npDiv(data, gv.dbRecordIndexes[idx].mvcMv);
        data = npMult(data, 100);
      }
      //------------------------------- %레벨로 보기
      else {
        if (gv.setting.isViewUnitKgf.value == true) {
          data = npMult(data, GvDef.convLv);
        }
      }
      //------------------------------------------------------------------------
      // 마크 데이터 입력
      //------------------------------------------------------------------------
      List<double> xTimeMark = gv.dbRecordContents.markTime;
      xTimeMark = npSubFixed(xTimeMark, timeOffset, 2); //시작시간 보정
      List<double> dataMark = gv.dbRecordContents.markValue;
      if (gvRecord.isSelectedViewPrm.value == true) {
        dataMark = npDiv(dataMark, gv.dbRecordIndexes[idx].mvcMv);
        dataMark = npMultFixed(dataMark, 100, 0); //소수점 없이 표현
      } else {
        if (gv.setting.isViewUnitKgf.value == true) {
          dataMark = npMultFixed(dataMark, GvDef.convLv, 1); //소수점 한자리
        } else {
          dataMark = npMultFixed(dataMark, 1, 2); //mV 로 표시할대는 소수점 둘째자리
        }
      }
      List<EmlTargetResult> targetResult = gv.dbRecordContents.targetResult;

      //------------------------------------------------------------------------
      // 가이드라인 및 목표 영역
      //------------------------------------------------------------------------
      double oneRm = 100;
      double targetHigh = gv.dbRecordIndexes[idx].targetPrm.toDouble() +
          DspCommonParameter.targetPRange;
      double targetLow = gv.dbRecordIndexes[idx].targetPrm.toDouble() -
          DspCommonParameter.targetPRange;

      //------------------------------------------------------------------------
      // 단위과 레벨인 경우의 값 처리
      //------------------------------------------------------------------------

      if (gvRecord.isSelectedViewPrm.value == false) {
        if (gv.setting.isViewUnitKgf.value == true) {
          oneRm = gv.dbRecordIndexes[idx].mvcMv * GvDef.convLv;
        } else {
          oneRm = gv.dbRecordIndexes[idx].mvcMv;
        }

        targetHigh = oneRm * targetHigh / 100;
        targetLow = oneRm * targetLow / 100;
      }
      //------------------------------------------------------------------------
      // 심전도 데이터
      // 시간은 근전도(40ms)의 2배 용량 데이터 (20ms = 0.02 주기로 저장되었음)
      // 근전도 데이터 최대눈금에 맞추어 크기 조절 필요
      //------------------------------------------------------------------------
      List<double> ecgXTime = List<double>.generate(
          gv.dbRecordContents.ecgData.length,
          (index) => xTime[0] + index * 0.02);
      List<double> ecgData = gv.dbRecordContents.ecgData;

      // 크기 보정
      // 최소 크기는 5mV가 되도록
      // 이렇게 안하면 줌에 문제 발생
      // double ecgMax = npMax(npAbs(ecgData)) * 2;
      // ecgMax = max(ecgMax, 1);

      // ecgData = npMult(ecgData, oneRm / ecgMax);
      ecgData = npMult(ecgData, oneRm);
      ecgData = npAdd(ecgData, oneRm / 2); // 0V가 중앙에 오도록 수정

      //syncfusion 원활한 줌 동작을 위해 오버되는 값 잘라내기
      ecgData = npClipping(ecgData, 0, oneRm);

      // ECG 데이터 존재 여부 - 존재하지 않을 수 있음
      bool isEcgDataEmpty = gv.dbRecordContents.ecgData.isEmpty;

      //------------------------------------------------------------------------
      // 심박 카운트 데이터
      // 심박 카운트가 있을 경우 1로 기술
      //------------------------------------------------------------------------
      List<double> ecgCountTime = gv.dbRecordContents.ecgCountTime;
      ecgCountTime = npSub(ecgCountTime, 1.5); //동기화를 위해 1.5초 빼기
      List<double> ecgCountData = List<double>.generate(
          gv.dbRecordContents.ecgCountTime.length, (index) => oneRm * 0.9);

      //------------------------------------------------------------------------
      // 초반 1초 데이터 잘라내기
      // 지연된 데이터 시간 만큼
      //------------------------------------------------------------------------
      xTime = xTime.sublist(25); //40ms 25개는 1초
      xTime = npSub(xTime, 1);
      data = data.sublist(25);
      if (ecgData.length > 50) {
        ecgXTime = ecgXTime.sublist(50); //20ms 50개는 1초
        ecgXTime = npSub(ecgXTime, 1);
        ecgData = ecgData.sublist(50);
        ecgCountTime = npSub(ecgCountTime, 1);
      }
      return Container(
        decoration: BoxDecoration(
            color: tm.grey01,
            borderRadius: BorderRadius.circular(asHeight(30))),
        child: Column(
          children: [
            asSizedBox(height: 4),
            //----------------------------------------------------------------------
            // 버튼 - 가이드 보기, 마크 보기 on/off
            //----------------------------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //--------------------------------------------------------------
                // 심박 보기
                isEcgDataEmpty == false
                    ? InkWell(
                        borderRadius: BorderRadius.circular(asHeight(8)),
                        onTap: (() {
                          //보기 설정 변경
                          gvRecord.isViewEcg = !gvRecord.isViewEcg;
                          setState(() {});
                        }),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: asWidth(10 + 8),
                              vertical: asHeight(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 심박 보기 설정에 따라 컬러 변경
                              Icon(
                                Icons.favorite,
                                color: gvRecord.isViewEcg
                                    ? tm.red
                                    : tm.red.withOpacity(0.2),
                                size: asHeight(20),
                              ),
                              asSizedBox(width: 4),
                              TextN(
                                  (gv.dbRecordContents.ecgHeartRateAv)
                                      .toStringAsFixed(0),
                                  fontSize: tm.s16,
                                  fontWeight: FontWeight.bold,
                                  color: gvRecord.isViewEcg
                                      ? tm.grey04
                                      : tm.grey03),
                            ],
                          ),
                        ),
                      )
                    : Container(),

                //--------------------------------------------------------------
                // 비율 보기
                wButtonState(
                  stateIndex: gvRecord.isSelectedViewPrm.value ? 0 : 1,
                  numOfState: 2,
                  width: asWidth(122),
                  height: asHeight(34),
                  touchWidth: asWidth(142 + 8),
                  touchHeight: asHeight(54),
                  padding: asWidth(12),
                  onTap: (() {
                    gvRecord.isSelectedViewPrm.value =
                        !gvRecord.isSelectedViewPrm.value;
                  }),
                  child: FittedBoxN(
                      child: TextN(
                          gvRecord.isSelectedViewPrm.value
                              ? '비율 보기 (%)'
                              : (gv.setting.isViewUnitKgf.value == true
                                  ? 'Kgf로 보기'
                                  : 'mV로 보기'),
                          fontSize: tm.s14,
                          color: tm.mainBlue)),
                ),
                // asSizedBox(width: 4),
              ],
            ),
            // asSizedBox(height: 10),
            //----------------------------------------------------------------------
            // 그래프
            //----------------------------------------------------------------------
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: BasicTimeChart(
                //------------------------------- data
                xTime: xTime,
                data: data,
                //------------------------------- ecg data
                isViewEcg: gvRecord.isViewEcg,
                ecgXTime: ecgXTime,
                ecgData: ecgData,
                ecgLineColor: tm.red.withOpacity(0.2),
                ecgLineWidth: 2,
                ecgCountData: ecgCountData,
                ecgCountTime: ecgCountTime,
                ecgPointColor: tm.red.withOpacity(0.3),
                ecgPointSize: 5,
                //------------------------------- data line
                lineWidth: 2,
                lineColor: Colors.blue,
                isViewDataLabel: false,
                dataLabelTextSize: 15,
                dataLabelTextColor: Colors.blue,

                //------------------------------- mark
                xTimeMark: xTimeMark,
                dataMark: dataMark,
                targetResult: targetResult,

                //------------------------------- latest data mark
                isViewMark: gvRecord.isSelectedViewMark.value,
                markWidth: 8,
                markHeight: 8,
                markSuccessColor: tm.mainBlue,
                markGeneralColor: tm.grey03,
                markTextColor: tm.mainBlue,
                markTextSize: 15,
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
                borderLineWidth: 0,
                borderLineColor: Colors.transparent,

                //------------------------------- axis, grid
                axisLineWidth: 2,
                gridLineColor: Colors.transparent,
                axisLineColor: Colors.transparent,

                //------------------------------- xy-label
                xLabelTextSize: 15,
                xLabelTextColor: tm.grey03,
                yLabelTextSize: 15,
                yLabelTextColor: tm.grey03,
              ),
            ),
          ],
        ),
      );
    });
  }
}
