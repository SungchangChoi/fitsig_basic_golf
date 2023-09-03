import '/F0_BASIC/common_import.dart';

//==============================================================================
// popup
//==============================================================================
openPopupBasicVerticalButton({
  double width = 300,
  double height = 310,
  required String title,
  required String text,
  int buttonNumber = 1,
  List<String> buttonTitleList = const ['확인'],
  List<String> buttonDescription = const [''],
  List<Color> buttonTitleColorList = const [Colors.white],
  List<Color> buttonBackgroundColorList = const [Colors.blue],
  required List<GestureTapCallback> callbackList,
  bool showCancelButton = true,
  Color? backgroundColor,
  AlignmentGeometry? alignment,
  EdgeInsets? insetPadding,
}) async {
  await Get.dialog(
    AlertDialog(
      iconPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: asHeight(20), horizontal: asWidth(20)),
            width: width,
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
                Expanded(child: SizedBox(height: asHeight(10))),
                //------------------------------------------------------------------
                // 버튼
                //------------------------------------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    buttonNumber,
                    (index) => Column(
                      children: [
                        SizedBox(height: asHeight(8)),
                        Row(
                          children: [
                            textButtonI(
                              width: asWidth(155),
                              height: asHeight(44),
                              radius: asHeight(8),
                              backgroundColor: buttonBackgroundColorList[index],
                              onTap: callbackList[index],
                              title: buttonTitleList[index],
                              textColor: buttonTitleColorList[index],
                              fontSize: tm.s14,
                              fontWeight: FontWeight.bold,
                              borderColor: Colors.transparent,
                            ),
                            SizedBox(width: asWidth(5)),
                            FittedBoxN(
                                child: TextN(
                              buttonDescription[index],
                              fontSize: tm.s14,
                              color: tm.grey04,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                            )),
                          ],
                        ),
                        SizedBox(height: asHeight(8)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: asHeight(7),
            right: asWidth(7),
            child: InkWell(
              borderRadius: BorderRadius.circular(asWidth(5)),
              onTap: (() {
                Get.back();
              }),
              child: Container(
                width: asWidth(40),
                height: asWidth(40),
                alignment: Alignment.center,
                child: Icon(
                  Icons.close,
                  size: asWidth(20),
                  color: tm.grey03,
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: backgroundColor,
      alignment: alignment,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(asWidth(20)),
      ),
    ),
  );
}
