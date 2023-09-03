import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
import 'package:flutter/cupertino.dart';

//----------------------------------------------------------------------------
// 다이얼로그 메인내용
//----------------------------------------------------------------------------
Widget spinnerBasic({
  double width = 200,
  double height = 600,
  Color backgroundColor = Colors.transparent,
  Color textColor = Colors.grey,
  Function(int)? onSelectedItemChanged,
  int childCount = 1,
  int initialItem = 0,
  double fontSize = 15,
  double itemHeight = 50,
  List<String> itemTextList = const ['text'],
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(asHeight(18)),
    ),
    child: CupertinoPicker.builder(
        scrollController: FixedExtentScrollController(initialItem: initialItem),
        itemExtent: itemHeight,
        childCount: childCount,
        onSelectedItemChanged: onSelectedItemChanged,
        // backgroundColor: backgroundColor,
        // diameterRatio: 1.1,
        // offAxisFraction: 1,
        // magnification: 1,
        squeeze: 1.1, //1.1

        // 선택 바의 색상 및 모양 (기술 안하면 쿠퍼티노 기본 값)
        // selectionOverlay: Container(
        //   decoration: BoxDecoration(
        //     color: tm.grey01, //.withOpacity(0.1),
        //     borderRadius: BorderRadius.circular(itemHeight/4),
        //   ),
        //  ),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            width: width*0.9,
            height: asHeight(30),
            // color: Colors.yellow,
            child:
            FittedBoxN(
              child: TextN(
                itemTextList[index],
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }),
  );
}
