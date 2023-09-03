import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//==============================================================================
// bottom sheet (상부 원형)
//==============================================================================
openBottomSheetBasic({
  required Widget child,
  double height = 200,
  bool isDismissible = true,
  bool isScrollControlled = true,
  bool enableDrag = true,
  bool isHeadView = false,
  bool existDeleteIcon = false,
  bool hideCloseButton = false,
  String headTitle = '제목',
  double? titleTopMargin,
  double? titleBottomMargin,
}) async {
  await Get.bottomSheet(
    SizedBox(
      height: height, //Get.height * 0.8,
      child: isHeadView
          ? (existDeleteIcon
              ? _bottomSheetWithHeadAndDeleteIcon(
                  title: headTitle,
                  hideCloseButton: hideCloseButton,
                  titleTopMargin: titleTopMargin ?? asHeight(10),
                  titleBottomMargin: titleBottomMargin ?? asHeight(10),
                  child: child,
                )
              : _bottomSheetWithHead(
                  title: headTitle,
                  hideCloseButton: hideCloseButton,
                  titleTopMargin: titleTopMargin ?? asHeight(10),
                  titleBottomMargin: titleBottomMargin ?? asHeight(10),
                  child: child,
                ))
          : child,
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
    Widget child = const SizedBox(),
    bool hideCloseButton = false,
    double titleTopMargin = 10,
    double titleBottomMargin = 10}) {
  return Column(
    children: [
      //------------------------------------------------------------------------
      // head
      //------------------------------------------------------------------------
      Container(
        // 여유공간
        margin: EdgeInsets.only(
          top: titleTopMargin,
          left: asWidth(8),
          right: asWidth(8),
          bottom: titleBottomMargin,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: TextN(
                title,
                fontSize: tm.s14,
                color: tm.grey04,
                // fontWeight: FontWeight.bold,
              ),
            ),
            //------------------------------------------------------------------
            // 닫기 버튼
            if (hideCloseButton != true)
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(asWidth(10)),
                  onTap: (() {
                    Get.back();
                  }),
                  child: Container(
                    width: asWidth(44),
                    height: asHeight(44),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close,
                      size: asHeight(24),
                      color: tm.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      // dividerBig(),
      //------------------------------------------------------------------------
      // child
      //------------------------------------------------------------------------
      child,
    ],
  );
}

Widget _bottomSheetWithHeadAndDeleteIcon(
    {String title = '제목',
    Widget child = const SizedBox(),
    bool hideCloseButton = false,
    double titleTopMargin = 10,
    double titleBottomMargin = 10}) {
  return Column(
    children: [
      //------------------------------------------------------------------------
      // head
      //------------------------------------------------------------------------
      Container(
        // 여유공간
        margin: EdgeInsets.only(
          top: titleTopMargin,
          left: asWidth(8),
          right: asWidth(8),
          bottom: titleBottomMargin,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: TextN(
                title,
                fontSize: tm.s14,
                color: tm.grey04,
                // fontWeight: FontWeight.bold,
              ),
            ),
            //------------------------------------------------------------------
            // 삭제 아이콘 버튼
            Align(
              alignment: Alignment.topRight,
              child: wButtonGeneral(
                onTap: () async {
                  openPopupBasicButton(
                    width: asWidth(250),
                    height: asHeight(200),
                    title: '사진 삭제',
                    text: '사진을 삭제 하시겠습니까?',
                    buttonNumber: 2,
                    buttonTitleList: ['확인', '취소'],
                    buttonTitleColorList: [tm.white, tm.mainBlue],
                    buttonBackgroundColorList: [tm.mainBlue, tm.softBlue],
                    callbackList: [
                      () async {
                        Get.back();
                        deletePicture();
                        Get.back();
                      },
                      () {
                        Get.back();
                      }
                    ],
                  );
                },
                isViewBorder: false,
                borderColor: Colors.transparent,
                height: asHeight(24),
                width: asWidth(48),
                touchHeight: asHeight(40),
                touchWidth: asWidth(48),
                child: Container(
                  width: asWidth(16),
                  height: asHeight(24),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/icons/ic_delete2.png',
                    fit: BoxFit.scaleDown,
                    height: asHeight(24),
                    color: tm.grey03,
                  ),
                ),
              ),
            ),

            //------------------------------------------------------------------
            // 닫기 버튼
            // if (hideCloseButton != true)
            //   Align(
            //     alignment: Alignment.topRight,
            //     child: InkWell(
            //       borderRadius: BorderRadius.circular(asWidth(10)),
            //       onTap: (() {
            //         Get.back();
            //       }),
            //       child: Container(
            //         width: asWidth(44),
            //         height: asHeight(44),
            //         alignment: Alignment.center,
            //         child: Icon(
            //           Icons.close,
            //           size: asHeight(24),
            //           color: tm.black,
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
      // dividerBig(),
      //------------------------------------------------------------------------
      // child
      //------------------------------------------------------------------------
      child,
    ],
  );
}

//==============================================================================
// bottom sheet (상부 네모) - sheet 밖 클릭 방법 못 찾음 - 이 프로젝트에서 사용 안함
//==============================================================================
openBottomSheetSquare(BuildContext context,
    {required Widget child, double height = 200}) {
  showModalBottomSheet(
    //showMaterialModalBottomSheet(
    context: context,
    builder: (context) => child,
    isDismissible: false,
    barrierColor: Colors.transparent,
    backgroundColor: tm.mainBlue,
  );
}
