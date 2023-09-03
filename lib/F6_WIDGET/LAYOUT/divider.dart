import '/F0_BASIC/common_import.dart';


//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// Line
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

//==============================================================================
// 항목 구분 선
//==============================================================================
Widget dividerSmall() {
  return Column(
    children: [
      Container(width: asWidth(324), height: asHeight(2), color: tm.grey01),
      //asSizedBox(height: 10),
    ],
  );
}

Widget dividerSmall2() {
  return Column(
    children: [
      Container(width: asWidth(324), height: asHeight(2), color: tm.grey01),
      //asSizedBox(height: 10),
    ],
  );
}

//==============================================================================
// 항목 구분 선 2
//==============================================================================
Widget dividerSmallThin() {
  return Column(
    children: [
      Container(width: asWidth(324), height: asHeight(1), color: tm.grey01),
      //asSizedBox(height: 10),
    ],
  );
}


//==============================================================================
// 영역 구분 선
//==============================================================================
Widget dividerBig() {
  return Column(
    children: [
      Container(height: asHeight(8), color: tm.grey01),
      //SizedBox(height: asHeight(10)),
    ],
  );
}
Widget dividerBig2() {
  return Column(
    children: [
      Container(height: asHeight(8), color: tm.grey02),
      //SizedBox(height: asHeight(10)),
    ],
  );
}