// import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
//
// //==============================================================================
// // 옵션 선택 창
// //==============================================================================
//
// class GuideOptionSelect extends StatefulWidget {
//   final Function() callbackMode;
//   final Function() callbackOption;
//
//   const GuideOptionSelect({
//     required this.callbackMode,
//     required this.callbackOption,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<GuideOptionSelect> createState() => _GuideOptionSelectState();
// }
//
// class _GuideOptionSelectState extends State<GuideOptionSelect> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         asSizedBox(height: 10),
//         modeSelect(callbackMode: widget.callbackMode),
//         asSizedBox(height: 20),
//         optionSelect(callbackOption: widget.callbackOption),
//       ],
//     );
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 모드 선택
//   ///---------------------------------------------------------------------------
//   Widget modeSelect({
//     required Function() callbackMode,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         asSizedBox(width: 3),
//         //----------------------------------------------------------------------
//         // 가이드 항목
//         InkWell(
//           onTap: (() {
//             dvSetting.isOptionGuide = true;
//             setState(() {});
//           }),
//           borderRadius: BorderRadius.circular(asHeight(8)),
//           child: Container(
//             height: asHeight(50),
//             padding: EdgeInsets.symmetric(horizontal: asWidth(15)),
//             alignment: Alignment.center,
//             child: Container(
//               height: asHeight(30),
//               alignment: Alignment.center,
//               child: TextN(
//                 '가이드 항목',
//                 fontSize: tm.s14,
//                 color: dvSetting.isOptionGuide ? tm.black : tm.grey03,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         //----------------------------------------------------------------------
//         // 좌/우
//         InkWell(
//           onTap: (() {
//             dvSetting.isOptionGuide = false;
//             setState(() {});
//           }),
//           borderRadius: BorderRadius.circular(asHeight(8)),
//           child: Container(
//             height: asHeight(50),
//             alignment: Alignment.center,
//             padding: EdgeInsets.symmetric(horizontal: asWidth(15)),
//             child: Container(
//               height: asHeight(30),
//               alignment: Alignment.center,
//               child: TextN(
//                 '좌/우',
//                 fontSize: tm.s14,
//                 color: !dvSetting.isOptionGuide ? tm.black : tm.grey03,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 옵션 선택
//   ///---------------------------------------------------------------------------
//   Widget optionSelect({
//     required Function() callbackOption,
//   }) {
//     List<String> itemDirection = const ['좌', '우'];
//     List<String> itemGuide = const ['부착위치 가이드', '부착사진', '관련 운동'];
//     double width = asWidth(360);
//     double height = asHeight(220);
//
//     return SizedBox(
//       width: width,
//       height: height,
//       child: Column(
//         children: [
//           //----------------------------------------------------------------------
//           // ListView
//           //----------------------------------------------------------------------
//           Expanded(
//             child: ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: dvSetting.isOptionGuide
//                     ? itemGuide.length
//                     : itemDirection.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: (() {
//                         // guide option
//                         if (dvSetting.isOptionGuide) {
//                           dvSetting.guideContents =
//                               EmaGuideContents.values[index];
//                         }
//                         // 좌우 옵션
//                         else {
//                           if (index == 0) {
//                             dvSetting.isViewLeft = true;
//                           } else {
//                             dvSetting.isViewLeft = false;
//                           }
//                         }
//                         callbackOption(); //화면 갱신을 위한 callback
//                         setState(() {});
//                         // 아래와 같이 하면 기존에 생성한 모든 instance 가 갱신되는 것인가?
//                         // 동작은 하는데 조금 혼동스러움
//                         MuscleGuideSlide().refreshCarouseSlideWithIndicator(); // 슬라이드 화면 갱신
//                         Get.back(); //선택 후 창 닫기
//                       }),
//                       child: Container(
//                         width: width,
//                         height: asHeight(54),
//                         alignment: Alignment.center,
//                         padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom:
//                                     BorderSide(color: tm.grey01, width: 1))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             //--------------------------------------------------
//                             // 글씨
//                             //--------------------------------------------------
//                             TextN(
//                               dvSetting.isOptionGuide
//                                   ? itemGuide[index]
//                                   : itemDirection[index],
//                               fontSize: tm.s16,
//                               color: _color(index),
//                             ),
//                             //--------------------------------------------------
//                             // 체크 표시 (선택된 경우에만)
//                             //--------------------------------------------------
//                             if (_color(index) == tm.blue)
//                               Image.asset(
//                                 'assets/icons/ic_check.png',
//                                 height: asHeight(12),
//                                 color: tm.blue,
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           )
//         ],
//       ),
//     );
//   }
//
//   ///---------------------------------------------------------------------------
//   /// color
//   ///---------------------------------------------------------------------------
//   Color _color(int index) {
//     Color color = Colors.black;
//     //--------------------------------------------------------------------------
//     // 가이드 옵션 모드
//     //--------------------------------------------------------------------------
//     if (dvSetting.isOptionGuide) {
//       color = dvSetting.guideContents == EmaGuideContents.values[index]
//           ? tm.blue
//           : tm.grey03;
//     }
//     //--------------------------------------------------------------------------
//     // 좌우 선택
//     //--------------------------------------------------------------------------
//     else {
//       color = (dvSetting.isViewLeft == true && index == 0) ||
//               (dvSetting.isViewLeft == false && index == 1)
//           ? tm.blue
//           : tm.grey03;
//     }
//     return color;
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 다이얼로그 제목
//   ///---------------------------------------------------------------------------
//   // Widget _head({String title = '제목'}) {
//   //   return Container(
//   //     // 여유공간
//   //     margin: EdgeInsets.only(
//   //       top: asHeight(10),
//   //       left: asWidth(8),
//   //       right: asWidth(8),
//   //       bottom: asHeight(10),
//   //     ),
//   //     child: Stack(
//   //       alignment: AlignmentDirectional.center,
//   //       children: [
//   //         Align(
//   //           alignment: Alignment.center,
//   //           child: TextN(
//   //             title,
//   //             fontSize: tm.s20,
//   //             color: tm.grey04,
//   //             fontWeight: FontWeight.w600,
//   //           ),
//   //         ),
//   //         //----------------------------------------------------------------------
//   //         // 닫기 버튼
//   //         Align(
//   //           alignment: Alignment.centerRight,
//   //           child: InkWell(
//   //             borderRadius: BorderRadius.circular(asWidth(10)),
//   //             onTap: (() {
//   //               Get.back();
//   //             }),
//   //             child: Container(
//   //               width: asWidth(56),
//   //               height: asHeight(56),
//   //               alignment: Alignment.center,
//   //               child: Icon(
//   //                 Icons.close,
//   //                 size: asHeight(36),
//   //                 color: tm.grey03,
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }
