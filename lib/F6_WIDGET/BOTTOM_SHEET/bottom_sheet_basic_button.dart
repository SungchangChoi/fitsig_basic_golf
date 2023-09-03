import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// bottom sheet 구성
// - Title       - 닫기 버튼
//       - 텍스트
//  - 버튼       - (취소버튼)
//==============================================================================
openBottomSheetBasicButton({
  required double height,
  required String headTitle,
  bool isDismissible = true,
  bool isScrollControlled = true,
  bool enableDrag = true,
  bool hideCloseButton = false,
  double? titleTopMargin,
  double? titleBottomMargin,
  required String text,
  required String buttonTitle,
  required GestureTapCallback? onTap,
}) {
  Get.bottomSheet(
    SizedBox(
      height: height, //Get.height * 0.8,
      child: _bottomSheetWithHead(
        title: headTitle,
        hideCloseButton: hideCloseButton,
        titleTopMargin: titleTopMargin ?? asHeight(10),
        titleBottomMargin: titleBottomMargin ?? asHeight(10),
        text: text,
        buttonTitle: buttonTitle,
        onTap: onTap,
      ),
    ),
    isScrollControlled: isScrollControlled,
    enableDrag: enableDrag,
    backgroundColor: tm.white,
    isDismissible: isDismissible,
    // elevation: 100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(asHeight(30))),
    ),
  );
}

Widget _bottomSheetWithHead(
    {String title = '제목',
    required String text,
    required String buttonTitle,
    bool hideCloseButton = false,
    required GestureTapCallback? onTap,
    double titleTopMargin = 40,
    double titleBottomMargin = 20}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: asWidth(18), vertical: asHeight(18)),
    decoration: BoxDecoration(
        color: tm.white,
        borderRadius: BorderRadius.circular(asHeight(30))),
    child: Column(
      children: [
        //------------------------------------------------------------------------
        // head
        //------------------------------------------------------------------------
        SizedBox(
          height: asHeight(70),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //------------------------------------------------------------------
              // 제목
              //------------------------------------------------------------------
              Align(
                alignment: Alignment.center,
                child: TextN(
                  title,
                  fontSize: tm.s18,
                  color: tm.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //------------------------------------------------------------------
              // 닫기 버튼
              //------------------------------------------------------------------
              if (hideCloseButton != true)
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(asWidth(10)),
                    onTap: (() {
                      Get.back();
                    }),
                    child: Container(
                      width: asHeight(44),
                      height: asHeight(44),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close,
                        size: asWidth(20),
                        color: tm.grey03,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        //------------------------------------------------------------------------
        // 내용
        //------------------------------------------------------------------------
        Expanded(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------------------------------------------------------------
                //  버튼
                //------------------------------------------------------------------
                TextN(
                  text,
                  color: tm.grey04,
                  fontWeight: FontWeight.bold,
                  fontSize: tm.s14,
                  height: 1.5,
                ),
                Expanded(child: asSizedBox(height: 10)),
                //------------------------------------------------------------------
                //  버튼
                //------------------------------------------------------------------
                textButtonI(
                  width: asWidth(324),
                  height: asHeight(52),
                  radius: asHeight(8),
                  backgroundColor: tm.mainBlue,
                  onTap: onTap,
                  title: buttonTitle,
                  textColor: tm.fixedWhite,
                  fontSize: tm.s16,
                  fontWeight: FontWeight.bold,
                  borderColor: Colors.transparent,
                  borderLineWidth: asWidth(1),
                ),
                asSizedBox(height: 40)
              ],
            ),
          ),
        )
      ],
    ),
  );
}

//==============================================================================
// bottom sheet 구성
// - Title       - 닫기 버튼
//       - 위젯
//  - 버튼       - (취소버튼)
//==============================================================================
openBottomSheetBasicButtonWithWidget({
  required double height,
  required String headTitle,
  bool isDismissible = true,
  bool isScrollControlled = true,
  bool enableDrag = true,
  bool hideCloseButton = false,
  double? titleTopMargin,
  double? titleBottomMargin,
  required Widget child,
  required String buttonTitle,
  required GestureTapCallback? onTap,
}) {
  Get.bottomSheet(
    SizedBox(
      height: height, //Get.height * 0.8,
      child: _bottomSheetWithHeadAndWidget(
        title: headTitle,
        hideCloseButton: hideCloseButton,
        titleTopMargin: titleTopMargin ?? asHeight(10),
        titleBottomMargin: titleBottomMargin ?? asHeight(10),
        child: child,
        buttonTitle: buttonTitle,
        onTap: onTap,
      ),
    ),
    isScrollControlled: isScrollControlled,
    enableDrag: enableDrag,
    backgroundColor: tm.white,
    isDismissible: isDismissible,
    // elevation: 100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(asHeight(30))),
    ),
  );
}

Widget _bottomSheetWithHeadAndWidget(
    {String title = '제목',
      required Widget child,
      required String buttonTitle,
      bool hideCloseButton = false,
      required GestureTapCallback? onTap,
      double titleTopMargin = 40,
      double titleBottomMargin = 20}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: asWidth(18), vertical: asHeight(18)),
    decoration: BoxDecoration(
        color: tm.white,
        borderRadius: BorderRadius.circular(asHeight(30))),
    child: Column(
      children: [
        //------------------------------------------------------------------------
        // head
        //------------------------------------------------------------------------
        SizedBox(
          height: asHeight(70),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //------------------------------------------------------------------
              // 제목
              //------------------------------------------------------------------
              Align(
                alignment: Alignment.center,
                child: TextN(
                  title,
                  fontSize: tm.s18,
                  color: tm.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //------------------------------------------------------------------
              // 닫기 버튼
              //------------------------------------------------------------------
              if (hideCloseButton != true)
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(asWidth(10)),
                    onTap: (() {
                      Get.back();
                    }),
                    child: Container(
                      width: asHeight(44),
                      height: asHeight(44),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close,
                        size: asWidth(20),
                        color: tm.grey03,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        //------------------------------------------------------------------------
        // 내용
        //------------------------------------------------------------------------
        Expanded(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------------------------------------------------------------
                //  버튼
                //------------------------------------------------------------------
                child,
                Expanded(child: asSizedBox(height: 10)),
                //------------------------------------------------------------------
                //  버튼
                //------------------------------------------------------------------
                textButtonI(
                  width: asWidth(324),
                  height: asHeight(52),
                  radius: asHeight(8),
                  backgroundColor: tm.mainBlue,
                  onTap: onTap,
                  title: buttonTitle,
                  textColor: tm.fixedWhite,
                  fontSize: tm.s16,
                  fontWeight: FontWeight.bold,
                  borderColor: Colors.transparent,
                  borderLineWidth: asWidth(1),
                ),
                asSizedBox(height: 40)
              ],
            ),
          ),
        )
      ],
    ),
  );
}

