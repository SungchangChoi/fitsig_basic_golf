import '/F0_BASIC/common_import.dart';

GlobalKey<_SelectMuscleState> keySelectMuscleState = GlobalKey();
GlobalKey<_SetMuscleState> _keySetMuscleState = GlobalKey();
GlobalKey<_SetMvcLevelState> _keySetMvcLevelState = GlobalKey();

//==============================================================================
// 근육 설정 위젯 (key 연결 목적)
//==============================================================================
Widget setMuscle() {
  return SetMuscle(key: _keySetMuscleState);
}

//==============================================================================
// 근육 설정
//==============================================================================

class SetMuscle extends StatefulWidget {
  const SetMuscle({Key? key}) : super(key: key);

  @override
  State<SetMuscle> createState() => _SetMuscleState();
}

class _SetMuscleState extends State<SetMuscle> {
  //----------------------------------------------------------------------------
  // 시작단계
  //----------------------------------------------------------------------------
  @override
  void initState() {
    // 슬라이드 값 - 현재 디바이스의 근력 레벨 값으로 표시
    // 여기서 변경해야 박스안 값이 갱신 됨
    // 슬라이드에서는 별도로 초기화
    gvMeasure.sliderValueMvc = gv.deviceData[0].mvc.value;
    super.initState();
  }

  //----------------------------------------------------------------------------
  // 해제단계 : 관련 정보 저장 - 버튼으로 이동
  //----------------------------------------------------------------------------
  @override
  void dispose() async {
    // 바로 저장하면 화면 갱신부분에 충돌나는 듯 (Obx 와 setState 충돌인 듯)
    // 해제될 때 100ms 후에 save 실행
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   saveMuscleData(); //데이터 저장
    //   if (kDebugMode) {
    //     print('화면이 사라질 때 근육 설정 save');
    //   }
    // });

    super.dispose();
  }

  //----------------------------------------------------------------------------
  // 갱신
  //----------------------------------------------------------------------------
  void refresh() {
    setState(() {});
  }

  //----------------------------------------------------------------------------
  // 빌드
  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  //----------------------------------------------------------------
                  // 상단 바
                  Container(),
                  _topBarBack(context),
                  //설정 전용 back
                  // asSizedBox(height: 10),
                  //----------------------------------------------------------------
                  // 리스트 및 편집 버튼
                  _topListEdit(),
                  asSizedBox(height: 5),
                  //----------------------------------------------------------------
                  // 근육 선택
                  _SelectMuscle(key: keySelectMuscleState),
                  // Obx(() {
                  //   int refresh = _refreshMuscle.value;
                  //   return const _SelectMuscle(); //_selectMuscle(context);
                  //   // return _selectMuscle(context);
                  // }),
                  asSizedBox(height: 10),
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            asSizedBox(height: 30),
                            //------------------------------------------------------
                            // 근육 이름 설정
                            MuscleNameTextField(key: keyMuscleNameTextField),
                            asSizedBox(height: 20),
                            //------------------------------------------------------
                            // 근육 부위 설정
                            _muscleType(context),
                            asSizedBox(height: 10),
                            dividerBig(),
                            asSizedBox(height: 22),

                            //------------------------------------------------------
                            // 근력운동 강도 설정
                            _exerciseLevel(context),
                            asSizedBox(height: 20),
                            dividerSmall(),
                            asSizedBox(height: 20),
                            //------------------------------------------------------
                            // 최대근력 레벨
                            _mvcLevel(context),
                            asSizedBox(height: 20),
                            //------------------------------------------------------
                            // 기본 값 설정
                            // _setDefault(),
                            // asSizedBox(height: 20),
                            //------------------------------------------------------
                            // 확인/취소
                            // _confirmCancelButton(),
                            // asSizedBox(height: 30),
                            //------------------------------------------------------
                            // 근육 삭제하기
                            // dividerBig(),
                            asSizedBox(height: 10),
                            _deleteMuscle(),
                            asSizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //----------------------------------------------------------------
              // 확인 버튼 : 이때 모두 기록하기
              //----------------------------------------------------------------
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: tm.white,
                    padding: EdgeInsets.symmetric(vertical: asHeight(10)),
                    alignment: Alignment.center,
                    child: textButtonI(
                      width: asWidth(324),
                      height: asHeight(52),
                      radius: asHeight(8),
                      backgroundColor: tm.mainBlue,
                      title: '확인',
                      fontSize: tm.s16,
                      onTap: (() {
                        saveMuscleData(); //데이터 저장
                        if (kDebugMode) {
                          print('화면이 사라질 때 근육 설정 save');
                        }
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Get.back();
                        });
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

//==============================================================================
// List & 편집 버튼
//==============================================================================
Widget _topListEdit() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          asSizedBox(width: asWidth(18)),
          Image.asset(
            'assets/icons/ic_list2.png',
            height: asHeight(11.5),
            color: tm.grey03,
          ),
          asSizedBox(width: asWidth(8)),
          TextN('총 ${gv.dbmMuscle.numberOfData}개',
              fontSize: tm.s14, color: tm.grey04),
        ],
      ),
      InkWell(
        onTap: (() {
          openBottomSheetBasic(
              isHeadView: true,
              headTitle: '편집',
              child: const ReorderMuscle(),
              height: asHeight(770));
        }),
        borderRadius: BorderRadius.circular(asHeight(8)),
        child: Container(
            height: asHeight(44),
            padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
            alignment: Alignment.center,
            child: TextN(
              '편집',
              color: tm.grey04,
              fontSize: tm.s14,
            )),
      ),
    ],
  );
}

//==============================================================================
// 스크롤 포지션 외부 초기화
//==============================================================================
void muscleListScrollPositionToLast() {
  keySelectMuscleState.currentState?.scrollPositionInit();
}

//==============================================================================
// 근육 선택 - 스크롤 초기 값 문제로 stateful 적용
//==============================================================================

class _SelectMuscle extends StatefulWidget {
  const _SelectMuscle({
    Key? key,
  }) : super(key: key);

  @override
  State<_SelectMuscle> createState() => _SelectMuscleState();
}

class _SelectMuscleState extends State<_SelectMuscle> {
  final ScrollController _scrollController = ScrollController();
  late List<DbMuscleIndex> dbMuscleIndexList;

  @override
  void initState() {
    super.initState();
    dbMuscleIndexList = gv.dbMuscleIndexes;

    //--------------------------------------------------------------------------
    // 스크롤 위치 초기 값 설정하기 - 화면이 그려진 100ms 후에 동작
    //--------------------------------------------------------------------------
    Future.delayed(const Duration(milliseconds: 1), () async {
      //----------------------------------------------
      // 화면이 다 그려지기를 대기 함 (대부분 바로 그려지는 듯)
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        if (_scrollController.hasClients) {
          if (kDebugMode) {
            print('scroll ready');
          }
          return false;
        }
        if (kDebugMode) {
          print('scroll not ready');
        }
        return true;
      });
      //----------------------------------------------
      // 선택된 근육 부위로 점프
      scrollPositionInit();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  refresh() {
    setState(() {});
  }

  //----------------------------------------------------------------------------
  // 근육 부위로 점프
  //----------------------------------------------------------------------------
  void scrollPositionInit() {
    //----------------------------------------------
    // 스크롤이 준비 되었으면 선택된 근육 부위로 점프
    if (_scrollController.hasClients) {
      double blockWidth = asWidth(143);
      double jumpPosition = 0;
      //----------------------------------- 첫번째 근육인 경우 처음으로
      if (gv.control.idxMuscle.value == 0) {
        jumpPosition = 0;
      }
      //----------------------------------- 마지막 근육인 경우 맨 끝으로
      else if (gv.control.idxMuscle.value == gv.dbmMuscle.numberOfData - 1) {
        jumpPosition = _scrollController.position.maxScrollExtent;
      }
      //----------------------------------- 중간 근육인 경우
      else {
        jumpPosition = blockWidth * gv.control.idxMuscle.value - asWidth(100);
        // print(jumpPosition);
      }
      //---------------------------- 애니메이션 점프
      _scrollController.animateTo(jumpPosition,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      //---------------------------- 바로 점프
      // _scrollController.jumpTo(jumpPosition); //바로가기
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // int refresh = _refreshMuscle.value;
      gv.control.idxMuscle.value;
      return SizedBox(
        height: asHeight(96),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              //--------------------------------------------------------------------
              // 근육 리스트
              Row(
                children: List.generate(dbMuscleIndexList.length, (index) {
                  gv.control.idxMuscle.value;
                  return _selectMuscleBox(
                      context, index, dbMuscleIndexList[index]);
                }),
              ),
              asSizedBox(width: 18),
            ],
          ),
        ),
      );
    });
  }

  //----------------------------------------------------------------------------
  // 새로운 근육버튼 선택
  //----------------------------------------------------------------------------
  Widget _selectMuscleBox(
      BuildContext context, int index, DbMuscleIndex dbMuscleIndex) {
    bool isSelected = index == gv.control.idxMuscle.value;
    return Row(
      children: [
        asSizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(asHeight(16)),
          onTap: () async {
            if (index != gv.control.idxMuscle.value) {
              //------------------------------------------------------------------
              // 기존 근육 조절 값 데이터베이스에 업데이트
              //------------------------------------------------------------------
              await saveMuscleData();
              //------------------------------------------------------------------
              // 새로운 근육 값 정보 읽은 후 화면에 표시하기
              //------------------------------------------------------------------
              await gv.control.updateIdxMuscle(index); //관련 class 데이터 갱신
              // RefreshSetMuscle.muscle();
              RefreshMuscleNameTextField.refresh();
              RefreshSetMuscle.all();
              // 슬라이더 값 새로 불러오기
              gvMeasure.sliderValueTargetPrm =
                  gv.deviceData[0].targetPrm.value.toDouble();
              gvMeasure.sliderValueMvc = gv.deviceData[0].mvc.value;
              initMvcSlider(); //슬라이더 범위 등의 값 초기화
              await changeGraphMuscle();
            }
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              TextN(
                '${index + 1} ',
                fontSize: tm.s40,
                color: isSelected ? tm.softBlue : tm.black.withOpacity(0.1),
                fontWeight: FontWeight.w900,
              ),
              Container(
                padding: EdgeInsets.all(asHeight(12)),
                width: asWidth(131),
                height: asHeight(96),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(asHeight(16)),
                  border: Border.all(
                    width: isSelected ? 4 : 3,
                    color: isSelected ? tm.mainBlue : tm.grey02,
                  ),
                ),
                child: AutoSizeText(
                  dbMuscleIndex.muscleName,
                  style: TextStyle(
                    fontSize: tm.s18,
                    color: isSelected ? tm.mainBlue : tm.grey03,
                  ),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//==============================================================================
// 근육부위 선택
//==============================================================================
Widget _muscleType(BuildContext context) {
  // List<String>
  int d = 0;
  //----------------------------------------------
  // 좌우
  String leftRight = '';
  if (gv.deviceData[0].muscleTypeIndex.value == 0) {
    leftRight = '';
  } else if (gv.deviceData[0].isLeft.value == true) {
    leftRight = ' (좌)';
  } else {
    leftRight = ' (우)';
  }
  //----------------------------------------------
  // 근육이름
  String muscleTypeName = '';
  if (gv.setting.isMuscleNameKrPure.value == true) {
    muscleTypeName =
        GvDef.muscleListKrPure[gv.deviceData[0].muscleTypeIndex.value];
  } else {
    muscleTypeName = GvDef.muscleListKr[gv.deviceData[0].muscleTypeIndex.value];
  }
  muscleTypeName = muscleTypeName + leftRight;

  return Container(
      margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //--------------------------------------------------------------------
          // 근육 부위
          TextN(
            '근육 부위'.tr,
            fontSize: tm.s14,
            color: tm.grey04,
          ),
          asSizedBox(height: 12),
          //------------------------------------------------------------------------
          // select button
          wButtonDualWidget(
              width: asWidth(324),
              height: asHeight(44),
              radius: asHeight(8),
              padWidth: asWidth(12),
              backgroundColor: tm.grey01,
              isViewBorder: false,
              childLeft: TextN(
                muscleTypeName,
                fontSize: tm.s14,
                color: tm.grey03,
              ),
              childRight: Image.asset(
                'assets/icons/ic_change_20.png',
                height: asHeight(20),
                color: tm.mainBlue,
              ),
              onTap: (() {
                openEditMuscle();
              })),
        ],
      ));
}

Widget _muscleTypeBox({
  Function()? onTap,
  String title = '',
  bool isSelected = false,
}) {
  return textButtonSel(
      title: title,
      onTap: onTap,
      width: asWidth(78),
      height: asHeight(36),
      radius: asWidth(5),
      isSelected: isSelected,
      fontSize: tm.s16);
  // textButtonBasic(
  //   radius: asWidth(5),
  //   onTap: onTap,
  //   width: asWidth(78),
  //   title: title,
  //   textColor: isSelected ? tm.white : tm.grey02,
  //   backgroundColor: isSelected ? tm.blue : tm.grey03,
  //   borderColor: Colors.transparent,
  // );
}

//==============================================================================
// 근력운동 강도
//==============================================================================
Widget _exerciseLevel(BuildContext context) {
  int index = gv.control.idxMuscle.value;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //----------------------------------------------------------------------
        // 제목파트
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextN(
                  '근력운동 힘 목표',
                  fontSize: tm.s14,
                  color: tm.grey04,
                ),
                // asSizedBox(width: 10),
                // helpIcon(),
              ],
            ),
            TextN(
              // '${(gvMeasure.sliderValueTargetPrm).toStringAsFixed(0)}%',
              '${gv.dbMuscleIndexes[index].targetPrm.toInt()}%',
              // '${(gv.dbmMuscle.tData[index]['targetPrm'])}%',
              fontSize: tm.s20,
              color: tm.black,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        asSizedBox(height: 20),
        //----------------------------------------------------------------------
        // 일반인 권장 범위 : 50~75% : 슬라이더 최소 값 20% 반영
        Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 30, //40%
                    child: Container(
                      height: asHeight(2),
                      color: tm.white,
                    )),
                Expanded(
                    flex: 25,
                    child: Column(
                      children: [
                        FittedBoxN(
                          child: TextN(
                            '일반인 권장 범위',
                            fontSize: tm.s12,
                            color: tm.mainBlue,
                          ),
                        ),
                        asSizedBox(height: 10),
                        DashLineH(
                          color: tm.mainBlue,
                          dashWidth: 6,
                          lineThickness: 1,
                        ),
                      ],
                    )),
                Expanded(
                    flex: 25,
                    child: Container(
                      height: asHeight(2),
                      color: tm.white,
                    ))
              ],
            ),
          ],
        ),
        asSizedBox(height: 7),
        //----------------------------------------------------------------------
        // 슬라이드 바
        TargetSlider(key: keyTargetSlider),
        asSizedBox(height: 18),
        //----------------------------------------------------------------------
        // 반복 횟수
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //----------------------- title
            TextN(
              '세트 반복횟수',
              fontSize: tm.s14,
              color: tm.grey04,
            ),
            //---------------------- RM 표시
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (gv.deviceData[0].targetCount.value > 1) {
                      gv.deviceData[0].targetCount.value =
                          gv.deviceData[0].targetCount.value - 1;
                      saveMuscleData(fromSliderChange: false);
                      RefreshSetMuscle.all();
                    }
                  },
                  borderRadius: BorderRadius.circular(asHeight(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: asWidth(22),
                      height: asHeight(30),
                      child: Image.asset(
                        'assets/icons/btn_minus.png',
                        fit: BoxFit.scaleDown,
                        height: asHeight(30),
                        color: tm.grey04,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: asWidth(60),
                  height: asHeight(40),
                  decoration: BoxDecoration(
                    color: tm.white,
                    borderRadius: BorderRadius.circular(asHeight(12)),
                  ),
                  child: TextN(
                    // '${prmToRepetition(gvMeasure.sliderValueTargetPrm).toStringAsFixed(0)} 회',
                    '${gv.dbMuscleIndexes[index].targetCount} 회',
                    fontSize: tm.s16,
                    color: tm.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (gv.deviceData[0].targetCount.value < 120) {
                      gv.deviceData[0].targetCount.value =
                          gv.deviceData[0].targetCount.value + 1;
                      saveMuscleData(fromSliderChange: false);
                      RefreshSetMuscle.all();
                    }
                  },
                  borderRadius: BorderRadius.circular(asHeight(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: asWidth(22),
                      height: asHeight(30),
                      child: Image.asset(
                        'assets/icons/btn_plus.png',
                        fit: BoxFit.scaleDown,
                        height: asHeight(30),
                        color: tm.grey04,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        asSizedBox(height: 18),
        //----------------------------------------------------------------------
        // 휴식 시간
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextN(
              '휴식 시간',
              fontSize: tm.s14,
              color: tm.grey04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/ic_rest.png',
                  height: asHeight(20),
                ),
                asSizedBox(width: 6),
                TextN(
                  timeToStringColon(
                      timeSec:
                          prmToRelaxTime(gv.deviceData[0].targetPrm.value)),
                  fontSize: tm.s14,
                  fontWeight: FontWeight.normal,
                  color: tm.black,
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );
}

//==============================================================================
// 최대근력 레벨
//==============================================================================
Widget _mvcLevel(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //----------------------------------------------------------------------
        // 최대근력 레벨
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //------------------------------------------------------------------
            // 제목부
            Row(
              children: [
                TextN('최대근력', fontSize: tm.s14, color: tm.grey04),
                // asSizedBox(width: 10),
                // helpIcon(),
              ],
            ),
            //------------------------------------------------------------------
            // 값 조절 박스 : 숫자 및 타이핑으로 값 조절
            Row(
              children: [
                // TextN(
                //   'LV ',
                //   fontSize: tm.s16,
                //   color: tm.grey04,
                // ),
                TextN(
                  // (gv.deviceData[0].mvcLevel.value).toStringAsFixed(1),
                  convertMvcToDisplayValue(gv.deviceData[0].mvc.value),
                  // gv.dbMuscleIndexes[gv.control.idxMuscle.value].mvcLevel
                  //     .toStringAsFixed(1),
                  // '${(gv.dbmMuscle.tData[gv.control.idxMuscle.value]['mvcLevel']).toStringAsFixed(1)}',
                  fontSize: tm.s14,
                  color: tm.grey04,
                ),
                asSizedBox(width: 0),
                textButtonAwG(
                    // width: asWidth(60),
                    height: asHeight(34),
                    padWidth: asWidth(12),
                    padTouchWidth: asWidth(10),
                    // touchWidth: asWidth(60),
                    touchHeight: asHeight(54),
                    title: '변경',
                    fontSize: tm.s14,
                    textColor: tm.mainBlue,
                    isViewBorder: true,
                    borderColor: tm.softBlue,
                    borderWidth: 2,
                    onTap: (() {
                      openBottomSheetBasic(
                          isHeadView: true,
                          headTitle: '최대근력 레벨 변경',
                          child: _SetMvcLevel(key: _keySetMvcLevelState),
                          height: asHeight(580));
                    })),
                // Container(
                //   alignment: Alignment.center,
                //   width: asWidth(60),
                //   height: asHeight(40),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(asHeight(12)),
                //       border: Border.all(width: 2, color: tm.grey02)),
                //   child: TextN(gvMeasure.sliderValueMvc.toStringAsFixed(1),
                //       fontSize: tm.s16, color: tm.black),
                // ),
              ],
            ),
          ],
        ),
        //----------------------------------------------------------------------
        // 설명글
        asSizedBox(height: 4),
        TextN(
          '운동을 하면 최대근력은 자동으로 측정됩니다.'
          ' 문제가 발생한 경우에만 최대근력을 변경하세요.',
          fontSize: tm.s12,
          color: tm.grey04,
          height: 1.5,
        ),
      ],
    ),
  );
}

//==============================================================================
// 최대근력 레벨 bottom sheet
//==============================================================================
class _SetMvcLevel extends StatefulWidget {
  const _SetMvcLevel({Key? key}) : super(key: key);

  @override
  State<_SetMvcLevel> createState() => _SetMvcLevelState();
}

class _SetMvcLevelState extends State<_SetMvcLevel> {
  //--------------------------------------------
  // 외부 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    Future.delayed(const Duration(milliseconds: 100), () {
      // 바로실행하면 예외처리 됨 - 100ms 뒤에 실행해야 안정적 갱신
      // print('set_muscle :: 수동으로 설정한 값은 ${gvMeasure.sliderValueMvc} mV 입니다.');
      gv.deviceData[0].mvc.value = gvMeasure.sliderValueMvc;
      RefreshSetMuscle.all();
      if (kDebugMode) {
        print('최대근력 설정 화면이 사라질 때 100ms 후에 본 화면 전체 갱신');
      }
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //----------------------------------------------------------------------
          // 최대근력 레벨
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextN(
                '신규 최대근력 레벨',
                fontSize: tm.s16,
                fontWeight: FontWeight.bold,
                color: tm.black,
              ),
              TextN(
                convertMvcToDisplayValue(gvMeasure.sliderValueMvc),
                fontSize: tm.s16,
                fontWeight: FontWeight.bold,
                color: tm.black,
              ),
            ],
          ),
          asSizedBox(height: 10),
          TextN(
            '기존 최대근력 레벨 ${convertMvcToDisplayValue(gv.deviceData[0].mvc.value)}',
            fontSize: tm.s14,
            fontWeight: FontWeight.bold,
            color: tm.grey03,
          ),

          //----------------------------------------------------------------------
          // 최대근력 레벨 슬라이드
          asSizedBox(height: 14),
          MvcSlider(key: keyMvcSlider),

          //----------------------------------------------------------------------
          // 설명글
          asSizedBox(height: 14),
          TextN(
            '운동을 하면 최대근력은 자동으로 측정됩니다. 문제가 발생한 경우에만 최대근력 레벨을 변경하세요.',
            fontSize: tm.s12,
            color: tm.grey04,
            height: 1.5,
          ),
          asSizedBox(height: 20),
          dividerSmall2(),
          asSizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/ic_caution.png',
                color: tm.mainGreen,
                height: asHeight(12),
              ),
              asSizedBox(width: 4),
              TextN(
                '주의사항',
                fontSize: tm.s12,
                fontWeight: FontWeight.bold,
                color: tm.mainGreen,
              ),
            ],
          ),
          asSizedBox(height: 8),
          TextN(
            '같은 근육부위라도 전극 부착위치가 변하면 최대근력은 크게 달라질 수 있습니다. 매 측정 시 최대한 같은 위치에 전극을 부착하시기 바랍니다. 부착위치는 도움말을 참조하세요.',
            fontSize: tm.s12,
            color: tm.grey04,
            height: 1.5,
          ),
          asSizedBox(height: 28),
          textButtonI(
            width: asWidth(324),
            height: asHeight(52),
            radius: asHeight(8),
            backgroundColor: tm.mainBlue,
            onTap: () {
              Get.back();
            },
            title: '확인'.tr,
            textColor: tm.fixedWhite,
            fontSize: tm.s16,
            fontWeight: FontWeight.bold,
            borderColor: Colors.transparent,
            borderLineWidth: asWidth(1),
          ),
        ],
      ),
    );
  }
}

//==============================================================================
// 기본 값으로 설정
//==============================================================================
Widget _setDefault() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
    child: textButtonI(
      title: '목표와 최대근력 기존 값으로 되돌리기',
      fontSize: tm.s16,
      width: asWidth(328),
      //최대 넓이
      height: asHeight(40),
      // textColor: tm.white,
      // borderColor: Colors.transparent,
      // backgroundColor: tm.blue,
      // radius: asHeight(10),
      onTap: (() {
        // 데이터베이스에 저장 된 기존 값으로 되돌림
        int index = gv.control.idxMuscle.value;
        gvMeasure.sliderValueTargetPrm =
            gv.deviceData[0].targetPrm.value.toDouble();
        // gv.dbMuscleIndexes[index].targetPrm.toDouble();
        gvMeasure.sliderValueMvc =
            gv.deviceData[0].mvc.value; // gv.dbMuscleIndexes[index].mvcLevel;
        RefreshSetMuscle.all();
        // RefreshSetMuscle.targetMvc();
        // RefreshSetMuscle.mvc();
        // refreshMvcSlider();
        // refreshTargetSlider();
      }),
    ),
  );
}

//==============================================================================
// 근육 삭제
//==============================================================================
Widget _deleteMuscle() {
  return Container(
    padding: EdgeInsets.all(asWidth(18)),
    color: tm.grey01,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //-------------------------------------------------------------
            // 제목
            TextN(
              '근육 데이터 삭제',
              fontSize: tm.s14,
              color: tm.grey04,
              height: 1.5,
            ),
            //-------------------------------------------------------------
            // 삭제 버튼
            textButtonAwG(
              title: '삭제',
              fontSize: tm.s14,
              height: asHeight(34),
              padWidth: asWidth(12),
              touchHeight: asHeight(54),
              padTouchWidth: asWidth(10),
              textColor: tm.grey04,
              borderColor: tm.grey02,
              borderWidth: 2,
              // backgroundColor: tm.blue,
              // radius: asHeight(10),
              onTap: (() async {
                //------------------------------------------------------------
                // 데이터 삭제 조건 체크 : 최소 1개의 근육은 유지해야 함
                if (gv.dbmMuscle.numberOfData < 2) {
                  openSnackBarBasic('삭제불가', '최소한 1개의 근육 데이터는 유지해야 합니다.');
                }
                //------------------------------------------------------------
                // 현재 선택된 index 데이터 삭제 (삭제 확인 팝업 창)
                else {
                  openPopupBasicButton(
                    width: asWidth(300),
                    height: asHeight(260),
                    title: '근육 데이터 삭제',
                    text: '통계를 포함하는 현재 선택한 근육관련된 모든 정보가 삭제됩니다.'
                        '삭제 후 되돌릴 수 없습니다.\n정말 삭제하시겠습니까?',
                    buttonNumber: 2,
                    buttonTitleList: ['확인', '취소'],
                    buttonTitleColorList: [tm.fixedWhite, tm.mainBlue],
                    buttonBackgroundColorList: [tm.mainBlue, tm.softBlue],
                    callbackList: [
                      () async {
                        //현재 근육의 이미지가 있으면 삭제
                        if (gv.deviceData[0].imagePath.value != '') {
                          await removeImageFiles(
                              filePath: gv.deviceData[0].imagePath.value);
                        }
                        int idxDelete = gv.control.idxMuscle.value;

                        // muscle 메모리에서 삭제
                        gv.dbMuscleIndexes.removeAt(idxDelete);

                        // muscle DB 에서 데이터 삭제
                        await gv.dbmMuscle.deleteData(index: idxDelete);

                        // Record 메모리와 DB 에서 데이터 삭제
                        await deleteDbRecordIndexes(idxDelete);

                        // 삭제 후 index 하나 줄이기
                        await gv.control
                            .updateIdxMuscle(gv.control.idxMuscle.value - 1);
                        updateGraphData();
                        //관련 class 데이터 갱신
                        RefreshSetMuscle.allInit(); //초기화 갱신
                        Get.back(); //창 닫기
                        //   openSnackBarBasic('데이터 초기화 완료', '모든 데이터가 초기화 되었습니다.');
                      },
                      () {
                        Get.back();
                      }
                    ],
                  );
                }
              }),
            ),
          ],
        ),
        TextN(
          '현재 선택된 근육정보를 삭제합니다.'
          ' 삭제를 실행하면 현재의 근육 관련 통계를 포함하는 모든 정보가 삭제되니 주의하시기 바랍니다.',
          fontSize: tm.s12,
          color: tm.grey03,
          height: 1.5,
        ),
        asSizedBox(height: 16),
      ],
    ),
  );
}

//==============================================================================
// top bar back : 운동기록 / 설정
//==============================================================================
Widget _topBarBack(
  BuildContext context, {
  String title = '',
}) {
  return Container(
    // margin: EdgeInsets.only(top: asHeight(12)), //상단 여유
    // height: icHeight,
    height: asHeight(54), //30 + 12 + 12
    child: Stack(
      alignment: Alignment.center,
      children: [
        //------------------------------------------------------------------
        // title
        TextN(
          title,
          fontSize: tm.s14,
          color: tm.grey03,
          fontWeight: FontWeight.w400,
        ),

        //------------------------------------------------------------------
        // back & deviceIcon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //--------------------------------------------------------------
            // back
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (() async {
                    // int d = 0;
                    Get.back();
                  }),
                  borderRadius: BorderRadius.circular(asHeight(15)),
                  child: Container(
                    alignment: Alignment.center,
                    height: asHeight(54),
                    width: asWidth(54), // 30 + 18 + 18
                    child: Image.asset(
                      'assets/icons/ic_banner_arrow_l.png',
                      fit: BoxFit.scaleDown,
                      height: asHeight(30),
                      color: tm.black,
                    ),
                  ),
                ),
              ],
            ),
            //--------------------------------------------------------------
            // 근육 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(asHeight(16)),
                  onTap: (() {
                    openAddMuscle();
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: asWidth(10), vertical: asHeight(10)),
                    child: Container(
                      height: asHeight(32),
                      padding: EdgeInsets.symmetric(horizontal: asWidth(10)),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(asHeight(8)),
                          color: tm.softBlue),
                      child: TextN(
                        '근육추가',
                        color: tm.mainBlue,
                        fontSize: tm.s12,
                      ),
                    ),
                  ),
                ),
                asSizedBox(width: 8),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

//==============================================================================
// 화면 갱신용
//==============================================================================
// RxInt _refreshAll = 0.obs;

class RefreshSetMuscle {
  //----------------------------------------------------------------------------
  // 전체 갱신 (일부는 갱신 안됨)
  //----------------------------------------------------------------------------
  static void all() {
    // _refreshAll.value++;
    _keySetMuscleState.currentState?.refresh();
    keySelectMuscleState.currentState?.refresh();
  }

  static void setMvc() {
    // _refreshAll.value++;
    _keySetMvcLevelState.currentState?.refresh(); //근육설정 팝업 갱신
  }

  //----------------------------------------------------------------------------
  // 전체 초기화 갱신 (새로온 근육 index 로 변경 시)
  //----------------------------------------------------------------------------
  static void allInit() {
    _updateSliderValue(); //슬라이드 value 갱신
    RefreshMuscleNameTextField.refresh(); //텍스트 필드 변경
    keySelectMuscleState.currentState?.scrollPositionInit(); //스크롤 위치 초기화
    // _refreshAll.value++;
    _keySetMuscleState.currentState?.refresh();
    keySelectMuscleState.currentState?.refresh();
  }
}

//==============================================================================
// 슬라이드 값 읽어오기
//==============================================================================
void _updateSliderValue() {
  //------------------------------- 최대근력 슬라이더
  gvMeasure.sliderValueMvc = gv.deviceData[0].mvc.value;
  // 슬라이더 범위 설정하기
  if (gvMeasure.sliderValueMvc > 3) {
    gvMeasure.sliderMvcMaxRange = 3;
  } else if (gvMeasure.sliderValueMvc > 2) {
    gvMeasure.sliderMvcMaxRange = 2;
  } else if (gvMeasure.sliderValueMvc > 1) {
    gvMeasure.sliderMvcMaxRange = 1;
  } else {
    gvMeasure.sliderMvcMaxRange = 0; //대부분 여기 사용
  }
  //------------------------------- %1RM 슬라이더
  gvMeasure.sliderValueTargetPrm = gv.deviceData[0].targetPrm.value.toDouble();
}

//==============================================================================
// 근육관련 저장
//==============================================================================
saveMuscleData({bool fromSliderChange = true}) async {
  int d = 0;

  //----------------------------------------------------------------------------
  // 세팅 값 읽어오기
  //----------------------------------------------------------------------------
  int index = gv.control.idxMuscle.value;
  // 슬라이드 값 반영하기 (목표, 반복횟수, 최대근력 레벨)
  int targetPrm;
  int targetCount;
  double mvcLevel;
  Map convertTable = {
    1: 97,
    2: 92,
    3: 89,
    4: 87,
    5: 85,
    6: 82,
    7: 80,
    8: 78,
    9: 76,
    10: 74,
    11: 72,
    12: 71,
    13: 69,
    14: 67,
    15: 66,
    16: 64,
    17: 63,
    18: 62,
    19: 60,
    20: 59
  };

  if (fromSliderChange) {
    targetPrm = gvMeasure.sliderValueTargetPrm.toInt();
    targetCount = prmToRepetition(gvMeasure.sliderValueTargetPrm).toInt();
    // print('set_muscle :: saveMuscleData() : targetCount=$targetCount');
    mvcLevel = gvMeasure.sliderValueMvc; //mV로 항상 기록
    // print('save gvMeasure.sliderValueMvc = ${gvMeasure.sliderValueMvc}');
    // print('save mvcLevel = $mvcLevel');
  } else {
    if (convertTable.keys.contains(gv.deviceData[0].targetCount.value)) {
      targetCount = gv.deviceData[0].targetCount.value;
      targetPrm = convertTable[gv.deviceData[0].targetCount.value];
    } else {
      targetCount = gv.deviceData[0].targetCount.value;
      targetPrm = repetitionToPrm(targetCount).toInt();
    }
    gvMeasure.sliderValueTargetPrm = targetPrm.toDouble();
    mvcLevel = gvMeasure.sliderValueMvc; //mV로 항상 기록
  }

  //----------------------------------------------------------------------------
  // 현재 값 업데이트 - 화면표시 및 DB 저장
  //----------------------------------------------------------------------------
  gv.deviceData[d].targetPrm.value = targetPrm;
  gv.deviceData[d].targetCount.value = targetCount;
  gv.deviceData[d].mvc.value = mvcLevel;
  //----------------------------------------------------------------------------
  // DB에 저장할 값 업데이트
  //----------------------------------------------------------------------------
  gv.dbMuscleIndexes[index].targetPrm = targetPrm; //목표 %
  gv.dbMuscleIndexes[index].targetCount = targetCount; //목표 카운트
  // gv.dbMuscleIndexes[index].mvcMv = mvcLevel / GvDef.convLv;
  gv.dbMuscleIndexes[index].mvcMv = mvcLevel; //최대근력 전압
  gv.dbMuscleIndexes[index].muscleTypeIndex =
      gv.deviceData[d].muscleTypeIndex.value; //근육 종류
  gv.dbMuscleIndexes[index].isLeft = gv.deviceData[d].isLeft.value; //좌우
  //----------------------------------------------------------------------------
  // DB 저장
  //----------------------------------------------------------------------------
  await gv.dbmMuscle.updateData(
      index: index,
      indexMap: gv.dbMuscleIndexes[index].toJson(),
      contentsMap: gv.dbMuscleContents.toJson());
}
