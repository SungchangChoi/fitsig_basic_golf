// import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';
//
// // 선택가능한 년, 월, 일 리스트
// List<int> selectionListYear = List.generate(100, (index) => index + 1970);
// List<int> selectionListMonth = List.generate(12, (index) => index + 1);
// List<int> selectionListDay = List.generate(31, (index) => index + 1);
//
// //==============================================================================
// // class : 날짜 스피너 픽커 다이얼로그 생성
// //==============================================================================
// class DateSpinnerPicker extends StatefulWidget {
//   const DateSpinnerPicker({
//     Key? key,
//     this.initialValue = const [],
//     this.title = '',
//     required this.onSelected,
//   }) : super(key: key);
//   final List<int> initialValue;
//   final String title;
//   final void Function(List<int>) onSelected;
//
//   @override
//   State<DateSpinnerPicker> createState() => _DateSpinnerPickerState();
// }
//
// class _DateSpinnerPickerState extends State<DateSpinnerPicker> {
//
//
//   //----------------------------------------------------------------------------
//   // 위젯 사이즈 또는 텍스트 크기와 관련된 변수
//   //----------------------------------------------------------------------------
//   //dialog 의 child (SizedBox) 크기
//   double dialogHeight = asHeight(400); //360 overflow 나서 좀 늘림(HJJ)
//   double dialogWidth = Get.width * 0.8;
//
//   // spinner picker 하나의 크기 ( 년도는 숫자가 4자리, 월과 일은 숫자가 2자리지만 일단은 같은 크기로 설정)
//   double spinnerPickerWidth = tm.s30 * 3;
//   double spinnerPickerHeight = tm.s20 * 10;
//
//   // spinner picker 에서 item 1개의 높이
//   double itemExtent = tm.s30;
//
//   // spinner picker 에 표시되는 선택값의 글자 크기
//   double spinnerPickerItemFontSize = tm.s20;
//   //----------------------------------------------------------------------------
//
//
//
//   int selectedYear = 0; // 선택된 년
//   int selectedMonth = 0; // 선택된 월
//   int selectedDay = 0; // 선택된 일
//
//   int yearIndex = 0; // selectionListYear 에서의 index
//   int monthIndex = 0; // selectionListMonth 에서의 index
//   int dayIndex = 0; // selectionListDay 에서의 index
//
//   late List<int> results; // 선택한 년, 월, 시, 분 값을 return 할 때 사용되는 리스트 변수
//
//   @override
//   void initState() {
//     selectedYear = gvRecord.yearOfDeleteRecord.value;
//     selectedMonth = gvRecord.monthOfDeleteRecord.value;
//     selectedDay = gvRecord.dayOfDeleteRecord.value;
//
//     yearIndex = selectionListYear.indexOf(selectedYear);
//     monthIndex = selectionListMonth.indexOf(selectedMonth);
//     dayIndex = selectionListDay.indexOf(selectedDay);
//
//     results = [];
//
//     assert(monthIndex != -1,
//         'not available index of selectionListMonth in SpinnerSelector');
//     assert(yearIndex != -1,
//         'not available index of selectionListYear in SpinnerSelector');
//     assert(dayIndex != -1,
//         'not available index of selectionListHour in SpinnerSelector');
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
//       width: dialogWidth,
//       height: dialogHeight,
//       child: Column(
//         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           asSizedBox(width: tm.s24),
//           _head(),
//           asSizedBox(height: 18),
//           dividerBig(),
//           asSizedBox(height: 18),
//           _main(),
//           asSizedBox(height: 18),
//           dialogButton(context),
//         ],
//       ),
//     );
//   }
//
//   //----------------------------------------------------------------------------
//   //다이얼로그 제목
//   //----------------------------------------------------------------------------
//   Widget _head() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         asSizedBox(width: tm.s24),
//         TextN(
//           '날짜를 선택해주세요',
//           fontSize: tm.s20,
//           color: tm.black,
//         ),
//         InkWell(
//           onTap: (() {
//             Get.back();
//           }),
//           child: Icon(
//             Icons.close,
//             size: tm.s24,
//           ),
//         ),
//       ],
//     );
//   }
//
//   //----------------------------------------------------------------------------
//   //다이얼로그의 메인 내용
//   //----------------------------------------------------------------------------
//   Widget _main() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         //--------------------------------------------------------------------
//         // '년' spinner picker
//         //--------------------------------------------------------------------
//         Column(
//           children: [
//             Text(
//               '년',
//               style: TextStyle(
//                 fontSize: tm.s20,
//               ),
//             ),
//             Container(
//               width: spinnerPickerWidth,
//               height: spinnerPickerHeight,
//               decoration: BoxDecoration(color: tm.white),
//               child: CupertinoPicker.builder(
//                   scrollController:
//                       FixedExtentScrollController(initialItem: yearIndex),
//                   itemExtent: itemExtent,
//                   // item의 height
//                   childCount: selectionListYear.length,
//                   onSelectedItemChanged: (index) {
//                     //setState(() {});
//                     selectedYear = selectionListYear[index];
//                   },
//                   itemBuilder: (context, index) {
//                     return Text(
//                       selectionListYear[index].toString(),
//                       style: TextStyle(
//                         color: tm.grey05,
//                         fontSize: spinnerPickerItemFontSize,
//                         height: 1.3,
//                       ),
//                     );
//                   }),
//             ),
//           ],
//         ),
//
//         //--------------------------------------------------------------------
//         // '월' spinner picker
//         //--------------------------------------------------------------------
//         Column(
//           children: [
//             Text(
//               '월',
//               style: TextStyle(
//                 fontSize: tm.s20,
//               ),
//             ),
//             Container(
//               width: spinnerPickerWidth,
//               height: spinnerPickerHeight,
//               decoration: BoxDecoration(color: tm.white),
//               child: CupertinoPicker.builder(
//                   scrollController:
//                       FixedExtentScrollController(initialItem: monthIndex),
//                   itemExtent: itemExtent,
//                   // item의 height
//                   childCount: selectionListMonth.length,
//                   onSelectedItemChanged: (index) {
//                     selectedMonth = selectionListMonth[index];
//                   },
//                   itemBuilder: (context, index) {
//                     return Text(
//                       selectionListMonth[index].toString(),
//                       style: TextStyle(
//                         color: tm.grey05,
//                         fontSize: spinnerPickerItemFontSize,
//                         height: 1.3,
//                       ),
//                     );
//                   }),
//             ),
//           ],
//         ),
//
//         //--------------------------------------------------------------------
//         // '일' spinner picker
//         //--------------------------------------------------------------------
//         Column(
//           children: [
//             Text(
//               '일',
//               style: TextStyle(
//                 fontSize: tm.s20,
//               ),
//             ),
//             Container(
//               width: spinnerPickerWidth,
//               height: spinnerPickerHeight,
//               decoration: BoxDecoration(color: tm.white),
//               child: CupertinoPicker.builder(
//                   scrollController:
//                       FixedExtentScrollController(initialItem: dayIndex),
//                   itemExtent: itemExtent,
//                   // item의 height
//                   childCount: selectionListDay.length,
//                   onSelectedItemChanged: (index) {
//                     selectedDay = selectionListDay[index];
//                   },
//                   itemBuilder: (context, index) {
//                     return Text(
//                       selectionListDay[index].toString(),
//                       style: TextStyle(
//                         color: tm.grey05,
//                         fontSize: spinnerPickerItemFontSize,
//                         height: 1.3,
//                       ),
//                     );
//                   }),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   //----------------------------------------------------------------------------
//   // 다이얼로그 버튼
//   //----------------------------------------------------------------------------
//   Widget dialogButton(context) {
//     return InkWell(
//       child: Container(
//         alignment: Alignment.center,
//         width: asWidth(Get.width * 0.3),
//         height: asHeight(36),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(asHeight(18)),
//             border:
//                 Border.all(width: asWidth(2), color: tm.softBlue)),
//         child: TextN(
//           '확인',
//           fontSize: tm.s16,
//           color: tm.mainBlue,
//         ),
//       ),
//       onTap: () {
//         results.add(selectedYear);
//         results.add(selectedMonth);
//
//         //선택된 날짜의 유효성 검사 및 날짜를 유효한 값으로 변환 (2월 31일처럼 존재하지 않는 날짜일 경우때문)
//         var date = DateTime(selectedYear, selectedMonth, selectedDay);
//         if (selectedMonth != date.month) {
//           selectedDay = (DateTime(selectedYear, selectedMonth + 1, 0)).day;
//         }
//         results.add(selectedDay);
//         assert(results.length == 3,
//             'not available enableNumber in SpinnerSelector. results.length=${results.length}');
//         // 선택한 값을 callback 함수에 전달
//         widget.onSelected(results);
//         Navigator.pop(context);
//       },
//     );
//   }
// }
