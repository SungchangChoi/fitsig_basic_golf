// import 'package:fitsig_basic/F7_UI/P10_INTRO/V03_personal_information_old.dart';
//
// import '/F0_BASIC/common_import.dart';
// //==============================================================================
// // 제품을 처음 사용하는 경우의 페이지
// // 언어선택 및 약관 동의
// //==============================================================================
//
// class FirstUserPage extends StatelessWidget {
//   const FirstUserPage({Key? key}) : super(key: key);
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
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   asSizedBox(height: 20),
//                   //------------------------------------------------------------
//                   // 언어변경 (추후 번역 후 구현)
//                   //------------------------------------------------------------
//                   // Obx(() {
//                   //   return settingButtonBox(
//                   //     onTap: (() {
//                   //       openBottomSheetBasic(
//                   //         child: LanguageSpinnerPicker(context: context),
//                   //         height: asHeight(340),
//                   //       );
//                   //     }),
//                   //     title: 'Language',
//                   //     subTitle: LanguageData
//                   //         .supportedLanguage[gv.setting.languageIndex.value],
//                   //     // subTitle: LanguageLocal.getDisplayLanguage(
//                   //     //         gv.setting.locale.value.languageCode)['nativeName']
//                   //     //     .toString(),
//                   //     subTitleColor: tm.blue,
//                   //     buttonName: '변경'.tr,
//                   //   );
//                   // }),
//                   // asSizedBox(height: 10),
//                   // dividerSmall(),
//                   asSizedBox(height: 20),
//                   //------------------------------------------------------------
//                   // 인사말
//                   //------------------------------------------------------------
//                   TextN(
//                     '제품을 사용해 주셔서 감사합니다.'
//                             ' 본 어플리케이션은 FITSIG 근전도 측정장비와 연동하여'
//                             ' 근력운동 목적으로 사용할 수 있습니다. '
//                         .tr,
//                     fontSize: tm.s16,
//                     color: tm.black,
//                   ),
//                   asSizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         height: asHeight(120),
//                         child: Image.asset(
//                           'assets/images/device_one_angle 45_red_512.png',
//                           fit: BoxFit.scaleDown,
//                           // color: Colors.lightGreenAccent,
//                         ),
//                       ),
//                       SizedBox(
//                         height: asHeight(120),
//                         child: Image.asset(
//                           'assets/images/device_circle_type1_512.png',
//                           //device_three_type2_512.png
//                           fit: BoxFit.scaleDown,
//                           // color: Colors.lightGreenAccent,
//                         ),
//                       ),
//                     ],
//                   ),
//                   asSizedBox(height: 20),
//                   dividerSmall(),
//                   asSizedBox(height: 20),
//                   // 장비 사진
//                   //------------------------------------------------------------
//                   // 약관, 개인정보 처리 방침
//                   //------------------------------------------------------------
//                   TextN(
//                     '본 제품을 사용하기 전에 반드시 약관 및 개인정보처리방침을 읽어 주시기 바랍니다.'
//                         ' 본 제품을 사용하면 약관 및 정책에 동의하신 것으로 판단합니다.'
//                             ' 약관 내용은 설정에서 다시 확인할 수 있습니다.'
//                         .tr,
//                     fontSize: tm.s16,
//                     color: tm.black,
//                   ),
//                   asSizedBox(height: 20),
//                   textButtonG(
//                     width: asWidth(280),
//                     height: asHeight(40),
//                     title: '이용약관',
//                     onTap: (() {
//                       Navigator.of(context).push(pageRouteAnimationSimple(
//                           TermsPageForm(
//                             child: wordTerms(), //Html(data: htmlTerms),
//                             termsTitle: '이용약관',
//                           ),
//                           EmlMoveDirection.rightToLeft));
//                     }),
//                   ),
//                   // asSizedBox(height: 10),
//                   // textButtonG(
//                   //   width: asWidth(280),
//                   //   title: '운영정책',
//                   //   onTap: (() {
//                   //     Navigator.of(context).push(pageRouteAnimationSimple(
//                   //         TermsPageForm(
//                   //           child: Html(data: htmlPolicy),
//                   //           termsTitle: '운영정책',
//                   //         ),
//                   //         EmlMoveDirection.rightToLeft));
//                   //   }),
//                   // ),
//                   asSizedBox(height: 10),
//                   textButtonG(
//                     width: asWidth(280),
//                     height: asHeight(40),
//                     title: '개인정보취급방침',
//                     onTap: (() {
//                       Navigator.of(context).push(pageRouteAnimationSimple(
//                           TermsPageForm(
//                             child: wordPersonalInformation(),
//                             termsTitle: '개인정보처리방침',
//                           ),
//                           EmlMoveDirection.rightToLeft));
//                     }),
//                   ),
//                   asSizedBox(height: 10),
//                   dividerSmall(),
//                   asSizedBox(height: 10),
//                 ],
//               ),
//
//               //----------------------------------------------------------------
//               // 시작하기
//               //----------------------------------------------------------------
//               Column(
//                 children: [
//                   textButtonI(
//                       onTap: (() {
//                         Get.off(() => const PersonalInfoPage());
//                       }),
//                       width: asWidth(280),
//                       height: asHeight(40),
//                       title: '다음으로'.tr),
//                   asSizedBox(height: 10),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
