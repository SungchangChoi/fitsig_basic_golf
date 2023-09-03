import '/F0_BASIC/common_import.dart';

//==============================================================================
// help slide image
//==============================================================================

Widget guideSlideImage({
  List<String> imageManRight = const [],
  List<String> imageWomanRight = const [],
  List<String> imageGuideLeft = const [],
  List<String> imageGuideRight = const [],
  List<String> exerciseVideo = const [],
  String text = '',
  bool isViewLeft = true,
  EmaGuideContents guideContents = EmaGuideContents.attachPosition,
  // bool isViewGuide = true,
}) {
  int imgNum = 0;
  bool flagImageFlip = false;

  List<String> imageView = [];
  //-------------------------
  // 좌 - 가이드
  if (isViewLeft && (guideContents == EmaGuideContents.attachPosition)) {
    imageView = imageGuideLeft;
    flagImageFlip = false;
  }
  //-------------------------
  // 우 - 가이드
  else if (!isViewLeft && (guideContents == EmaGuideContents.attachPosition)) {
    imageView = imageGuideRight;
    flagImageFlip = false;
  }
  //-------------------------
  // 좌 - 실사-남 (이미지 뒤집기)
  else if (isViewLeft &&
      (guideContents == EmaGuideContents.attachPhoto) &&
      (gv.setting.genderIndex.value == 0)) {
    imageView = imageManRight;
    flagImageFlip = true;
  }
  //-------------------------
  // 좌 - 실사-여 (이미지 뒤집기)
  else if (isViewLeft &&
      (guideContents == EmaGuideContents.attachPhoto) &&
      (gv.setting.genderIndex.value == 1)) {
    imageView = imageWomanRight;
    flagImageFlip = true;
  }
  //-------------------------
  // 좌 - 실사-기타 (이미지 뒤집기)
  else if (isViewLeft &&
      (guideContents == EmaGuideContents.attachPhoto) &&
      (gv.setting.genderIndex.value == 2)) {
    imageView = imageManRight + imageWomanRight;
    flagImageFlip = true;
  }
  //-------------------------
  // 우 - 실사
  else if (!isViewLeft &&
      (guideContents == EmaGuideContents.attachPhoto) &&
      (gv.setting.genderIndex.value == 0)) {
    imageView = imageManRight;
    flagImageFlip = false;
  }
  //-------------------------
  // 우 - 실사
  else if (!isViewLeft &&
      (guideContents == EmaGuideContents.attachPhoto) &&
      (gv.setting.genderIndex.value == 1)) {
    imageView = imageWomanRight;
    flagImageFlip = false;
  }
  //-------------------------
  // 우 - 실사
  else if (!isViewLeft &&
      (guideContents == EmaGuideContents.attachPhoto) &&
      (gv.setting.genderIndex.value == 2)) {
    imageView = imageManRight + imageWomanRight;
    flagImageFlip = false;
  }

  //-------------------------
  // 운동 비디오
  else if (guideContents == EmaGuideContents.exercise) {
    imageView = exerciseVideo;
    flagImageFlip = false;
  }

  if (imageView.isNotEmpty) {
    imgNum = imageView.length; //이미지 숫자
  } else {
    imgNum = 0;
  }
  //-------------------------------------------------------------
  // 새로운 코드
  return Column(
    children: [
      asSizedBox(height: 8),
      MuscleGuideSlide().carouseSlideWithIndicator(
        // slideBasic(
        width: asWidth(360),
        height: guideContents != EmaGuideContents.exercise
            ? asWidth(240)
            : asWidth(202.5),
        //넓이에 맞추어 변화
        viewportFraction: 1,
        autoPlay: false,
        // enlargeCenterPage: false,
        // enlargeFactor: 0.3,
        items: List<Widget>.generate(
          imageView.length,
          (index) => guideContents != EmaGuideContents.exercise
              //------------------ 비디오가 아닌 경우
              ? slideImageBox(
                  imageView[index],
                  height: asHeight(240),
                  isHFlip: flagImageFlip,
                )
              //------------------ 비디오 인 경우 (높이 넓이 비디오에 맞춤)
              : GuideVideo(
                  fileName: exerciseVideo[index],
                  height: asWidth(202.5),
                  width: asWidth(360)),
        ),
      ),
      asSizedBox(height: 10),
    ],
  );
  //-------------------------------------------------------------
  // 기존 코드
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      children: [
        asSizedBox(height: 8),
        //-------------------------------------------
        //전체 디스플레이
        if (imageView.isNotEmpty)
          Row(
            children: List<Widget>.generate(
                imageView.length,
                (index) => slideImageBox(
                      imageView[index],
                      height: asHeight(200),
                      isHFlip: flagImageFlip,
                    )),
          ),
        if (imageView.isEmpty)
          Container(
              height: asHeight(200), width: asWidth(300), color: tm.mainBlue),
        asSizedBox(height: 10),
        // TextN(text, fontSize: tm.s16, color: tm.grey04),
        // asSizedBox(height: 20),
      ],
    ),
  );
}

//==============================================================================
// 이미지 박스
//==============================================================================
Widget slideImageBox(String fileName,
    {double height = 100, bool isHFlip = false}) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(asHeight(12)),
          border: Border.all(
            width: 1,
            color: tm.grey02,
          ),
        ),
        child: Transform(
          alignment: Alignment.center,
          transform: isHFlip ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
          child: Image.asset(
            'assets/images_muscle/$fileName',
            fit: BoxFit.fitWidth,
            // height: height,
            width: asWidth(360 - 2),
          ),
        ),
      ),
      // asSizedBox(width: 10),
    ],
  );
}

//==============================================================================
// 터치 시 현재 영상 플레이
//==============================================================================
class GuideVideo extends StatefulWidget {
  final double width;
  final double height;
  final String fileName;

  const GuideVideo(
      {this.width = 400, this.height = 200, this.fileName = '', Key? key})
      : super(key: key);

  @override
  State<GuideVideo> createState() => _GuideVideoState();
}

class _GuideVideoState extends State<GuideVideo> {
  final bool _flagIsView = true;
  bool isLocalVideoAvailable = false;

  @override
  Widget build(BuildContext context) {
    isLocalVideoAvailable = gv.youtubeManager.downloadedVideoIds.contains(widget.fileName);
    return SizedBox(
      width: widget.width,
      height: widget.height,
      // color: tm.blue,
      // 여러개의 비디오가 있을 때, 터치하면 화면 갱신하여 영상이 플레이 되도록 할 목적
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          isLocalVideoAvailable
              ?
              //----------------------------------------------------------------------
              // 로컬 비디오
              //----------------------------------------------------------------------
              Container(
                  color: tm.white,
                  width: widget.width,
                  height: widget.height,
                  child: _flagIsView == true
                      ? VideoPlayerScreen(
                          fileName: widget.fileName,
                          callbackReplay: (() {
                            // 특별히 뭘 하지 않아도 되는 듯
                            // setState(() {}); //내부 터치 콜백 시 화면 갱신
                          }),
                        )
                      : Container(
                          // width: widget.width,
                          // height: widget.height,
                          // color: Colors.red,
                          ),
                )
              :
              //----------------------------------------------------------------------
              // 유투브 비디오
              //----------------------------------------------------------------------
              Container(
                  color: tm.white,
                  width: widget.width,
                  height: widget.height,
                  child: _flagIsView == true
                      ? VideoYoutube(
                          videoId: widget.fileName,
                          loop: true,
                          hideControls: true,
                          autoPlay: false,
                          callbackReplay: (() {
                            // 특별히 뭘 하지 않아도 되는 듯
                            // setState(() {}); //내부 터치 콜백 시 화면 갱신
                          }),
                        )
                      : Container(
                          // width: widget.width,
                          // height: widget.height,
                          // color: Colors.red,
                          ),
                ),
          //----------------------------------------------------------------------
          // 운동이름 등 안내 글
          //----------------------------------------------------------------------
          // Container(
          //   width: width,
          //   height: height,
          //   // color: Colors.yellow.withOpacity(0.2),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       TextN('이 운동의 이름은...',
          //           color: tm.white.withOpacity(0.8), fontSize: tm.s20),
          //       asSizedBox(height: 10),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

//==============================================================================
// guide Video
//==============================================================================
Widget guideVideo(
    {double width = 400, double height = 200, String fileName = ''}) {
  // double width = Get.width;
  // double height = width * 9 / 16;
  // double basicPadding = 0;
  return Container(
    width: width,
    height: height,
    // color: tm.blue,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        //----------------------------------------------------------------------
        // 비디오
        //----------------------------------------------------------------------
        Container(
          color: tm.white,
          width: width,
          height: height,
          child: VideoPlayerScreen(
            fileName: fileName,
            callbackReplay: (() {}),
          ),
        ),
        // Container(
        //   color: tm.orange.withOpacity(0.1),
        //   width: width,
        //   height: height,
        // ),
        //----------------------------------------------------------------------
        // 운동이름 등 안내 글
        //----------------------------------------------------------------------
        // Container(
        //   width: width,
        //   height: height,
        //   // color: Colors.yellow.withOpacity(0.2),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       TextN('이 운동의 이름은...',
        //           color: tm.white.withOpacity(0.8), fontSize: tm.s20),
        //       asSizedBox(height: 10),
        //     ],
        //   ),
        // ),
      ],
    ),
  );
}
