import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 근육 선택 창
//==============================================================================
void openMuscleGuide({int muscleTypeIndex = 0}) {
  openBottomSheetBasic(
      height: asHeight(760),
      isHeadView: true,
      headTitle: '가이드', // GvDef.muscleListKr[muscleTypeIndex],
      child: _MuscleGuide(muscleTypeIndex: muscleTypeIndex));
}

//==============================================================================
// 근육 선택 창
//==============================================================================
class _MuscleGuide extends StatefulWidget {
  final int muscleTypeIndex;

  const _MuscleGuide({this.muscleTypeIndex = 0, Key? key}) : super(key: key);

  @override
  State<_MuscleGuide> createState() => _MuscleGuideState();
}

class _MuscleGuideState extends State<_MuscleGuide> {
  late bool hasAllVideoFiles;

  // 다운로드 상태를 표시하는 flag
  late bool isVideoDownloading;

  // 영상 다운로드를 권장하는 말풍선을 사라지게하는 타이머
  Timer? showBubbleTimer;
  RxBool _isVisible = false.obs;

  @override
  void initState() {
    isVideoDownloading = dvSetting.isVideoDownloading;
    // 현재 근육에 대한 모든 영상 파일이 있는지 확인
    hasAllVideoFiles = gv.youtubeManager
        .checkLocalVideoAvailable(muscleTypeIndex: widget.muscleTypeIndex);
    if (dvSetting.guideContents == EmaGuideContents.exercise &&
        hasAllVideoFiles == false) {
      print('_MuscleGuideState :: initState :: 버블 타이머를 설정합니다');
      setBubbleTimer();
    } else {
      _isVisible.value = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    showBubbleTimer?.cancel();
    super.dispose();
  }

  // 말풍선 종료 타이머
  void setBubbleTimer() {
    _isVisible.value = true;
    showBubbleTimer = Timer(const Duration(seconds: 5), () {
      WidgetsBinding.instance.addPostFrameCallback((_) =>  _isVisible.value = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _muscleGuide(muscleTypeIndex: widget.muscleTypeIndex);
  }

  ///---------------------------------------------------------------------------
  /// 근육 선택 내용
  ///---------------------------------------------------------------------------
  Widget _muscleGuide({int muscleTypeIndex = 0}) {
    gv.control.idxMuscle; //몇번째 근육 인지

    late Widget wg;

    //------------------------------------------
    // 보여줄 근육 가이드 선택
    if (muscleTypeIndex == 1) {
      wg = m01WristFlexor();
    } else if (muscleTypeIndex == 2) {
      wg = m02WristExtensor();
    } else if (muscleTypeIndex == 3) {
      wg = m03Biceps();
    } else if (muscleTypeIndex == 4) {
      wg = m04Triceps();
    } else if (muscleTypeIndex == 5) {
      wg = m05FrontDeltoid();
    } else if (muscleTypeIndex == 6) {
      wg = m06MiddleDeltoid();
    } else if (muscleTypeIndex == 7) {
      wg = m07BackDeltoid();
    } else if (muscleTypeIndex == 8) {
      wg = m08ExternalRotator();
    } else if (muscleTypeIndex == 9) {
      wg = m09ExternalRotator();
    } else if (muscleTypeIndex == 10) {
      wg = m10UpperPectoralis();
    } else if (muscleTypeIndex == 11) {
      wg = m11MiddlePectoralis();
    } else if (muscleTypeIndex == 12) {
      wg = m12LowerPectoralis();
    } else if (muscleTypeIndex == 13) {
      wg = m13SerratusAnterior();
    } else if (muscleTypeIndex == 14) {
      wg = m14RectusAbdominal();
    } else if (muscleTypeIndex == 15) {
      wg = m15ExternalObliqueAbdominal();
    } else if (muscleTypeIndex == 16) {
      wg = m16UpperTrapezius();
    } else if (muscleTypeIndex == 17) {
      wg = m17MiddleTrapezius();
    } else if (muscleTypeIndex == 18) {
      wg = m18LowerTrapezius();
    } else if (muscleTypeIndex == 19) {
      wg = m19LatissimusDorsi();
    } else if (muscleTypeIndex == 20) {
      wg = m20ErectorSpinae();
    } else if (muscleTypeIndex == 21) {
      wg = m21GluteusMaximus();
    } else if (muscleTypeIndex == 22) {
      wg = m22GluteusMedius();
    } else if (muscleTypeIndex == 23) {
      wg = m23QuadricepsFemoris();
    } else if (muscleTypeIndex == 24) {
      wg = m24Hamstrings();
    } else if (muscleTypeIndex == 25) {
      wg = m25Adductor();
    } else if (muscleTypeIndex == 26) {
      wg = m26TibialisAnterior();
    } else {
      wg = m27Gastrocnemius();
    }

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //------------------------------------------------------------------------
            // title
            asSizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
              child: Column(
                children: [
                  TextN(
                      '${GvDef.muscleListKrPure[gv.deviceData[0].muscleTypeIndex.value]}'
                      ' (${GvDef.muscleListKr[gv.deviceData[0].muscleTypeIndex.value]})',
                      fontSize: tm.s18,
                      color: tm.mainBlue,
                      fontWeight: FontWeight.bold),
                ],
              ),
            ),
            asSizedBox(height: 40),
            //------------------------------------------------------------------------
            // 선택 버튼
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
                          print('_MuscleGuideState :: _muscleGuide :: 부착이 클릭되었습니다.');
                          dvSetting.guideContents =
                              EmaGuideContents.attachPosition;
                          setState(() {
                            _isVisible.value = false;
                          });
                        })),
                    //------------------------------------------------------------
                    // 사진
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
                          print('_MuscleGuideState :: _muscleGuide :: 사진이 클릭되었습니다.');
                          dvSetting.guideContents =
                              EmaGuideContents.attachPhoto;
                          setState(() {
                            _isVisible.value = false;
                          });
                        })),
                    //------------------------------------------------------------
                    // 부착
                    wButtonAwGeneral(
                        child: TextN(
                          '운동',
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
                        onTap: (() {
                          dvSetting.guideContents = EmaGuideContents.exercise;
                          setState(() {
                            setBubbleTimer();
                          });
                        })),
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
                        onTap: (() {
                          openBottomSheetBasic(
                            height: asHeight(230),
                            child: GuideOptionSelect(
                              callbackOption: (() {
                                setState(() {});
                              }),
                            ),
                          );
                        }))
                    : IgnorePointer(
                        ignoring: isVideoDownloading,
                        child: Visibility(
                          visible: !hasAllVideoFiles,
                          child: wButtonAwGeneral(
                            child: TextN(
                              isVideoDownloading ? '영상 다운로드 중' : '영상 다운로드',
                              fontSize: tm.s14,
                              color: dvSetting.guideContents ==
                                      EmaGuideContents.exercise
                                  ? tm.mainBlue
                                  : tm.grey04,
                            ),
                            height: asHeight(34),
                            touchHeight: asHeight(54),
                            padTouchWidth: asWidth(5),
                            borderColor: dvSetting.guideContents ==
                                    EmaGuideContents.exercise
                                ? tm.softBlue
                                : tm.grey02,
                            borderWidth: dvSetting.guideContents ==
                                    EmaGuideContents.exercise
                                ? 2
                                : 1,
                            padWidth: asWidth(10),
                            onTap: () async {
                              // 동영상 파일을 다운 받아있지 팝업으로 물어보기
                              int muscleTypeIndex =
                                  gv.deviceData[0].muscleTypeIndex.value;
                              String muscleName =
                                  gv.setting.isMuscleNameKrPure.value == true
                                      ? GvDef.muscleListKrPure[muscleTypeIndex]
                                      : GvDef.muscleListKr[muscleTypeIndex];
                              await openPopupBasicVerticalButton(
                                width: asWidth(300),
                                height: asHeight(280),
                                title: '운동영상 다운로드',
                                text:
                                    '영상파일을 다운 받으면, 유튜브 딜레이 없이 바로 영상을 볼 수 있습니다. 다운로드는 백그라운드에서 진행됩니다',
                                buttonNumber: 2,
                                buttonTitleList: [
                                  '모든 운동영상 다운로드',
                                  '현재 근육 운동영상 다운로드',
                                ],
                                buttonDescription: [
                                  '파일 용량 116MB',
                                  '파일 용량 ${gv.youtubeManager.muscleTypeVideoSize[muscleTypeIndex - 1]}MB',
                                ],
                                buttonTitleColorList: [
                                  tm.fixedWhite,
                                  tm.mainBlue
                                ],
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
                                            gv
                                                .youtubeManager
                                                .muscleTypeToExerciseList
                                                .length;
                                        index++) {
                                      await gv.youtubeManager.download(
                                        muscleTypeIndex: index + 1,
                                        onDone: () {},
                                      );
                                    }
                                    dvSetting.isVideoDownloading = false;

                                    // gv.youtubeManager.download 메서드의 마지막 부분에 다운 받은 파일을 파악해서 downloadedVideoIds 변수를
                                    // 업데이트 하는 부분이 오래 걸리는지 downloadedVideoIds.length 값에 마지막에 다운로드한 파일 숫자가 포함이 안되있어서
                                    // delay를 추가하니 제대로 동작함
                                    await Future.delayed(
                                        const Duration(milliseconds: 1000));
                                    if (mounted) {
                                      setState(() {
                                        hasAllVideoFiles = (gv.youtubeManager
                                                .totalNumberOfVideo ==
                                            gv.youtubeManager.downloadedVideoIds
                                                .length);
                                        isVideoDownloading =
                                            dvSetting.isVideoDownloading;
                                      });
                                    }
                                  },

                                  // 현재 근육 동영상만 다운 받기
                                  () async {
                                    dvSetting.isVideoDownloading = true;
                                    setState(() {
                                      isVideoDownloading =
                                          dvSetting.isVideoDownloading;
                                    });
                                    Get.back(); //창 닫기
                                    await gv.youtubeManager.download(
                                      muscleTypeIndex: muscleTypeIndex,
                                      onDone: () {
                                        if (mounted) {
                                          setState(() {
                                            hasAllVideoFiles = gv.youtubeManager
                                                .checkLocalVideoAvailable(
                                                    muscleTypeIndex:
                                                        widget.muscleTypeIndex);
                                          });
                                        }
                                      },
                                    );
                                    dvSetting.isVideoDownloading = false;
                                    if (mounted) {
                                      setState(() {
                                        isVideoDownloading =
                                            dvSetting.isVideoDownloading;
                                      });
                                    }
                                  },
                                ],
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),

            //------------------------------------------------------------------------
            // 내용
            Container(
                // color: Colors.yellow,
                height: asHeight(570),
                child: SingleChildScrollView(child: wg)),
          ],
        ),
        if (dvSetting.guideContents == EmaGuideContents.exercise &&
            !hasAllVideoFiles)
          Positioned(
            top: asHeight(20),
            right: asWidth(18),
            child: Obx(() => AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _isVisible.value ? 1.0 : 0.0,
                  child: youtubeDownloadRecommendBubble(),
                )),
          ),
      ],
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
              padding: EdgeInsets.symmetric(horizontal: asWidth(10)),
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
}
