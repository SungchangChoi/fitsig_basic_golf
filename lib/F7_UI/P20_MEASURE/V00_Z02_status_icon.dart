// import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
//
// //==============================================================================
// // no connection icon
// //==============================================================================
// class AniIconNoConnection extends StatefulWidget {
//   final double height;
//
//   const AniIconNoConnection({this.height = 100, Key? key}) : super(key: key);
//
//   @override
//   State<AniIconNoConnection> createState() => _AniIconNoConnectionState();
// }
//
// class _AniIconNoConnectionState extends State<AniIconNoConnection> {
//   late Timer _timer;
//
//   //----------------------------------------------------------------------------
//   // 시작단계
//   //----------------------------------------------------------------------------
//   int cnt = 0;
//   bool isView = true;
//
//   @override
//   void initState() {
//     _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       cnt++;
//       if (cnt == 1) {
//         isView = true;
//         setState(() {});
//       } else if (cnt == 10) {
//         isView = false;
//         setState(() {});
//       } else if (cnt >= 15) {
//         cnt = 0;
//       }
//     });
//     super.initState();
//   }
//
//   //----------------------------------------------------------------------------
//   // 종료단계
//   //----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   //----------------------------------------------------------------------------
//   // 빌드
//   //----------------------------------------------------------------------------
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         //------------------------------------------------------------------
//         // 장비연결 배경 이미지
//         Image.asset(
//           'assets/icons/장비연결 아이콘2.png',
//           fit: BoxFit.fitHeight,
//           height: widget.height,
//           color: tm.white,
//         ),
//         //------------------------------------------------------------------
//         // 장비연결 X 표시
//         AnimatedOpacity(
//           opacity: isView ? 0.7 : 0,
//           duration: const Duration(milliseconds: 300),
//           child: Image.asset(
//             'assets/icons/장비연결 엑스아이콘.png',
//             fit: BoxFit.fitHeight,
//             height: widget.height,
//             color: tm.red,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// //==============================================================================
// // no connection icon
// //==============================================================================
//
// class AniIconNotGoodAttach extends StatefulWidget {
//   final double height;
//   const AniIconNotGoodAttach({this.height = 100, Key? key}) : super(key: key);
//
//   @override
//   State<AniIconNotGoodAttach> createState() => _AniIconNotGoodAttachState();
// }
//
// class _AniIconNotGoodAttachState extends State<AniIconNotGoodAttach> {
//   late Timer _timer;
//
//   //----------------------------------------------------------------------------
//   // 시작단계
//   //----------------------------------------------------------------------------
//   int cnt = 0;
//   bool isViewArrow = true;
//   bool isStartPosition = true;
//
//   @override
//   void initState() {
//     _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       cnt++;
//       if (cnt == 1) {
//         isViewArrow = false;
//         isStartPosition = true;
//         setState(() {});
//       }
//       else if (cnt == 2) {
//         // isViewArrow = false;
//         setState(() {});
//       }
//       else if (cnt == 10) {
//         isStartPosition = false;
//         setState(() {});
//       }
//       else if (cnt == 15) {
//         isViewArrow = true;
//         setState(() {});
//       }      else if (cnt >= 20) {
//         cnt = 0;
//       }
//     });
//     super.initState();
//   }
//
//   //----------------------------------------------------------------------------
//   // 종료단계
//   //----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   //----------------------------------------------------------------------------
//   // 빌드
//   //----------------------------------------------------------------------------
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         //------------------------------------------------------------------
//         // 피부 배경 이미지
//         Image.asset(
//           'assets/icons/피부 아이콘.png',
//           fit: BoxFit.fitHeight,
//           height: widget.height,
//           color: tm.white,
//         ),
//         //------------------------------------------------------------------
//         // 아래방향 화살표
//         AnimatedOpacity(
//           opacity: isViewArrow ? 0.7 : 0,
//           duration: const Duration(milliseconds: 300),
//           child: Image.asset(
//             'assets/icons/아래방향 화살표1.png',
//             fit: BoxFit.fitHeight,
//             height: widget.height,
//             color: tm.mainBlue,
//           ),
//         ),
//         //------------------------------------------------------------------
//         // 장비
//         AnimatedPositioned(
//           // opacity: isView ? 0.7 : 0,
//           top:  isStartPosition ? widget.height * 0.5 : 0, //asHeight(52) : 0
//           curve: Curves.decelerate,
//           duration: Duration(milliseconds: isStartPosition ? 700 : 200),
//           child: Image.asset(
//             'assets/icons/장비측면 아이콘1.png',
//             fit: BoxFit.fitHeight,
//             height: widget.height,
//             color: tm.white,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// //==============================================================================
// // no connection icon 2
// //==============================================================================
//
// class AniIconNotGoodAttachBody extends StatefulWidget {
//   final double height;
//   const AniIconNotGoodAttachBody({this.height = 100, Key? key}) : super(key: key);
//
//   @override
//   State<AniIconNotGoodAttachBody> createState() => _AniIconNotGoodAttachBodyState();
// }
//
// class _AniIconNotGoodAttachBodyState extends State<AniIconNotGoodAttachBody> {
//   late Timer _timer;
//
//   //----------------------------------------------------------------------------
//   // 시작단계
//   //----------------------------------------------------------------------------
//   int cnt = 0;
//   bool isViewArrow = true;
//
//
//   @override
//   void initState() {
//     _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       cnt++;
//       if (cnt == 1) {
//         isViewArrow = false;
//         setState(() {});
//       }
//       else if (cnt == 15) {
//         isViewArrow = true;
//         setState(() {});
//       }      else if (cnt >= 20) {
//         cnt = 0;
//       }
//     });
//     super.initState();
//   }
//
//   //----------------------------------------------------------------------------
//   // 종료단계
//   //----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   //----------------------------------------------------------------------------
//   // 빌드
//   //----------------------------------------------------------------------------
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         //------------------------------------------------------------------
//         // 피부 배경 이미지
//         Image.asset(
//           'assets/icons/근육 상반신 아이콘.png',
//           fit: BoxFit.fitHeight,
//           height: asHeight(widget.height),
//           color: tm.white,
//         ),
//         //------------------------------------------------------------------
//         // 장비 아이콘
//         AnimatedOpacity(
//           opacity: isViewArrow ? 0.7 : 0,
//           duration: const Duration(milliseconds: 300),
//           child: Image.asset(
//             'assets/icons/근육 상반신 장비아이콘.png',
//             fit: BoxFit.fitHeight,
//             height: asHeight(widget.height),
//             color: tm.red,
//           ),
//         ),
//       ],
//     );
//   }
// }