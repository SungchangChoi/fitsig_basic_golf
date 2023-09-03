// import '/F0_BASIC/common_import.dart';
//
// //==============================================================================
// // 측정 종료단계
// //==============================================================================
//
// class MeasureEnd extends StatelessWidget {
//   const MeasureEnd({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Wakelock.disable(); //화면 켜짐 해제
//     return Material(
//       color: tm.white,
//       child: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             //------------------------------------------------------------------
//             // 상단 바
//             // topBarBasic(context),
//             topBarGuide(context, isViewXButton: false, isMeasureEnd: true),
//
//             //------------------------------------------------------------
//             // 최대근력 표시
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     //------------------------------------------------------------
//                     // 성과
//                     // asSizedBox(height: 20),
//                     _award(),
//                     //------------------------------------------------------------
//                     // 가운데 점선
//                     _new1rm(),
//                     //------------------------------------------------------------
//                     // 가운데 점선
//                     Container(
//                         height: asHeight(2),
//                         alignment: Alignment.center,
//                         padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//                         child: dashLineHSimple(
//                             color: tm.grey03,
//                             numOfDash: 50,
//                             height: asHeight(2))),
//
//                     //------------------------------------------------------------
//                     // 측정 품질 안내 문구
//                     measureQualityDetail(),
//
//                     //------------------------------------------------------------
//                     // 결과 요약
//                     _resultBrief(),
//                     //------------------------------------------------------------
//                     // 버튼
//                     _saveOrNotButton(context),
//                   ],
//                 ),
//               ),
//             ),
//
//             //------------------------------------------------------------------
//             // 하부영역 - 스크롤 - 리포트
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// //==============================================================================
// // 최대근력 반영하기
// //==============================================================================
// Widget _award() {
//   int setIdx = 0;
//   int resultGrade = 0; //bad(0), good(1), great(2), over(3), very over(4)
//   int numOfStart = resultGrade + 1;
//   double aoeSet = dm[0].g.report.aoeSet[setIdx] * 100;
//   Color _color = tm.grey04;
//   String aoeSetStr = aoeSet.toStringAsFixed(1);
//
//   //------------------------ 조금 부족해요
//   if (aoeSet < 50){
//     resultGrade = 0;
//     numOfStart = 1;
//     _color = tm.grey04;
//   }
//   //------------------------ 많이 무리했어요
//   else if (aoeSet > 400){
//     resultGrade = 4;
//     numOfStart = 0;
//     _color = tm.red;
//   }
//   //------------------------ 조금 무리했어요
//   else if (aoeSet > 200){
//     resultGrade = 3;
//     numOfStart = 1;
//     _color = tm.red;
//   }
//   //------------------------ 좋아요
//   else if (aoeSet > 150 || aoeSet< 70){
//     resultGrade = 1;
//     numOfStart = 2;
//     _color = tm.green;
//   }
//   //------------------------ 훌륭해요 (70 ~ 150)
//   else{
//     resultGrade = 2;
//     numOfStart = 3;
//     _color = tm.blue;
//   }
//
//
//   return SizedBox(
//     // height: asHeight(115), //37+28
//     child: Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         //----------------------------------------------------------------------
//         // background - 목표 달성한 경우에만 표시
//         //----------------------------------------------------------------------
//         if (resultGrade == 2) //great 일 대
//           Image.asset(
//             'assets/images/effect_bg.png',
//             height: asHeight(100),
//           ),
//         Column(
//           children: [
//             //------------------------------------------------------------------
//             // 별과 이모티콘
//             //------------------------------------------------------------------
//             asSizedBox(height: 20),
//             Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 //------------------------------------------------------------------
//                 // 아쉬워요, 좋아요, 훌륭해요 3개에서만 별 표시
//                 //------------------------------------------------------------------
//                 // if (numOfStart != 0)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //----------------------------------------------
//                     // 첫번째 별
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         asSizedBox(height: asHeight(10)),
//                         Opacity(
//                             opacity: numOfStart >= 1 ? 1 : 0.2,
//                             child: Image.asset(
//                               'assets/icons/ic_star.png',
//                               height: asHeight(20),
//                             )),
//                       ],
//                     ),
//                     //----------------------------------------------
//                     //두번째 별
//                     asSizedBox(width: 4),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         //asSizedBox(height: asHeight(10)),
//                         Opacity(
//                             opacity: numOfStart >= 2 ? 1 : 0.2,
//                             child: Image.asset(
//                               'assets/icons/ic_star.png',
//                               height: asHeight(20),
//                             )),
//                       ],
//                     ),
//                     //----------------------------------------------
//                     //세번째 별
//                     asSizedBox(width: 4),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         asSizedBox(height: asHeight(10)),
//                         Opacity(
//                             opacity: numOfStart >= 3 ? 1 : 0.2,
//                             child: Image.asset(
//                               'assets/icons/ic_star.png',
//                               height: asHeight(20),
//                             )),
//                       ],
//                     ),
//                   ],
//                 ),
//                 //------------------------------------------------------------------------
//                 // 성과 이모티콘 표시
//                 //------------------------------------------------------------------------
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     asSizedBox(height: 28),
//                     Image.asset(
//                       //-------------- 결과에 따른 이모티콘
//                       resultGrade == 0
//                           ? 'assets/icons/ic_not_good.png'
//                           : resultGrade == 1
//                               ? 'assets/icons/ic_good.png'
//                               : resultGrade == 2
//                                   ? 'assets/icons/ic_great.png'
//                                   : resultGrade == 3
//                                       ? 'assets/icons/ic_over.png'
//                                       : 'assets/icons/ic_very_over.png',
//                       height: asHeight(37),
//                       //-------------- 결과에 이모티콘 색상
//                       color: _color,
//                     ),
//                     //------------------------------------------------------------------------
//                     // 성과 글씨 표시
//                     //------------------------------------------------------------------------
//                     asSizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         TextN(
//                           '운동량($aoeSetStr%)  ',
//                           fontSize: tm.s16,
//                           color: _color,
//                         ),
//                         TextN(
//                           resultGrade == 0
//                               ? '조금 부족해요'
//                               : resultGrade == 1
//                                   ? '좋아요!'
//                                   : resultGrade == 2
//                                       ? '훌륭해요!' //목표 달성
//                                       : resultGrade == 3
//                                           ? '조금 무리했어요'
//                                           : '많이 무리했어요!',
//                           fontSize: tm.s20,
//                           fontWeight: FontWeight.bold,
//                           color: _color,
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
//
// //==============================================================================
// // 최대근력 반영하기
// //==============================================================================
// Widget _new1rm() {
//   int d = 0; //device index
//   int setIdx = 0; // set index (basic 은 단일 세트 운동)
//   double oneRmPrevious = dm[0].g.report.w1Rm[setIdx];
//   double oneRmNew = dm[0].g.report.w1RmNew[setIdx];
//   bool isNew = oneRmNew > oneRmPrevious;
//   bool isTooBig = oneRmNew >= oneRmPrevious * 1.3; //30% 이상 크다면
//   // bool isIgnoreNew1rm = gvMeasure.isIgnoreNew1rm.value;
//
//   late Color buttonColor;
//   late String buttonText;
//
//   // 신규 측정된 최대근력 값이 기존보다 크지 않다면
//   // if (isNew == false) {
//   //   isIgnoreNew1rm = false;
//   // }
//   //
//   // // 새로운 값이 무시 된 경우
//   // if (isIgnoreNew1rm == false) {
//   //   buttonColor = tm.grey03;
//   //   buttonText = '신규 측정 값 미적용';
//   // }
//   // // 새로운 값이 반영된 경우
//   // else {
//   //   buttonColor = tm.blue;
//   //   buttonText = '신규 측정 값 적용';
//   // }
//
//   return Container(
//     height: asHeight(266),
//     alignment: Alignment.center,
//     padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//     // color: Colors.yellow,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         //------------------------------------------------------------
//         // 최대근력 갱신 알림
//         isNew
//             ? TextN(
//                 '새로운 최대근력 레벨이 측정되었습니다.'.tr,
//                 fontSize: tm.s18,
//                 color: tm.red.withOpacity(0.7),
//               )
//             : TextN(
//                 '운동이 종료되었습니다.',
//                 fontSize: tm.s18,
//                 color: tm.blue,
//               ),
//         asSizedBox(height: 30),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             //------------------------------------------------------------------
//             // 근력 결과 표시
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //------------------------------------------------------------
//                 // 기존 최대근력
//                 _titleContents(
//                     '기존 근력'.tr,
//                     // (dm[0].g.report.w1Rm[setIdx] * GvDef.convLv)
//                     //     .toStringAsFixed(1),
//                     convertMvcToDisplayValue(dm[0].g.report.w1Rm[setIdx]),
//                     isInactive: isNew),
//                 //------------------------------------------------------------
//                 // 신규 최대근력
//                 asSizedBox(height: 10),
//                 _titleContents(
//                     '신규 근력'.tr,
//                     // (dm[0].g.report.w1RmNew[setIdx] * GvDef.convLv)
//                     //     .toStringAsFixed(1),
//                     convertMvcToDisplayValue(dm[0].g.report.w1RmNew[setIdx]),
//                     isInactive: !isNew),
//               ],
//             ),
//             //------------------------------------------------------------------
//             // 성장 정도 표시
//             if (isNew)
//               Container(
//                 width: asWidth(132),
//                 alignment: Alignment.center,
//                 child: Container(
//                   // margin: EdgeInsets.only(right: asWidth(30)),
//                   width: asWidth(80),
//                   height: asHeight(40),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: tm.red.withOpacity(0.7),
//                       borderRadius: BorderRadius.circular(asHeight(20))),
//                   child: FittedBoxN(
//                     child: TextN(
//                       '+ ${toStrFixedAuto(oneRmNew / oneRmPrevious * 100 - 100)}%',
//                       fontSize: tm.s20,
//                       color: tm.white,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//
//         //---------------------------------------------------------------
//         //
//         // Container(
//         //   alignment: Alignment.bottomLeft,
//         //   height: asHeight(40),
//         //   child: isTooBig
//         //       ? TextN(
//         //           '! 새로운 값이 30% 이상 큽니다. 잘못 측정된 경우라면 결과를 저장하지 마시고 취소하세요.',
//         //           fontSize: tm.s15,
//         //           color: tm.blue.withOpacity(0.8),
//         //         )
//         //       : Container(),
//         // ),
//       ],
//     ),
//   );
// }
//
// //==============================================================================
// // 최대근력 반영하기
// //==============================================================================
// Widget _resultBrief() {
//   // 시간 표시 변환
//   int setIdx = 0;
//   String timeStr = timeToStringBasic(timeSec: DspManager.timeMeasure.value);
//   String aoeSet =
//       (dm[0].g.report.aoeSet[setIdx] * 100).toStringAsFixed(1) + '%';
//   String aoeTarget =
//       (dm[0].g.report.aoeTargetSet[setIdx] * 100).toStringAsFixed(1) + '%';
//   String sign =
//       gv.deviceData[0].freqEnd.value > gv.deviceData[0].freqBegin.value
//           ? '+'
//           : '';
//   String freqChange = sign +
//       (gv.deviceData[0].freqEnd.value - gv.deviceData[0].freqBegin.value)
//           .toStringAsFixed(1) +
//       'Hz';
//   // 휴식시간은 목표 %1RM에 따라 변화 (실제 측정 값이 반영되지 않음)
//   String relaxTime =
//       prmToRelaxTime(gv.deviceData[0].targetPrm.value).toString() + '초'.tr;
//
//   return Container(
//     height: asHeight(266),
//     alignment: Alignment.center,
//     padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//     // color: Colors.yellow,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         //----------------------------------------------------------------------
//         // 좌측 결과
//         //----------------------------------------------------------------------
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //------------------------------------------------------------------
//             // 운동결과 요약
//             _titleContents('운동 시간', timeStr),
//             asSizedBox(height: 10),
//             _titleContents('세트 운동량', aoeSet),
//             asSizedBox(height: 10),
//             _titleContents('목표영역 운동량', aoeTarget),
//             asSizedBox(height: 10),
//             _titleContents('주파수 변화', freqChange),
//             asSizedBox(height: 10),
//             _titleContents('권장 휴식시간', relaxTime),
//           ],
//         ),
//         //----------------------------------------------------------------------
//         // 우측 휴식시간
//         //----------------------------------------------------------------------
//         Container(
//           width: asWidth(132),
//           alignment: Alignment.center,
//           child: FittedBoxN(
//             //------------------------------------------------------------------
//             // 훌룽해요
//             child: gv.deviceData[0].aoeSet >= GvDef.aoeGreat
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       TextN(
//                         '훌륭해요!!!',
//                         fontSize: tm.s18,
//                         color: tm.blue,
//                       ),
//                       asSizedBox(height: 10),
//                       Image.asset(
//                         'assets/icons/ic_great.png',
//                         fit: BoxFit.scaleDown,
//                         height: asHeight(90),
//                         color: tm.blue,
//                       ),
//                     ],
//                   )
//                 //------------------------------------------------------------------
//                 // 좋아요
//                 : gv.deviceData[0].aoeSet >= GvDef.aoeGood
//                     ? Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           TextN(
//                             '좋아요!!',
//                             fontSize: tm.s18,
//                             color: tm.blue,
//                           ),
//                           asSizedBox(height: 10),
//                           Image.asset(
//                             'assets/icons/ic_good.png',
//                             fit: BoxFit.scaleDown,
//                             height: asHeight(90),
//                             color: tm.blue,
//                           ),
//                         ],
//                       )
//                     //------------------------------------------------------------------
//                     // 아쉬워요
//                     : Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           TextN(
//                             '아쉬워요!',
//                             fontSize: tm.s18,
//                             color: tm.blue,
//                           ),
//                           asSizedBox(height: 10),
//                           Image.asset(
//                             'assets/icons/ic_bad.png',
//                             fit: BoxFit.scaleDown,
//                             height: asHeight(90),
//                             color: tm.blue,
//                           ),
//                         ],
//                       ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// //==============================================================================
// // 제목과 타이틀
// //==============================================================================
// Widget _titleContents(String title, String contents,
//     {bool isInactive = false}) {
//   Color titleColor = isInactive ? tm.grey03 : tm.black;
//   Color contentsColor =
//       isInactive ? tm.grey03 : tm.grey04; //tm.blue.withOpacity(0.8);
//   return Row(
//     children: [
//       Container(
//         alignment: Alignment.centerLeft,
//         width: asWidth(110),
//         child: FittedBoxN(
//           child: TextN(
//             title,
//             fontSize: tm.s18,
//             color: titleColor,
//           ),
//         ),
//       ),
//       asSizedBox(width: 8),
//       Container(
//         alignment: Alignment.centerLeft,
//         width: asWidth(70),
//         child: FittedBoxN(
//           child: TextN(
//             contents,
//             fontSize: tm.s18,
//             color: contentsColor,
//           ),
//         ),
//       ),
//     ],
//   );
// }
//
// //==============================================================================
// // 바닥 버튼
// //==============================================================================
// Widget _saveOrNotButton(BuildContext context) {
//   //expanded가 있었음
//   return Row(
//     children: [
//       //----------------------------------------------------------------------
//       // 저장 안함 버튼
//       //----------------------------------------------------------------------
//       Expanded(
//         child: InkWell(
//           onTap: (() {
//             // 취소 시 원래 값으로 복귀
//             gv.deviceData[0].mvc.value =
//                 gv.dbMuscleIndexes[gv.control.idxMuscle.value].mvcMv;
//             Get.back();
//           }),
//           child: Ink(
//             color: tm.blue,
//             child: Container(
//               alignment: Alignment.center,
//               // color: tm.blue,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.cancel_outlined,
//                     size: asHeight(30),
//                     color: tm.white.withOpacity(0.5),
//                   ),
//                   asSizedBox(width: 5),
//                   TextN(
//                     '취소'.tr,
//                     color: tm.white,
//                     fontSize: tm.s20,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       //----------------------------------------------------------------------
//       // 저장 버튼
//       //----------------------------------------------------------------------
//       Container(
//         width: asWidth(1),
//         color: tm.white,
//       ),
//       Expanded(
//         child: InkWell(
//           //----------------------------------------------------------------
//           // 저장 진행
//           onTap: (() async {
//             //------------------------------------------------------------
//             // 측정 종료 명령 - 중복클릭 방지
//             var _dialog = openPopupProcessIndicator(
//               context,
//               text: '저장 중입니다',
//             );
//             //------------------------------------------------------------
//             // 저장 명령
//             await saveMeasureData();
//             //------------------------------------------------------------
//             // 다이올로그 닫기
//             Navigator.pop(context, _dialog);
//
//             //------------------------------------------------------------
//             // 새로 측정된 근력 값으로 갱신
//             int d = 0;
//             int setIdx = 0;
//             gv.deviceData[d].mvc.value = (max(dm[d].g.report.w1RmNew[setIdx],
//                     dm[d].g.report.w1Rm[setIdx]))
//                 .toPrecision(4);
//
//             //------------------------------------------------------------
//             // 새로 측정데이터 내용을 통계 그래프에 업데이트
//             await updateGraphData(timePeriod: gvRecord.graphTimePeriod.value);
//
//             //-----------------------------------------------------------
//             // 오디오 플레이 - 저장성공
//             gv.audioManager.play(type: EmaSoundType.saveSuccess);
//             //------------------------------------------------------------
//             // 측정 대기 페이지로 이동
//             Get.back();
//           }),
//           child: Ink(
//             color: tm.blue,
//             child: Container(
//               alignment: Alignment.center,
//               // color: tm.blue,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.save_outlined,
//                     size: asHeight(30),
//                     color: tm.white.withOpacity(0.5),
//                   ),
//                   asSizedBox(width: 5),
//                   TextN(
//                     '저장'.tr,
//                     color: tm.white,
//                     fontSize: tm.s20,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
