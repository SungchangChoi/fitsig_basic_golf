import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 근육 선택
//==============================================================================
Widget singleSpinnerPicker({
  required Function(int) callbackOnTap,
  int idxInitial = 0,
  List<String> itemTextList = const [''],
  double width = 300,
  double height = 200,
}) {
  int idxPresent = 0;
  return SizedBox(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //_head(),
        Column(
          children: [
            asSizedBox(height: 10),
            Container(
              width: asWidth(70),
              height: asHeight(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: tm.grey02),
            ),
            asSizedBox(height: 20),
            //----------------------------------------------------------------------
            // spinner
            //----------------------------------------------------------------------
            spinnerBasic(
              width: width,
              //asWidth(324),
              //360-36
              height: height,
              //asHeight(300),
              //tm.s30 * 7,
              itemHeight: asHeight(40),
              //tm.s40,
              backgroundColor: Colors.transparent,
              //tm.grey01,
              onSelectedItemChanged: (index) {
                idxPresent = index;
              },
              childCount: itemTextList.length,
              initialItem: idxInitial,
              fontSize: tm.s20,
              textColor: tm.grey04,
              itemTextList: itemTextList,
            ),
          ],
        ),
        Column(
          children: [
            // asSizedBox(height: 20),
            textButtonI(
                title: '확인',
                width: asWidth(324),
                height: asHeight(52),
                radius: asHeight(8),
                fontSize: tm.s16,
                fontWeight: FontWeight.bold,

                // touchWidth: asWidth(120),
                // touchHeight: asHeight(60),
                onTap: (() {
                  callbackOnTap(idxPresent);
                })),
            asSizedBox(height: 20),
          ],
        ), // onTap(idxPresent)),
      ],
    ),
  );
}

//==============================================================================
//다이얼로그 제목
//==============================================================================
Widget _head({String title = '제목'}) {
  return Container(
    // 여유공간
    margin: EdgeInsets.only(
      top: asHeight(10),
      left: asWidth(8),
      right: asWidth(8),
      bottom: asHeight(10),
    ),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: TextN(
            title,
            fontSize: tm.s20,
            color: tm.grey04,
            fontWeight: FontWeight.w600,
          ),
        ),
        //----------------------------------------------------------------------
        // 닫기 버튼
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            borderRadius: BorderRadius.circular(asWidth(10)),
            onTap: (() {
              Get.back();
            }),
            child: Container(
              width: asWidth(56),
              height: asHeight(56),
              alignment: Alignment.center,
              child: Icon(
                Icons.close,
                size: asHeight(36),
                color: tm.grey03,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
