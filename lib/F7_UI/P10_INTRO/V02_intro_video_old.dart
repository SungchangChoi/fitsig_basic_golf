import '/F0_BASIC/common_import.dart';

//==============================================================================
// video intro page
//==============================================================================

class VideoIntroPage extends StatefulWidget {
  const VideoIntroPage({Key? key}) : super(key: key);

  @override
  State<VideoIntroPage> createState() => _VideoIntroPageState();
}

class _VideoIntroPageState extends State<VideoIntroPage> {
  bool isViewTransverse = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tm.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //------------------------------------------------------------------
            // 기본 세로보기
            //------------------------------------------------------------------
            if (!isViewTransverse)
              Column(
                children: [
                  asSizedBox(height: 40),
                  //------------------------------------------------------------
                  // 제목
                  Center(
                    child: TextN(
                      '핏시그가 처음이신가요?',
                      fontSize: tm.s20,
                      color: tm.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  asSizedBox(height: 16),
                  //------------------------------------------------------------
                  // 로고
                  Image.asset(
                    'assets/images/logo_light_grey.png',
                    height: asHeight(12),
                    color: tm.mainBlue,
                  ),

                  //--------------------------------------------------
                  // 설명글
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                    child: TextN(
                      '반갑습니다! 핏시그가 처음이시라면 기본 사용법 영상을 통해 사용방법을 숙지하시기 바랍니다.'
                          ' 본 영상은 도움말에서 다시 볼 수 있습니다.',
                      fontSize: tm.s16,
                      color: tm.black,
                    ),
                  ),

                  asSizedBox(height: 60),
                  //------------------------------------------------------------
                  // 비디오
                  SizedBox(
                      width: asWidth(360),
                      // height: asHeight(240),
                      child: VideoYoutube(
                        callbackReplay: (() {
                          // setState(() {});
                          // print('click');
                        }),
                        videoId: 'kt9KJtsddc4',
                      )),
                  asSizedBox(height: 40),
                  //------------------------------------------------------------
                  // 가로보기
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: asWidth(18), vertical: asHeight(10)),
                    child: wButtonAwGeneral(
                      height: asHeight(52),
                      radius: asHeight(8),
                      padWidth: asWidth(10),
                      backgroundColor: tm.mainBlue,
                      onTap: () {
                        gv.system.isFirstUser = false;
                        gv.spMemory.write('isFirstUser', false);
                        // 대기 화면으로 이동
                        Get.back();
                        Get.off(() => const MeasureIdle(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 500));
                      },
                      child: Row(children: [
                        Image.asset('assets/icons/ic_가로보기.png'),
                        asSizedBox(width: 8),
                        TextN('가로보기', fontSize: tm.s14, color: tm.mainBlue,)
                      ],),
                    ),
                  ),
                  asSizedBox(height: 40),
                  //--------------------------------------------------
                  // 설명글
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                    child: TextN(
                      '핏시그가 처음이시라면 기본 사용법 영상을 통해 사용방법을 숙지하시기 바랍니다.'
                      ' 본 영상은 도움말에서 다시 볼 수 있습니다.',
                      fontSize: tm.s16,
                      color: tm.black,
                      height: 1.5,
                    ),
                  ),
                ],
              ),

            //------------------------------------------------------------------
            // 가로 보기
            //------------------------------------------------------------------
            if (isViewTransverse)
              Column(
                children: [
                  //--------------------------------------------------------------
                  // 비디오 세로보기
                  //--------------------------------------------------------------
                  SizedBox(
                      // width: asWidth(360),
                      height: asHeight(640),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: VideoYoutube(
                          callbackReplay: (() {
                            // setState(() {});
                            // print('click');
                          }),
                          videoId: 'kt9KJtsddc4',
                        ),
                      )),
                  asSizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                    child: Align(
                        alignment: Alignment.center,
                        child: textButtonG(
                            width: asWidth(324),
                            height: asHeight(40),
                            title: '작게 보기',
                            fontSize: tm.s16,
                            onTap: (() {
                              isViewTransverse = false;
                              setState(() {});
                            }))

                        // TextN(
                        //   '인터넷 브라우저로 영상 보기',
                        //   fontSize: tm.s16,
                        //   color: tm.black,
                        // ),
                        ),
                  ),
                ],
              ),

            //------------------------------------------------------------------
            // 다음으로 버튼
            //------------------------------------------------------------------
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: asWidth(18), vertical: asHeight(10)),
              child: textButtonI(
                width: asWidth(324),
                height: asHeight(52),
                radius: asHeight(8),
                backgroundColor: tm.mainBlue,
                onTap: () {
                  gv.system.isFirstUser = false;
                  gv.spMemory.write('isFirstUser', false);
                  // 대기 화면으로 이동
                  // Get.back();
                  Get.off(() => const MeasureIdle(),
                      transition: Transition.fade,
                      duration: const Duration(milliseconds: 500));
                },
                title: '다음으로'.tr,
                fontSize: tm.s18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
