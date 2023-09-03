import '/F0_BASIC/common_import.dart';

//==============================================================================
// 측정 종료단계
//==============================================================================
class MeasureEnd extends StatefulWidget {
  const MeasureEnd({Key? key}) : super(key: key);

  @override
  State<MeasureEnd> createState() => _MeasureEndState();
}

class _MeasureEndState extends State<MeasureEnd> {
  //----------------------------------------------------
  // 최대근력 갱신 관련 변수들
  late int d;
  int setIdx = 0;
  late double oneRmPrevious; // = dm[d].g.report.w1Rm[setIdx];
  late double oneRmNew; //= dm[d].g.report.w1RmNew[setIdx];
  late bool isNew1RmIsBig; // = oneRmNew < oneRmPrevious; //테스트
  bool isMeasureQualityExpanded = false; //측정 품질 펼쳐보기
  String timeStr = timeToStringBasic(timeSec: DspManager.timeMeasure.value);

  ///---------------------------------------------------------------------------
  /// init
  ///---------------------------------------------------------------------------
  @override
  void initState() {
    d = 0; //device index
    setIdx = 0; // set index (basic 은 단일 세트 운동)
    //----------------------------------------------------
    // 최대근력 갱신 관련 변수 초기화
    oneRmPrevious = dm[d].g.report.w1Rm[setIdx];
    oneRmNew = dm[d].g.report.w1RmNew[setIdx];
    isNew1RmIsBig = oneRmNew > oneRmPrevious; //테스트
    timeStr = timeToStringBasic(timeSec: DspManager.timeMeasure.value);
    //----------------------------------------------------
    // 휴식시간 타이머 설정 (목표 %에 따라 휴식시간 변경)
    // 실제 성과를 보고 휴식시간 조절하는 것은 추후에 검토
    // set state 충돌 방지를 위해 obs 변수는 지연시킨 후 초기화
    Future.delayed(const Duration(milliseconds: 200), () {
      DspManager.timeSetRelax.value =
          prmToRelaxTime(gv.deviceData[0].targetPrm.value); //휴식시간 초기화
      DspManager.idxMuscleRelax = gv.control.idxMuscle.value; //현재의 근육 기록
    });

    //----------------------------------------------------
    // 휴식 시간 흐름목적 초단위 화면 갱신
    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   setState(() {});
    // });
    super.initState();
  }

  ///---------------------------------------------------------------------------
  /// dispose()
  ///---------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
  }

  ///---------------------------------------------------------------------------
  /// build
  ///---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // isNew1RmIsBig = false; //삭제예정
    // isNew1RmIsBig = oneRmNew > oneRmPrevious;
    Wakelock.disable(); //화면 켜짐 해제
    return Material(
      color: tm.white,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //------------------------------------------------------------------
                // 상단 바
                // topBarBasic(context),
                topBarGuide(context, isViewXButton: false, isMeasureEnd: true),
                //------------------------------------------------------------
                // 최대근력 표시
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //------------------------------------------------------------
                        // 성과
                        // asSizedBox(height: 20),
                        _award(),
                        asSizedBox(height: 30),
                        //------------------------------------------------------------
                        // 최대근력 결과
                        _oneRmResult(),
                        asSizedBox(height: 30),
                        dividerBig(),
                        asSizedBox(height: 20),
                        //------------------------------------------------------------
                        // 측정 품질 안내 문구
                        _measureQualityBrief(),
                        asSizedBox(height: 40),
                        //------------------------------------------------------------
                        // 결과 요약
                        _resultTable(),
                        asSizedBox(height: 200),
                      ],
                    ),
                  ),
                ),

                //------------------------------------------------------------------
                // 하부영역 - 스크롤 - 리포트
              ],
            ),
            //------------------------------------------------------------
            // 버튼
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _saveOrNotButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 운동 성과
  ///---------------------------------------------------------------------------
  Widget _award() {
    int setIdx = 0;
    // 운동량 성과
    double aoeSet = dm[0].g.report.aoeSet[setIdx];
    Map aoeAward = aoeResultAward(aoeSet);
    String aoeSetStr = (aoeSet * 100).toStringAsFixed(1);

    return SizedBox(
      // height: asHeight(115), //37+28
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          //----------------------------------------------------------------------
          // background - 목표 달성한 경우에만 표시
          //----------------------------------------------------------------------
          if (aoeAward['award'] == EmaAward.great) //great 일 대
            Image.asset(
              'assets/images/effect_bg.png',
              height: asHeight(100),
            ),
          Column(
            children: [
              //------------------------------------------------------------------
              // 별과 이모티콘
              //------------------------------------------------------------------
              asSizedBox(height: 20),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  //------------------------------------------------------------------
                  // 아쉬워요, 좋아요, 훌륭해요 3개에서만 별 표시
                  //------------------------------------------------------------------
                  // if (aoeAward['numOfStar'] != 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //----------------------------------------------
                      // 첫번째 별
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          asSizedBox(height: asHeight(10)),
                          Opacity(
                              opacity: aoeAward['numOfStar'] >= 1 ? 1 : 0.2,
                              child: Image.asset(
                                'assets/icons/ic_star.png',
                                height: asHeight(20),
                              )),
                        ],
                      ),
                      //----------------------------------------------
                      //두번째 별
                      asSizedBox(width: 4),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //asSizedBox(height: asHeight(10)),
                          Opacity(
                              opacity: aoeAward['numOfStar'] >= 2 ? 1 : 0.2,
                              child: Image.asset(
                                'assets/icons/ic_star.png',
                                height: asHeight(20),
                              )),
                        ],
                      ),
                      //----------------------------------------------
                      //세번째 별
                      asSizedBox(width: 4),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          asSizedBox(height: asHeight(10)),
                          Opacity(
                              opacity: aoeAward['numOfStar'] >= 3 ? 1 : 0.2,
                              child: Image.asset(
                                'assets/icons/ic_star.png',
                                height: asHeight(20),
                              )),
                        ],
                      ),
                    ],
                  ),
                  //------------------------------------------------------------------------
                  // 성과 이모티콘 표시
                  //------------------------------------------------------------------------
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      asSizedBox(height: 28),
                      Image.asset(
                        aoeAward['imPath'],
                        height: asHeight(37),
                        //-------------- 결과에 이모티콘 색상
                        color: aoeAward['color'],
                      ),
                      //------------------------------------------------------------------------
                      // 성과 글씨 표시
                      //------------------------------------------------------------------------
                      asSizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextN(
                            '운동량($aoeSetStr%)  ',
                            fontSize: tm.s16,
                            color: aoeAward['color'],
                          ),
                          TextN(
                            aoeAward['awardText'],
                            fontSize: tm.s20,
                            fontWeight: FontWeight.bold,
                            color: aoeAward['color'],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 최대근력 측정 결과
  ///---------------------------------------------------------------------------
  Widget _oneRmResult() {
    return Container(
      // height: asHeight(266),
      // alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      // color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //----------------------------------------------------------------------
          // 최대근력 값 갱신 알림
          //----------------------------------------------------------------------
          if (isNew1RmIsBig)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TextN('더 큰 '.tr, fontSize: tm.s16, color: tm.black),
                TextN(
                  '최대근력(1RM)'.tr,
                  fontSize: tm.s16,
                  color: tm.black,
                  fontWeight: FontWeight.bold,
                ),
                TextN('이 증가했습니다!'.tr, fontSize: tm.s16, color: tm.black),
              ],
            ),
          if (isNew1RmIsBig) asSizedBox(height: 20),
          //----------------------------------------------------------------------
          // 운동시간 및 단위
          //----------------------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextN(
                '단위: ${gv.setting.isViewUnitKgf.value == false ? 'mV' : 'kgf'}',
                fontSize: tm.s12,
                color: tm.grey04,
                height: 1,
              ),
            ],
          ),
          asSizedBox(height: 12),
          //----------------------------------------------------------------------
          // 최대근력 결과 박스
          //----------------------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //------------------------------------------------------------------
              // 이전 1RM
              Container(
                width: asWidth(155),
                height: asHeight(104),
                padding: EdgeInsets.symmetric(
                    horizontal: asWidth(14), vertical: asHeight(14)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(asHeight(16)),
                  color: tm.grey01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //------------------------------------------------------------
                    // 상단
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: asHeight(20),
                            alignment: Alignment.center,
                            child: TextN(isNew1RmIsBig ? '이전 기록' : '최대근력(1RM)',
                                fontSize: tm.s12, color: tm.grey03)),
                      ],
                    ),
                    //------------------------------------------------------------
                    // 하단
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //--------------------------------------------------------
                        // 신규 1RM
                        TextN(
                            convertMvcToDisplayValue(
                                dm[0].g.report.w1Rm[setIdx],
                                isViewUnit: false),
                            fontSize: tm.s28,
                            fontWeight: FontWeight.bold,
                            color: tm.grey04),
                        //--------------------------------------------------------
                        // 역대 최대
                        Obx(() => TextN(
                            'max ${convertMvcToDisplayValue(gv.control.greatestEverMvcMv > dm[0].g.report.w1RmNew[setIdx] ? gv.control.greatestEverMvcMv : dm[0].g.report.w1RmNew[setIdx], fractionDigits: 2, isViewUnit: false)}',
                            fontSize: tm.s12,
                            color: tm.grey04)),
                      ],
                    ),
                  ],
                ),
              ),

              //------------------------------------------------------------------
              // 신규 1RM
              Container(
                width: asWidth(155),
                height: asHeight(104),
                padding: EdgeInsets.symmetric(
                    horizontal: asWidth(14), vertical: asHeight(14)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(asHeight(16)),
                  color: tm.softBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //------------------------------------------------------------
                    // 상단
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: asHeight(20),
                            alignment: Alignment.center,
                            child: TextN(
                                isNew1RmIsBig ? '신규 최대근력(1RM)' : '신규 측정',
                                fontSize: tm.s12,
                                color: tm.mainBlue)),
                      ],
                    ),
                    //------------------------------------------------------------
                    // 하단
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //--------------------------------------------------------
                        // 신규 1RM
                        TextN(
                            convertMvcToDisplayValue(
                                dm[0].g.report.w1RmNew[setIdx],
                                isViewUnit: false),
                            fontSize: tm.s28,
                            fontWeight: FontWeight.bold,
                            color: tm.mainBlue),
                        //asSizedBox(width: 12),
                        //--------------------------------------------------------
                        // 상승 % 박스 (현재 값이 더 클때만 표시)
                        if (isNew1RmIsBig)
                          Container(
                            // margin: EdgeInsets.only(right: asWidth(30)),
                            width: asWidth(67),
                            height: asHeight(26),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: tm.mainBlue,
                                borderRadius:
                                    BorderRadius.circular(asHeight(13))),
                            child: FittedBoxN(
                              child: TextN(
                                '+${toStrFixedAuto(oneRmNew / oneRmPrevious * 100 - 100)}%',
                                fontSize: tm.s14,
                                color: tm.fixedWhite,
                                // fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       width: asWidth(50),
                        //       alignment: Alignment.centerRight,
                        //       // color: Colors.red,
                        //       child: FittedBoxN(
                        //         child: TextN(
                        //           '+${toStrFixedAuto(oneRmNew / oneRmPrevious * 100 - 100)}%',
                        //           fontSize: tm.s14,
                        //           color: tm.blue,
                        //           // fontWeight: FontWeight.w900,
                        //         ),
                        //       ),
                        //     ),
                        //     asSizedBox(width: 2),
                        //     Image.asset(
                        //       'assets/icons/ic_arrow_up_2.png',
                        //       color: tm.blue,
                        //       height: asHeight(12),
                        //     ),
                        //     asSizedBox(width: 10),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          //--------------------------------------------------------------------
          // 운동시간
          asSizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/ic_time.png',
                height: asHeight(14),
              ),
              asSizedBox(width: 4),
              TextN(
                '운동시간: $timeStr',
                fontSize: tm.s14,
                color: tm.grey04,
                height: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 측정품질 요약 및 펼치기
  ///---------------------------------------------------------------------------
  Widget _measureQualityBrief() {
    // 측정 품질 분석
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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  asSizedBox(width: 18),
                  //------------------------------------------------
                  // 느낌표
                  if (!flagMeasureGood)
                    Container(
                      width: asHeight(12),
                      height: asHeight(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(asHeight(6)),
                          color: tm.red),
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
                    // color: tm.grey04,
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
            ),
            Row(
              children: [
                wButtonAwSel(
                    height: asHeight(34),
                    touchHeight: asHeight(54),
                    padTouchWidth: asWidth(10),
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
                asSizedBox(width: 8),
              ],
            ),
          ],
        ),
        //----------------------------------------------------------------------
        // 측정 품질 상세보기 펼치기를 한 경우
        // 애니메이션이 되다가 안되는 이유는?
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child:
              isMeasureQualityExpanded ? measureQualityDetail() : Container(),
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
  /// 측정결과 테이블
  ///---------------------------------------------------------------------------
  Widget _resultTable() {
    //-----------------------------------------
    // 세트 운동량
    String aoeSet =
        (dm[0].g.report.aoeSet[setIdx] * 100).toStringAsFixed(1) + '%';
    //-----------------------------------------
    // 목표영역 운동량
    String aoeTarget =
        (dm[0].g.report.aoeTargetSet[setIdx] * 100).toStringAsFixed(1) + '%';
    //-----------------------------------------
    // 주파수 차이
    String sign =
        gv.deviceData[0].freqEnd.value > gv.deviceData[0].freqBegin.value
            ? '+'
            : '';
    String freqChange = sign +
        (gv.deviceData[0].freqEnd.value - gv.deviceData[0].freqBegin.value)
            .toStringAsFixed(1) +
        'Hz';
    String freqStart = gv.deviceData[0].freqBegin.value.toStringAsFixed(1);
    String freqEnd = gv.deviceData[0].freqEnd.value.toStringAsFixed(1);
    //-----------------------------------------
    // 휴식시간
    // 휴식시간은 목표 %1RM에 따라 변화 (실제 측정 값이 반영되지 않음)
    String relaxTime =
        prmToRelaxTime(gv.deviceData[0].targetPrm.value).toString() + '초'.tr;
    //-----------------------------------------
    // 심박
    // 조건 부 표시 (저장된 심박 수를 보고 3개 초과일 때)
    int hrNum = dm[0].g.report.ecgCountTime[setIdx].length;
    String hrMax = '미측정';
    String hrAv = '';
    if (hrNum > 3){
      hrMax = (dm[0].g.report.ecgHeartRateMax[setIdx]).toStringAsFixed(0);
      hrAv = '/ '+(dm[0].g.report.ecgHeartRateAv[setIdx]).toStringAsFixed(0);
    }


    return Container(
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      // color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //------------------------------------------------------------------
          // 운동결과 요약
          // _titleContents('운동 시간', timeStr),
          // asSizedBox(height: 10),
          _titleContents('운동량', aoeSet),
          asSizedBox(height: 10),
          _titleContents('힘 목표 운동량', aoeTarget),
          asSizedBox(height: 10),
          _titleContents('주파수 변화', '$freqChange ($freqStart→$freqEnd)'),
          asSizedBox(height: 10),
          Obx(
            () => _titleContents('권장 휴식시간($relaxTime)',
                timeToStringColon(timeSec: DspManager.timeSetRelax.value)),
          ),
          asSizedBox(height: 10),
          _titleContents('심박수 최대 / 평균', '$hrMax $hrAv'),
          asSizedBox(height: 10),
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
    height: asHeight(46),
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
              height: asHeight(45),
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
              height: asHeight(45),
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
        Container(width: asWidth(304), height: asHeight(1), color: tm.grey01),
      ],
    ),
  );
}

//==============================================================================
// 바닥 버튼
//==============================================================================
Widget _saveOrNotButton(BuildContext context) {
  //expanded가 있었음
  return Material(
    color: tm.white,
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          asSizedBox(height: 10),
          //----------------------------------------------------------------------
          // 저장 버튼
          //----------------------------------------------------------------------
          InkWell(
            borderRadius: BorderRadius.circular(asHeight(8)),
            //----------------------------------------------------------------
            // 저장 진행
            onTap: (() async {
              //------------------------------------------------------------
              // 측정 종료 명령 - 중복클릭 방지
              var _dialog = openPopupProcessIndicator(
                context,
                text: '저장 중입니다',
              );
              //------------------------------------------------------------
              // 저장 명령
              await saveMeasureData();
              //------------------------------------------------------------
              // 다이올로그 닫기
              Navigator.pop(context, _dialog);

              //------------------------------------------------------------
              // 새로 측정된 근력 값으로 갱신
              int d = 0;
              int setIdx = 0;
              gv.deviceData[d].mvc.value = (max(dm[d].g.report.w1RmNew[setIdx],
                      dm[d].g.report.w1Rm[setIdx]))
                  .toPrecision(4);

              // 새로 측정된 record 가 있으므로 역대 최대근력 업데이트 프로세스 실행
              gv.control.greatestEverMvcMv =
                  gv.control.findGreatestEver1Rm(gv.control.idxMuscle.value);

              //------------------------------------------------------------
              // 새로 측정데이터 내용을 통계 그래프에 업데이트
              await updateGraphData(timePeriod: gvRecord.graphTimePeriod.value);

              //-----------------------------------------------------------
              // 오디오 플레이 - 저장성공
              gv.audioManager.play(type: EmaSoundType.saveSuccess);
              //------------------------------------------------------------
              // 측정 대기 페이지로 이동
              Get.back();
            }),
            child: Ink(
              decoration: BoxDecoration(
                  color: tm.mainBlue,
                  borderRadius: BorderRadius.circular(asHeight(8))),
              width: asWidth(342),
              height: asHeight(52),
              child: Container(
                alignment: Alignment.center,
                child: TextN(
                  '저장하기'.tr,
                  color: tm.fixedWhite,
                  fontSize: tm.s16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //----------------------------------------------------------------------
          // 취소 버튼
          //----------------------------------------------------------------------
          asSizedBox(height: 10),
          InkWell(
            borderRadius: BorderRadius.circular(asHeight(8)),
            onTap: (() {
              int d = 0;
              int setIdx = 0;
              // 취소 시 최대근력 원래 값으로 복귀
              gv.deviceData[0].mvc.value =
                  gv.dbMuscleIndexes[gv.control.idxMuscle.value].mvcMv;

              // 최대근력 재설정 가능여부 복귀
              // 만약 dB에 기록된 최대값 보다 mvc 값이 작다면, 최대근력 재 설정 된 것을 이미
              // 이때는 재 설정 가능하게 복귀
              if (dm[d].g.report.w1Rm[setIdx] < gv.deviceData[0].mvc.value) {
                gv.deviceData[0].disableReset1RM.value = false;
              }

              // 취소 시 최대근력 원래 값으로 복귀 (dB의 값 읽기)
              DspManager.update1Rm(
                  deviceIndex: d, value: gv.deviceData[setIdx].mvc.value);
              DspManager.update1RmRt(
                  deviceIndex: d, value: gv.deviceData[setIdx].mvc.value);

              Get.back();
            }),
            child: Ink(
              decoration: BoxDecoration(
                  color: tm.white,
                  borderRadius: BorderRadius.circular(asHeight(8))),
              width: asWidth(342),
              height: asHeight(52),
              child: Container(
                alignment: Alignment.center,
                // color: tm.blue,
                child: TextN(
                  '취소'.tr,
                  color: tm.grey04,
                  fontSize: tm.s16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          asSizedBox(height: 0),
        ],
      ),
    ),
  );
}

//==============================================================================
// 성과 등급
//==============================================================================
Map aoeResultAward(double aoeSet) {
  Map map = {};
  EmaAward emaAward = EmaAward.good;
  Color _color = Colors.transparent;
  int numOfStar = 0;
  String awardText = '';
  String shortText = '';
  String imgPath = '';

  //------------------------ 조금 부족해요
  if (aoeSet < GvDef.aoeGood) {
    emaAward = EmaAward.notGood;
    _color = tm.grey04;
    numOfStar = 1;
    awardText = '조금 부족해요';
    shortText = '조금 부족해요';
    imgPath = 'assets/icons/ic_not_good.png';
  }
  //------------------------ 많이 무리했어요
  else if (aoeSet > GvDef.aoeVeryOver) {
    emaAward = EmaAward.veryOver;
    _color = tm.pointOrange;
    numOfStar = 0;
    awardText = '많이 무리했어요!';
    shortText = '많이 무리했어요';
    imgPath = 'assets/icons/ic_very_over.png';
  }
  //------------------------ 조금 무리했어요
  else if (aoeSet > GvDef.aoeOver) {
    emaAward = EmaAward.over;
    _color = tm.pointOrange;
    numOfStar = 1;
    awardText = '조금 무리했어요';
    shortText = '조금 무리했어요';
    imgPath = 'assets/icons/ic_over.png';
  }
  //------------------------ 좋아요
  else if (aoeSet > GvDef.aoeGreatH || aoeSet < GvDef.aoeGreatL) {
    emaAward = EmaAward.good;
    _color = tm.mainGreen;
    numOfStar = 2;
    awardText = '좋아요!';
    shortText = '좋아요';
    imgPath = 'assets/icons/ic_good.png';
  }
  //------------------------ 훌륭해요 (70 ~ 150)
  else {
    emaAward = EmaAward.great;
    _color = tm.mainBlue;
    numOfStar = 3;
    awardText = '목표 달성!'; //훌륭해요
    shortText = '훌륭해요';
    imgPath = 'assets/icons/ic_great.png';
  }

  map['award'] = emaAward;
  map['color'] = _color;
  map['numOfStar'] = numOfStar;
  map['awardText'] = awardText;
  map['shortText'] = shortText;
  map['imPath'] = imgPath;
  return map;
}
