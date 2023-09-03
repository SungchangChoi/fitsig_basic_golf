import '/F0_BASIC/common_import.dart';

//-------------------------------------
// 구문 안에 if문 넣기
//-------------------------------------
// (() {
// // your code here
// }())

//-------------------------------------
// Obx 넣기
//-------------------------------------
// return Obx(() {});

//==============================================================================
// list double 형태의 데이터 별도 저장 (소수점 자리 수 제한)
//==============================================================================
class DbDataRecordContentsListDouble {
  List<double> emgData = const [];

  // DbDataRecordContentsListDouble();
  //------------------------ 저장용량 제한을 위해 소수점 제한하며 json 포맷으로 변환하기
  @override
  String toString() {
    return '{"data":[${listDoubleToStringAsFixed(emgData, 2)}]}';
  }
}

//==============================================================================
// list double 을 string 으로 변환 (쉼표로 구분)
//==============================================================================
String listDoubleToStringAsFixed(List<double> data, int fractionDigits) {
  String result = '';

  if (data.isNotEmpty) {
    result = data[0].toStringAsFixed(fractionDigits);
    for (int n = 1; n < data.length; n++) {
      result = result + ',' + data[n].toStringAsFixed(fractionDigits);
    }
  }
  return result;
}


//==============================================================================
// 데이터 베이스 - json 시험
//==============================================================================
void jsonTest(){
  //---------------------------------------
  // 자동 json 직렬화 테스트
  DbRecordContents tmp = DbRecordContents();
  tmp.emgData = [1.2, 3.141592, 2.223322];

  tmp.emgData = npFixed(tmp.emgData, 2); //저장 전에 꼭 실행 필요

  String jsonString = jsonEncode(tmp);
  var fromJsonMap = jsonDecode(jsonString);
  if (kDebugMode) {
    print(jsonString);
    print(fromJsonMap);
    print(jsonDecode('{}'));
  }
  //---------------------------------------
  // list double json 직렬화 테스트
  // DbDataRecordContentsListDouble tmpList = DbDataRecordContentsListDouble();
  // tmpList.emgData = [1,2,3,4];
  // String jsonList = tmpList.toString();//jsonEncode(tmpList);
  // var fromJsonListMap = jsonDecode(jsonList);
  // if (kDebugMode) {
  //   print(jsonList);
  //   print(fromJsonListMap);
  // }

  // DbDataRecordContents tmp = DbDataRecordContents();
  // String jsonString = jsonEncode(tmp.toJson());
  // String toString = tmp.toString();
  //
  // var fromJsonMap = jsonDecode(jsonString);
  // var fromString = jsonDecode(toString);
  //
  // if (kDebugMode) {
  //   print('=============================================================');
  //   print(jsonString);
  //   print(toString);
  //   print('-----------------------------------');
  //   print(fromJsonMap);
  //   print(fromString);
  // }

}

//
// // checkBoxRound(
// //   isChecked: _isSelectedTotalList,
// //   size: 20,
// //   onChanged: ((check) {
// //     _isSelectedTotalList.value = check;
// //   }),
// Obx(() {
// return checkBoxRound(
// isChecked: _isSelectedTotalList.value,
// size: 20,
// onChanged: ((bool? check) {
// _isSelectedTotalList.value = check!;
// // !_isSelectedTotalList.value;
// }),
// );
// }),
//
// Obx(() {
// return Container(
// height: 20,
// width: 20,
// // decoration: BoxDecoration(
// //   borderRadius: BorderRadius.circular(10),
// //   color: tm.grey03,
// // ),
// child: Checkbox(
// checkColor: tm.white,
// activeColor: tm.blue,
//
// value: _isSelectedTotalList.value,
// // size: 20,
// onChanged: ((bool? check) {
// _isSelectedTotalList.value = check!;
// }),
// shape: const CircleBorder(),
// ),
// );
// }),
//
// // Checkbox(
// //   checkColor: tm.white,
// //   activeColor: tm.blue,
// //   // fillColor: tm.blue,
// //   // fillColor: MaterialStateProperty.resolveWith(getColor),
// //   value:  _isSelectedTotalList.value,
// //   shape: const CircleBorder(),
// //   onChanged: ((check){_isSelectedTotalList.value = check!;}),
// // ),



//==============================================================================
// 근육 이름 변경
//==============================================================================
// Widget _muscleName(BuildContext context) {
//   return Obx(() {
//     int index = gv.control.idxMuscle.value;
//     int refresh = _refresh.value;
//     var textController = TextEditingController();
//         // text: gv.dbmMuscle.tData[index]['muscleName']);
//
//     var _muscleField = CupertinoTextField(
//       placeholder: '${gv.dbmMuscle.tData[index]['muscleName']}',
//       placeholderStyle: TextStyle(fontSize: tm.s16, color: tm.black),
//       padding: EdgeInsets.symmetric(horizontal: asHeight(16)),
//       controller: textController,
//       style: TextStyle(fontSize: tm.s16, color: tm.black),
//       textAlignVertical: TextAlignVertical.center,
//
//
//       decoration:  BoxDecoration(
//         color: Colors.transparent,
//         border: Border.all(width: 0),
//         // borderRadius: BorderRadius.circular(asHeight(12)),
//       ),
//     );
//
//     return Column(
//       children: [
//         //----------------------------------------------------------------------
//         // 근육 이름 변경
//         Container(
//           height: asHeight(48),
//           margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
//           decoration: BoxDecoration(
//             color: tm.grey02,
//             borderRadius: BorderRadius.circular(asHeight(12)),
//           ),
//           child: Row(
//             children: [
//               SizedBox(
//                 height: asHeight(48),
//                 width: asWidth(242),
//                 child: _muscleField,
//                 // alignment: Alignment.center,
//               ),
//               textButtonBasic(
//                 width: asWidth(62),
//                 height: asHeight(32),
//                 radius: asHeight(8),
//                 backgroundColor: tm.black.withOpacity(0.5),
//                 textColor: tm.white,
//                 isViewBorder: false,
//                 title: '변경',
//                 onTap: (() {
//                   // 새로은 이름 값 넣기
//                   gv.dbmMuscle.tData[index]['muscleName'] = textController.text;
//                   // map 파일 추출
//                   var mapData = gv.dbmMuscle.tData[index];
//                   // 데이터베이스 업데이트
//                   gv.dbmMuscle
//                       .updateDbRecordByIndex(index: index, mapData: mapData);
//                   // 화면 갱신
//                   _refresh++;
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   });
// }