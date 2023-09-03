import 'package:intl/intl.dart';
import '/F0_BASIC/common_import.dart';

//==============================================================================
// report page
//==============================================================================
class ReportPage extends StatefulWidget {
  final int reportIndex;

  const ReportPage({this.reportIndex = 0, Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool isMeasureQualityExpanded = false; //측정 품질 펼쳐보기

  @override
  Widget build(BuildContext context) {
    return _reportPage(widget.reportIndex);
  }

  ///---------------------------------------------------------------------------
  /// report main
  ///---------------------------------------------------------------------------
  Widget _reportPage(int reportIndex) {
    int idx = reportIndex;

    String date =
        DateFormat('yyyy.M.d').format(gv.dbRecordIndexes[idx].startTime);
    String startTime =
        DateFormat('hh:mm:ss').format(gv.dbRecordIndexes[idx].startTime);
    String endTime =
        DateFormat('hh:mm:ss').format(gv.dbRecordIndexes[idx].endTime);
    return Column(
      children: [
        asSizedBox(height: 10),
        _head(reportIndex),
        asSizedBox(height: 10),

        //----------------------------------------------------------------------
        // 운동부위 및 마크보기
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            asSizedBox(width: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextN(date,
                    fontSize: tm.s14,
                    color: tm.black,
                    fontWeight: FontWeight.bold),
                TextN('  ' + startTime, fontSize: tm.s14, color: tm.grey03),
                TextN(
                    '  (${timeToStringBasic(timeSec: gv.dbRecordIndexes[reportIndex].exerciseTime)})',
                    fontSize: tm.s16,
                    color: tm.grey03),
                // TextN('  ( ' + startTime, fontSize: tm.s16, color: tm.grey03),
                // TextN(' ~ ' + endTime + ' )', fontSize: tm.s16, color: tm.grey03),
              ],
            ),
          ],
        ),
        asSizedBox(height: 10),
        //----------------------------------------------------------------------
        // 운동부위
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                asSizedBox(width: 18),
                TextN('운동부위: ', fontSize: tm.s12, color: tm.grey04),
                TextN(
                    gv.setting.isMuscleNameKrPure.value == true
                        ? GvDef.muscleListKrPure[
                            gv.dbRecordIndexes[reportIndex].muscleTypeIndex]
                        : GvDef.muscleListKr[
                            gv.dbRecordIndexes[reportIndex].muscleTypeIndex],
                    fontSize: tm.s12,
                    color: tm.grey04),
              ],
            ),
            //--------------------------------------------------------------------
            // 마크보기 버튼 : todo : 수정 필요 (시간 없어서...)

            InkWell(
              borderRadius: BorderRadius.circular(asHeight(8)),
              onTap: (() {
                gvRecord.isSelectedViewMark.value =
                    !gvRecord.isSelectedViewMark.value;
                setState(() {});
              }),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: asWidth(18), vertical: asWidth(18)),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/ic_check_square.png',
                          height: asHeight(16),
                          color: gvRecord.isSelectedViewMark.value
                              ? tm.mainBlue
                              : tm.grey03,
                        ),
                        Image.asset(
                          'assets/icons/ic_check.png',
                          height: asHeight(8),
                          color: tm.white,
                        ),
                      ],
                    ),
                    asSizedBox(width: 6),
                    TextN('마크보기', fontSize: tm.s14, color: tm.grey04),
                    // asSizedBox(width: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
        asSizedBox(height: 6),
        // dividerBig(),
        dividerSmall(),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                  child: Column(
                    children: [
                      //------------------------------------------------------------------
                      // TIME CHART
                      asSizedBox(height: 20),
                      ReportTimeChart(
                        width: asWidth(360 - 36),
                        height: asHeight(220),
                      ),
                      asSizedBox(height: 20),
                      //------------------------------------------------------------------
                      // 측정 결과 알림
                      _measureQualityBrief(),
                      asSizedBox(height: 30),
                      //------------------------------------------------------------------
                      // 운동량 과 목표달성
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _aoeBar(reportIndex),
                          _aoeTargetBar(reportIndex),
                        ],
                      ),
                      asSizedBox(height: 20),
                      dividerSmall(),
                      asSizedBox(height: 20),
                      //------------------------------------------------------------------
                      // 주파수 변화
                      _frequencyBar(reportIndex),
                      asSizedBox(height: 30),
                    ],
                  ),
                ),
                //------------------------------------------------------------------
                // 주요 분석 결과
                dividerBig2(),
                _resultTable(reportIndex),
                asSizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///---------------------------------------------------------------------------
  /// head
  ///---------------------------------------------------------------------------
  Widget _head(int reportIndex) {
    int idx = reportIndex;
    String muscleName = gv.dbRecordIndexes[idx].muscleName;
    return Container(
      // 여유공간
      margin: EdgeInsets.only(top: asHeight(10)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          //----------------------------------------------------------------------
          // 제목
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: asWidth(220),
              child: AutoSizeText(
                muscleName,
                maxLines: 2,
                style: TextStyle(
                  fontSize: tm.s20,
                  color: tm.grey04,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //----------------------------------------------------------------------
          // 닫기 버튼
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(asHeight(23)),
              onTap: (() {
                Get.back();
              }),
              child: Container(
                width: asWidth(72),
                height: asHeight(46),
                alignment: Alignment.center,
                child: Icon(
                  Icons.close,
                  size: asHeight(36),
                  color: tm.grey03,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 측정 결과
  ///---------------------------------------------------------------------------
  Widget _measureQualityBrief() {
    // List<double> electrodeContactData = gv.dbRecordContents.electrodeContactData; //전극 접촉 데이터
    // double endTime = gv.dbRecordContents.endTime;
    double electrodeContactMax =
        gv.dbRecordContents.electrodeContactMax; //접촉 품질 최대 값
    int exCntDetach = gv.dbRecordContents.exCntDetach; //전극 분리 횟수
    double exTimeDetached = gv.dbRecordContents.exTimeDetached; //전극 분리 시간
    int exCntExternal = gv.dbRecordContents.exCntExternal; //무선 손실 예외 횟수
    double exTimeFake = gv.dbRecordContents.exTimeFake; //가짜 신호 시간

    bool flagMeasureGood = true;

    if (exCntDetach > 0) flagMeasureGood = false;
    if (exTimeDetached > 0) flagMeasureGood = false;
    if (exCntExternal > 0) flagMeasureGood = false;
    if (exTimeFake > 0) flagMeasureGood = false;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                //------------------------------------------------
                // 느낌표
                if (!flagMeasureGood)
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
                if (!flagMeasureGood) asSizedBox(width: 4),
                //------------------------------------------------
                // 기본 안내문구
                Container(
                  width: flagMeasureGood ? asWidth(218) : asWidth(202),
                  alignment: Alignment.centerLeft,
                  child: TextN(
                    flagMeasureGood
                        ? '측정 과정에서 오류가 발견되지 않았습니다.'
                        : '측정 과정에서 잡음이 발생하였습니다.',
                    fontSize: tm.s14,
                    color: tm.black,
                    maxLines: 2,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            wButtonAwSel(
                height: asHeight(34),
                touchHeight: asHeight(54),
                padTouchWidth: asWidth(0),
                isArrowFlip: isMeasureQualityExpanded,
                onTap: (() {
                  isMeasureQualityExpanded = !isMeasureQualityExpanded;
                  setState(() {});
                }),
                child: TextN(
                  '상세보기',
                  fontSize: tm.s14,
                  color: tm.grey04,
                )),
          ],
        ),
        //----------------------------------------------------------------------
        // 측정 품질 상세보기 펼치기를 한 경우
        // 애니메이션이 되다가 안되는 이유는?
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child:
              isMeasureQualityExpanded ? _measureQualityDetail() : Container(),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              child: child,
              axisAlignment: -1.0, //위쪽으로 정렬
              sizeFactor: Tween<double>(
                begin: 0, // 높이가 0으로 시작하도록 함
                end: 1, // 높이가 원래 크기(100%)로 펼쳐지도록 함
              ).animate(animation),
            );
          },
        ),
      ],
    );
  }

  ///---------------------------------------------------------------------------
  /// 측정 결과 상세
  ///---------------------------------------------------------------------------
  Widget _measureQualityDetail() {
    List<double> electrodeContactData =
        gv.dbRecordContents.electrodeContactData; //전극 접촉 데이터
    List<double> isExBufferCleared =
        gv.dbRecordContents.isExBufferCleared; //버퍼 클리어 여부 데이터
    double endTime = gv.dbRecordContents.endTime;
    double electrodeContactMax =
        gv.dbRecordContents.electrodeContactMax; //접촉 품질 최대 값
    int exCntDetach = gv.dbRecordContents.exCntDetach; //전극 분리 횟수
    double exTimeDetached = gv.dbRecordContents.exTimeDetached; //전극 분리 시간
    int exCntExternal = gv.dbRecordContents.exCntExternal; //무선 손실 예외 횟수
    double exTimeFake = gv.dbRecordContents.exTimeFake; //가짜 신호 시간
    bool flagMeasureGood = true;

    if (exCntDetach > 0) flagMeasureGood = false;
    if (exTimeDetached > 0) flagMeasureGood = false;
    if (exCntExternal > 0) flagMeasureGood = false;
    if (exTimeFake > 0) flagMeasureGood = false;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: asWidth(8)),
      // margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
      decoration: BoxDecoration(
        color: tm.grey01,
        borderRadius: BorderRadius.circular(asHeight(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          asSizedBox(height: 30),
          //----------------------------------------------------------------------
          // 전극 품질
          ElectrodeQualityChart(
            width: asWidth(360 - 36),
            height: asHeight(120),
            etContactData: electrodeContactData,
            buffClearData: isExBufferCleared,
            endTime: endTime,
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
                    ' 해당 구간의 데이터가 자동삭제 되었습니다. (위 그래프의 붉은색 영역)',
            fontSize: tm.s12,
            color: flagMeasureGood ? tm.black : tm.grey04,
            height: 1.5,
          ),
          asSizedBox(height: 5),
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
          asSizedBox(height: 30),
        ],
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

  ///---------------------------------------------------------------------------
  /// 운동량 바
  ///---------------------------------------------------------------------------
  Widget _aoeBar(int reportIndex) {
    double aoeSet = gv.dbRecordIndexes[reportIndex].aoeSet;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //------------------------------------------ 제목
        TextN(
          '세트 운동량'.tr,
          fontSize: tm.s14,
          color: tm.black,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
        asSizedBox(height: 6),
        //--------------------------- % 표시
        TextN(
          '${toStrFixedAuto(aoeSet * 100)}%',
          fontSize: tm.s20,
          color: tm.mainGreen,
          fontWeight: FontWeight.w400,
          height: 1,
        ),
        asSizedBox(height: 9),
        //------------------------------------------ bar
        basicHorizontalBarLive(
          value: aoeSet,
          //exerciseGauge.value,
          width: asWidth(152),
          height: asHeight(6),
          backgroundColor: tm.grey02,
          barColor: tm.mainGreen,
          isViewMaxLine: aoeSet <= 1 ? false : true,
          maxLineColor: tm.mainGreen,
          maxLineHeight: asHeight(6) * 2,
          maxLineWidth: 3,
        ),
      ],
    );
  }

  ///---------------------------------------------------------------------------
  /// 목표달성 바
  ///---------------------------------------------------------------------------
  Widget _aoeTargetBar(int reportIndex) {
    double aoeTargetSet = gv.dbRecordContents.aoeTarget;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //------------------------------------------ 제목
        TextN(
          // '힘 목표(${gv.dbRecordIndexes[reportIndex].targetPrm}%) 달성 운동량'
          '목표달성 운동량'.tr,
          fontSize: tm.s14,
          color: tm.black,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
        asSizedBox(height: 6),
        //--------------------------- % 표시
        TextN(
          '${toStrFixedAuto(aoeTargetSet * 100)}%',
          fontSize: tm.s20,
          color: tm.mainBlue,
          fontWeight: FontWeight.w400,
          height: 1,
        ),
        asSizedBox(height: 9),
        //------------------------------------------ bar
        basicHorizontalBarLive(
          value: aoeTargetSet,
          width: asWidth(152),
          height: asHeight(6),
          backgroundColor: tm.grey02,
          barColor: tm.mainBlue,
          isViewMaxLine: aoeTargetSet <= 1 ? false : true,
          maxLineColor: tm.mainBlue,
          maxLineHeight: asHeight(6) * 2,
          maxLineWidth: 3,
        ),
      ],
    );
  }

  ///---------------------------------------------------------------------------
  /// 주파수 바
  ///---------------------------------------------------------------------------
  Widget _frequencyBar(int reportIndex) {
    //-------------------- 주파수 최대 최소
    double freqBegin = gv.dbRecordContents.freqBegin;
    double freqEnd = gv.dbRecordContents.freqEnd;

    double valueH = max(freqBegin, freqEnd);
    double valueL = min(freqBegin, freqEnd);

    //-------------------- 바 최대 영역 : 보통 고정이지만, 필요에 따라 조절
    double barMax = max(GvDef.freqDisplayMax, valueH); //가장 큰 값
    double barMin = min(GvDef.freqDisplayMin, valueL); //가장 작은 값
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //--------------------------------------------------------------------
            // 제목
            SizedBox(
              width: asWidth(107),
              height: asHeight(20),
              child: TextN(
                '주파수 변화(Hz)'.tr,
                fontSize: tm.s14,
                color: tm.black,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //------------------------------------------------------------------
            // 그래프
            rangePatternHorizontalBar(
                width: asWidth(100),
                height: asHeight(14),
                valueHigh: valueH,
                valueLow: valueL,
                barMax: barMax,
                barMin: barMin,
                numberOfBar: 30,
                barRadius: 10,
                intervalWidthRatioVsBar: 1,
                barColor: freqBegin > freqEnd
                    ? tm.mainBlue //감소하면 blue
                    : tm.mainGreen,
                //주파수가 증가하면 black
                barBackgroundColor: tm.grey02),
            //------------------------------------------------------------------
            // Text
            asSizedBox(width: 13),
            Row(
              children: [
                Container(
                  width: asWidth(36),
                  height: asHeight(20),
                  alignment: Alignment.center,
                  child: FittedBoxN(
                    child: TextN(
                      '$freqBegin',
                      fontSize: tm.s16,
                      color: tm.grey03,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ),
                asSizedBox(width: 3),
                Icon(
                  Icons.double_arrow_rounded,
                  size: tm.s16,
                  color: tm.grey03,
                ),
                asSizedBox(width: 3),
                Container(
                  width: asWidth(36),
                  height: asHeight(20),
                  alignment: Alignment.center,
                  child: FittedBoxN(
                    child: TextN(
                      '$freqEnd',
                      fontSize: tm.s16,
                      color: tm.black,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  ///---------------------------------------------------------------------------
  /// 운동결과 기타 정보
  ///---------------------------------------------------------------------------
  Widget _resultTable(int reportIndex) {
    double columnHeight = asHeight(40);
    return Container(
      color: tm.grey01,
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          asSizedBox(height: 30),
          TextN('운동 결과',
              fontSize: tm.s14, color: tm.black, fontWeight: FontWeight.bold),
          asSizedBox(height: 10),
          //--------------------------------------------------------------------
          // 최대근력
          _titleContents(
              '최대근력(1RM) 기준 값',
              convertMvcToDisplayValue(gv.dbRecordIndexes[reportIndex].mvcMv,
                  fractionDigits: 3)),
          //--------------------------------------------------------------------
          // 신규측정
          _titleContents(
              '최대근력(1RM) 신규 측정값',
              convertMvcToDisplayValue(gv.dbRecordContents.measureMvcMv,
                  fractionDigits: 3)),
          //--------------------------------------------------------------------
          // 역대 최대 MVC
          _titleContents(
              '최대근력(1RM) 역대 최댓값',
              convertMvcToDisplayValue(
                  gv.dbRecordIndexes[reportIndex].greatestEverMvcMv == 0.0
                      ? gv.dbRecordIndexes[reportIndex].mvcMv
                      : gv.dbRecordIndexes[reportIndex].greatestEverMvcMv,
                  fractionDigits: 3)),
          //--------------------------------------------------------------------
          // 근전도 최대
          _titleContents(
              '근전도 신호 최대',
              convertMvcToDisplayValue(gv.dbRecordContents.emgTimeMax,
                  fractionDigits: 3)),
          //--------------------------------------------------------------------
          // 근전도 평균
          _titleContents(
              '근전도 신호 평균',
              convertMvcToDisplayValue(gv.dbRecordContents.emgTimeAv,
                  fractionDigits: 3)),
          //--------------------------------------------------------------------
          // 근전도 피크 평균
          _titleContents(
              '근전도 피크 평균',
              convertMvcToDisplayValue(gv.dbRecordContents.emgCountAv,
                  fractionDigits: 3)),
          //--------------------------------------------------------------------
          // 근전도 성공/총 반복 횟수
          _titleContents(
              '목표성공/총 반복 횟수',
              '${gv.dbRecordContents.repetitionTargetSuccess}'
                      ' / ${gv.dbRecordContents.repetition} ' +
                  '회'),
          //--------------------------------------------------------------------
          // 심박
          _titleContents('심박 최대 / 평균',
              '${(gv.dbRecordContents.ecgHeartRateMax).toStringAsFixed(0)}'
                  ' / ${(gv.dbRecordContents.ecgHeartRateAv).toStringAsFixed(0)}'),

          asSizedBox(height: 30),
          //------------------------------------------------------------------------
          // 설명글
          //------------------------------------------------------------------------
          _textScript(
              '최대근력(1RM)',
              '가장 큰 힘을 낼 때 발생하는 근전도 신호의 크기 값입니다.'
                  ' 즉, 1회 반복할 수 있는 최대 무게로 운동할 때 발생하는 근전도 크기로 볼 수 있습니다.'
                  ' 측정한 근전도 신호를 바탕으로 최대근력을 통계적 방식으로 추정하여 표시합니다.'
                  ' 설정에 따라 전압(mV) 혹은 체감무게(kgf)로 표시됩니다.'),
          _textScript('최대근력 기준값', '힘 목표 가이드 및 운동량 계산을 할 때 사용한 기준이 되는 값입니다.'),
          _textScript(
              '최대근력 신규 측정 값',
              '새로 측정한 최대근력 추정값으로, 기준 최대근력보다 작거나 같습니다.'
                  ' 전극 부착위치에 따라 신규측정 최대근력은 크게 달라질 수 있습니다.'
                  ' 최대한 동일한 위치에 부착하면 좀 더 신뢰성 있는 결과를 얻습니다.'),
          _textScript('최대근력 역대 최댓값', '최대근력(1RM) 통계 기록 중 가장 큰 값을 표시합니다.'),
          _textScript('근전도 신호 최대 및 평균', '측정한 근전도 신호의 최댓 값 혹은 평균 값입니다.'),
          _textScript('근전도 피크평균', '반복운동에 따른 피크 값들의 평균입니다.'),
          asSizedBox(height: 30),
        ],
      ),
    );
  }
}

//==============================================================================
// 제목과 타이틀
//==============================================================================
Widget _titleContents(String title, String contents) {
  return Container(
    height: asHeight(48),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: asWidth(140),
              height: asHeight(47),
              child: FittedBoxN(
                child: TextN(
                  title,
                  fontSize: tm.s14,
                  color: tm.grey04,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: asWidth(140),
              height: asHeight(47),
              child: FittedBoxN(
                child: TextN(
                  contents,
                  fontSize: tm.s14,
                  color: tm.grey04,
                ),
              ),
            ),
          ],
        ),
        Container(width: asWidth(322), height: asHeight(1), color: tm.grey02),
      ],
    ),
  );
}

//==============================================================================
// 제목과 타이틀
//==============================================================================
Widget _textScript(String title, String contents) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: asHeight(4)),
    child: RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: tm.s14,
            color: tm.grey04,
            height: 1.5,
            fontWeight: FontWeight.normal,
          ),
          children: [
            TextSpan(
                text: '· ' + title + ' : ',
                style: TextStyle(
                    fontSize: tm.s14,
                    color: tm.grey04,
                    height: 1.5,
                    fontWeight: FontWeight.bold)),
            TextSpan(text: contents),
          ]),
    ),
  );
}
