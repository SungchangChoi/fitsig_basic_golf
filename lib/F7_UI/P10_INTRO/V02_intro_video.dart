import '/F0_BASIC/common_import.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

//==============================================================================
// video intro page
//==============================================================================

class IntroVideoPage extends StatelessWidget {
  const IntroVideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 가로 전환 한 경우의 넓이 : 디자인 상 최대 넓이로 제한
    double transverseWidth = asWidth(360) * 16 / 9;
    transverseWidth = min(transverseWidth, asHeight(720));
    RxBool isViewTransverse = false.obs;
    RxBool isViewTransverseDelay = false.obs;
    double transverseHeight = asWidth(360) * 16 / 9;
    return Obx(() {
      return Material(
        color: isViewTransverse.value ? tm.black : tm.grey03,
        child: SafeArea(
          child: Container(
            //Colors.transparent,
            decoration: BoxDecoration(
              color: isViewTransverse.value ? tm.black : tm.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(asHeight(30)),
                topRight: Radius.circular(asHeight(30)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    if (!isViewTransverse.value) asSizedBox(height: 60),
                    //--------------------------------------------------
                    // 제목
                    if (!isViewTransverse.value)
                      Center(
                        child: TextN(
                          '핏시그가 처음이신가요?',
                          fontSize: tm.s20,
                          color: tm.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (!isViewTransverse.value) asSizedBox(height: 16),
                    //--------------------------------------------------
                    // 로고
                    if (!isViewTransverse.value)
                      Image.asset(
                        'assets/images/logo_light_grey.png',
                        height: asHeight(12),
                        color: tm.mainBlue,
                      ),
                    if (!isViewTransverse.value) asSizedBox(height: 40),
                    //--------------------------------------------------
                    // 설명글
                    if (!isViewTransverse.value)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                        child: TextN(
                          '반갑습니다! 핏시그가 처음이시라면 기본 사용법 영상을 통해 사용방법을 숙지하시기 바랍니다.'
                          ' 본 영상은 도움말에서 다시 볼 수 있습니다.',
                          fontSize: tm.s16,
                          color: tm.black,
                          height: 1.5,
                        ),
                      ),
                    if (!isViewTransverse.value && Platform.isAndroid) asSizedBox(height: 60),
                    if (Platform.isIOS) asSizedBox(height: 40),

                    //--------------------------------------------------
                    // 비디오 : 기본 사용법
                    Platform.isAndroid
                        ? RotatedBox(
                            quarterTurns: !isViewTransverse.value ? 0 : 1,
                            child: Container(
                              color: tm.white,
                              width: isViewTransverse.value
                                  ? transverseWidth
                                  : asWidth(360),
                              // height: isViewTransverse ? transverseWidth * 9/16 : asWidth(360) * 9/16,
                              //---------------------------------------------
                              // [1] 기본 비디오 플레이 : 유투브는 안되는 것으로 보임
                              // child: VideoNetwork(
                              //   callbackReplay: ((){}),
                              //   videoID: 'kt9KJtsddc4',
                              // ),

                              //---------------------------------------------
                              // [2] VideoYoutube
                              // 중지했을 때 자막을 가리는 문제
                              // child: VideoYoutube(
                              //   // hideControls: true,
                              //   callbackReplay: (() {
                              //     // setState(() {});
                              //     // print('click');
                              //   }),
                              //   videoId: 'kt9KJtsddc4',
                              // ),

                              //---------------------------------------------
                              // [3] VideoYoutubeIframe
                              // 종료 시 이상한 에러들 뜸
                              child: const VideoYoutubeIframe(
                                videoId: 'kt9KJtsddc4',
                                autoPlay: false,
                              ),
                            ),
                          )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            wButtonAwGeneral(
                                height: asHeight(40),
                                touchHeight: asHeight(54),
                                padTouchWidth: asWidth(10),
                                padWidth: asWidth(10),
                                backgroundColor: tm.white,
                                borderColor: tm.mainBlue,
                                onTap: () async {
                                  launchUrl(
                                    Uri.parse('https://youtu.be/kt9KJtsddc4'),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/youtube_icon.png',
                                      height: asHeight(30),
                                      color: tm.mainBlue,
                                    ),
                                    asSizedBox(width: 8),
                                    TextN(
                                      '기본 사용법 영상 보기',
                                      fontSize: tm.s14,
                                      color: tm.mainBlue,
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),

                    if (!isViewTransverse.value) asSizedBox(height: 10),
                    //--------------------------------------------------
                    // 비디오 가로보기 버튼
                    if (!isViewTransverse.value && Platform.isAndroid)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          wButtonAwGeneral(
                            height: asHeight(34),
                            touchHeight: asHeight(54),
                            padWidth: asWidth(10),
                            backgroundColor: tm.white,
                            borderColor: tm.mainBlue,
                            onTap: () {
                              isViewTransverse.value = true;
                              // setState(() {
                              //
                              // });
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/ic_가로보기.png',
                                  height: asHeight(14),
                                  color: tm.mainBlue,
                                ),
                                asSizedBox(width: 8),
                                TextN(
                                  '가로보기',
                                  fontSize: tm.s14,
                                  color: tm.mainBlue,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    //--------------------------------------------------
                    // x 버튼
                    // if (isViewTransverse)
                    //   asSizedBox(height: 10),
                  ],
                ),

                //------------------------------------------------------------------
                // 가로보기 X 버튼
                //------------------------------------------------------------------
                if (isViewTransverse.value  )
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: asWidth(18), vertical: asHeight(18)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(asHeight(8)),
                              onTap: (() {
                                isViewTransverse.value = false;
                                // setState(() {
                                //
                                // });
                              }),
                              child: Container(
                                width: asHeight(44),
                                height: asHeight(44),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/icons/ic_close.png',
                                  color: tm.white,
                                  height: asHeight(24),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                //------------------------------------------------------------------
                // 다음으로 버튼
                //------------------------------------------------------------------
                if (!isViewTransverse.value)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: asWidth(18), vertical: asHeight(20)),
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
        ),
      );
    });
  }
}
