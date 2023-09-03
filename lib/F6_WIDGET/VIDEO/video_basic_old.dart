// import 'package:video_player/video_player.dart';
// import '/F0_BASIC/common_import.dart';
// import 'dart:io' as io;
//
// //==============================================================================
// // local video replay
// //==============================================================================
//
// // 동시에 여러개의 비디오를 플레이 하기 위한 방법
// const int _num = 50;
// List<VideoPlayerController> _controllerList = List.generate(_num,
//     (index) => VideoPlayerController.asset('assets/videos/010_band_01.mp4'));
// List<Future<void>> _initializeVideoPlayerFutureList =
//     List.generate(_num, (index) => _controllerList[0].initialize());
//
// int _idx = 0;
//
// class VideoPlayerScreen extends StatefulWidget {
//   final String fileName;
//
//   const VideoPlayerScreen({this.fileName = '', Key? key}) : super(key: key);
//
//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   // late VideoPlayerController _controller;
//   // late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     // _controller = VideoPlayerController.network(
//     //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//     // );
//
//     _idx = _idx + 1;
//     _idx %= _num;
//     //------------------------------------------------
//     // 한글과 space 로 된 파일을 읽게 하기 위한 조치 (장 동작 안함)
//
//     _controllerList[_idx] = VideoPlayerController.asset(
//       'assets/videos/${widget.fileName}.mp4',
//     );
//
//     // _controller = _controllerList.last;
//
//     // _controller = VideoPlayerController.asset(
//     //   'assets/videos/${widget.fileName}.mp4',
//     // );
//
//     // 컨트롤러를 초기화하고 추후 사용하기 위해 Future를 변수에 할당
//     _initializeVideoPlayerFutureList[_idx] = _controllerList[_idx].initialize();
//
//
//     // 비디오를 반복 재생하기 위해 컨트롤러를 사용
//     _controllerList[_idx].setLooping(true);
//     _controllerList[_idx].setVolume(0); //자동 start 를 위해 volume 0 처리
//     // _controller.initialize().then((_) => setState(() {}));
//     // _controller.initialize().then((value) => _controller.play());
//     _controllerList[_idx].play();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // 자원을 반환하기 위해 VideoPlayerController를 dispose
//     // _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initializeVideoPlayerFutureList[_idx],
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
//           // VideoPlayer의 종횡비를 제한
//           //_controller.play();
//           return AspectRatio(
//             aspectRatio: _controllerList[_idx].value.aspectRatio,
//             // 영상을 보여주기 위해 VideoPlayer 위젯을 사용
//             child: VideoPlayer(_controllerList[_idx]),
//           );
//         } else {
//           // VideoPlayerController 가 초기화 중이라면 로딩 스피너
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
