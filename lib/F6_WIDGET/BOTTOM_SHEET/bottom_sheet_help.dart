import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// bottom sheet
//==============================================================================
openBottomSheetHelp(BuildContext context,
    {required Widget child, String title = '도움말 제목', double height = 200}) {
  Get.bottomSheet(
    SizedBox(
      height: height, //Get.height * 0.8,
      child: Column(
        children: [
          asSizedBox(height: 18),
          //--------------------------------------------------------------------
          // 도움말 상단
          //--------------------------------------------------------------------
          _helpHead(context),
          asSizedBox(height: 10),
          dividerSmall(),

          //--------------------------------------------------------------------
          // 도움말 제목
          //--------------------------------------------------------------------
          textTitleMain(title),
          //--------------------------------------------------------------------
          // 도움말 내용
          //--------------------------------------------------------------------
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: asWidth(20)),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true, //true,
    enableDrag: false,
    backgroundColor: tm.white,
    // elevation: 100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(asHeight(30))),
    ),
  );
}

//==============================================================================
// 도움말 상단
//==============================================================================
Widget _helpHead(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: asWidth(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        asSizedBox(width: 54),
        //------------------------------------------------------------------------
        // 기본 내용
        //------------------------------------------------------------------------
        TextN(
          '도움말',
          fontSize: tm.s18,
          color: tm.grey03,
        ),

        //------------------------------------------------------------------------
        // 하단 삭제버튼 시트 (1개 이상 선택되면 나타남)
        //------------------------------------------------------------------------
        textButtonG(
            title: '확인',
            // textColor: tm.blue,
            fontSize: tm.s16,
            // borderColor: tm.blue.withOpacity(0.3),
            width: asWidth(54),
            height: asHeight(36),
            onTap: (() {
              Get.back(); //창 닫기
            }))
      ],
    ),
  );
}
