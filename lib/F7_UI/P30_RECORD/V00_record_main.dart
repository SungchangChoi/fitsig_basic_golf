import '/F0_BASIC/common_import.dart';

//==============================================================================
// record main
//==============================================================================

class RecordMain extends StatelessWidget {
  const RecordMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //----------------------------------------------------------------
              // top bar
              topBarBack(context),
              //----------------------------------------------------------------
              // muscle title
              asSizedBox(height: 10),
              _muscleTitleExpand(context),
              //----------------------------------------------------------------
              // view selection
              asSizedBox(height: 20),
              _viewSelectionButton(),

              //----------------------------------------------------------------
              // graph or list
              Obx(() {
                return gvRecord.isSelectedStatsView.value
                    ? recordStatsMain(context)
                    : recordList(context);
              }),
            ],
          ),
        ));
  }
}

//==============================================================================
// 기록 리스트
//==============================================================================
// Widget _listRecords() {
//   return Expanded(
//     child: Scrollbar(
//       child: SingleChildScrollView(
//         child: Column(
//           children: List<Widget>.generate(gvRecord.totalNumOfRecord.value,
//               (index) => _simpleRecordTitleBox()),
//         ),
//       ),
//     ),
//   );
// }

// Widget _simpleRecordTitleBox() {
//   return Container(
//     height: asHeight(76),
//     width: 200, //double.maxFinite,
//     color: Colors.yellow, //tm.white,
//     child: Row(
//       children: [
//         //------------------------------------------------------------------------
//         // 날짜
//         Column(
//           children: [
//             TextN(
//               '최근으로'.tr,
//               fontSize: tm.s16,
//               color: tm.grey03,
//               fontWeight: FontWeight.w400,
//             ),
//             TextN(
//               'date'.tr,
//               fontSize: tm.s16,
//               color: tm.grey03,
//               fontWeight: FontWeight.w400,
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

//==============================================================================
// 근육 확장형 선택
// 좌우 이동형이 디자인이 어울리지 않아 팝업 형식으로 변경
//==============================================================================
Widget _muscleTitleExpand(BuildContext context) {
  return InkWell(
    borderRadius: BorderRadius.circular(asWidth(22)),
    onTap: (() {
      openBottomSheetBasic(
          height: gv.setting.isBigFont.value ? asHeight(420) : asHeight(380),
          child: muscleSpinnerPicker());
          // child: MuscleSpinnerPicker(context: context));
    }),
    child: Obx(() {
      return Container(
        width: asWidth(300),
        height: asHeight(54),
        alignment: Alignment.center,
        child: FittedBoxN(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextN(
                gv.dbMuscleIndexes[gv.control.idxMuscle.value].muscleName,
                fontSize: tm.s20,
                fontWeight: FontWeight.bold,
                color: tm.black,
              ),
              Icon(
                Icons.expand_more_rounded,
                size: tm.s24,
                color: tm.grey03,
              ),
            ],
          ),
        ),
      );
    }),
  );
}

//==============================================================================
// 근육 리스트
//==============================================================================
// Widget _muscleList() {
//   return Container(
//     padding:
//         EdgeInsets.symmetric(horizontal: asWidth(18), vertical: asHeight(20)),
//     child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(width: asWidth(36)),
//             TextN(
//               '근육 선택'.tr,
//               fontSize: tm.s20,
//               color: tm.black,
//             ),
//             SizedBox(
//               width: asWidth(36),
//               child: InkWell(
//                 onTap: (() {
//                   Get.back();
//                 }),
//                 borderRadius: BorderRadius.circular(asWidth(10)),
//                 child: Icon(
//                   Icons.close,
//                   size: asWidth(36),
//                   color: tm.grey03,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         asSizedBox(height: 20),
//         Expanded(
//           child: Scrollbar(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: List.generate(gv.dbMuscleIndexes.length,
//                     (index) => _muscleTitleBox(index)),
//               ),
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }

//==============================================================================
// 근육 박스
//==============================================================================
// Widget _muscleTitleBox(int index) {
//   return Obx(() {
//     String muscleName = gv.dbMuscleIndexes[index].muscleName;
//     bool isSelected = index == gv.control.idxMuscle.value;
//     return Column(
//       children: [
//         InkWell(
//           borderRadius: BorderRadius.circular(asHeight(10)),
//           onTap: (() async {
//             //---------------------------------------------------------
//             // 새로운 근육 선택
//             await gv.control.updateIdxMuscle(index); //관련 class 데이터 갱신
//             Get.back();
//           }),
//           child: Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(asHeight(5)),
//             child: FittedBoxN(
//               child: TextN(
//                 muscleName,
//                 fontSize: tm.s18,
//                 color: isSelected ? tm.mainBlue : tm.grey03,
//               ),
//             ),
//             decoration: BoxDecoration(
//                 color:
//                     isSelected ? tm.softBlue : Colors.transparent,
//                 borderRadius: BorderRadius.circular(asHeight(10)),
//                 border: Border.all(
//                     color: isSelected ? tm.mainBlue.withOpacity(0.3) : tm.grey02)),
//           ),
//         ),
//         asSizedBox(height: 10),
//       ],
//     );
//   });
// }

//==============================================================================
// 보기 선택 버튼
//==============================================================================
Widget _viewSelectionButton() {
  return Obx(() {
    bool isSelectedStatsView = gvRecord.isSelectedStatsView.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //----------------------------------------------------------------------
        // 리스트 보기 버튼
        Row(
          children: [
            asSizedBox(width: 40),
            InkWell(
              onTap: (() {
                gvRecord.isSelectedStatsView.value = false;
                gv.spMemory.write(
                    'isSelectedStatsView', gvRecord.isSelectedStatsView.value);
              }), //리스트 보기로 이동
              borderRadius: BorderRadius.circular(asHeight(41 / 2)), // 동
              child: _viewSelectionBox(
                  width: asWidth(137),
                  height: asHeight(41),
                  title: '리스트 보기',
                  textFontSize: tm.s16,
                  textColor: isSelectedStatsView ? tm.grey03 : tm.white,
                  buttonColor:
                      isSelectedStatsView ? Colors.transparent : tm.mainBlue,
                  //조건부
                  imagePath: 'assets/icons/ic_list_grey.png'),
            ),
          ],
        ),
        //----------------------------------------------------------------------
        // 통계 그래프 보기 버튼
        Row(
          children: [
            InkWell(
              onTap: (() {
                gvRecord.isSelectedStatsView.value = true;
                gv.spMemory.write(
                    'isSelectedStatsView', gvRecord.isSelectedStatsView.value);
              }), //그래프 보기로 이
              borderRadius: BorderRadius.circular(asHeight(41 / 2)), // 동
              child: _viewSelectionBox(
                  width: asWidth(137),
                  height: asHeight(41),
                  title: '통계 보기',
                  textFontSize: tm.s16,
                  textColor: isSelectedStatsView ? tm.white : tm.grey03,
                  buttonColor:
                      isSelectedStatsView ? tm.mainBlue : Colors.transparent,
                  //조건부
                  imagePath: 'assets/icons/ic_graph_white.png'),
            ),
            asSizedBox(width: 40),
          ],
        ),
      ],
    );
  });
}

Widget _viewSelectionBox({
  double width = 100,
  double height = 60,
  double radius = 30,
  String title = 'title',
  String imagePath = 'assets/icons/ic_banner_arrow_l.png',
  Color buttonColor = Colors.grey,
  double textFontSize = 15,
  Color textColor = Colors.black,
  double padWidth = 8,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: buttonColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.scaleDown,
          height: textFontSize,
          color: textColor,
        ),
        SizedBox(width: padWidth),
        TextN(
          title,
          fontSize: textFontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        )
      ],
    ),
  );
}
