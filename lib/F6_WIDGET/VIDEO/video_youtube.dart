import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '/F0_BASIC/common_import.dart';

//==============================================================================
// local video replay
//==============================================================================

class VideoYoutube extends StatefulWidget {
  final Function callbackReplay;
  final String videoId;
  final Widget child;
  final bool loop;
  final bool autoPlay;
  final bool hideControls;

  const VideoYoutube(
      {this.videoId = '', //'kt9KJtsddc4',
      required this.callbackReplay,
      this.child = const TextN(''),
      this.loop = false,
      this.autoPlay = false,
      this.hideControls = false,
      Key? key})
      : super(key: key);

  @override
  State<VideoYoutube> createState() => _VideoYoutubeState();
}

class _VideoYoutubeState extends State<VideoYoutube> {
  late YoutubePlayerController _controller;
  bool isPlay = false;

  ///---------------------------------------------------------------------------
  /// initState
  ///---------------------------------------------------------------------------
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: widget.autoPlay,
        mute: false,
        loop: widget.loop,
        isLive: false,
        //false,
        disableDragSeek: true,
        // true로 하면 drag 안되게
        forceHD: false,
        enableCaption: true,
        showLiveFullscreenButton: false,
        hideControls: widget.hideControls,
        useHybridComposition: false,
        // hideThumbnail: true,
      ),
    );

    isPlay = false;
    super.initState();
  }

  ///---------------------------------------------------------------------------
  /// replay
  ///---------------------------------------------------------------------------
  // play() {
  //   if (isPlay) {
  //     _controller.play();
  //     // _controller.
  //   } else {
  //     _controller.pause();
  //   }
  // }

  ///---------------------------------------------------------------------------
  /// dispose
  ///---------------------------------------------------------------------------
  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   _controller.pause();
  //   super.deactivate();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///---------------------------------------------------------------------------
  /// build
  ///---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    //--------------------------------------------------------------------------
    // 기본 구성
    //--------------------------------------------------------------------------
    return InkWell(
      onTap: (() {
        isPlay = !isPlay;
        if (isPlay) {
          _controller.play();
          // _controller.
        } else {
          _controller.pause();
        }
        setState(() {});
        // print('clicked');
        // widget.callbackReplay(); //화면 갱신을 위한 callback 호출
      }),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          YoutubePlayerBuilder(
              onExitFullScreen: () {
                // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                SystemChrome.setPreferredOrientations(DeviceOrientation.values);
              },
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: tm.mainBlue,
                thumbnail: Container(),
                //-------------------------------------
                // 전체 보기 button 없애기
                bottomActions: [
                  const SizedBox(width: 14.0),
                  CurrentPosition(),
                  const SizedBox(width: 8.0),
                  ProgressBar(isExpanded: true),
                  RemainingDuration(),
                  const PlaybackSpeedButton(),
                ],

                //   videoProgressIndicatorColor: Colors.amber,
                //   progressColors: ProgressColors(
                //     playedColor: Colors.amber,
                //     handleColor: Colors.amberAccent,
                //   ),
                //   onReady () {
                // _controller.addListener(listener);
                // },
              ),
              builder: (context, player) {
                return player;
              }),

          //----------------------------
          // play button
          !isPlay
              ? Padding(
                padding: EdgeInsets.all(asHeight(10)),
                child: Image.asset(
                    'assets/icons/ic_play.png',
                    color: tm.white.withOpacity(0.7),
            height: asHeight(25),
                  ),
              )
              : Container(),
        ],
      ),
    );

    //--------------------------------------------------------------------------
    // 전체화면 보기 : bottom sheet 와 꼬임 : 다른 방법 검토 필요
    //--------------------------------------------------------------------------
    // return YoutubePlayerBuilder(
    //     player: YoutubePlayer(controller: _controller),
    //     builder: (context, player) {
    //       return InkWell(
    //         onTap: (() {
    //           play();
    //           widget.callbackReplay(); //화면 갱신을 위한 callback 호출
    //         }),
    //         child: Stack(
    //           alignment: Alignment.center,
    //           children: [
    //             //--------------------------------------------------------------
    //             // 비디오
    //             //--------------------------------------------------------------
    //             player,
    //             //--------------------------------------------------------------
    //             // 위젯 (플레이 버튼 등)
    //             //--------------------------------------------------------------
    //             widget.child,
    //           ],
    //         ),
    //       );
    //     });
  }
}
