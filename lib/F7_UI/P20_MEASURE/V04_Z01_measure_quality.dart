import '/F0_BASIC/common_import.dart';

//==============================================================================
// 측정 결과 상세 보기
//==============================================================================

Widget measureQualityDetail() {
  int setIdx = 0;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: asWidth(8)),
    margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
    decoration: BoxDecoration(
      color: tm.grey01,
      borderRadius: BorderRadius.circular(asHeight(30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        asSizedBox(height: 20),
        //----------------------------------------------------------------------
        // 파형
        MeasureEndSimpleTimeChart(
          width: asWidth(360 - 36),
          height: asHeight(160),
        ),
        Center(
            child: TextN(
          '<근전도 측정 결과>',
          fontSize: tm.s12,
          color: tm.grey03,
        )),
        asSizedBox(height: 30),
        //----------------------------------------------------------------------
        // 전극 품질
        ElectrodeQualityChart(
          width: asWidth(360 - 36),
          height: asHeight(120),
          etContactData: dm[0].g.report.electrodeContactData[setIdx],
          buffClearData: dm[0].g.report.isExBufferCleared[setIdx],
          endTime: dm[0].g.report.timeSet[setIdx],
        ),
        Center(
            child: TextN(
          '<전극 접촉 상태: 낮을 수록 양호>',
          fontSize: tm.s12,
          color: tm.grey03,
        )),
        asSizedBox(height: 40),

        //----------------------------------------------------------------------
        // 전극 접촉 품질
        _electrodeQualityComment(),
        //----------------------------------------------------------------------
        // 상세 결과 - 디버그용
        if (gv.setting.isViewMeasureQualityDebug.value == true)
          measureQualityDebug(),

        asSizedBox(height: 30),
      ],
    ),
  );
}

//==============================================================================
// 전극 품질 코멘트
//==============================================================================
Widget _electrodeQualityComment() {
  int setIdx = 0;

  // 전극 접촉 레벨 - 측정 중 최대 값으로 판단
  // 추가 최대로만 판단하는 것에 문제가 있을 경우 평균, 분산 등 활용 고려
  double electrodeContactMax = dm[0].g.report.electrodeContactMax[setIdx];

  // 예외 상황 값 읽어오기
  int exCntDetach = dm[0].g.report.exCntDetach[setIdx];
  double exTimeDetached = dm[0].g.report.exTimeDetached[setIdx];
  int exCntExternal = dm[0].g.report.exCntExternal[setIdx];
  double exTimeFake = dm[0].g.report.exTimeFake[setIdx];
  bool flagMeasureGood = true;

  if (exCntDetach > 0) flagMeasureGood = false;
  if (exTimeDetached > 0) flagMeasureGood = false;
  if (exCntExternal > 0) flagMeasureGood = false;
  if (exTimeFake > 0) flagMeasureGood = false;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //----------------------------------------------------------------------
      // 안내사항
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: asHeight(12),
            height: asHeight(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(asHeight(6)),
                color: tm.pointOrange),
            alignment: Alignment.center,
            child: TextN(
              '!',
              fontSize: tm.s10,
              color: tm.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          asSizedBox(width: 4),
          TextN(
            '안내사항',
            fontSize: tm.s12,
            color: tm.black,
          ),
        ],
      ),
      //----------------------------------------------------------------------
      // 총평
      asSizedBox(height: 8),
      TextN(
        flagMeasureGood
            ? '측정 과정에서 오류가 발견되지 않았습니다.'
            : '측정 과정에서 전극 접촉 불량 혹은 충격 등 간섭으로 인한 잡음이 발생하여'
                ' 해당 구간의 데이터가 자동삭제 되었습니다. (아래 그래프의 붉은색 영역)',
        fontSize: tm.s12,
        color: flagMeasureGood ? tm.black : tm.grey04,
        height: 1.5,
      ),
      asSizedBox(height: 10),
      //----------------------------------------------------------------------
      // 전극 접촉 상태
      (electrodeContactMax < GvDef.electrodeContactQuality[0])
          ? _textContents('전극 접촉 상태가 매우 양호하였습니다.')
          : (electrodeContactMax < GvDef.electrodeContactQuality[1])
              ? _textContents('전극 접촉 상태가 양호하였습니다.')
              : (electrodeContactMax < GvDef.electrodeContactQuality[2])
                  ? _textContents('전극 접촉 상태가 보통이었습니다.')
                  : (electrodeContactMax < GvDef.electrodeContactQuality[3])
                      ? _textContents('전극 접촉 상태가 다소 불안정했습니다.')
                      : _textContents('전극 접촉 상태가 매우 불안정했습니다.'),
      //----------------------------------------------------------------------
      // 전극 탈부착 횟수
      if (exCntDetach > 0) _textContents('측정 중 전극이 $exCntDetach회 떨어졌습니다.'),
      if (exTimeDetached > 0)
        _textContents('전극이 떨어진 시간은 약'
            '  ${exTimeDetached.toStringAsFixed(1)}초 입니다.'),
      if (exCntExternal > 0)
        _textContents('측정 중 무선 데이터 손실이 $exCntExternal회 발생하였습니다.'),
      if (exTimeFake > 0)
        _textContents('측정 중 장비 충격 등의 원인으로 잡음이 발생한 시간이 대략'
            '  ${exTimeFake.toStringAsFixed(1)}초 발생하였습니다.'),
    ],
  );
}

//==============================================================================
// 텍스트
//==============================================================================
Widget _textTitle(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: asHeight(10)),
    child: TextN(
      text,
      fontSize: tm.s18,
      color: tm.mainBlue,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _textContents(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: asHeight(6)),
    child: TextN(
      text,
      fontSize: tm.s12,
      color: tm.grey04,
      height: 1.5,
    ),
  );
}
