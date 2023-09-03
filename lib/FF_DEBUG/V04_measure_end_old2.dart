// import '/F0_BASIC/common_import.dart';
//
// bool _is1RmRefNewMeasure = true; //reference MVC가 최신 것인지 이전 것인지 알림
//
// //==============================================================================
// // 측정 종료단계
// //==============================================================================
// class MeasureEnd extends StatefulWidget {
//   const MeasureEnd({Key? key}) : super(key: key);
//
//   @override
//   State<MeasureEnd> createState() => _MeasureEndState();
// }
//
// class _MeasureEndState extends State<MeasureEnd> {
//   //----------------------------------------------------
//   // 최대근력 갱신 관련 변수들
//   late int d;
//   int setIdx = 0;
//   late double oneRmPrevious; // = dm[d].g.report.w1Rm[setIdx];
//   late double oneRmNew; //= dm[d].g.report.w1RmNew[setIdx];
//   late bool isNew1RmIsBig; // = oneRmNew < oneRmPrevious; //테스트
//   String timeStr = timeToStringBasic(timeSec: DspManager.timeMeasure.value);
//
//   @override
//   void initState() {
//     d = 0; //device index
//     setIdx = 0; // set index (basic 은 단일 세트 운동)
//     //----------------------------------------------------
//     // 최대근력 갱신 관련 변수 초기화
//     oneRmPrevious = dm[d].g.report.w1Rm[setIdx];
//     oneRmNew = dm[d].g.report.w1RmNew[setIdx];
//     isNew1RmIsBig = oneRmNew > oneRmPrevious; //테스트
//     timeStr = timeToStringBasic(timeSec: DspManager.timeMeasure.value);
//     //---------------------------------------------------------
//     // 새로운 값이 큰 경우 운동량 계산 기준은 무조건 새로운 값
//     // 기존 값이 크다면, 운동량 계산 기준은, 버튼 설정에 따라 변경 가능
//     // 기본은 새로운 값이 운동량 계산 기준 값이 됨
//     _is1RmRefNewMeasure = true;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     isNew1RmIsBig = false; //삭제예정
//     Wakelock.disable(); //화면 켜짐 해제
//     return Material(
//       color: tm.white,
//       child: SafeArea(
//         child: Stack(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 //------------------------------------------------------------------
//                 // 상단 바
//                 // topBarBasic(context),
//                 topBarGuide(context, isViewXButton: false, isMeasureEnd: true),
//                 //------------------------------------------------------------
//                 // 최대근력 표시
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         //------------------------------------------------------------
//                         // 성과
//                         // asSizedBox(height: 20),
//                         _award(),
//                         asSizedBox(height: 30),
//                         //------------------------------------------------------------
//                         // 최대근력 결과
//                         _oneRmResult(),
//                         asSizedBox(height: 30),
//                         dividerBig(),
//                         asSizedBox(height: 20),
//                         //------------------------------------------------------------
//                         // 측정 품질 안내 문구
//                         _measureQualityBrief(),
//                         asSizedBox(height: 40),
//                         //------------------------------------------------------------
//                         // 결과 요약
//                         _resultBrief(),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 //------------------------------------------------------------------
//                 // 하부영역 - 스크롤 - 리포트
//               ],
//             ),
//             //------------------------------------------------------------
//             // 버튼
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 _saveOrNotButton(context),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 운동 성과
//   ///---------------------------------------------------------------------------
//   Widget _award() {
//     int setIdx = 0;
//     int resultGrade = 0; //bad(0), good(1), great(2), over(3), very over(4)
//     int numOfStart = resultGrade + 1;
//     double aoeSet = dm[0].g.report.aoeSet[setIdx] * 100;
//     Color _color = tm.grey04;
//     String aoeSetStr = aoeSet.toStringAsFixed(1);
//
//     //------------------------ 조금 부족해요
//     if (aoeSet < 50) {
//       resultGrade = 0;
//       numOfStart = 1;
//       _color = tm.grey04;
//     }
//     //------------------------ 많이 무리했어요
//     else if (aoeSet > 400) {
//       resultGrade = 4;
//       numOfStart = 0;
//       _color = tm.red;
//     }
//     //------------------------ 조금 무리했어요
//     else if (aoeSet > 200) {
//       resultGrade = 3;
//       numOfStart = 1;
//       _color = tm.red;
//     }
//     //------------------------ 좋아요
//     else if (aoeSet > 150 || aoeSet < 70) {
//       resultGrade = 1;
//       numOfStart = 2;
//       _color = tm.green;
//     }
//     //------------------------ 훌륭해요 (70 ~ 150)
//     else {
//       resultGrade = 2;
//       numOfStart = 3;
//       _color = tm.blue;
//     }
//
//     return SizedBox(
//       // height: asHeight(115), //37+28
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           //----------------------------------------------------------------------
//           // background - 목표 달성한 경우에만 표시
//           //----------------------------------------------------------------------
//           if (resultGrade == 2) //great 일 대
//             Image.asset(
//               'assets/images/effect_bg.png',
//               height: asHeight(100),
//             ),
//           Column(
//             children: [
//               //------------------------------------------------------------------
//               // 별과 이모티콘
//               //------------------------------------------------------------------
//               asSizedBox(height: 20),
//               Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   //------------------------------------------------------------------
//                   // 아쉬워요, 좋아요, 훌륭해요 3개에서만 별 표시
//                   //------------------------------------------------------------------
//                   // if (numOfStart != 0)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       //----------------------------------------------
//                       // 첫번째 별
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           asSizedBox(height: asHeight(10)),
//                           Opacity(
//                               opacity: numOfStart >= 1 ? 1 : 0.2,
//                               child: Image.asset(
//                                 'assets/icons/ic_star.png',
//                                 height: asHeight(20),
//                               )),
//                         ],
//                       ),
//                       //----------------------------------------------
//                       //두번째 별
//                       asSizedBox(width: 4),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           //asSizedBox(height: asHeight(10)),
//                           Opacity(
//                               opacity: numOfStart >= 2 ? 1 : 0.2,
//                               child: Image.asset(
//                                 'assets/icons/ic_star.png',
//                                 height: asHeight(20),
//                               )),
//                         ],
//                       ),
//                       //----------------------------------------------
//                       //세번째 별
//                       asSizedBox(width: 4),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           asSizedBox(height: asHeight(10)),
//                           Opacity(
//                               opacity: numOfStart >= 3 ? 1 : 0.2,
//                               child: Image.asset(
//                                 'assets/icons/ic_star.png',
//                                 height: asHeight(20),
//                               )),
//                         ],
//                       ),
//                     ],
//                   ),
//                   //------------------------------------------------------------------------
//                   // 성과 이모티콘 표시
//                   //------------------------------------------------------------------------
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       asSizedBox(height: 28),
//                       Image.asset(
//                         //-------------- 결과에 따른 이모티콘
//                         resultGrade == 0
//                             ? 'assets/icons/ic_not_good.png'
//                             : resultGrade == 1
//                                 ? 'assets/icons/ic_good.png'
//                                 : resultGrade == 2
//                                     ? 'assets/icons/ic_great.png'
//                                     : resultGrade == 3
//                                         ? 'assets/icons/ic_over.png'
//                                         : 'assets/icons/ic_very_over.png',
//                         height: asHeight(37),
//                         //-------------- 결과에 이모티콘 색상
//                         color: _color,
//                       ),
//                       //------------------------------------------------------------------------
//                       // 성과 글씨 표시
//                       //------------------------------------------------------------------------
//                       asSizedBox(height: 15),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           TextN(
//                             '운동량($aoeSetStr%)  ',
//                             fontSize: tm.s16,
//                             color: _color,
//                           ),
//                           TextN(
//                             resultGrade == 0
//                                 ? '조금 부족해요'
//                                 : resultGrade == 1
//                                     ? '좋아요!'
//                                     : resultGrade == 2
//                                         ? '훌륭해요!' //목표 달성
//                                         : resultGrade == 3
//                                             ? '조금 무리했어요'
//                                             : '많이 무리했어요!',
//                             fontSize: tm.s20,
//                             fontWeight: FontWeight.bold,
//                             color: _color,
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 최대근력 측정 결과
//   ///---------------------------------------------------------------------------
//   Widget _oneRmResult() {
//     return Container(
//       // height: asHeight(266),
//       // alignment: Alignment.center,
//       padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//       // color: Colors.yellow,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           //----------------------------------------------------------------------
//           // 최대근력 값 갱신 알림
//           //----------------------------------------------------------------------
//           if (isNew1RmIsBig)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // TextN('더 큰 '.tr, fontSize: tm.s16, color: tm.black),
//                 TextN(
//                   '최대근력(1RM)'.tr,
//                   fontSize: tm.s16,
//                   color: tm.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 TextN('이 증가했습니다!'.tr, fontSize: tm.s16, color: tm.black),
//               ],
//             ),
//           if (isNew1RmIsBig) asSizedBox(height: 20),
//           //----------------------------------------------------------------------
//           // 운동시간 및 단위
//           //----------------------------------------------------------------------
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/icons/ic_time.png',
//                     height: asHeight(14),
//                   ),
//                   asSizedBox(width: 4),
//                   TextN(
//                     '운동시간: $timeStr',
//                     fontSize: tm.s14,
//                     color: tm.grey04,
//                     height: 1,
//                   ),
//                 ],
//               ),
//               TextN(
//                 '단위: ${gv.setting.isViewUnitKgf.value == false ? 'mV' : 'kgf'}',
//                 fontSize: tm.s12,
//                 color: tm.grey04,
//                 height: 1,
//               ),
//             ],
//           ),
//           asSizedBox(height: 12),
//           //----------------------------------------------------------------------
//           // 최대근력 결과 박스
//           //----------------------------------------------------------------------
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               //------------------------------------------------------------------
//               // 이전 1RM
//               Container(
//                 width: asWidth(155),
//                 height: asHeight(104),
//                 padding: EdgeInsets.symmetric(
//                     horizontal: asWidth(14), vertical: asHeight(14)),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(asHeight(16)),
//                   color: tm.grey01,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //------------------------------------------------------------
//                     // 상단
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                             height: asHeight(20),
//                             alignment: Alignment.center,
//                             child: TextN('최대근력(1RM)',
//                                 fontSize: tm.s12, color: tm.grey03)),
//                         if (_is1RmRefNewMeasure == false)
//                           Container(
//                             alignment: Alignment.center,
//                             height: asHeight(20),
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: asHeight(5)),
//                             decoration: BoxDecoration(
//                                 color: tm.grey03,
//                                 borderRadius:
//                                     BorderRadius.circular(asHeight(6))),
//                             child: TextN(
//                               '기준',
//                               fontSize: tm.s12,
//                               color: tm.grey01,
//                             ),
//                           ),
//                       ],
//                     ),
//                     //------------------------------------------------------------
//                     // 하단
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         //--------------------------------------------------------
//                         // 신규 1RM
//                         TextN(
//                             convertMvcToDisplayValue(
//                                 dm[0].g.report.w1Rm[setIdx],
//                                 isViewUnit: false),
//                             fontSize: tm.s28,
//                             fontWeight: FontWeight.bold,
//                             color: tm.grey04),
//                         //--------------------------------------------------------
//                         // 역대 최대
//                         TextN('max 3.9', fontSize: tm.s12, color: tm.grey04),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               //------------------------------------------------------------------
//               // 신규 1RM
//               Container(
//                 width: asWidth(155),
//                 height: asHeight(104),
//                 padding: EdgeInsets.symmetric(
//                     horizontal: asWidth(14), vertical: asHeight(14)),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(asHeight(16)),
//                   color: tm.blue.withOpacity(0.1),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //------------------------------------------------------------
//                     // 상단
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                             height: asHeight(20),
//                             alignment: Alignment.center,
//                             child: TextN('신규 측정',
//                                 fontSize: tm.s12, color: tm.blue)),
//                         if (_is1RmRefNewMeasure == true)
//                           Container(
//                             alignment: Alignment.center,
//                             height: asHeight(20),
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: asHeight(5)),
//                             decoration: BoxDecoration(
//                                 color: tm.blue,
//                                 borderRadius:
//                                     BorderRadius.circular(asHeight(6))),
//                             child: TextN(
//                               '기준',
//                               fontSize: tm.s12,
//                               color: tm.grey01,
//                             ),
//                           ),
//                       ],
//                     ),
//                     //------------------------------------------------------------
//                     // 하단
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         //--------------------------------------------------------
//                         // 신규 1RM
//                         TextN(
//                             convertMvcToDisplayValue(
//                                 dm[0].g.report.w1RmNew[setIdx],
//                                 isViewUnit: false),
//                             fontSize: tm.s28,
//                             fontWeight: FontWeight.bold,
//                             color: tm.blue),
//                         //asSizedBox(width: 12),
//                         //--------------------------------------------------------
//                         // 상승 % 박스 (현재 값이 더 클때만 표시)
//                         if (isNew1RmIsBig)
//                           Row(
//                             children: [
//                               Container(
//                                 width: asWidth(50),
//                                 alignment: Alignment.centerRight,
//                                 // color: Colors.red,
//                                 child: FittedBoxN(
//                                   child: TextN(
//                                     '+${toStrFixedAuto(oneRmNew / oneRmPrevious * 100 - 100)}%',
//                                     fontSize: tm.s14,
//                                     color: tm.blue,
//                                     // fontWeight: FontWeight.w900,
//                                   ),
//                                 ),
//                               ),
//                               asSizedBox(width: 2),
//                               Image.asset(
//                                 'assets/icons/ic_arrow_up_2.png',
//                                 color: tm.blue,
//                                 height: asHeight(12),
//                               ),
//                               asSizedBox(width: 10),
//                             ],
//                           ),
//
//                         // Container(
//                         //   // margin: EdgeInsets.only(right: asWidth(30)),
//                         //   width: asWidth(67),
//                         //   height: asHeight(26),
//                         //   alignment: Alignment.center,
//                         //   decoration: BoxDecoration(
//                         //       color: tm.blue,
//                         //       borderRadius: BorderRadius.circular(asHeight(13))),
//                         //   child: FittedBoxN(
//                         //     child: TextN(
//                         //       '+${toStrFixedAuto(oneRmNew / oneRmPrevious * 100 - 100)}%',
//                         //       fontSize: tm.s14,
//                         //       color: tm.white,
//                         //       // fontWeight: FontWeight.w900,
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           //----------------------------------------------------------------------
//           // 1RM 기준 변경 버튼
//           // 최종 단계에서 기준값 변경하는 것은 혼란을 유발할 수 있어 일단 구현 안함
//           // 나중에 필요 시 재 검토
//           //----------------------------------------------------------------------
//           // if (!isNew1RmIsBig) asSizedBox(height: 10),
//           // if (!isNew1RmIsBig)
//           //   Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     children: [
//           //       //----------------------------------------------------------------
//           //       // 기준 변경 버튼
//           //       wButtonAwGeneral(
//           //           // width: asWidth(125),
//           //           height: asHeight(34),
//           //           touchHeight: asHeight(54),
//           //           padWidth: asWidth(12),
//           //           padTouchWidth: 0,
//           //           borderColor: tm.blue.withOpacity(0.3),
//           //           // touchWidth: asWidth(125),
//           //           child: Row(
//           //             children: [
//           //               TextN(
//           //                 '1RM 기준값 변경',
//           //                 fontSize: tm.s14,
//           //                 color: tm.blue,
//           //               ),
//           //               asSizedBox(width: 10),
//           //               Image.asset('assets/icons/ic_refresh.png',
//           //                   height: asHeight(14), color: tm.blue),
//           //             ],
//           //           ),
//           //           //
//           //           // title: '기준 1RM 변경',
//           //           // fontSize: tm.s14,
//           //           onTap: (() {
//           //             // 새로운 1RM이 이전보다 작은 경우에만 변경 가능
//           //             if (isNew1RmIsBig == false) {
//           //               _is1RmRefNewMeasure = !_is1RmRefNewMeasure;
//           //               setState(() {});
//           //             }
//           //           })),
//           //       // asSizedBox(width: 8),
//           //       InkWell(
//           //         //----------------------------------------------------------------
//           //         // 도움말 설명 글
//           //         onTap: (() {
//           //           openPopupBasic(SizedBox(
//           //             height: asHeight(400),
//           //             child: Column(
//           //               children: [
//           //                 asSizedBox(width: 20),
//           //                 textTitleSmall('1RM 기준 값 변경'),
//           //                 textNormalC(
//           //                     '다음 조건에서 운동량 계산을 위한 1RM 기준 값을 변경할 수 있습니다.'),
//           //                 textSub('설정에서 1RM 자동추정 기능이 해제되어 있는 경우'),
//           //                 textSub('새로 측정한 1RM이 이전의 1RM 보다 작은 경우'),
//           //                 textNormalC('전극부착 위치가 변경되어 신규 1RM 값이 이전보다 크게 작아진 경우,'
//           //                     ' 계산 기준을 신규 1RM으로 변경하여, 세트 운동량을 좀 더 정확하게 계산할 수 있습니다.'),
//           //                 textNormalC(
//           //                     '부착위치가 자주 변한다면 세트 설정에서 1RM 자동추정 기능을 활성화 하세요.'),
//           //               ],
//           //             ),
//           //           ));
//           //         }),
//           //         borderRadius: BorderRadius.circular(asHeight(8)),
//           //         //----------------------------------------------------------------
//           //         // 도움말 아이콘
//           //         child: Container(
//           //           padding: EdgeInsets.symmetric(
//           //               horizontal: asWidth(10), vertical: asHeight(10)),
//           //           alignment: Alignment.center,
//           //           child: Image.asset(
//           //             'assets/icons/ic_help_line.png',
//           //             height: asHeight(20),
//           //             color: tm.blue.withOpacity(0.3),
//           //           ),
//           //         ),
//           //       )
//           //     ],
//           //   ),
//           //----------------------------------------------------------------------
//           // 운동시간
//           //----------------------------------------------------------------------
//           // asSizedBox(height: 2),
//         ],
//       ),
//     );
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 측정품질 요약 및 펼치기
//   ///---------------------------------------------------------------------------
//   Widget _measureQualityBrief() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             TextN('이번 측정 결과는 양호합니다', fontSize: tm.s14, color: tm.black),
//           ],
//         ),
//         //----------------------------------------------------------------------
//         // 측정 품질 펼치기를 한 경우
//         measureQualityDetail(),
//       ],
//     );
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 측정결과 테이블
//   ///---------------------------------------------------------------------------
//   Widget _resultBrief() {
//     // 시간 표시 변환
//     int setIdx = 0;
//     String timeStr = timeToStringBasic(timeSec: DspManager.timeMeasure.value);
//     String aoeSet =
//         (dm[0].g.report.aoeSet[setIdx] * 100).toStringAsFixed(1) + '%';
//     String aoeTarget =
//         (dm[0].g.report.aoeTargetSet[setIdx] * 100).toStringAsFixed(1) + '%';
//     String sign =
//         gv.deviceData[0].freqEnd.value > gv.deviceData[0].freqBegin.value
//             ? '+'
//             : '';
//     String freqChange = sign +
//         (gv.deviceData[0].freqEnd.value - gv.deviceData[0].freqBegin.value)
//             .toStringAsFixed(1) +
//         'Hz';
//     // 휴식시간은 목표 %1RM에 따라 변화 (실제 측정 값이 반영되지 않음)
//     String relaxTime =
//         prmToRelaxTime(gv.deviceData[0].targetPrm.value).toString() + '초'.tr;
//
//     //---------------------------------------------------------------
//     //
//     // Container(
//     //   alignment: Alignment.bottomLeft,
//     //   height: asHeight(40),
//     //   child: isTooBig
//     //       ? TextN(
//     //           '! 새로운 값이 30% 이상 큽니다. 잘못 측정된 경우라면 결과를 저장하지 마시고 취소하세요.',
//     //           fontSize: tm.s15,
//     //           color: tm.blue.withOpacity(0.8),
//     //         )
//     //       : Container(),
//     // ),
//
//     return Container(
//       height: asHeight(266),
//       alignment: Alignment.center,
//       padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//       // color: Colors.yellow,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           //----------------------------------------------------------------------
//           // 좌측 결과
//           //----------------------------------------------------------------------
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //------------------------------------------------------------------
//               // 운동결과 요약
//               _titleContents('운동 시간', timeStr),
//               asSizedBox(height: 10),
//               _titleContents('세트 운동량', aoeSet),
//               asSizedBox(height: 10),
//               _titleContents('목표영역 운동량', aoeTarget),
//               asSizedBox(height: 10),
//               _titleContents('주파수 변화', freqChange),
//               asSizedBox(height: 10),
//               _titleContents('권장 휴식시간', relaxTime),
//             ],
//           ),
//           //----------------------------------------------------------------------
//           // 우측 휴식시간
//           //----------------------------------------------------------------------
//           Container(
//             width: asWidth(132),
//             alignment: Alignment.center,
//             child: FittedBoxN(
//               //------------------------------------------------------------------
//               // 훌룽해요
//               child: gv.deviceData[0].aoeSet >= GvDef.aoeGreat
//                   ? Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         TextN(
//                           '훌륭해요!!!',
//                           fontSize: tm.s18,
//                           color: tm.blue,
//                         ),
//                         asSizedBox(height: 10),
//                         Image.asset(
//                           'assets/icons/ic_great.png',
//                           fit: BoxFit.scaleDown,
//                           height: asHeight(90),
//                           color: tm.blue,
//                         ),
//                       ],
//                     )
//                   //------------------------------------------------------------------
//                   // 좋아요
//                   : gv.deviceData[0].aoeSet >= GvDef.aoeGood
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             TextN(
//                               '좋아요!!',
//                               fontSize: tm.s18,
//                               color: tm.blue,
//                             ),
//                             asSizedBox(height: 10),
//                             Image.asset(
//                               'assets/icons/ic_good.png',
//                               fit: BoxFit.scaleDown,
//                               height: asHeight(90),
//                               color: tm.blue,
//                             ),
//                           ],
//                         )
//                       //------------------------------------------------------------------
//                       // 아쉬워요
//                       : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             TextN(
//                               '아쉬워요!',
//                               fontSize: tm.s18,
//                               color: tm.blue,
//                             ),
//                             asSizedBox(height: 10),
//                             Image.asset(
//                               'assets/icons/ic_bad.png',
//                               fit: BoxFit.scaleDown,
//                               height: asHeight(90),
//                               color: tm.blue,
//                             ),
//                           ],
//                         ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
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
//   return Material(
//     color: tm.white,
//     child: Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           asSizedBox(height: 10),
//           //----------------------------------------------------------------------
//           // 저장 버튼
//           //----------------------------------------------------------------------
//           InkWell(
//               borderRadius: BorderRadius.circular(asHeight(8)),
//             //----------------------------------------------------------------
//             // 저장 진행
//             onTap: (() async {
//               //------------------------------------------------------------
//               // 측정 종료 명령 - 중복클릭 방지
//               var _dialog = openPopupProcessIndicator(
//                 context,
//                 text: '저장 중입니다',
//               );
//               //------------------------------------------------------------
//               // 저장 명령
//               await saveMeasureData();
//               //------------------------------------------------------------
//               // 다이올로그 닫기
//               Navigator.pop(context, _dialog);
//
//               //------------------------------------------------------------
//               // 새로 측정된 근력 값으로 갱신
//               int d = 0;
//               int setIdx = 0;
//               gv.deviceData[d].mvc.value = (max(dm[d].g.report.w1RmNew[setIdx],
//                       dm[d].g.report.w1Rm[setIdx]))
//                   .toPrecision(4);
//
//               //------------------------------------------------------------
//               // 새로 측정데이터 내용을 통계 그래프에 업데이트
//               await updateGraphData(timePeriod: gvRecord.graphTimePeriod.value);
//
//               //-----------------------------------------------------------
//               // 오디오 플레이 - 저장성공
//               gv.audioManager.play(type: EmaSoundType.saveSuccess);
//               //------------------------------------------------------------
//               // 측정 대기 페이지로 이동
//               Get.back();
//             }),
//             child: Ink(
//               decoration: BoxDecoration(
//                   color: tm.blue,
//                   borderRadius: BorderRadius.circular(asHeight(8))),
//               width: asWidth(342),
//               height: asHeight(52),
//               child: Container(
//                 alignment: Alignment.center,
//                 child : TextN(
//                   '저장하기'.tr,
//                   color: tm.white,
//                   fontSize: tm.s16,
//                   fontWeight: FontWeight.bold,
//                 ),
//
//               ),
//             ),
//           ),
//           //----------------------------------------------------------------------
//           // 취소 버튼
//           //----------------------------------------------------------------------
//           asSizedBox(height: 10),
//           InkWell(
//             borderRadius: BorderRadius.circular(asHeight(8)),
//             onTap: (() {
//               // 취소 시 원래 값으로 복귀
//               gv.deviceData[0].mvc.value =
//                   gv.dbMuscleIndexes[gv.control.idxMuscle.value].mvcMv;
//               Get.back();
//             }),
//             child: Ink(
//               decoration: BoxDecoration(
//                   color: tm.white,
//                   borderRadius: BorderRadius.circular(asHeight(8))),
//               width: asWidth(342),
//               height: asHeight(52),
//               child: Container(
//                 alignment: Alignment.center,
//                 // color: tm.blue,
//                 child: TextN(
//                   '취소'.tr,
//                   color: tm.grey04,
//                   fontSize: tm.s16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           asSizedBox(height: 0),
//         ],
//       ),
//     ),
//   );
// }
