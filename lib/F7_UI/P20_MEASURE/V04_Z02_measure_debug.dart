import '/F0_BASIC/common_import.dart';

//==============================================================================
// 측정 결과 디버깅
//==============================================================================

Widget measureQualityDebug() {
  int setIdx = 0;
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //----------------------------------------------------------------------
        // 전극 접촉 품질
        //----------------------------------------------------------------------
        asSizedBox(height: 20),
        dividerSmall(),
        _textTitle('전극 접촉 상태'),
        _textContents(
            title: '접촉품질 최대',
            value: (dm[0].g.report.electrodeContactMax[0]).toStringAsFixed(3)),
        _textContents(
            title: '접촉품질 최소',
            value: (dm[0].g.report.electrodeContactMin[0]).toStringAsFixed(3)),
        _textContents(
            title: '접촉품질 평균',
            value: (dm[0].g.report.electrodeContactAv[0]).toStringAsFixed(3)),
        _textContents(
            title: '접촉품질 분산',
            value: (dm[0].g.report.electrodeContactVar[0]).toStringAsFixed(3)),
        _textContents(
            title: '접촉품질 표준편차',
            value: (dm[0].g.report.electrodeContactStd[0]).toStringAsFixed(3)),
        asSizedBox(height: 20),
        //----------------------------------------------------------------------
        // 예외상황 기록
        //----------------------------------------------------------------------
        dividerSmall(),
        _textTitle('예외 상황 발행 현황 (디버그 상세 분석)'),

        TextN(
            '신호 급변 시간 : ${(dm[0].g.report.exTimeBigTransition[setIdx]).toStringAsFixed(3)}',
            fontSize: tm.s12,
            color: tm.black),
        TextN('부착 횟수 : ${dm[0].g.report.exCntAttach[setIdx]}',
            fontSize: tm.s12, color: tm.black),
        TextN('탈착 횟수 : ${dm[0].g.report.exCntDetach[setIdx]}',
            fontSize: tm.s12, color: tm.black),
        TextN(
            '탈착 시간 : ${(dm[0].g.report.exTimeDetached[setIdx]).toStringAsFixed(1)}',
            fontSize: tm.s12,
            color: tm.black),
        TextN('외부 예외 횟수 : ${dm[0].g.report.exCntExternal[setIdx]}',
            fontSize: tm.s12, color: tm.black),
        TextN(
            '가짜신호 시간 : ${(dm[0].g.report.exTimeFake[setIdx]).toStringAsFixed(1)}',
            fontSize: tm.s12,
            color: tm.black),
        asSizedBox(height: 10),
        TextN('가짜신호 시간 (0.2초 단위)-----------------------------', fontSize: tm.s12, color: tm.black),
        TextN(
            '   - 피크/평균 기준 이상 : ${(dm[0].g.report.exFakeTimePeakFreqVsMeanTooBig[setIdx]).toStringAsFixed(1)}초',
            fontSize: tm.s12,
            color: tm.black),
        TextN(
            '   - 저주파/고주파 기준 이상: ${(dm[0].g.report.exFakeTimeLowFreqVsHighTooBig[setIdx]).toStringAsFixed(1)}초',
            fontSize: tm.s12,
            color: tm.black),
        TextN('가짜신호 기준 및 최대 ----------------------------------', fontSize: tm.s12, color: tm.black),
        // TextN('   - 피크 index 기준 : 35 (121Hz)',
        //     fontSize: tm.s18, color: tm.blue),
        // TextN(
        //     '   - 피크 index 최대 : [TH 35(121Hz)]'
        //         ' ${dm[0].g.report.exFakeMeasureMaxPeakFreqIndex[setIdx]}'
        //         ' (${(dm[0].g.report.exFakeMeasureMaxPeakFreqIndex[setIdx] * 250 / 64).toStringAsFixed(0)}Hz)',
        //     fontSize: tm.s18,
        //     color: tm.black),
        TextN(
            '   - 피크/평균 : [TH ${DspCommonParameter.exThFakeMaxVsAvRatio}]'
            ' ${(dm[0].g.report.exFakeFreqPeakVsMeanMax[setIdx]).toStringAsFixed(3)}',
            fontSize: tm.s12,
            color: tm.black),
        // TextN(
        //     '   - 저주파/고주파 기준 : ${DspCommonParameter.exThFakeLowVsHighRatio}',
        //     fontSize: tm.s18,
        //     color: tm.blue),
        TextN(
            '   - 저주파/고주파 : [TH ${DspCommonParameter.exThFakeLowVsHighRatio}]'
            ' ${(dm[0].g.report.exFakeFreqLowVsHighMax[setIdx]).toStringAsFixed(3)}',
            fontSize: tm.s12,
            color: tm.black),

        TextN(
            '   - 저주파/고주파 구간평균 : [TH ${DspCommonParameter.exThFakeLowVsHighRatioAv}]'
            ' ${(dm[0].g.report.exFakeFreqLowVsHighAvMax[setIdx]).toStringAsFixed(3)}',
            fontSize: tm.s12,
            color: tm.black),
        asSizedBox(height: 20),
      ],
    ),
  );
}

//==============================================================================
// 소제목
//==============================================================================
Widget _textTitle(String title) {
  double width = asWidth(150);
  return Padding(
    padding:
        EdgeInsets.symmetric(horizontal: asWidth(0), vertical: asHeight(6)),
    child: Row(
      children: [
        TextN(
          title,
          fontSize: tm.s14,
          color: tm.black,
          fontWeight: FontWeight.bold,
        ),
      ],
    ),
  );
}

//==============================================================================
// 내용
//==============================================================================
Widget _textContents({String title = '제목', String value = '00'}) {
  double width = asWidth(150);
  return Padding(
    padding:
        EdgeInsets.symmetric(horizontal: asWidth(0), vertical: asHeight(6)),
    child: Row(
      children: [
        Container(
          width: width,
          alignment: Alignment.centerLeft,
          child: TextN(title, fontSize: tm.s12, color: tm.mainBlue),
        ),
        TextN(value, fontSize: tm.s12, color: tm.black),
      ],
    ),
  );
}
