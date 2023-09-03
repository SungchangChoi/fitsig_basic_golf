import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// main title
//==============================================================================
Widget textTitleMain(String title) {
  return Column(
    children: [
      asSizedBox(height: 15),
      Center(
          child: TextN(
        title,
        fontSize: tm.s24,
        color: tm.black,
        fontWeight: FontWeight.w600,
      )),
      asSizedBox(height: 15),
    ],
  );
}

//==============================================================================
// 대제목
//==============================================================================
Widget textTitleBig(String title) {
  return Column(
    children: [
      asSizedBox(height: 20),
      TextN(
        title,
        fontSize: tm.s16,
        color: tm.mainBlue,
        fontWeight: FontWeight.bold,
      ),
      asSizedBox(height: 10),
    ],
  );
}

//==============================================================================
// 소제목
//==============================================================================
Widget textTitleSmall(String title, {double padW = 0, double padH = 10}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padW),
    child: Column(
      children: [
        asSizedBox(height: 20 + padH),
        TextN(
          title,
          fontSize: tm.s14,
          color: tm.mainBlue,
          fontWeight: FontWeight.w900,
        ),
        asSizedBox(height: padH),
      ],
    ),
  );
}

//==============================================================================
// 내용
//==============================================================================
Widget textNormal(String text,
    {double padW = 0,
    double padH = 5,
    bool isBold = false,
    // bool isColorGrey4 = false,
    Color fontColor = Colors.transparent,
    double fontSize = 0}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padW),
    child: Column(
      children: [
        asSizedBox(height: padH),
        TextN(
          text,
          fontSize: fontSize == 0 ? tm.s14 : fontSize,
          color: fontColor == Colors.transparent ? tm.black : fontColor,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          // letterSpacing: 1.5,
          height: 1.5,
        ),
        asSizedBox(height: padH),
      ],
    ),
  );
}

//==============================================================================
// 내용
//==============================================================================
Widget textNormalC(String text, {Color color = Colors.black, double padW = 0}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padW),
    child: Column(
      children: [
        asSizedBox(height: 5),
        TextN(
          text,
          fontSize: tm.s16,
          color: tm.black,
          fontWeight: FontWeight.w400,
          // letterSpacing: 1.5,
          height: 1.5,
        ),
        asSizedBox(height: 5),
      ],
    ),
  );
}

//==============================================================================
// 들여쓰기
//==============================================================================
Widget textSub(String text,
    {double padW = 0,
      double padH = 5,
    bool isDot = false,
    bool isCheck = false,
    double fontSize = 0,
    Color fontColor = Colors.transparent}) {
  double _fontSize = fontSize == 0 ? tm.s14 : fontSize;
  Color _fontColor = fontColor == Colors.transparent ? tm.grey04 : fontColor;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padW),
    child: Column(
      children: [
        asSizedBox(height: padH),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //-------------------------------------------------
            // check 이미지
            isCheck
                ? Container(
                    height: _fontSize * 1.5,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: asWidth(4)),
                    child: Image.asset('assets/icons/ic_check_14.png',
                        height: _fontSize, color: tm.mainBlue),
                  )
                //-------------------------------------------------
                // 도트나 선
                : Container(
                    alignment: Alignment.centerLeft,
                    width: asWidth(10),
                    child: TextN(
                      isDot ? '·' : '-',
                      fontSize: _fontSize,
                      color: _fontColor,
                      fontWeight: FontWeight.normal, //w400,
                      // letterSpacing: 1.5,
                      height: 1.5,
                    ),
                  ),
            Expanded(
              child: SizedBox(
                child: TextN(
                  text,
                  fontSize: _fontSize,
                  color: _fontColor,
                  fontWeight: FontWeight.normal, //w400,
                  // letterSpacing: 1.5,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
        asSizedBox(height: padH),
      ],
    ),
  );
}

//==============================================================================
// 이미지
//==============================================================================
Widget textImage(String path,
    {double height = 100, String text = '', BoxFit fit = BoxFit.scaleDown}) {
  return SizedBox(
    width: double.maxFinite,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        asSizedBox(height: 8),
        Image.asset(
          path,
          fit: fit,
          height: height,
        ),
        asSizedBox(height: 20),
        if (text.isNotEmpty)
          TextN(
            text,
            fontSize: tm.s12,
            color: tm.black,
            fontWeight: FontWeight.w400,
            height: 1.5,
            // letterSpacing: 1.5,
          ),
        asSizedBox(height: 20),
      ],
    ),
  );
}
