import '/F0_BASIC/common_import.dart';

//==============================================================================
// popup
//==============================================================================
openPopupBasicButton({
  double width = 300,
  double height = 230,
  required String title,
  required String text,
  int buttonNumber = 1,
  List<String> buttonTitleList = const ['확인'],
  List<Color> buttonTitleColorList = const [Colors.white],
  List<Color> buttonBackgroundColorList = const [Colors.blue],
  required List<GestureTapCallback> callbackList,
  bool showCancelButton = true,
  Color? backgroundColor,
  AlignmentGeometry? alignment,
  EdgeInsets? insetPadding,
}) {
  Get.dialog(
    AlertDialog(
      iconPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(vertical: asHeight(20), horizontal:asWidth(20) ),
        width:width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: asHeight(10)),
            //------------------------------------------------------------------
            // 제목
            //------------------------------------------------------------------
            TextN(
              title,
              fontSize: tm.s18,
              color: tm.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: asHeight(20)),
            //------------------------------------------------------------------
            // 내용(text)
            //------------------------------------------------------------------
            TextN(
              text,
              fontSize: tm.s14,
              color: tm.grey04,
              fontWeight: FontWeight.normal,
              height: 1.5,
            ),
            Expanded(child: SizedBox(height: asHeight(30))),
            //------------------------------------------------------------------
            // 버튼
            //------------------------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              List.generate(buttonNumber, (index) => textButtonI(
                width: (width-asWidth(40)-asWidth(8*(buttonNumber-1)))/buttonNumber,
                height: asHeight(44),
                radius: asHeight(8),
                backgroundColor: buttonBackgroundColorList[index],
                onTap: callbackList[index],
                title: buttonTitleList[index],
                textColor: buttonTitleColorList[index],
                fontSize: tm.s14,
                fontWeight: FontWeight.bold,
                borderColor: Colors.transparent,
              ),),
            )
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      alignment: alignment,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(asWidth(20)),
      ),
    ),
  );
}
