// import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
//
// //==============================================================================
// // contents
// //==============================================================================
//
// class MuscleGuidePage extends StatefulWidget {
//   const MuscleGuidePage({Key? key}) : super(key: key);
//
//   @override
//   State<MuscleGuidePage> createState() => _MuscleGuidePageState();
// }
//
// class _MuscleGuidePageState extends State<MuscleGuidePage> {
//   //--------------------------- 스크롤에 따른 메뉴 변경
//   final ScrollController _scrollController = ScrollController();
//
//   // late Timer _timer;
//   bool _flagIsScrollPositionZero = true; //스크롤이 처음 위치인지 여부
//   bool _flagIsScrollPositionZero_1p = true; //변화 감지용
//   // double scrollPosition = 0;
//   // double scrollPosition_1p = 0;
//   //--------------------------- 근육 관련
//   static int _contentsIdx = 0;
//   List<String> muscleTypeName = ['팔', '어깨', '가슴', '복부', '등', '엉덩이', '다리'];
//
//   @override
//   void initState() {
//     _flagIsScrollPositionZero = true;
//     _flagIsScrollPositionZero_1p = true;
//     //--------------------------------------------------------------------------
//     // 스크롤 위치 초기 값 설정하기 - 화면이 그려진 100ms 후에 동작
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
//       // 처음 위치로 스크롤 초기화
//       scrollPositionInit();
//       //----------------------------------------------
//       // 스크롤 리스너 추가 (처음위치인지 여부 알림)
//       _scrollController.addListener(_scrollListener);
//     });
//
//     super.initState();
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 해제하기
//   ///---------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 스크롤 상태 읽기
//   ///---------------------------------------------------------------------------
//   void _scrollListener() {
//     // if (_scrollController.position.pixels < 1) {
//     //   _flagIsScrollPositionZero = true;
//     // } else {
//     //   _flagIsScrollPositionZero = false;
//     // }
//
//     // 화면 접속 시 처음 1회만 큰 화면 이후 나머지는 작은 메뉴 화면
//     if (_scrollController.position.pixels > 1) {
//       _flagIsScrollPositionZero = false;
//     }
//
//     //------------------------------------------------------------
//     // 처음위치 / 아닌위치 변화가 생겼다면 화면 갱신
//     if (_flagIsScrollPositionZero_1p != _flagIsScrollPositionZero) {
//       setState(() {});
//       if (kDebugMode) {
//         print('근육 정보 스크롤 처음위치 여부 : $_flagIsScrollPositionZero');
//       }
//     }
//     _flagIsScrollPositionZero_1p = _flagIsScrollPositionZero;
//     // print(_scrollController.position.pixels); // 현재 스크롤 위치 값 출력
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 맨 처음 위치로 스크롤 위치 점프
//   ///---------------------------------------------------------------------------
//   void scrollPositionInit() {
//     //----------------------------------------------
//     // 스크롤이 준비 되었으면 점프
//     if (_scrollController.hasClients) {
//       double jumpPosition = 0;
//       //---------------------------- 애니메이션 점프
//       _scrollController.animateTo(jumpPosition,
//           duration: const Duration(milliseconds: 300), curve: Curves.ease);
//       //---------------------------- 바로 점프
//       // _scrollController.jumpTo(jumpPosition); //바로가기
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// build
//   ///---------------------------------------------------------------------------
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         color: tm.white,
//         child: SafeArea(
//           child: Column(
//             children: [
//               //----------------------------------------------------------------
//               // 상단 바
//               //----------------------------------------------------------------
//               topBarBack(context, title: '근육 부착 위치'),
//               asSizedBox(height: 10),
//               //----------------------------------------------------------------
//               // 상단 근육 버튼 선택 - 처음에는 크게, 스크롤 한번 하면 작게 변경
//               // 스크롤이 처음 지점으로 오면 다시 크게 변경
//               //----------------------------------------------------------------
//               AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 500),
//                 child: _flagIsScrollPositionZero
//                     ? _muscleTypeSelectInit()
//                     : _muscleTypeSelectSmall(),
//                 transitionBuilder: (child, animation) {
//                   return SizeTransition(
//                     child: child,
//                     axisAlignment: -1.0, //위쪽으로 정렬
//                     sizeFactor: Tween<double>(
//                       begin: 0, // 높이가 0으로 시작하도록 함
//                       end: 1, // 높이가 원래 크기(100%)로 펼쳐지도록 함
//                     ).animate(animation),
//                   );
//                 },
//               ),
//
//               // _flagIsScrollPositionZero == true
//               //     ? _muscleTypeSelectInit()
//               //     : _muscleTypeSelectSmall(),
//               //----------------------------------------------------------------
//               //  하단 메뉴
//               //----------------------------------------------------------------
//               asSizedBox(height: 10),
//               _muscleGuideOption(),
//               //----------------------------------------------------------------
//               // 하단 도움말 내용
//               //----------------------------------------------------------------
//               Expanded(
//                 child: Scrollbar(
//                   controller: _scrollController,
//                   child: SingleChildScrollView(
//                     controller: _scrollController,
//                     child: Container(
//                         padding: EdgeInsets.symmetric(
//                             // horizontal: asWidth(18),
//                             vertical: asHeight(18)),
//                         child: muscleGuideContents(contentsIdx: _contentsIdx)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 근육 종류 선택 - 시작단계
//   /// --------------------------------------------------------------------------
//   Widget _muscleTypeSelectInit() {
//     return Column(
//       children: [
//         Container(
//           color: tm.grey02,
//           padding: EdgeInsets.symmetric(vertical: asHeight(18)),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(
//                       3,
//                       (index) => _muscleTypeBox(
//                           onTap: (() {
//                             _contentsIdx = index;
//                             scrollPositionInit(); //스크롤 처음 위치로
//                             setState(() {});
//                           }),
//                           isSelected: _contentsIdx == index,
//                           title: muscleTypeName[index])),
//                 ),
//               ),
//               asSizedBox(height: 6),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(
//                       3,
//                       (index) => _muscleTypeBox(
//                           onTap: (() {
//                             _contentsIdx = index + 3;
//                             setState(() {});
//                           }),
//                           isSelected: _contentsIdx == index + 3,
//                           title: muscleTypeName[index + 3])),
//                 ),
//               ),
//               asSizedBox(height: 6),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _muscleTypeBox(
//                         onTap: (() {
//                           _contentsIdx = 6;
//                           setState(() {});
//                         }),
//                         isSelected: _contentsIdx == 6,
//                         title: '다리'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 근육 종류 선택 - 스크롤 단계
//   /// --------------------------------------------------------------------------
//   Widget _muscleTypeSelectSmall() {
//     double buttonHeight = asHeight(44);
//     double buttonPadWidth = asWidth(10);
//
//     //----------------------------------------------------------------------------
//     // 분석 할 데이터가 늘어나면 스크롤로 데이터 선택
//     //----------------------------------------------------------------------------
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: asWidth(13)),
//       child: SizedBox(
//         height: buttonHeight,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: muscleTypeName.length,
//           itemBuilder: (context, index) {
//             return InkWell(
//               borderRadius: BorderRadius.circular(asWidth(10)),
//               onTap: () {
//                 _contentsIdx = index;
//                 // scrollPositionInit(); //스크롤 처음 위치로
//                 setState(() {});
//               },
//               child: _muscleMenuBox(
//                 isSelected: _contentsIdx == index,
//                 // 바뀌는 부분
//                 padWidth: buttonPadWidth,
//                 height: buttonHeight,
//                 title: muscleTypeName[index],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _muscleMenuBox({
//     bool isSelected = false,
//     double padWidth = 10,
//     double height = 40,
//     String title = 'title',
//   }) {
//     return Container(
//       alignment: Alignment.center,
//       height: height,
//       padding: EdgeInsets.symmetric(horizontal: padWidth),
//       margin: EdgeInsets.symmetric(horizontal: asWidth(5)),
//       decoration: BoxDecoration(
//         border: Border(
//             bottom: BorderSide(
//                 width: asHeight(4),
//                 color: isSelected
//                     ? tm.blue.withOpacity(0.2)
//                     : Colors.transparent)),
//         // borderRadius: BorderRadius.circular(radius),
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           //----------------------------------------------------------------------
//           // 텍스트
//           TextN(
//             title,
//             fontSize: tm.s16,
//             color: isSelected ? tm.blue : tm.grey03,
//             fontWeight: FontWeight.w900,
//             textAlign: TextAlign.center,
//           ),
//           //----------------------------------------------------------------------
//           // 하단 줄표
//           if (isSelected)
//             Container(
//               alignment: Alignment.bottomCenter,
//               // width: width,
//               height: height,
//               child: Container(
//                 // width: width * 0.8,
//                 height: asHeight(6),
//                 decoration: BoxDecoration(
//                   color: tm.blue.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 보기 선택 옵션 메뉴
//   /// --------------------------------------------------------------------------
//   Widget _muscleGuideOption() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: asWidth(3)),
//       child: Column(
//         children: [
//           //--------------------------------------------------------------------
//           // 주의 사항
//           //--------------------------------------------------------------------
//           InkWell(
//             onTap: (() {
//               openBottomSheetBasic(
//                   height: asHeight(800),
//                   child: muscleGuideCaution(),
//                   isHeadView: true,
//                   headTitle: '주의사항');
//             }),
//             borderRadius: BorderRadius.circular(asHeight(8)),
//             child: Container(
//               height: asHeight(54),
//               padding: EdgeInsets.symmetric(horizontal: asWidth(10)),
//               child: Row(
//                 children: [
//                   Container(
//                     height: asHeight(14),
//                     width: asHeight(14),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: tm.grey03,
//                       borderRadius: BorderRadius.circular(asHeight(7)),
//                     ),
//                     child: TextN(
//                       '!',
//                       color: tm.white,
//                       fontSize: tm.s12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   // Image.asset(
//                   //   'assets/icons/ic_도움말.png',
//                   //   height: asHeight(14),
//                   // ),
//                   asSizedBox(width: 6),
//                   TextN('주의사항', fontSize: tm.s14, color: tm.grey03),
//                 ],
//               ),
//             ),
//           ),
//           //--------------------------------------------------------------------
//           // 부착/사진
//           //--------------------------------------------------------------------
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//
//               Row(
//                 children: [
//                   wButtonAwSel(
//                       child: TextN(
//                         '가이드 종류',
//                         fontSize: tm.s14,
//                         color: tm.black,
//                       ),
//                       height: asHeight(34),
//                       touchHeight: asHeight(54),
//                       padTouchWidth: asWidth(10),
//                       onTap: (() {
//                         dvSetting.isOptionGuide = true;
//                         openBottomSheetBasic(
//                           height: asHeight(300),
//                           child: GuideOptionSelect(
//                             callbackOption: (() {
//                               setState(() {});
//                             }),
//                             callbackMode: (() {
//                               setState(() {});
//                             }),
//                           ),
//                         );
//                       })),
//                   // asSizedBox(width: 10),
//                   wButtonAwSel(
//                       child: TextN(
//                         '좌/우',
//                         fontSize: tm.s14,
//                         color: tm.black,
//                       ),
//                       height: asHeight(34),
//                       touchHeight: asHeight(54),
//                       padTouchWidth: asWidth(10),
//                       onTap: (() {
//                         dvSetting.isOptionGuide = false;
//                         openBottomSheetBasic(
//                           height: asHeight(300),
//                           child: GuideOptionSelect(
//                             callbackOption: (() {
//                               setState(() {});
//                             }),
//                             callbackMode: (() {
//                               setState(() {});
//                             }),
//                           ),
//                         );
//                       })),
//                   asSizedBox(width: 3),
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
//   /// 근육 종류 박스
//   ///---------------------------------------------------------------------------
//   Widget _muscleTypeBox({
//     Function()? onTap,
//     String title = '',
//     bool isSelected = false,
//   }) {
//     return textButtonSel(
//         title: title,
//         onTap: onTap,
//         width: asWidth(104),
//         height: asHeight(45),
//         radius: asWidth(0),
//         // touchRadius: asWidth(10),
//         // touchWidth: asWidth(82),
//         // touchHeight: asHeight(46),
//         isSelected: isSelected,
//         fontSize: tm.s16);
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 주의사항
//   ///---------------------------------------------------------------------------
// }
