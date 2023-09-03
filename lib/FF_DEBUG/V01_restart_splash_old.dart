// import '/F0_BASIC/common_import.dart';
//
// //==============================================================================
// // 재 시작할 때 실행되는 페이지
// //==============================================================================
// class RestartSplash extends StatefulWidget {
//   const RestartSplash({Key? key}) : super(key: key);
//
//   @override
//   State<RestartSplash> createState() => _RestartSplashState();
// }
//
// class _RestartSplashState extends State<RestartSplash> {
//   late Timer _timer; //타이머
//   int cnt100ms = 0;
//   @override
//   void initState() {
//     super.initState();
//
//     //-------------------------------------------
//     // 1초를 기다렸다 idle 화면으로 접근해야 muscle track position key duplication 이 발생 안함
//     // 추후 원인 파악 필요 (왜 1초 기다렸다가 하면 괜찮은가?)
//     _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       cnt100ms++;
//       if (cnt100ms == 10) {
//         _timer.cancel();
//         Get.off(() => const MeasureIdle());
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return GetMaterialApp(
//   //       theme: ThemeData(
//   //         primarySwatch: Colors.orange,
//   //       ),
//   //
//   //       home: Center(
//   //         child: TextN('변경된 설정 적용 중입니다.', color: tm.black, fontSize: tm.s20,),
//   //
//   //       ));
//   //
//   //
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: tm.white,
//         child: Center(
//           child: TextN('변경된 설정 적용 중입니다.', color: tm.black, fontSize: tm.s20,),
//
//     ));
//   }
// }
