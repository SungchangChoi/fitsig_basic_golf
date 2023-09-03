import '/F0_BASIC/common_import.dart';

//==============================================================================
// 통계 그래프
//==============================================================================
Widget statsGraph(BuildContext context) {
  String unit = gv.setting.isViewUnitKgf.value == false ? 'mV' : 'kgf';
  // 바의 색상 - 3개 겹침 혹은 2개 겹침
  List<Color> lineColorList =
      gvRecord.graphDataType.value != GraphDataType.frequency
          ? [
              // tm.grey03.withOpacity(0.5),
              // tm.blue.withOpacity(0.7),
              // tm.green.withOpacity(0.7)
              tm.mainBlue.withOpacity(0.7),
              tm.mainGreen.withOpacity(0.9),
              tm.grey03.withOpacity(0.8)
            ]
          : [tm.mainBlue.withOpacity(0.7), tm.mainGreen.withOpacity(0.8)];
  List<String> lineNameList = [];

  //----------------------------------------------------------------
  // 상승 및 하강 계산 : 트렌드 라인 기울기 보고

  return Center(
    child: Column(
      children: [
        Container(
          width: asWidth(324),
          decoration: BoxDecoration(
              color: tm.grey01,
              borderRadius: BorderRadius.circular(asHeight(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              asSizedBox(height: 24),
              //----------------------------------------------------------------
              // 통계 그래프에 표시되는 날짜 구간
              //----------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //------------------------------------------------------------
                  // 그래프에 표시되고 있는 data 의 기간 출력 텍스트
                  Obx(() {
                    gvRecord.graphTimeRangeUpdateCount.value;
                    gvRecord.graphDataUpdateCount.value;
                    int startYear = (gvRecord
                            .barDataBuckets[gvRecord.visibleMinIndex]
                            .startDate) ~/
                        10000;
                    int startMonth = ((gvRecord
                                .barDataBuckets[gvRecord.visibleMinIndex]
                                .startDate) %
                            10000) ~/
                        100;
                    int startDay = (gvRecord
                            .barDataBuckets[gvRecord.visibleMinIndex]
                            .startDate) %
                        100;
                    int endYear = (gvRecord
                            .barDataBuckets[gvRecord.visibleMaxIndex]
                            .endDate) ~/
                        10000;
                    int endMonth = ((gvRecord
                                .barDataBuckets[gvRecord.visibleMaxIndex]
                                .endDate) %
                            10000) ~/
                        100;
                    int endDay = (gvRecord
                            .barDataBuckets[gvRecord.visibleMaxIndex].endDate) %
                        100;
                    return TextN(
                      '$startYear년 $startMonth월 $startDay일 ~ $endYear년 $endMonth월 $endDay일',
                      fontSize: tm.s14,
                      fontWeight: FontWeight.bold,
                      color: tm.black,
                    );
                  }),
                ],
              ),
              //----------------------------------------------------------------
              // 상승 하강 표시
              //----------------------------------------------------------------
              asSizedBox(height: 13),
              Obx(
                () {
                  // gvRecord.graphTimeRangeUpdateCount.value;
                  // gvRecord.graphDataUpdateCount.value;
                  gvRecord.trendLineUpdateCount.value;
                  double firstValueOnChartWindow = double.infinity;
                  double lastValueOnChartWindow = -double.infinity;

                  //------------------------------------------------------------
                  // 통계 타입에 따라 (근력은 3개, 운동시간은 1개, 운동량 2개, 근주파수 2개 등) 의 data 리스트가 그래프에 입력됨
                  // 통계 타입에 따른 어느 data 의 변화량을 % 로 표시할지 설정이 필요함
                  // 예, 근력 통계의 경우 1RM 기준, 1RM 신규, 근활성도 평균, 이 3가지중 1RM 신규에 대한 변화량을 표시
                  //------------------------------------------------------------
                  int bundleIndex = 0;
                  if (gvRecord.graphDataType.value == GraphDataType.mvc) {
                    bundleIndex = 1; // 1RM 신규
                  } else if (gvRecord.graphDataType.value ==
                      GraphDataType.exerciseTimeAcc) {
                    bundleIndex = 0; // 운동시간
                  } else if (gvRecord.graphDataType.value ==
                      GraphDataType.aoeSet) {
                    bundleIndex = 0; // 운동량
                  } else if (gvRecord.graphDataType.value ==
                      GraphDataType.frequency) {
                    bundleIndex = 0; // 시작 주파수
                  } else if (gvRecord.graphDataType.value ==
                      GraphDataType.repetitionAvg) {
                    bundleIndex = 0; // 평균 반복수
                  }

                  //------------------------------------------------------------
                  // 그래프에 보여지는 데이터 값 중 최소 값과, 최대값 구하기
                  // for(int index = gvRecord.visibleMinIndex; index <= gvRecord.visibleMaxIndex ;index++){
                  //   double newValue = gvRecord.graphData.yDataListBundle[bundleIndex][index];
                  //   minValue = (minValue > newValue) && (newValue != 0) ? newValue:minValue;
                  //   maxValue = (maxValue < newValue) && (newValue != 0) ? newValue:maxValue;
                  // }

                  //------------------------------------------------------------
                  // SyncFusion 의 trend line 을 그릴때 첫 데이터와 마지막 데이터에 해당하는 점을 그리고 연결하는 것을 확인하고,
                  // 이점들을 이용해 통계 변화량을 계산하도록 수정
                  double value;
                  if (gvRecord.trendLinePointList.length == 2){
                    value = (gvRecord.trendLinePointList[1][1] - gvRecord.trendLinePointList[0][1])/gvRecord.trendLinePointList[0][1]*100;
                  }else{
                    value = 0;
                  }
                  //------------------------------------------------------------
                  // 최소값 대비 최대값의 변화량 계산
                  String sign = value > 0 ? '+' : '';

                  // 호면에 0개의 데이터가 있을 경우 value 는 NaN 이므로 화면에 변화량 표시 안함
                  // 화면에 1개의 데이터만 있을 경우 value 는 0이 되므로 화면에 변화량 표시 안함
                  return value.isNaN || value == 0
                      ? SizedBox(height: asHeight(22.5))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextN(sign + value.toStringAsFixed(0) + '%',
                                fontSize: tm.s20,
                                color: tm.mainBlue,
                                fontWeight: FontWeight.bold),
                            asSizedBox(width: 6),
                            Image.asset(
                              'assets/icons/ic_arrow_up2.png',
                              height: asHeight(20),
                              color: tm.mainBlue,
                            ),
                          ],
                        );
                },
              ),
              asSizedBox(height: 10),

              //--------------------------------------------------------------------
              // 통계 그래프
              //--------------------------------------------------------------------
              Obx(() {
                gvRecord.graphDataUpdateCount.value;
                gvRecord.graphTimeRangeUpdateCount.value;
                //--------------------------------------------------------------
                // 통계 그래프 y축 아래 첫번째 label 뒤에 붙는 단위
                //--------------------------------------------------------------
                if (gvRecord.graphDataType.value ==
                    GraphDataType.exerciseTimeAcc) {
                  var maximumYData =
                      gvRecord.graphData.yDataListBundle[0].reduce(max);
                  if (maximumYData > 3600) {
                    unit = '시';
                  } else if (maximumYData > 60) {
                    unit = '분';
                  } else {
                    unit = '초';
                  }
                } else if (gvRecord.graphDataType.value ==
                    GraphDataType.frequency) {
                  unit = 'Hz';
                } else if (gvRecord.graphDataType.value == GraphDataType.aoeSet
                    // || gvRecord.graphDataType.value == GraphDataType.aoeTarget
                    ) {
                  unit = 'set';
                } else {
                  unit = gv.setting.isViewUnitKgf.value == false ? 'mV' : 'kgf';
                }

                List<double> tempYDataList =
                    []; // 운동시간을 표시할 경우 최대 값에 따라 표시하는 단위가 바뀌므로 임시로 단위에 맞춰 변환한 yDataList
                if (gvRecord.graphDataType.value ==
                    GraphDataType.exerciseTimeAcc) {
                  // 시간 단위(초, 분, 시) 에 따라 data를  변환
                  int divider = (unit == '시')
                      ? 3600
                      : (unit == '분')
                          ? 60
                          : 1;
                  tempYDataList = gvRecord.graphData.yDataListBundle[0]
                      .map((e) => e / divider)
                      .toList();
                }
                return gvRecord.graphDataType.value != GraphDataType.frequency
                    // 주파수 외에 나머지
                    ? RecordChart(
                        width: asWidth(324),
                        height: asHeight(260),
                        xLabel: gvRecord.graphData.xLabelList,
                        yDataListBundle: (gvRecord.graphDataType.value ==
                                GraphDataType.exerciseTimeAcc)
                            ? [tempYDataList]
                            : gvRecord.graphData.yDataListBundle,
                        // visibleMinimum: gvRecord.graphData.visibleMinimum,
                        // visibleMaximum: gvRecord.graphData.visibleMaximum,
                        visibleMinimum: gvRecord.visibleMinIndex.toDouble(),
                        visibleMaximum: gvRecord.visibleMaxIndex.toDouble(),
                        lineColorList: lineColorList,
                        unit: unit,
                        isTrendLineOn: gvRecord.isTrendLineOn.value,
                      )
                    // 주파수 그래프 - 범위 챠트로 주식그래프 비슷
                    : RecordHiloChart(
                        width: asWidth(324),
                        height: asHeight(260),
                        xLabel: gvRecord.graphData.xLabelList,
                        yDataListBundle: gvRecord.graphData.yDataListBundle,
                  visibleMinimum: gvRecord.visibleMinIndex.toDouble(),
                  visibleMaximum: gvRecord.visibleMaxIndex.toDouble(),
                        lineColorList: lineColorList,
                        unit: unit,
                  isTrendLineOn: gvRecord.isTrendLineOn.value,
                      );
              }),
              asSizedBox(height: 10),
            ],
          ),
        ),
        asSizedBox(height: 20),
        SizedBox(
          width: asWidth(344),
          //--------------------------------------------------------------------
          // 그래프 Legend 표시 박스
          // - sf chart  내의 legend 표시 기능을 사용하려 했으나, null check error 가 발생해서 원인을 찾지 못해 직점 만듬
          //--------------------------------------------------------------------
          child: Obx(() {
            gvRecord.graphDataUpdateCount.value;
            lineNameList = [];
            if (gvRecord.graphDataType.value == GraphDataType.mvc) {
              lineNameList = ['1RM 기준', '1RM 신규', '근활성도 평균'];
            } else if (gvRecord.graphDataType.value ==
                GraphDataType.frequency) {
              lineNameList = [
                '근주파수 감소',
                '근주파수 증가',
              ];
            } else if (gvRecord.graphDataType.value == GraphDataType.aoeSet) {
              lineNameList = [
                '운동량',
                '목표 운동량',
              ];
            } else if (gvRecord.graphDataType.value ==
                GraphDataType.repetitionAvg) {
              lineNameList = [
                '평균 반복수',
                '목표달성 반복수',
              ];
            } else {
              lineNameList = [];
            }

            return SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int index = 0; index < lineNameList.length; index++)
                    Row(
                      children: [
                        Container(
                          width: asHeight(40),
                          height: asHeight(6),
                          decoration: BoxDecoration(
                            color: lineColorList[index],
                            borderRadius: BorderRadius.circular(asHeight(3)),
                          ),
                        ),
                        asSizedBox(width: 5),
                        TextN(
                          lineNameList[index],
                          fontSize: tm.s12,
                          color: tm.grey03,
                        ),
                        asSizedBox(width: 10),
                      ],
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}
