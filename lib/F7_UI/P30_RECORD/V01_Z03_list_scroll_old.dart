// import '/F0_BASIC/common_import.dart';
// import 'package:intl/intl.dart';
//
// GlobalKey<_ListRecordsState> _keyListRecordsState = GlobalKey();
//
// Widget listRecordsScroll({bool isDeleteMode = false}) {
//   return _ListRecords(key: _keyListRecordsState);
// }
//
// //==============================================================================
// // 기록 리스트
// // DB 연결 시 최신 값이 맨 위로 오도록 처리 (여기서 끝에서 부터 읽기)
// // 리스트 수가 많을 경우 적절한 범위만 읽어오기
// //==============================================================================
// class _ListRecords extends StatefulWidget {
//   final bool isDeleteMode;
//
//   const _ListRecords({this.isDeleteMode = false, Key? key}) : super(key: key);
//
//   @override
//   State<_ListRecords> createState() => _ListRecordsState();
// }
//
// class _ListRecordsState extends State<_ListRecords> {
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     //--------------------------------------------------------------------------
//     // 스크롤 위치 초기 값 설정하기 - 화면이 그려진 1~100ms 후에 동작
//     //--------------------------------------------------------------------------
//     Future.delayed(const Duration(milliseconds: 1), () async {
//       //----------------------------------------------
//       // 화면이 다 그려지기를 대기 함 (대부분 바로 그려지는 듯)
//       await Future.doWhile(() async {
//         await Future.delayed(const Duration(milliseconds: 1));
//         if (_scrollController.hasClients) {
//           if (kDebugMode) {
//             print('scroll ready');
//           }
//           return false;
//         }
//         if (kDebugMode) {
//           print('scroll not ready');
//         }
//         return true;
//       });
//       //----------------------------------------------
//       // 선택된 근육 부위로 점프
//       scrollPositionInit();
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   //----------------------------------------------------------------------------
//   // 근육 부위로 점프
//   //----------------------------------------------------------------------------
//   void scrollPositionInit() {
//     //----------------------------------------------
//     // 스크롤이 준비 되었으면 선택된 근육 부위로 점프
//     if (_scrollController.hasClients) {
//       double blockWidth = asWidth(143);
//       double jumpPosition = 0;
//       //----------------------------------- 맨 처음으로 인 경우
//       if (gvRecord.isToGoEnd.value == false) {
//         jumpPosition = 0;
//       }
//       //----------------------------------- 맨 끝인 경우
//       else {
//         jumpPosition = _scrollController.position.maxScrollExtent;
//       }
//       //----------------------------------- 중간인 경우 : 박스의 높이로 추정 가능
//       // jumpPosition = blockWidth * gv.control.idxMuscle.value - asWidth(100);
//
//       //---------------------------- 애니메이션 점프
//       _scrollController.animateTo(jumpPosition,
//           duration: const Duration(milliseconds: 300), curve: Curves.ease);
//       //---------------------------- 바로 점프
//       // _scrollController.jumpTo(jumpPosition); //바로가기
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       int refresh = _refreshList.value;
//       int listTotalNum = gvRecord.totalNumOfRecord.value;
//       int count = gv.control.numOfRecordPresentMuscle.value + 1;
//
//       return Expanded(
//         child: Scrollbar(
//           child: SingleChildScrollView(
//             controller: _scrollController,
//             // reverse: gvRecord.isToGoEnd.value == true ? true : false,
//             // scrollDirection: Axis.horizontal,
//             // dragStartBehavior: DragStartBehavior.start,
//             child: Column(
//                 children: List<Widget>.generate(
//               listTotalNum,
//               ((index) {
//                 //----------------------------------------------------------------
//                 // 현재 선택된 근육과 같은 리스트라면
//                 if (gv.dbRecordIndexes[listTotalNum - index - 1].idxMuscle ==
//                     gv.control.idxMuscle.value) {
//                   count--;
//                   //--------------------------------------------------------------
//                   // 리스트 내용 간단 보기 상태라면
//                   if (gvRecord.isViewListSimple.value) {
//                     return simpleRecordTitleBox(
//                         index: listTotalNum - index - 1,
//                         count: count,
//                         isDeleteMode: widget.isDeleteMode);
//                   }
//                   //--------------------------------------------------------------
//                   // 리스트 내용 상세 보기 상태라면
//                   else {
//                     return detailRecordTitleBox(
//                         index: listTotalNum - index - 1,
//                         count: count,
//                         isDeleteMode: widget.isDeleteMode);
//                   }
//                 }
//                 //----------------------------------------------------------------
//                 // 현재 선택된 근육과 다른 리스트라면 표시 안함
//                 else {
//                   return Container();
//                 }
//               }),
//             )),
//           ),
//         ),
//       );
//     });
//   }
// }
//
// //==============================================================================
// // 간단 보기
// //==============================================================================
// Widget simpleRecordTitleBox(
//     {required int index, int count = 0, bool isDeleteMode = false}) {
//   // double boxWidth = Get.width * (360 - 36) / 360;
//   double boxWidth = Get.width;
//   //-------------------------------------------------------
//   // 리스트의 글씨 크기는 일정 이상 커지지 않게 제어 - 태블릿에서 목록을 많이 보이게 할 목적
//   double maxRatio = 1.5;
//   double s14 = min(tm.s14, 14 * maxRatio);
//   double s16 = min(tm.s16, 16 * maxRatio);
//   double s18 = min(tm.s18, 18 * maxRatio);
//   double s20 = min(tm.s20, 20 * maxRatio);
//
//   //-------------------------------------------------------
//   // 표시 항목
//   String date =
//       DateFormat('yyyy.M.d').format(gv.dbRecordIndexes[index].startTime);
//   String timeStart =
//       DateFormat('HH:mm:ss').format(gv.dbRecordIndexes[index].startTime);
//   String timeEnd =
//       DateFormat('HH:mm:ss').format(gv.dbRecordIndexes[index].endTime);
//
//   // 시간 차이 계산 (시작, 종료시간은 운동시간 보다 지연경로만큼 1.5초 길게 됨)
//   // Duration diff =
//   //     gv.dbRecordIndexes[index].endTime.difference(gv.dbRecordIndexes[index].startTime);
//   // 운동 시간
//   String timeExercise = timeToStringBasic(
//       timeSec: gv.dbRecordIndexes[index].exerciseTime, //diff.inSeconds,
//       strHour: '시간'.tr,
//       strMinute: '분'.tr,
//       strSecond: '초'.tr);
//
//   // String level =
//   //     (gv.dbRecordIndexes[index].mvcMv * GvDef.convLv).toStringAsFixed(1);
//
//   String aoe = (gv.dbRecordIndexes[index].aoeSet * 100).toStringAsFixed(0);
//   //------------------------------------------------
//   // 성과
//   double aoeSet = gv.dbRecordIndexes[index].aoeSet;
//   Map aoeAward = aoeResultAward(aoeSet);
//
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//     child: InkWell(
//       borderRadius: BorderRadius.circular(asHeight(tm.s10)),
//       onTap: (() async {
//         if (isDeleteMode == false) {
//           await gv.control.updateIdxRecord(index); //현재 선택 된 기록 index 저장
//           final _indicatePopup =
//               openPopupProcessIndicator(Get.context!, text: '로딩 중입니다...');
//           Future.delayed(const Duration(milliseconds: 100), () {
//             Navigator.pop(Get.context!, _indicatePopup);
//             openBottomSheetBasic(
//                 height: Get.height - asHeight(40),
//                 child: ReportPage(reportIndex: index));
//           });
//         }
//       }),
//       child: Container(
//         width: boxWidth,
//         color: isDeleteMode ? tm.white : Colors.transparent,
//         child: Column(
//           children: [
//             //----------------------------------------------------------------------
//             // 내용
//             SizedBox(height: s18),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 //------------------------------------------------------------------
//                 // 일시
//                 Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // ------------------------------------- 순서
//                         // TextN(
//                         //   '   $count',
//                         //   fontSize: s14,
//                         //   color: tm.blue.withOpacity(0.5),
//                         //   fontWeight: FontWeight.w400,
//                         // ),
//                         SizedBox(
//                           width: asWidth(147),
//                           child: TextN(
//                             '$date ',
//                             fontSize: s16,
//                             color: tm.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         asSizedBox(height: 6),
//                         // ------------------------------------- 시간범위
//                         SizedBox(
//                           width: asWidth(147),
//                           child: TextN(
//                             '$timeStart ($timeExercise)', // - $timeEnd',
//                             fontSize: s14,
//                             color: tm.grey03,
//                             overflow: TextOverflow.clip,
//                             // fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                     //------------------------------------------------------------------
//                     // 성과 아이콘
//                     Image.asset(
//                       aoeAward['imPath'],
//                       height: asHeight(37),
//                       //-------------- 결과에 이모티콘 색상
//                       color: aoeAward['color'],
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     //--------------------------------------------------------------
//                     // 레벨
//
//                     TextN(
//                       // level,
//                       convertMvcToDisplayValue(gv.dbRecordIndexes[index].mvcMv),
//                       fontSize: s16,
//                       color: tm.black,
//                       fontWeight: FontWeight.bold,
//                       overflow: TextOverflow.clip,
//                     ),
//                     // TextN(
//                     //   'LV',
//                     //   fontSize: s10,
//                     //   color: tm.grey03,
//                     //   fontWeight: FontWeight.w400,
//                     // ),
//                     // asSizedBox(width: 10),
//                     //--------------------------------------------------------------
//                     // 운동량
//                     Container(
//                       alignment: Alignment.centerRight,
//                       width: asWidth(60),
//                       child: TextN(
//                         '$aoe%',
//                         fontSize: s16,
//                         color: tm.black,
//                         fontWeight: FontWeight.bold,
//                         overflow: TextOverflow.clip,
//                       ),
//                     ),
//                   ],
//                 ),
//                 //------------------------------------------------------------------
//                 // 기록 삭제 표시
//               ],
//             ),
//             //------------------------------------------------------------------
//             // 하단 줄
//             SizedBox(height: s18),
//             Container(
//               height: 2,
//               color: tm.grey01,
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
// //==============================================================================
// // 상세하게 보기
// //==============================================================================
// Widget detailRecordTitleBox(
//     {required int index, int count = 0, bool isDeleteMode = false}) {
//   // double boxWidth = Get.width * (360 - 36) / 360;
//   double boxWidth = Get.width; // * (360 - 36) / 360;
//   //-------------------------------------------------------
//   // 리스트의 글씨 크기는 일정 이상 커지지 않게 제어 - 태블릿에서 목록을 많이 보이게 할 목적
//   double maxRatio = 1.5;
//   double s12 = min(tm.s12, 12 * maxRatio);
//   double s14 = min(tm.s14, 14 * maxRatio);
//   double s15 = min(tm.s15, 15 * maxRatio);
//   double s16 = min(tm.s16, 16 * maxRatio);
//   double s18 = min(tm.s18, 18 * maxRatio);
//   double s20 = min(tm.s24, 20 * maxRatio);
//   double s24 = min(tm.s24, 24 * maxRatio);
//   double s30 = min(tm.s30, 30 * maxRatio);
//   double s67 = min(tm.s67, 67 * maxRatio);
//
//   //-------------------------------------------------------
//   // 표시 항목
//   String date =
//       DateFormat('yyyy.M.d').format(gv.dbRecordIndexes[index].startTime);
//   String timeStart =
//       DateFormat('HH:mm:ss').format(gv.dbRecordIndexes[index].startTime);
//   String timeEnd =
//       DateFormat('HH:mm:ss').format(gv.dbRecordIndexes[index].endTime);
//
//   // 시간 차이 계산 (시작, 종료시간은 운동시간 보다 지연경로만큼 1.5초 길게 됨)
//   // Duration diff =
//   //     gv.dbRecordIndexes[index].endTime.difference(gv.dbRecordIndexes[index].startTime);
//   // 운동 시간
//   String timeExercise = timeToStringBasic(
//       timeSec: gv.dbRecordIndexes[index].exerciseTime, //diff.inSeconds,
//       strHour: '시간'.tr,
//       strMinute: '분'.tr,
//       strSecond: '초'.tr);
//
//   String level =
//       (gv.dbRecordIndexes[index].mvcMv * GvDef.convLv).toStringAsFixed(1);
//
//   double aoeSet = gv.dbRecordIndexes[index].aoeSet;
//   String aoePercent = (aoeSet * 100).toStringAsFixed(0);
//
//   //-------------------------------------------------------
//   // 운동량 성과
//   Map aoeAward = aoeResultAward(aoeSet);
//
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//     child: InkWell(
//       //--------------------------------------------------------------------------
//       // 보고서 팝업
//       borderRadius: BorderRadius.circular(asHeight(20)),
//       onTap: (() async {
//         if (isDeleteMode == false) {
//           await gv.control.updateIdxRecord(index); //현재 선택 된 기록 index 저장
//
//           // navigator.pop 명령은 navigator stack 에서 가장 위에 있는 것을 삭제.
//           // 따라서 reportPage 를 bottomSheet 로 띄우기전에 processIndicator 을 pop 해야 함.
//           final _indicatePopup =
//               openPopupProcessIndicator(Get.context!, text: '로딩 중입니다...');
//           // Navigator.pop(Get.context!, _indicatePopup);
//           // Navigator.of(Get.context!).pushReplacement(pageRouteAnimationSimple(
//           //     openBottomSheetBasic(height: Get.height - asHeight(40), child: reportPage(index)), EmlMoveDirection.rightToLeft));
//           Future.delayed(const Duration(milliseconds: 100), () {
//             // Navigator.of(Get.context!).pop();
//             Navigator.pop(Get.context!, _indicatePopup);
//             openBottomSheetBasic(
//                 height: Get.height - asHeight(40),
//                 child: ReportPage(reportIndex: index));
//           });
//         }
//       }),
//       child: Container(
//         width: boxWidth,
//         color: isDeleteMode ? tm.white : Colors.transparent,
//         child: Column(
//           children: [
//             SizedBox(height: s16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 //--------------------------------------------------------------
//                 // 운동량 결과 표시
//                 //--------------------------------------------------------------
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     //-------------------------------------------------------
//                     // 성과텍스트
//                     Container(
//                         alignment: Alignment.center,
//                         width: asWidth(67),
//                         height: s30,
//                         //asHeight(30),
//                         decoration: BoxDecoration(
//                             color: aoeAward['color'].withOpacity(0.1),
//                             //tm.blue.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(asHeight(10))),
//                         child: FittedBoxN(
//                           child: TextN(
//                             aoeAward['shortText'],
//                             color: aoeAward['color'],
//                             fontSize: tm.s14,
//                           ),
//                         )),
//                     //--------------------------------------------------------
//                     // 운동량
//                     SizedBox(height: s18),
//                     Container(
//                       alignment: Alignment.center,
//                       width: asWidth(67),
//                       height: s24, //asHeight(24),
//                       // height: asHeight(37), //보드 두께 반영
//                       child: FittedBoxN(
//                         child: TextN(
//                           aoePercent + '%',
//                           fontSize: s24,
//                           color: tm.black,
//                           fontWeight: FontWeight.bold,
//                           height: 1,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 asSizedBox(width: 12),
//                 //--------------------------------------------------------------
//                 // 날짜, 용량, 레벨
//                 //--------------------------------------------------------------
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: s30, //asHeight(30),
//                       width: asWidth(245), //360-36-67-12
//                       alignment: Alignment.center,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           //----------------------------------------------------
//                           // 날짜
//                           TextN(
//                             date,
//                             fontSize: s14,
//                             color: tm.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           TextN(
//                             '${(0.4 + gv.dbRecordIndexes[index].exerciseTime * 0.424).toStringAsFixed(0)}kB',
//                             fontSize: s14,
//                             color: tm.grey03,
//                             // fontWeight: FontWeight.w400,
//                           ),
//                           //--------------------------------------------------------------------
//                           // 용량 (64비트로 계산) - 실제 DB에 저장되는 용량은 달라질 수 있음
//                           // 기본 50개의 변수 * 8byte = 400byte = 0.4kB
//                           // 초당 25 x 8byte = 200byte = 0.2KB (시간과 데이터 = 0.4KB)
//                           // 마크 : 초당 1개 가정 -> 8 x 3 = 24 = 0.024KB
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.end,
//                           //   children: [
//                           //     // //------------------------------ 목록번호,
//                           //     // Container(
//                           //     //   width: count >= 10000
//                           //     //       ? s16 * 6
//                           //     //       : count >= 1000
//                           //     //           ? s16 * 6
//                           //     //           : count >= 100
//                           //     //               ? s16 * 4
//                           //     //               : count > 10
//                           //     //                   ? s16 * 3
//                           //     //                   : s16 * 2,
//                           //     //   alignment: Alignment.center,
//                           //     //   decoration: BoxDecoration(
//                           //     //       borderRadius:
//                           //     //           BorderRadius.circular(s16 / 2),
//                           //     //       color: tm.grey02),
//                           //     //   child: FittedBoxN(
//                           //     //     child: TextN(
//                           //     //       '$count',
//                           //     //       fontSize: s16,
//                           //     //       color: tm.grey03,
//                           //     //       fontWeight: FontWeight.w400,
//                           //     //     ),
//                           //     //   ),
//                           //     // ),
//                           //     // asSizedBox(width: 10),
//                           //     // TextN(
//                           //     //   '${(0.4 + gv.dbRecordIndexes[index].exerciseTime * 0.424).toStringAsFixed(0)}kB',
//                           //     //   fontSize: s14,
//                           //     //   color: tm.grey03,
//                           //     //   // fontWeight: FontWeight.w400,
//                           //     // ),
//                           //   ],
//                           // ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: s18),
//                     //----------------------------------------------------------------------
//                     // 진도율, 시간, 레벨
//                     Container(
//                       height: s24, //asHeight(24),
//                       width: asWidth(245), //360-36-67-12
//                       alignment: Alignment.center,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               //------------------------------------------------------------
//                               // 소요시간
//                               Row(
//                                 children: [
//                                   Icon(Icons.schedule,
//                                       size: s14,
//                                       color: tm.mainBlue),
//                                   Container(
//                                     width: asWidth(130),
//                                     alignment: Alignment.centerLeft,
//                                     child: FittedBoxN(
//                                       fit: BoxFit.fitWidth,
//                                       child: TextN(
//                                         '  $timeStart ($timeExercise)',
//                                         fontSize: s14,
//                                         color: tm.grey04,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           //------------------------------------------------------------------
//                           // 레벨
//                           Container(
//                             width: asWidth(80),
//                             alignment: Alignment.centerRight,
//                             child: FittedBoxN(
//                               fit: BoxFit.fitWidth,
//                               child: TextN(
//                                 // '레벨 ${(gv.dbRecordIndexes[index].mvcMv * GvDef.convLv).toStringAsFixed(1)}',
//                                 convertMvcToDisplayValue(
//                                     gv.dbRecordIndexes[index].mvcMv),
//                                 fontSize: s14,
//                                 color: tm.grey04,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           //------------------------------------------------------------------
//                           // 기록 삭제 표시
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             //------------------------------------------------------------------
//             // 하단 줄
//             SizedBox(height: s16),
//             Container(
//               height: 2,
//               color: tm.grey01,
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
// RxInt _refreshList = 0.obs;
//
// //==============================================================================
// // refresh
// //==============================================================================
// class RefreshRecordList {
//   static void list() {
//     _refreshList++;
//     _keyListRecordsState.currentState?.scrollPositionInit(); //스크롤 위치 초기화
//   }
// }
