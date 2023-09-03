import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// youtube iframe
// pause할 때 현재 화면을 보여주는 관계로, 안내 영상에서만 이 위젯 사용
//==============================================================================
class VideoYoutubeIframe extends StatefulWidget {
  final String videoId;
  final bool loop;
  final bool autoPlay;

  const VideoYoutubeIframe({
    this.videoId = '',
    this.loop = false,
    this.autoPlay = false,
    Key? key,
  }) : super(key: key);

  @override
  State<VideoYoutubeIframe> createState() => _VideoYoutubeIframeState();
}

class _VideoYoutubeIframeState extends State<VideoYoutubeIframe> {
  late YoutubePlayerController _controller;

  ///---------------------------------------------------------------------------
  /// init
  ///---------------------------------------------------------------------------
  @override
  void initState() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: widget.autoPlay,
      params: YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: false,
        loop: widget.loop,
        showVideoAnnotations: true, //more video 뜨는 것 방지와 무관한 듯
        enableJavaScript: true,
        enableKeyboard: false,
      ),
    );


    // auto play
    // _controller.loadVideoById(videoId: widget.videoId);
    // manual
    // _controller.cueVideoById(videoId: widget.videoId);

    super.initState();
  }

  ///---------------------------------------------------------------------------
  /// dispose
  ///---------------------------------------------------------------------------
  @override
  void dispose() async {
    super.dispose();
    await _controller.close();
  }

  ///---------------------------------------------------------------------------
  /// build
  ///---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
