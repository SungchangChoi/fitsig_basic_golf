// import '/F0_BASIC/common_import.dart';
//
// //==============================================================================
// // 제품을 처음 사용하는 경우의 페이지
// // 언어선택 및 약관 동의
// //==============================================================================
//
// class PersonalInfoPage extends StatelessWidget {
//   const PersonalInfoPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: tm.white,
//       child: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(asHeight(18)),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 tm.blue.withOpacity(0.2),
//                 tm.grey03.withOpacity(0.2),
//                 tm.grey02.withOpacity(0.1),
//                 tm.white,
//                 tm.grey02.withOpacity(0.1),
//                 tm.grey03.withOpacity(0.2),
//                 tm.blue.withOpacity(0.2),
//               ],
//             ),
//           ),
//           child: Obx(() {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     asSizedBox(height: 50),
//                     //----------------------------------------------------------
//                     // 출생 연도 선택
//                     //----------------------------------------------------------
//                     TextN(
//                       '성별을 선택해 주세요.'.tr,
//                       fontSize: tm.s18,
//                       color: tm.black,
//                     ),
//
//                     //----------------------------------------------------------
//                     // 1열
//                     asSizedBox(height: 20),
//                     selectGender(),
//                     //----------------------------------------------------------
//                     // 1열
//                     asSizedBox(height: 80),
//                     //----------------------------------------------------------
//                     // 출생 연도 선택
//                     //----------------------------------------------------------
//                     TextN(
//                       '출생 연도를 선택해 주세요.'.tr,
//                       fontSize: tm.s18,
//                       color: tm.black,
//                     ),
//                     asSizedBox(height: 20),
//                     //----------------------------------------------------------
//                     // 출생 연도 선택
//                     //----------------------------------------------------------
//                     selectBornYear(),
//                     dividerSmall(),
//                     asSizedBox(height: 80),
//                     TextN(
//                       '본 어플리케이션은 성별과 출생연도 외에 별도의 개인정보를 필요로 하지 않습니다. 상기 정보는 통계분석 목적으로 사용됩니다.'
//                           .tr,
//                       fontSize: tm.s16,
//                       color: tm.grey04,
//                     ),
//                   ],
//                 ),
//
//                 //--------------------------------------------------------------
//                 // 시작하기
//                 //--------------------------------------------------------------
//                 Column(
//                   children: [
//                     textButtonI(
//                         onTap: (() {
//                           //처음 사용자 기록 해제
//                           gv.system.isFirstUser = false;
//                           gv.spMemory.write('isFirstUser', false);
//                           // 대기 화면으로 이동
//                           // Get.off(() => const MeasureIdle());
//                           Get.back();
//                         }),
//                         width: asWidth(280),
//                         height: asHeight(40),
//                         backgroundColor: tm.blue,
//                         title: '시작하기'.tr),
//                     asSizedBox(height: 10),
//                   ],
//                 ),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
//
// // Widget selectGender() {
// //   return Column(
// //     children: [
// //
// //       wButtonAwSel(
// //         radius: asHeight(8),
// //         height: asHeight(44),
// //         child: TextN('남성',fontSize: tm.s14, color: tm.black),
// //       ),
// //
// //       Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           // 남성
// //           textButtonSel(
// //             fontSize: tm.s16,
// //             title: gv.setting.genderList[0],
// //             onTap: (() async {
// //               gv.setting.genderIndex.value = 0;
// //               await gv.spMemory
// //                   .write('genderIndex', gv.setting.genderIndex.value);
// //             }),
// //             width: asWidth(105),
// //             height: asHeight(36),
// //             isSelected: gv.setting.genderIndex.value == 0,
// //           ),
// //           // 여성
// //           textButtonSel(
// //             fontSize: tm.s16,
// //             title: gv.setting.genderList[1],
// //             onTap: (() async {
// //               gv.setting.genderIndex.value = 1;
// //               await gv.spMemory
// //                   .write('genderIndex', gv.setting.genderIndex.value);
// //             }),
// //             width: asWidth(105),
// //             height: asHeight(36),
// //             isSelected: gv.setting.genderIndex.value == 1,
// //           ),
// //           // 기타
// //           textButtonSel(
// //             fontSize: tm.s16,
// //             title: gv.setting.genderList[2],
// //             onTap: (() async {
// //               gv.setting.genderIndex.value = 2;
// //               await gv.spMemory
// //                   .write('genderIndex', gv.setting.genderIndex.value);
// //             }),
// //             width: asWidth(105),
// //             height: asHeight(36),
// //             isSelected: gv.setting.genderIndex.value == 2,
// //           ),
// //         ],
// //       ),
// //     ],
// //   );
// // }
//
// Widget selectBornYear() {
//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // ~1940
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[0],
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 0;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 0,
//           ),
//           // ~1950
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[1],
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 1;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 1,
//           ),
//           // ~1960
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[2],
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 2;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 2,
//           ),
//           // ~1970
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[3],
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 3;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 3,
//           ),
//         ],
//       ),
//       asSizedBox(height: 10),
//       //----------------------------------------------------------
//       // 2열
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // ~1980
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[4],
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 4;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 4,
//           ),
//           // ~1990
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[5],
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 5;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 5,
//           ),
//           // ~2000
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[6],
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 6;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 6,
//           ),
//           // ~2010
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[7],
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 7;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 7,
//           ),
//         ],
//       ),
//       asSizedBox(height: 10),
//       //----------------------------------------------------------
//       // 3열
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // ~2020
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[8],
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 8;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 8,
//           ),
//           // ~2030
//           textButtonSel(
//             fontSize: tm.s14,
//             title: gv.setting.bornYearList[9].substring(0,5),
//             onTap: (() async {
//               gv.setting.bornYearIndex.value = 9;
//               await gv.spMemory
//                   .write('bornYearIndex', gv.setting.bornYearIndex.value);
//             }),
//             width: asWidth(78),
//             height: asHeight(36),
//             radius: asWidth(5),
//             isSelected: gv.setting.bornYearIndex.value == 9,
//           ),
//           asSizedBox(width: 78),
//           asSizedBox(width: 78),
//         ],
//       ),
//     ],
//   );
// }
