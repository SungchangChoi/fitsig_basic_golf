import '/F0_BASIC/common_import.dart';
import '/F7_UI/P30_RECORD/V02_Z02_stats_deletion.dart';

//==============================================================================
// record graph main
//==============================================================================
Widget recordStatsMain(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      //----------------------------------------------------------------
      // sub-menu view : 여러 메뉴 중 택일
      asSizedBox(height: 30),
      _dataSelection(context),

      // 데이터 종류 선택하는 메뉴와 아래 그래프 영역 사이의 경계를 그어주는 선을 그리는 용도인듯
      Container(width: double.maxFinite, height: 1, color: tm.grey02),
      asSizedBox(height: 30),

      //----------------------------------------------------------------
      // 하단 그래프
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          asSizedBox(width: 8),
          wButtonGeneral(
            onTap: () {
              gvRecord.isTrendLineOn.value = !(gvRecord.isTrendLineOn.value);
            },
            isViewBorder: false,
            borderColor: Colors.transparent,
            height: asHeight(30),
            width: asWidth(75),
            touchHeight: asHeight(50),
            touchWidth: asWidth(95),
            child:Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: asHeight(20),
                  width: asHeight(20),
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: asHeight(20),
                    color: gvRecord.isTrendLineOn.value ? tm.mainBlue : tm.grey02,
                  ),
                ),
                Container(
                  height: asHeight(25),
                  padding: EdgeInsets.symmetric(horizontal: asHeight(6)),
                  alignment: Alignment.centerLeft,
                  child: TextN(
                    '추세선보기',
                    fontSize: tm.s16,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          wButtonGeneral(
            onTap: () {
              openBottomSheetStatsDelete();
            },
            isViewBorder: false,
            borderColor: Colors.transparent,
            height: asHeight(30),
            width: asWidth(48),
            touchHeight: asHeight(50),
            touchWidth: asWidth(68),
            child: Row(
              children: [
                Container(
                  width: asWidth(16),
                  height: asHeight(30),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/icons/ic_delete.png',
                    fit: BoxFit.scaleDown,
                    height: asHeight(20),
                    color: tm.grey03,
                  ),
                ),
                SizedBox(
                  width: asWidth(26),
                  child: TextN(
                    '삭제',
                    fontWeight: FontWeight.bold,
                    fontSize: tm.s14,
                    color: tm.grey03,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: SizedBox(width: asHeight(90))),
          _graphTimePeriodExpand(context),
          asSizedBox(width: 8),
        ],
      ),
      SizedBox(height: asHeight(18)),
      statsGraph(context),
      SizedBox(height: asHeight(10)),
    ],
  );
}

//==============================================================================
// 통계 그래프 단위기간 확장형 선택
//==============================================================================
final List<String> timePeriodNameList = ['1주', '1개월', '3개월', '6개월', '1년'];

Widget _graphTimePeriodExpand(BuildContext context) {
  return wButtonAwSel(
    onTap: () {
      openBottomSheetBasic(
          height: gv.setting.isBigFont.value ? asHeight(420) : asHeight(380),
          child: graphTimePeriodSpinnerPicker());
    },
    height: asHeight(34),
    touchHeight: asHeight(54),
    padTouchWidth: asWidth(10),
    child: Obx(() => TextN(
          timePeriodNameList[
              GraphTimePeriod.values.indexOf(gvRecord.graphTimePeriod.value)],
          fontSize: tm.s14,
          fontWeight: FontWeight.bold,
          color: tm.black,
        )),
  );
}

//==============================================================================
// 통계 그래프 단위기간 확장형 클릭시 생성되는 bottom dialog widget
//==============================================================================
Widget graphTimePeriodSpinnerPicker() {
  GraphTimePeriod graphTimePeriod = gvRecord.graphTimePeriod.value;
  int graphTimePeriodIndex = GraphTimePeriod.values.indexOf(graphTimePeriod);
  return singleSpinnerPicker(
    width: asWidth(324),
    height: asHeight(220),
    idxInitial: graphTimePeriodIndex,
    itemTextList: timePeriodNameList,
    callbackOnTap: (idxPresent) async {
      if (gvRecord.graphTimePeriod.value !=
          GraphTimePeriod.values[idxPresent]) {
        gvRecord.graphTimePeriod.value = GraphTimePeriod.values[idxPresent];
        changeGraphTimePeriod(GraphTimePeriod.values[idxPresent]);
      }
      Get.back();
    },
  );
}

//==============================================================================
// 근육 확장형 선택
//==============================================================================
Widget _dataSelection(BuildContext context) {
  //---------------- 버튼 shape
  double buttonWidth = asWidth(75);
  double buttonHeight = asHeight(48);
  // //---------------- 공간
  // double padWidth10 = Get.width * 10 / 360;
  // double padWidth18 = Get.width * 18 / 360;

  //----------------------------------------------------------------------------
  // 분석 할 데이터가 늘어나면 스크롤로 데이터 선택
  //----------------------------------------------------------------------------
  return SizedBox(
    height: buttonHeight,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: graphDataTypeIndexForTime.length,
      itemBuilder: (context, index) {
        return Obx(
          () => InkWell(
            borderRadius: BorderRadius.circular(asWidth(10)),
            onTap: () {
              if (gvRecord.graphDataType.value !=
                  GraphDataType.values[graphDataTypeIndexForTime[index]]) {
                // 바뀌는 부분
                changeGraphDataType(GraphDataType
                    .values[graphDataTypeIndexForTime[index]]); // 바뀌는 부분
              }
            },
            child: _dataButtonBox(
              isSelected: gvRecord.graphDataType.value ==
                  GraphDataType.values[graphDataTypeIndexForTime[index]],
              // 바뀌는 부분
              width: buttonWidth,
              height: buttonHeight,
              title: graphDataTypeDisplayText[
                  graphDataTypeIndexForTime[index] + 2],
            ),
          ),
        );
      },
    ),
  );
}

Widget _dataButtonBox({
  bool isSelected = false,
  double width = 80,
  double height = 40,
  String title = 'title',
}) {
  return Container(
    alignment: Alignment.center,
    width: width,
    height: height,
    // decoration: BoxDecoration(
    //   borderRadius: BorderRadius.circular(radius),
    // ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        //----------------------------------------------------------------------
        // 텍스트
        TextN(
          title,
          fontSize: tm.s16,
          color: isSelected ? tm.mainBlue : tm.grey03,
          fontWeight: FontWeight.w900,
          textAlign: TextAlign.center,
        ),
        //----------------------------------------------------------------------
        // 하단 줄표
        if (isSelected)
          Container(
            alignment: Alignment.bottomCenter,
            width: width,
            height: height,
            child: Container(
              width: width * 0.8,
              height: asHeight(6),
              decoration: BoxDecoration(
                color: tm.softBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
      ],
    ),
  );
}

// //==============================================================================
// // 기록 그래프
// //==============================================================================
// Widget _recordGraph() {
//   return Center(
//     child: Container(
//       width: asWidth(324),
//       decoration: BoxDecoration(
//           color: tm.grey01, borderRadius: BorderRadius.circular(tm.s30)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           //--------------------------------------------------------------------
//           // 텍스트
//           asSizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               //----------------------------------------------------------------
//               // 제목 텍스트
//               Row(
//                 children: [
//                   asSizedBox(width: 18),
//                   TextN(
//                     '최근 6개월 평균 변화(kgf)',
//                     fontSize: tm.s14,
//                     color: tm.blue,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ],
//               ),
//               //----------------------------------------------------------------
//               // 성과 텍스트
//               Row(
//                 children: [
//                   TextN(
//                     '+12%',
//                     fontSize: tm.s30,
//                     color: tm.black,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   asSizedBox(width: 18),
//                 ],
//               ),
//             ],
//           ),
//           //----------------------------------------------------------------------
//           // 일/월/년 버튼
//           asSizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               daySelectTextButton(title: '일', isSelected: true),
//               asSizedBox(width: 10),
//               daySelectTextButton(title: '월', isSelected: false),
//               asSizedBox(width: 10),
//               daySelectTextButton(title: '년', isSelected: false),
//               asSizedBox(width: 20),
//             ],
//           ),
//           //----------------------------------------------------------------------
//           // 하단 그래프
//           asSizedBox(height: 10),
//           RecordChart(
//             width: asWidth(288),
//             height: asHeight(212),
//           ),
//           asSizedBox(height: 30),
//         ],
//       ),
//     ),
//   );
// }
