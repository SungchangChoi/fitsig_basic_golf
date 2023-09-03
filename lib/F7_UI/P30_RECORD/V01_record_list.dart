import 'package:flutter/gestures.dart';

import '/F0_BASIC/common_import.dart';

//==============================================================================
// record list main
//==============================================================================
Widget recordList(context) {
  gvRecord.isToGoEnd.value = false; //리스트 최근 항목으로 보여주기
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //----------------------------------------------------------------
        // 상단 타이틀
        asSizedBox(height: 30),
        Container(
            width: double.maxFinite, height: asHeight(10), color: tm.grey01),
        asSizedBox(height: 10),
        _listTitle(context),
        //----------------------------------------------------------------
        // 하단 리스트
        asSizedBox(height: 30),
        listRecordsScroll(),
      ],
    ),
  );
}

//==============================================================================
// 근육 확장형 선택
//==============================================================================
Widget _listTitle(context) {
  //---------------------------------------------------------------------------
  // 현재 근육과 관련 된 기록 수 카운트 하기
  int count = 0;
  for (int n = 0; n < gvRecord.totalNumOfRecord.value; n++) {
    if (gv.dbRecordIndexes[n].idxMuscle == gv.control.idxMuscle.value) {
      count++;
    }
  }
  gv.control.numOfRecordPresentMuscle.value = count;

  return Column(
    children: [
      //------------------------------------------------------------------------
      // 숫자 및 기록 삭제
      //------------------------------------------------------------------------
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //------------------------------ 리스트 숫자
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              asSizedBox(width: 18),
              Obx(() {
                int count = gv.control.numOfRecordPresentMuscle.value;
                return TextN(
                  '총'.tr + ' $count' + '개'.tr,
                  fontSize: tm.s16,
                  color: tm.grey03,
                  fontWeight: FontWeight.w400,
                );
              }),
            ],
          ),
          //------------------------------ 버튼

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //----------------------------------------------------------------
              // 삭제 모드로 들어가기 - 테스트용
              textButtonBasic(
                  width: asWidth(83),
                  height: asHeight(36),
                  touchWidth: asWidth(93),
                  touchHeight: asHeight(56),
                  title: '기록삭제',
                  textColor: tm.grey03,
                  borderColor: tm.grey02,
                  fontSize: tm.s16,
                  onTap: (() {
                    openBottomSheetRecordDelete(context);
                  })),
              asSizedBox(width: 13),
            ],
          ),
        ],
      ),
      //------------------------------------------------------------------------
      // 간략보기, 맨끝으로, 최근으로
      //------------------------------------------------------------------------
      asSizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // asSizedBox(width: 18),
              //----------------------------------------------------------------
              // 간략보기 버튼
              Obx(() {
                return InkWell(
                  onTap: (() {
                    gvRecord.isViewListSimple.value =
                        !gvRecord.isViewListSimple.value;
                    gv.spMemory.write(
                        'isViewListSimple', gvRecord.isViewListSimple.value);
                  }),
                  borderRadius: BorderRadius.circular(asHeight(20)),
                  child: Container(
                    width: asWidth(104),
                    height: asHeight(46),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //-------------------------------- 아이콘
                        Icon(
                          Icons.check_circle,
                          size: tm.s20,
                          color: gvRecord.isViewListSimple.value
                              ? tm.mainBlue
                              : tm.grey03,
                        ),
                        //-------------------------------- 제목
                        TextN(
                          ' ' + '간략보기'.tr,
                          fontSize: tm.s16,
                          color: gvRecord.isViewListSimple.value
                              ? tm.black
                              : tm.grey03,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
          //----------------------------------------------------------------
          // 최근으로, 맨끝으로 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //--------------------------------맨 끝으로 버튼
              InkWell(
                onTap: (() {
                  gvRecord.isToGoEnd.value = true;
                  RefreshRecordList.list(); //스크롤 갱신
                }),
                borderRadius: BorderRadius.circular(asHeight(23)),
                child: Container(
                  width: asWidth(84),
                  height: asHeight(46),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_double_arrow_down,
                        size: tm.s20,
                        color: tm.grey03,
                      ),
                      TextN(
                        '맨끝으로'.tr,
                        fontSize: tm.s16,
                        color: tm.grey03,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: tm.s16,
                width: 1,
                color: tm.grey02,
                // margin: EdgeInsets.symmetric(horizontal: tm.s6),
              ),
              //--------------------------------최근으로 버튼
              InkWell(
                onTap: (() {
                  gvRecord.isToGoEnd.value = false;
                  RefreshRecordList.list(); //스크롤 갱신
                }),
                borderRadius: BorderRadius.circular(asHeight(23)),
                child: Container(
                  width: asWidth(84),
                  height: asHeight(46),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_double_arrow_up,
                        size: tm.s20,
                        color: tm.grey03,
                      ),
                      TextN(
                        '최근으로'.tr,
                        fontSize: tm.s16,
                        color: tm.grey03,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
              asSizedBox(width: 10),
            ],
          ),
        ],
      ),
    ],
  );
}

// Widget _listRecords() {
//   ScrollController _controller = ScrollController();
//   return Obx(() {
//     int refresh = _refreshList.value;
//     int listTotalNum = gvRecord.totalNumOfRecord.value;
//     int count = gv.control.numOfRecordPresentMuscle.value + 1;
//     //----------------------------------------------------
//     // 위치 변경
//     // if (gvRecord.isToGoEnd.value == true) {
//     //   // _controller.position.maxScrollExtent;
//     //   _controller.jumpTo(0.0);
//     // }
//     // else{
//     //   // _controller.position.minScrollExtent;
//     //   // _controller.jumpTo(0.0);
//     // }
//     return Expanded(
//       child: Scrollbar(
//         child: SingleChildScrollView(
//           controller: _controller,
//           reverse: gvRecord.isToGoEnd.value == true ? true : false,
//           // scrollDirection: Axis.horizontal,
//           // dragStartBehavior: DragStartBehavior.start,
//           child: Column(
//               children: List<Widget>.generate(
//             listTotalNum,
//             ((index) {
//               //----------------------------------------------------------------
//               // 현재 선택된 근육과 같은 리스트라면
//               if (gv.dbRecordIndexes[listTotalNum - index - 1].idxMuscle ==
//                   gv.control.idxMuscle.value) {
//                 count--;
//                 //--------------------------------------------------------------
//                 // 리스트 내용 간단 보기 상태라면
//                 if (gvRecord.isViewListSimple.value) {
//                   return simpleRecordTitleBox(
//                       index: listTotalNum - index - 1, count: count);
//                 }
//                 //--------------------------------------------------------------
//                 // 리스트 내용 상세 보기 상태라면
//                 else {
//                   return detailRecordTitleBox(
//                       index: listTotalNum - index - 1, count: count);
//                 }
//               }
//               //----------------------------------------------------------------
//               // 현재 선택된 근육과 다른 리스트라면 표시 안함
//               else {
//                 return Container();
//               }
//             }),
//           )),
//         ),
//       ),
//     );
//   });
// }
