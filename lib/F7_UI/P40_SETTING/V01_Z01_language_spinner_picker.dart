// import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
//
// //==============================================================================
// // class : 언어 스피너 픽커 다이얼로그 생성
// //==============================================================================
// class LanguageSpinnerPicker extends StatefulWidget {
//   const LanguageSpinnerPicker({
//     Key? key,
//     required this.context,
//   }) : super(key: key);
//   final BuildContext context;
//
//   @override
//   State<LanguageSpinnerPicker> createState() => _LanguageSpinnerPickerState();
// }
//
// class _LanguageSpinnerPickerState extends State<LanguageSpinnerPicker> {
//   //----------------------------------------------------------------------------
//   // 선택된 언어 인덱스 (0 = 한국어, 1 = 영어)
//   int _languageIndex = gv.setting.languageIndex.value;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         children: [
//           _head(),
//           // dividerBig(),
//           _main(),
//           asSizedBox(height: 20),
//           _selectButton(context),
//         ],
//       ),
//     );
//   }
//
//   //----------------------------------------------------------------------------
//   //다이얼로그 제목
//   //----------------------------------------------------------------------------
//   Widget _head() {
//     return Container(
//       // 여유공간
//       margin: EdgeInsets.only(
//         top: asHeight(20),
//         left: asWidth(18),
//         right: asWidth(18),
//         bottom: asHeight(20),
//       ),
//       child: Stack(
//         alignment: AlignmentDirectional.center,
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: TextN(
//               '언어선택',
//               fontSize: tm.s20,
//               color: tm.grey04,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           //----------------------------------------------------------------------
//           // 닫기 버튼
//           Align(
//             alignment: Alignment.centerRight,
//             child: InkWell(
//               onTap: (() {
//                 Get.back();
//               }),
//               child: Icon(
//                 Icons.close,
//                 size: asHeight(36),
//                 color: tm.grey03,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   //----------------------------------------------------------------------------
//   // 다이얼로그 메인내용
//   //----------------------------------------------------------------------------
//   Widget _main() {
//     return spinnerBasic(
//       width: asWidth(Get.width * 0.6),
//       height: tm.s30 * 4,
//       itemHeight: tm.s30,
//       backgroundColor: tm.grey01,
//       onSelectedItemChanged: (index) {
//         _languageIndex = index;
//       },
//       childCount: LanguageData.supportedLanguage.length,
//       initialItem: gv.setting.languageIndex.value,
//       fontSize: tm.s20,
//       textColor: tm.grey04,
//       itemTextList: LanguageData.supportedLanguage, //_nativeLanguageNameList,
//     );
//   }
//
//   //----------------------------------------------------------------------------
//   // 다이얼로그 버튼
//   //----------------------------------------------------------------------------
//   Widget _selectButton(context) {
//     return InkWell(
//       child: Container(
//         alignment: Alignment.center,
//         width: asWidth(Get.width * 0.3),
//         height: asHeight(40),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(asHeight(18)),
//             border:
//                 Border.all(width: asWidth(1), color: tm.mainBlue.withOpacity(0.3))),
//         child: TextN(
//           '확인',
//           fontSize: tm.s16,
//           color: tm.mainBlue,
//         ),
//       ),
//       onTap: () {
//         // 최종 선택 된 언어 확정  및 공유메모리 기록
//         gv.setting.languageIndex.value = _languageIndex;
//         gv.spMemory.write('languageIndex', gv.setting.languageIndex.value);
//         // 사용 할 언어 갱신 (바로 반영 됨)
//         Get.updateLocale(
//             LanguageData.supportedLocales[gv.setting.languageIndex.value]);
//         Navigator.pop(context);
//       },
//     );
//   }
// }
