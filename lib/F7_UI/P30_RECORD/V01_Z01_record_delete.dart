import '/F0_BASIC/common_import.dart';

//==============================================================================
// bottom sheet
//==============================================================================
openBottomSheetRecordDelete(
  BuildContext context,
) {
  // 모든 체크박스 초기화
  _ListDelete.isSelectedTotalList.value = false;
  _ListDelete.isSelectedList =
      List.generate(gvRecord.totalNumOfRecord.value, (index) => false.obs);

  openBottomSheetBasic(
    height: Get.height - asHeight(40),
    child: _recodeDelete(context),
    enableDrag: false,
  );
}

//==============================================================================
// 기록 삭제 페이지
//==============================================================================
Widget _recodeDelete(BuildContext context) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      //------------------------------------------------------------------------
      // 기본 내용
      //------------------------------------------------------------------------
      Column(
        children: [
          //--------------------------------------------------------------------
          // head
          //--------------------------------------------------------------------
          _head(),
          //--------------------------------------------------------------------
          // body
          //--------------------------------------------------------------------
          _ListDelete().listTitle(context),
          dividerBig(),
          _ListDelete()._listDeleteBoxes(context),
        ],
      ),
      //------------------------------------------------------------------------
      // 하단 삭제버튼 시트 (1개 이상 선택되면 나타남)
      //------------------------------------------------------------------------
      _deleteSheet(context),
    ],
  );
}

//==============================================================================
// head
//==============================================================================
Widget _head() {
  return Container(
    // 여유공간
    margin:
        EdgeInsets.only(top: asHeight(10), left: asWidth(8), right: asWidth(8)),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        //----------------------------------------------------------------------
        // 제목
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: asWidth(220),
            child: AutoSizeText(
              gv.dbMuscleIndexes[gv.control.idxMuscle.value].muscleName,
              maxLines: 2,
              style: TextStyle(
                fontSize: tm.s20,
                color: tm.grey04,
                fontWeight: FontWeight.w600,

              ),
              textAlign: TextAlign.center,
            ),
            // TextN(
            //   gv.dbMuscleIndexes[gv.control.idxMuscle.value].muscleName,
            //   fontSize: tm.s20,
            //   color: tm.grey04,
            //   fontWeight: FontWeight.w600,
            // ),
          ),
        ),
        //----------------------------------------------------------------------
        // 닫기 x 버튼
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            borderRadius: BorderRadius.circular(asHeight(10)),
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

//==============================================================================
// list 삭제 클래스 - 변수 공유목적
//==============================================================================
class _ListDelete {
  static RxBool isSelectedTotalList = false.obs;
  static List<RxBool> isSelectedList = [];

  //----------------------------------------------------------------------------
  // list delete title
  //----------------------------------------------------------------------------
  Widget listTitle(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      margin: EdgeInsets.only(
          top: asHeight(0),
          bottom: asHeight(5),
          left: asWidth(8),
          right: asWidth(8)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //--------------------------------------------------------------
                // icon and title
                Obx(() {
                  int listTotalNum = gvRecord.totalNumOfRecord.value;
                  return Row(
                    children: [
                      //-------------------------------- 아이콘
                      InkWell(
                        borderRadius: BorderRadius.circular(tm.s12),
                        onTap: (() {
                          isSelectedTotalList.value =
                              !isSelectedTotalList.value;

                          //----------------------------------------------------
                          // 전체 리스트가 선택 된 경우
                          //----------------------------------------------------
                          if (isSelectedTotalList.value) {
                            //--------------------------------------------------
                            // 모든 레코드 기록 중에서 (기록은 근육별로 구분되어 있지 않음)
                            //--------------------------------------------------
                            for (int n = 0; n < listTotalNum; n++) {
                              //------------------------------------------------
                              // 현재 근육애 해당하는 기록이라면 모두 체크
                              if (gv.dbRecordIndexes[n].idxMuscle ==
                                  gv.control.idxMuscle.value) {
                                _ListDelete.isSelectedList[n].value = true;
                              }
                              //------------------------------------------------
                              // 다른 근육 기록인 경우 체크 안함
                              else {
                                _ListDelete.isSelectedList[n].value = false;
                              }
                            }
                          }
                          //----------------------------------------------------
                          // 전체 리스트가 해제된 경우 모두 해제
                          //----------------------------------------------------
                          else {
                            for (int n = 0; n < listTotalNum; n++) {
                              _ListDelete.isSelectedList[n].value = false;
                            }
                          }
                        }),
                        child: Container(
                          width: asWidth(104),
                          height: asHeight(54),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: asHeight(24),
                                color: isSelectedTotalList.value
                                    ? tm.mainBlue
                                    : tm.grey03,
                              ),
                              //-------------------------------- 제목
                              TextN(
                                ' ' + '전체선택'.tr,
                                fontSize: tm.s16,
                                color: isSelectedTotalList.value
                                    ? tm.black
                                    : tm.grey04,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),

                      TextN(
                        '    (' '총'.tr +
                            ' ${gv.control.numOfRecordPresentMuscle.value}' +
                            '개'.tr +
                            ')',
                        fontSize: tm.s16,
                        color: isSelectedTotalList.value ? tm.black : tm.grey04,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  );
                }),
                //--------------------------------------------------------------
                // 삭제하기 상세 옵션 팝업
                // 날짜를 정한 후 이전 이후 삭제하기 기능
                InkWell(
                  onTap: (() {
                    openPopupBasic(
                      recordListDeleteAdvanced(context),
                      // backgroundColor: tm.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(asWidth(20)),
                      ),
                    );
                  }),
                  borderRadius: BorderRadius.circular(asHeight(27)), //클릭되는 모양
                  child: Container(
                    width: asWidth(74),
                    height: asHeight(54),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/icons/ic_edit_filter.png',
                      fit: BoxFit.scaleDown,
                      color: tm.grey03,
                      // height: asHeight(34),
                      width: asWidth(54),
                      // color: Colors.lightGreenAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  // list 박스 나열하기
  //----------------------------------------------------------------------------
  Widget _listDeleteBoxes(BuildContext context) {
    return Obx(() {
      int listTotalNum = gvRecord.totalNumOfRecord.value;
      int count = gv.control.numOfRecordPresentMuscle.value + 1;
      return Expanded(
        child: SingleChildScrollView(
          //controller: controller,
          child: Column(
            children: List<Widget>.generate(
              gvRecord.totalNumOfRecord.value,
              ((index) {
                //----------------------------------------------------------------
                // 현재 선택된 근육과 같은 리스트라면
                if (gv.dbRecordIndexes[listTotalNum - index - 1].idxMuscle ==
                    gv.control.idxMuscle.value) {
                  // return _recordDeleteBox(context, index: index, deleteMode: true);
                  count--;
                  //--------------------------------------------------------------
                  // 리스트 내용 간단 보기 상태라면
                  if (gvRecord.isViewListSimple.value) {
                    return Row(
                      children: [
                        // asSizedBox(width: 8),
                        _listCheckBox(listTotalNum - index - 1),
                        // asSizedBox(width: 10),
                        SizedBox(
                          width: asWidth(300),
                          child: FittedBoxN(
                            child: simpleRecordTitleBox(
                                index: listTotalNum - index - 1,
                                count: count,
                                isDeleteMode: true),
                          ),
                        ),
                        asSizedBox(width: 10),
                      ],
                    );
                  }
                  //--------------------------------------------------------------
                  // 리스트 내용 상세 보기 상태라면
                  else {
                    return Row(
                      children: [
                        // asSizedBox(width: 8),
                        _listCheckBox(listTotalNum - index - 1),
                        // asSizedBox(width: 10),
                        SizedBox(
                          width: asWidth(300),
                          child: FittedBoxN(
                            child: detailRecordTitleBox(
                                index: listTotalNum - index - 1,
                                count: count,
                                isDeleteMode: true),
                          ),
                        ),
                      ],
                    );
                  }
                }
                //----------------------------------------------------------------
                // 현재 선택된 근육과 다른 리스트라면 표시 안함
                else {
                  return Container();
                }
              }),
            ),
          ),
        ),
      );
    });
  }

  //----------------------------------------------------------------------------
  // 레코드 삭제 체크 박스
  //----------------------------------------------------------------------------
  Widget _listCheckBox(int index) {
    return Obx(() {
      return InkWell(
        borderRadius: BorderRadius.circular(asWidth(10)),
        onTap: (() {
          isSelectedList[index].value = !isSelectedList[index].value;
        }),
        child: Container(
          width: asWidth(54),
          height: asHeight(54),
          alignment: Alignment.center,
          child: Icon(
            Icons.check_circle,
            size: asHeight(24), //asWidth(25),
            color: isSelectedList[index].value ? tm.mainBlue : tm.grey03,
            // _isSelectedList
          ),
        ),
      );
    });
  }
}

//==============================================================================
// 하단 삭제 버튼 시트
//==============================================================================
Widget _deleteSheet(BuildContext context) {
  return Obx(() {
//----------------- 삭제 할 목록 수 계산
    int deleteNumber = 0;
    RxBool refresh = false.obs; //애니메이션 갱신용

    for (int n = 0; n < gvRecord.totalNumOfRecord.value; n++) {
      if (_ListDelete.isSelectedList[n].value == true) {
        deleteNumber++;
      }
    }

    if (deleteNumber > 0) {
      refresh.value = true;
    } else {
      refresh.value = false;
    }
    //--------------------------------------------------------------------------
    // 상하좌우에서 나타나는 애니메이션
    return AnimationSheet(
      direction: 0,
      //0 : 밑에서 위로 올라오는 sheet
      width: Get.width,
      height: asHeight(110),
      //위젯 높이와 일체되게
      durationMs: 200,
      isView: refresh,
      child: _deleteSheetBox(
        context,
        height: asHeight(110),
        deleteNumber: deleteNumber,
      ),
    );
  });
}

//==============================================================================
// 하단 삭제 버튼
//==============================================================================
Widget _deleteSheetBox(BuildContext context,
    {int deleteNumber = 0, double height = 90}) {
  return Material(
    child: Ink(
      color: tm.mainBlue,
      child: InkWell(
        focusColor: tm.white,
        onTap: (() async {
          //------------------------------------------------------------
          // 측정 종료 명령 - 중복클릭 방지
          // var _dialog = openPopupProcessIndicator(
          //   context,
          //   text: '삭제 중입니다',
          // );
          //------------------------------------------------------------
          // 삭제 명령
          for (int n = 0; n < gvRecord.totalNumOfRecord.value; n++) {
            if (_ListDelete.isSelectedList[n].value == true) {
              // print('삭제되는 index $n');
              await deleteRecordData(n);
            }
          }

          // //------------------------------------------------------------
          // // 다이올로그 닫기
          // Navigator.pop(context, _dialog);

          // 모든 체크박스 초기화
          _ListDelete.isSelectedTotalList.value = false;
          // 삭제된 것을 반영한 개별 체크박스 재 생성
          _ListDelete.isSelectedList = List.generate(
              gvRecord.totalNumOfRecord.value, (index) => false.obs);

          //------------------------------------------------------------
          // 삭제 완료
          // Get.back();
        }),
        child: SizedBox(
          height: asHeight(height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // asSizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //------------------------------- 선택 항목 수
                  Container(
                    alignment: Alignment.center,
                    width: asHeight(40),
                    height: asHeight(40),
                    decoration: BoxDecoration(
                        color: tm.white,
                        borderRadius: BorderRadius.circular(asHeight(20))),
                    child: TextN(
                      '$deleteNumber',
                      fontSize: tm.s24,
                      color: tm.mainBlue,
                    ),
                  ),
                  asSizedBox(width: 12),
                  //------------------------------- 삭제 글
                  TextN(
                    '선택 삭제',
                    fontSize: tm.s24,
                    color: tm.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

//==============================================================================
// bottom sheet : 영역 밖 선택이 안되어 취소
//==============================================================================
// openBottomSheetDeleteButton(
//   BuildContext context,
// ) {
//   //----------------- 삭제 할 목록 수 계산
//   int deleteNumber = 0;
//
//   for (int n = 0; n < gvRecord.totalNumOfRecord.value; n++) {
//     if (_ListDelete.isSelectedList[n].value == true) {
//       deleteNumber++;
//     }
//   }
//   //
//   // if (deleteNumber == 0){
//   //   Get.back(); //목록이 없으면 창 닫기
//   // }
//   //
//   //----------------- bottom sheet 열기
//   openBottomSheetSquare(
//     context,
//     height: asHeight(120),
//     child: _deleteSheetBox(deleteNumber: deleteNumber),
//   );
// }
