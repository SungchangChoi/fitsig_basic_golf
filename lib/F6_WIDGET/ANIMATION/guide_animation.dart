// import '/F0_BASIC/common_import.dart';
//
// GlobalKey<_GuideAnimationState> _guideAnimationStateKey = GlobalKey();
//
// // late AnimationController guideAnimationController;
// // bool _isGuideAnimationControllerInitialized = false;
// bool isGuideVisible = false;
// late Timer _guideVisibleTimer = Timer(const Duration(milliseconds: 2000), () {});
//
// //==============================================================================
// // 리플 테스트코드
// //==============================================================================
//
// // void guideAnimationExecution() {
//   // // 이미 화면 상 측정 종료 된 경우 애니메이션 실행 안함 (애니메이션 에러 방지)
//   // // 애니메니션 컨트롤러가 초기화가 안된 경우에도 실행 안함
//   // if (DspManager.isMeasureOnScreen == false || _isGuideAnimationControllerInitialized == false){
//   //   return;
//   // }
//   //
//   // //원형 리플 애니메이션 재 시작
//   // guideAnimationController.reset();
//   // guideAnimationController.forward();
//
//   //최초 애니메이션 보이게
//   // isGuideVisible = true;
//   //
//   // // 특정 시간 후에 애니메이션 안보이게 할 목적의 타이머
//   // // 0.5초뒤에 사라짐
//   // _guideVisibleTimer.cancel();
//   // _guideVisibleTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
//   //   // 화면에서 사라지게
//   //   isGuideVisible = false;
//   //   _guideAnimationStateKey.currentState?.refresh(); //AnimatedOpacity 갱신
//   //   _guideVisibleTimer.cancel();
//   // });
// // }
//
// Widget guideAnimation({Color backgroundColor = Colors.blue, String text='', String? imagePath}) {
//   return GuideAnimation(
//     key: _guideAnimationStateKey,
//     backgroundColor: backgroundColor,
//     text: text,
//     imagePath: imagePath,
//   );
// }
//
// class GuideAnimation extends StatefulWidget {
//   final Color backgroundColor;
//   final String text;
//   final String? imagePath;
//
//   const GuideAnimation({
//     this.backgroundColor = Colors.blue,
//     this.text = '',
//     this.imagePath,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<GuideAnimation> createState() => _GuideAnimationState();
// }
//
// class _GuideAnimationState extends State<GuideAnimation>
//     with TickerProviderStateMixin {
//   late Color color; // = Colors.indigoAccent.withOpacity(0.2);
//
//   @override
//   void initState() {
//     super.initState();
//     // guideAnimationController = AnimationController(
//     //   duration: const Duration(milliseconds: 500),
//     //   vsync: this,
//     // ); //..forward();
//     // _isGuideAnimationControllerInitialized = true;
//   }
//
//   void changeVisible(){
//     if(isGuideVisible == false) {
//       setState(() {
//         isGuideVisible = true;
//       });
//       _guideVisibleTimer = Timer(const Duration(seconds: 2), () {
//         setState(() {
//           isGuideVisible = false;
//         });
//       });
//     }
//     else{
//       _guideVisibleTimer.cancel();
//       setState(() {
//         isGuideVisible = false;
//       });
//       setState(() {
//         isGuideVisible = true;
//       });
//       _guideVisibleTimer = Timer(const Duration(seconds: 2), () {
//         setState(() {
//           isGuideVisible = false;
//         });
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     // guideAnimationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       opacity: isGuideVisible ? 1.0 : 0.0, //점점 안보이게
//       duration: const Duration(milliseconds: 200),
//       child: Container(
//         color: tm.blue,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (widget.imagePath != null )
//               Image.asset(
//               widget.imagePath!,
//               fit: BoxFit.scaleDown,
//               height: asHeight(24),
//             ),
//             SizedBox(
//               width: asWidth(8),
//             ),
//             TextN(
//               widget.text,
//               fontSize: tm.s16,
//               fontWeight: FontWeight.bold,
//               color: tm.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }