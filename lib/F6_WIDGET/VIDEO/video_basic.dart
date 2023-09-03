import 'package:video_player/video_player.dart';
import '/F0_BASIC/common_import.dart';
import 'dart:io';

//==============================================================================
// local video replay
//==============================================================================

// List<VideoPlayerController> _controllerList = [];

class VideoPlayerScreen extends StatefulWidget {
  final Function callbackReplay;
  final String fileName;
  const VideoPlayerScreen({this.fileName = '', required this.callbackReplay, Key? key})
      : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  ///---------------------------------------------------------------------------
  /// initState
  ///---------------------------------------------------------------------------
  @override
  void initState() {
    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );

    //------------------------------------------------
    // 한글과 space 로 된 파일을 읽게 하기 위한 조치 (장 동작 안함)
    // String _localFilePath = 'assets/videos/${widget.fileName}.mp4'; //widget.fileName;
    // String _encoded = Uri.encodeFull(_localFilePath);
    // io.File _videoFile = io.File(_encoded);
    // _controller = VideoPlayerController.file(_videoFile);
    // _controller = VideoPlayerController.asset(
    //   'assets/videos/$_videoFile.mp4',
    // );


    // _controller = VideoPlayerController.asset(
    //   'assets/videos/${widget.fileName}.mp4',
    // );

    // 유튜브로 영상을 다운받는 위치가 앱디렉토리/videos/ 이므로 수정
    if (Platform.isIOS) {
      final String localFilePath = '${gv.youtubeManager.videoDirectoryPath}/${widget.fileName}.mp4';
      final File _videoFile = File(localFilePath);
      _controller = VideoPlayerController.file(_videoFile);

    }else {
      _controller = VideoPlayerController.file(
          File('${gv.youtubeManager.videoDirectoryPath}/${widget.fileName}.mp4'));
    }

    // 컨트롤러를 초기화하고 추후 사용하기 위해 Future를 변수에 할당
    _initializeVideoPlayerFuture = _controller.initialize();

    // 비디오를 반복 재생하기 위해 컨트롤러를 사용
    _controller.setLooping(true);
    _controller.setVolume(0); //자동 start를 위해 volume 0 처리
    // _controller.initialize().then((_) => setState(() {}));
    // _controller.initialize().then((value) => _controller.play());
    _controller.play();
    super.initState();
  }
  ///---------------------------------------------------------------------------
  /// replay
  ///---------------------------------------------------------------------------
  replay(){
    // _controller = VideoPlayerController.asset(
    //   'assets/videos/${widget.fileName}.mp4',
    // );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0); //자동 start를 위해 volume 0 처리
    _controller.play();
  }

  ///---------------------------------------------------------------------------
  /// dispose
  ///---------------------------------------------------------------------------
  @override
  void dispose() {
    // 자원을 반환하기 위해 VideoPlayerController를 dispose
    _controller.dispose();
    super.dispose();
  }

  ///---------------------------------------------------------------------------
  /// build
  ///---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
          // VideoPlayer의 종횡비를 제한
          //_controller.play();
          return InkWell(
            onTap: ((){
              replay();
              widget.callbackReplay(); //화면 갱신을 위한 callback 호출
            }),

            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // 영상을 보여주기 위해 VideoPlayer 위젯을 사용
              child: VideoPlayer(_controller),
            ),
          );
        } else {
          // return AspectRatio(
          //   aspectRatio: _controller.value.aspectRatio,
          //   // 영상을 보여주기 위해 VideoPlayer 위젯을 사용
          //   child: VideoPlayer(_controller),
          // );
          // VideoPlayerController 가 초기화 중이라면 로딩 스피너
          return const Center(
            child: CircularProgressIndicator()
          );
          // return const Center(
          //     // child: CircularProgressIndicator()
          // );
        }
      },
    );
  }
}
//==============================================================================
// local video replay : 유투브는 안되는 것으로 보임
//==============================================================================

// List<VideoPlayerController> _controllerList = [];

class VideoNetwork extends StatefulWidget {
  final Function callbackReplay;
  final String videoId;
  final bool loop;

  const VideoNetwork({
    required this.callbackReplay,
    this.videoId = '',
    this.loop = false,
    Key? key}) : super(key: key);

  @override
  State<VideoNetwork> createState() => _VideoNetworkState();
}

class _VideoNetworkState extends State<VideoNetwork> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  bool isPlay = false;
  ///---------------------------------------------------------------------------
  /// initState
  ///---------------------------------------------------------------------------
  @override
  void initState() {
    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );

    //------------------------------------------------
    // 한글과 space 로 된 파일을 읽게 하기 위한 조치 (장 동작 안함)
    // String _localFilePath = 'assets/videos/${widget.fileName}.mp4'; //widget.fileName;
    // String _encoded = Uri.encodeFull(_localFilePath);
    // io.File _videoFile = io.File(_encoded);
    // _controller = VideoPlayerController.file(_videoFile);
    // _controller = VideoPlayerController.asset(
    //   'assets/videos/$_videoFile.mp4',
    // );
    // 'assets/videos/${widget.fileName}.mp4',

    _controller = VideoPlayerController.contentUri(
        Uri.parse('https://www.youtube.com/watch?v=${widget.videoId}'));

    // _controller = VideoPlayerController.network('https://www.youtube.com/watch?v=${widget.videoID}');

    // 컨트롤러를 초기화하고 추후 사용하기 위해 Future를 변수에 할당
    _initializeVideoPlayerFuture = _controller.initialize();

    // 비디오를 반복 재생하기 위해 컨트롤러를 사용
    _controller.setLooping(widget.loop);
    // _controller.setVolume(0); //자동 start를 위해 volume 0 처리
    // _controller.initialize().then((_) => setState(() {}));
    // _controller.initialize().then((value) => _controller.play());
    _controller.play();
    super.initState();
  }
  ///---------------------------------------------------------------------------
  /// replay
  ///---------------------------------------------------------------------------
  replay(){
    // _controller = VideoPlayerController.asset(
    //   'assets/videos/${widget.fileName}.mp4',
    // );
    // _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true);
    // _controller.setVolume(0); //자동 start를 위해 volume 0 처리
    // _controller.play();

    if (isPlay == false){
      isPlay = true;
      _controller.play();
    }
    else{
      isPlay = false;
      _controller.pause();
    }
  }

  ///---------------------------------------------------------------------------
  /// dispose
  ///---------------------------------------------------------------------------
  @override
  void dispose() {
    // 자원을 반환하기 위해 VideoPlayerController를 dispose
    _controller.dispose();
    super.dispose();
  }

  ///---------------------------------------------------------------------------
  /// build
  ///---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
          // VideoPlayer의 종횡비를 제한
          //_controller.play();
          return InkWell(
            onTap: ((){
              replay();
              widget.callbackReplay(); //화면 갱신을 위한 callback 호출
            }),

            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // 영상을 보여주기 위해 VideoPlayer 위젯을 사용
              child: VideoPlayer(_controller),
            ),
          );
        } else {
          // return AspectRatio(
          //   aspectRatio: _controller.value.aspectRatio,
          //   // 영상을 보여주기 위해 VideoPlayer 위젯을 사용
          //   child: VideoPlayer(_controller),
          // );
          // VideoPlayerController 가 초기화 중이라면 로딩 스피너
          return const Center(
              child: CircularProgressIndicator()
          );
          // return const Center(
          //     // child: CircularProgressIndicator()
          // );
        }
      },
    );
  }
}
