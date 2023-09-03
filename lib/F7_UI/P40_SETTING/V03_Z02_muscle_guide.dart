import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// contents
//==============================================================================

class MuscleGuidePage extends StatefulWidget {
  const MuscleGuidePage({Key? key}) : super(key: key);

  @override
  State<MuscleGuidePage> createState() => _MuscleGuidePageState();
}

class _MuscleGuidePageState extends State<MuscleGuidePage> {
  //--------------------------- 스크롤에 따른 메뉴 변경
  final ScrollController _scrollController = ScrollController();

  // late Timer _timer;
  bool _flagIsScrollPositionZero = true; //스크롤이 처음 위치인지 여부
  bool _flagIsScrollPositionZero_1p = true; //변화 감지용
  // double scrollPosition = 0;
  // double scrollPosition_1p = 0;
  //--------------------------- 근육 관련
  static int _contentsIdx = 0;
  List<String> muscleTypeName = ['팔', '어깨', '가슴', '복부', '등', '엉덩이', '다리'];

  // 다운로드 상태를 표시하는 flag
  late bool isVideoDownloading;

  // 모든 영상이 다 다운 받아져잇는지 표시하는 플래그
  late bool hasAllVideoFiles;

  // 영상 다운로드를 권장하는 말풍선을 사라지게하는 타이머
  Timer? showBubbleTimer;
  late bool _isVisible;

  @override
  void initState() {
    _flagIsScrollPositionZero = true;
    _flagIsScrollPositionZero_1p = true;
    isVideoDownloading = dvSetting
        .isVideoDownloading; // 모든 video 다운로드 시 몇분이 걸리므로 다른 페이지를 왔다 갔다 할 수 있으므로, dvSetting 에 상태변수를 만들어둠

    hasAllVideoFiles = (gv.youtubeManager.totalNumberOfVideo == gv.youtubeManager.downloadedVideoIds.length);

    // 다운로드를 권하는 말풍선 보이기 : 조건은 아래와 같음
    // 1. 운동 영상 모두 다운 받지 않았음,
    // 2. 운동 보기 상태,
    // 3. 운동 영상을 다운로드 중이 아님,
    if(!(gv.youtubeManager.totalNumberOfVideo == gv.youtubeManager.downloadedVideoIds.length) && dvSetting.guideContents == EmaGuideContents.exercise && !isVideoDownloading){
      setBubbleTimer();
    }else{
      _isVisible = false;
    }


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
      // 처음 위치로 스크롤 초기화
      scrollPositionInit();
      //----------------------------------------------
      // 스크롤 리스너 추가 (처음위치인지 여부 알림)
      _scrollController.addListener(_scrollListener);
    });

    super.initState();
  }

  // 말풍선 종료 타이머
  void setBubbleTimer(){
    _isVisible = true;
    showBubbleTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  ///---------------------------------------------------------------------------
  /// 해제하기
  ///---------------------------------------------------------------------------
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    showBubbleTimer?.cancel();
    super.dispose();
  }

  ///---------------------------------------------------------------------------
  /// 스크롤 상태 읽기
  ///---------------------------------------------------------------------------
  void _scrollListener() {
    // if (_scrollController.position.pixels < 1) {
    //   _flagIsScrollPositionZero = true;
    // } else {
    //   _flagIsScrollPositionZero = false;
    // }

    // 화면 접속 시 처음 1회만 큰 화면 이후 나머지는 작은 메뉴 화면
    if (_scrollController.position.pixels > 1) {
      _flagIsScrollPositionZero = false;
    }

    //------------------------------------------------------------
    // 처음위치 / 아닌위치 변화가 생겼다면 화면 갱신
    if (_flagIsScrollPositionZero_1p != _flagIsScrollPositionZero) {
      setState(() {});
      if (kDebugMode) {
        print('근육 정보 스크롤 처음위치 여부 : $_flagIsScrollPositionZero');
      }
    }
    _flagIsScrollPositionZero_1p = _flagIsScrollPositionZero;
    // print(_scrollController.position.pixels); // 현재 스크롤 위치 값 출력
  }

  ///---------------------------------------------------------------------------
  /// 맨 처음 위치로 스크롤 위치 점프
  ///---------------------------------------------------------------------------
  void scrollPositionInit() {
    //----------------------------------------------
    // 스크롤이 준비 되었으면 점프
    if (_scrollController.hasClients) {
      double jumpPosition = 0;
      //---------------------------- 애니메이션 점프
      _scrollController.animateTo(jumpPosition,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      //---------------------------- 바로 점프
      // _scrollController.jumpTo(jumpPosition); //바로가기
    }
  }

  ///---------------------------------------------------------------------------
  /// build
  ///---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
          child: Column(
            children: [
              //----------------------------------------------------------------
              // 상단 바
              //----------------------------------------------------------------
              topBarBack(context, title: '근육별 가이드'),
              asSizedBox(height: 10),
              //----------------------------------------------------------------
              // 상단 근육 버튼 선택 - 처음에는 크게, 스크롤 한번 하면 작게 변경
              // 스크롤이 처음 지점으로 오면 다시 크게 변경
              //----------------------------------------------------------------
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _flagIsScrollPositionZero
                    ? _muscleTypeSelectInit()
                    : _muscleTypeSelectSmall(),
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

              // _flagIsScrollPositionZero == true
              //     ? _muscleTypeSelectInit()
              //     : _muscleTypeSelectSmall(),
              //----------------------------------------------------------------
              //  하단 메뉴
              //----------------------------------------------------------------
              asSizedBox(height: 10),
              _muscleGuideOption(),
              //----------------------------------------------------------------
              // 하단 도움말 내용
              //----------------------------------------------------------------
              Expanded(
                child: Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            // horizontal: asWidth(18),
                            vertical: asHeight(18)),
                        child: muscleGuideContents(contentsIdx: _contentsIdx)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  ///---------------------------------------------------------------------------
  /// 근육 종류 선택 - 시작단계
  /// --------------------------------------------------------------------------
  Widget _muscleTypeSelectInit() {
    return Column(
      children: [
        Container(
          color: tm.grey02,
          padding: EdgeInsets.symmetric(vertical: asHeight(18)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      3,
                      (index) => _muscleTypeBox(
                          onTap: (() {
                            _contentsIdx = index;
                            scrollPositionInit(); //스크롤 처음 위치로
                            setState(() {});
                          }),
                          isSelected: _contentsIdx == index,
                          title: muscleTypeName[index])),
                ),
              ),
              asSizedBox(height: 6),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      3,
                      (index) => _muscleTypeBox(
                          onTap: (() {
                            _contentsIdx = index + 3;
                            setState(() {});
                          }),
                          isSelected: _contentsIdx == index + 3,
                          title: muscleTypeName[index + 3])),
                ),
              ),
              asSizedBox(height: 6),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _muscleTypeBox(
                        onTap: (() {
                          _contentsIdx = 6;
                          setState(() {});
                        }),
                        isSelected: _contentsIdx == 6,
                        title: '다리'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///---------------------------------------------------------------------------
  /// 근육 종류 선택 - 스크롤 단계
  /// --------------------------------------------------------------------------
  Widget _muscleTypeSelectSmall() {
    double buttonHeight = asHeight(44);
    double buttonPadWidth = asWidth(10);

    //----------------------------------------------------------------------------
    // 분석 할 데이터가 늘어나면 스크롤로 데이터 선택
    //----------------------------------------------------------------------------
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: asWidth(13)),
      child: SizedBox(
        height: buttonHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: muscleTypeName.length,
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(asWidth(10)),
              onTap: () {
                _contentsIdx = index;
                // scrollPositionInit(); //스크롤 처음 위치로
                setState(() {});
              },
              child: _muscleMenuBox(
                isSelected: _contentsIdx == index,
                // 바뀌는 부분
                padWidth: buttonPadWidth,
                height: buttonHeight,
                title: muscleTypeName[index],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _muscleMenuBox({
    bool isSelected = false,
    double padWidth = 10,
    double height = 40,
    String title = 'title',
  }) {
    return Container(
      alignment: Alignment.center,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: padWidth),
      margin: EdgeInsets.symmetric(horizontal: asWidth(5)),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: asHeight(4),
                color: isSelected ? tm.softBlue : Colors.transparent)),
        // borderRadius: BorderRadius.circular(radius),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          //----------------------------------------------------------------------
          // 텍스트
          TextN(
            title,
            fontSize: tm.s16,
            color: isSelected ? tm.mainBlue : tm.grey03,
            fontWeight: FontWeight.w900,
            textAlign: TextAlign.center,
          ),
          //----------------------------------------------------------------------
          // 하단 줄표
          if (isSelected)
            Container(
              alignment: Alignment.bottomCenter,
              // width: width,
              height: height,
              child: Container(
                // width: width * 0.8,
                height: asHeight(6),
                decoration: BoxDecoration(
                  color: tm.softBlue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 보기 선택 옵션 메뉴
  /// --------------------------------------------------------------------------
  Widget _muscleGuideOption() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: asWidth(3)),
      child: Stack(
        children: [
          Column(
            children: [
              //--------------------------------------------------------------------
              // 주의 사항
              //--------------------------------------------------------------------
              InkWell(
                onTap: (() {
                  openBottomSheetBasic(
                      height: asHeight(800),
                      child: muscleGuideCaution(),
                      isHeadView: true,
                      headTitle: '주의사항');
                }),
                borderRadius: BorderRadius.circular(asHeight(8)),
                child: Container(
                  height: asHeight(54),
                  padding: EdgeInsets.symmetric(horizontal: asWidth(10)),
                  child: Row(
                    children: [
                      Container(
                        height: asHeight(14),
                        width: asHeight(14),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: tm.grey03,
                          borderRadius: BorderRadius.circular(asHeight(7)),
                        ),
                        child: TextN(
                          '!',
                          color: tm.white,
                          fontSize: tm.s12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Image.asset(
                      //   'assets/icons/ic_도움말.png',
                      //   height: asHeight(14),
                      // ),
                      asSizedBox(width: 6),
                      TextN('주의사항', fontSize: tm.s14, color: tm.grey03),
                    ],
                  ),
                ),
              ),
              //--------------------------------------------------------------------
              // 부착/사진
              //--------------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      //------------------------------------------------------------
                      // 부착
                      wButtonAwGeneral(
                          child: TextN(
                            '부착',
                            fontSize: tm.s14,
                            color: dvSetting.guideContents ==
                                    EmaGuideContents.attachPosition
                                ? tm.mainBlue
                                : tm.grey04,
                          ),
                          height: asHeight(34),
                          touchHeight: asHeight(54),
                          padTouchWidth: asWidth(5),
                          borderColor: dvSetting.guideContents ==
                                  EmaGuideContents.attachPosition
                              ? tm.softBlue
                              : tm.grey02,
                          borderWidth: dvSetting.guideContents ==
                                  EmaGuideContents.attachPosition
                              ? 2
                              : 1,
                          padWidth: asWidth(10),
                          onTap: (() {
                            dvSetting.guideContents =
                                EmaGuideContents.attachPosition;
                            setState(() {});
                          })),
                      //------------------------------------------------------------
                      // 부착
                      wButtonAwGeneral(
                          child: TextN(
                            '사진',
                            fontSize: tm.s14,
                            color: dvSetting.guideContents ==
                                    EmaGuideContents.attachPhoto
                                ? tm.mainBlue
                                : tm.grey04,
                          ),
                          height: asHeight(34),
                          touchHeight: asHeight(54),
                          padTouchWidth: asWidth(5),
                          borderColor: dvSetting.guideContents ==
                                  EmaGuideContents.attachPhoto
                              ? tm.softBlue
                              : tm.grey02,
                          borderWidth: dvSetting.guideContents ==
                                  EmaGuideContents.attachPhoto
                              ? 2
                              : 1,
                          padWidth: asWidth(10),
                          onTap: (() {
                            dvSetting.guideContents = EmaGuideContents.attachPhoto;
                            setState(() {});
                          })),
                      //------------------------------------------------------------
                      // 부착
                      wButtonAwGeneral(
                        child: TextN(
                          '운동',
                          fontSize: tm.s14,
                          color:
                              dvSetting.guideContents == EmaGuideContents.exercise
                                  ? tm.mainBlue
                                  : tm.grey04,
                        ),
                        height: asHeight(34),
                        touchHeight: asHeight(54),
                        padTouchWidth: asWidth(5),
                        borderColor:
                            dvSetting.guideContents == EmaGuideContents.exercise
                                ? tm.softBlue
                                : tm.grey02,
                        borderWidth:
                            dvSetting.guideContents == EmaGuideContents.exercise
                                ? 2
                                : 1,
                        padWidth: asWidth(10),
                        onTap: (() {
                          dvSetting.guideContents = EmaGuideContents.exercise;
                          setState(() {
                            setBubbleTimer();
                          });
                        }),
                      ),
                      // asSizedBox(width: 10),

                      asSizedBox(width: 3),
                    ],
                  ),
                  //----------------------------------------------------------------
                  // 좌우
                  //----------------------------------------------------------------
                  (dvSetting.guideContents != EmaGuideContents.exercise)
                      ? wButtonAwSel(
                          child: TextN(
                            dvSetting.isViewLeft ? '왼쪽' : '오른쪽',
                            fontSize: tm.s14,
                            color: tm.black,
                          ),
                          height: asHeight(34),
                          touchHeight: asHeight(54),
                          padTouchWidth: asWidth(10),
                          onTap: () {
                            openBottomSheetBasic(
                              height: asHeight(230),
                              child: GuideOptionSelect(
                                callbackOption: (() {
                                  setState(() {});
                                }),
                              ),
                            );
                          },
                        )
                      : IgnorePointer(
                    ignoring: isVideoDownloading,
                        child: Visibility(
                            visible: !hasAllVideoFiles,
                            child: wButtonAwGeneral(
                              child: TextN(
                                isVideoDownloading ? '영상 다운로드 중' : '모든영상 다운로드',
                                fontSize: tm.s14,
                                color: dvSetting.guideContents ==
                                        EmaGuideContents.exercise
                                    ? tm.mainBlue
                                    : tm.grey04,
                              ),
                              height: asHeight(34),
                              touchHeight: asHeight(54),
                              padTouchWidth: asWidth(5),
                              borderColor:
                                  dvSetting.guideContents == EmaGuideContents.exercise
                                      ? tm.softBlue
                                      : tm.grey02,
                              borderWidth:
                                  dvSetting.guideContents == EmaGuideContents.exercise
                                      ? 2
                                      : 1,
                              padWidth: asWidth(10),
                              onTap: () async {
                                // 동영상 파일을 다운 받아있지 팝업으로 물어보기
                                openPopupBasicButton(
                                  width: asWidth(300),
                                  height: asHeight(260),
                                  title: '모든 영상 다운로드',
                                  text:
                                      '모든 운동 영상을 기기로 다운로드합니다. 영상파일을 다운 받으면, 유튜브 딜레이 없이 바로 영상을 볼 수 있습니다. 파일 용량은 116MB입니다. 다운로드 하시겠습니까?\n(다운로드는 백그라운드에서 진행됩니다)',
                                  buttonNumber: 2,
                                  buttonTitleList: ['확인', '취소'],
                                  buttonTitleColorList: [tm.fixedWhite, tm.mainBlue],
                                  buttonBackgroundColorList: [
                                    tm.mainBlue,
                                    tm.softBlue
                                  ],
                                  callbackList: [
                                    () async {
                                      dvSetting.isVideoDownloading = true;
                                      setState(() {
                                        isVideoDownloading =
                                            dvSetting.isVideoDownloading;
                                      });
                                      Get.back(); //창 닫기
                                      // DateTime start = DateTime.now();
                                      for (int index = 0;
                                          index <
                                              gv.youtubeManager
                                                  .muscleTypeToExerciseList.length;
                                          index++) {
                                        await gv.youtubeManager.download(
                                          muscleTypeIndex: index + 1,
                                          onDone: () {
                                          },
                                        );
                                      }
                                      dvSetting.isVideoDownloading = false;

                                      // gv.youtubeManager.download 메서드의 마지막 부분에 다운 받은 파일을 파악해서 downloadedVideoIds 변수를
                                      // 업데이트 하는 부분이 오래 걸리는지 downloadedVideoIds.length 값에 마지막에 다운로드한 파일 숫자가 포함이 안되있어서
                                      // delay를 추가하니 제대로 동작함
                                      await Future.delayed(const Duration(milliseconds: 1000));
                                      if(this.mounted) {
                                        setState(() {
                                          hasAllVideoFiles = (gv.youtubeManager
                                              .totalNumberOfVideo ==
                                              gv.youtubeManager
                                                  .downloadedVideoIds.length);
                                          isVideoDownloading =
                                              dvSetting.isVideoDownloading;
                                        });
                                      }
                                      print(
                                          '_MuscleGuidePageState :: _muscleGuideOption :: 운동 영상 모두 다운 받기 완료 totalNumberOfVideo=${gv.youtubeManager.totalNumberOfVideo}  downloadedVideo=${gv.youtubeManager.downloadedVideoIds.length} ');
                                    },
                                    () {
                                      Get.back();
                                    }
                                  ],
                                );
                              },
                            ),
                          ),
                      ),
                ],
              ),
            ],
          ),
          if (!hasAllVideoFiles && (dvSetting.guideContents ==EmaGuideContents.exercise))
            Positioned(
              top: asHeight(1),
              right: asWidth(18),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _isVisible? 1.0 : 0.0,
                child: youtubeDownloadRecommendBubble(),
              ),
            ),
        ],
      ),
    );
  }

  Widget youtubeDownloadRecommendBubble() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: asHeight(54),
              width: asWidth(210),
              padding:
              EdgeInsets.symmetric(horizontal: asWidth(10)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(asHeight(18)),
                color: tm.pointOrange,
              ),
              child: TextN(
                '영상을 다운로드하시면 유튜브 연결 없이도 빠르게 시청이 가능합니다.',
                color: tm.white,
                fontSize: tm.s14,
                height: 1.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.rotate(
                  angle: pi,
                  child: Image.asset(
                    'assets/icons/말풍선 꼭지.png',
                    color: tm.pointOrange,
                    height: asHeight(12),
                  ),
                ),
                asSizedBox(width: 20),
              ],
            ),
          ],
        ),
        asSizedBox(width: 10),
      ],
    );
  }


  ///---------------------------------------------------------------------------
  /// 근육 종류 박스
  ///---------------------------------------------------------------------------
  Widget _muscleTypeBox({
    Function()? onTap,
    String title = '',
    bool isSelected = false,
  }) {
    return textButtonSel(
        title: title,
        onTap: onTap,
        width: asWidth(104),
        height: asHeight(45),
        radius: asWidth(0),
        // touchRadius: asWidth(10),
        // touchWidth: asWidth(82),
        // touchHeight: asHeight(46),
        isSelected: isSelected,
        fontSize: tm.s16);
  }

  ///---------------------------------------------------------------------------
  /// 주의사항
  ///---------------------------------------------------------------------------
}
