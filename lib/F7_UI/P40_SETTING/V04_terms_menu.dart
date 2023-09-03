import '/F0_BASIC/common_import.dart';

//==============================================================================
// setting main
//==============================================================================

class TermsMainPage extends StatelessWidget {
  const TermsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //------------------------------------------------------------------
              // 상단 바
              topBarBack(context, title: '약관 및 정책'),
              //------------------------------------------------------------------
              // 하단 메뉴
              asSizedBox(height: 26),
              _termsList(context),
            ],
          ),
        ));
  }
}

//==============================================================================
// menuList
//==============================================================================
Widget _termsList(BuildContext context) {
  // String fileHtmlContents = await rootBundle.loadString('EMG란.htm');
  return Expanded(
    child: Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //------------------------------------------------------------------------
            // 이용약관
            settingMenuBox(
                title: '이용약관',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      TermsPageForm(
                        child: wordTerms(),
                        termsTitle: '이용약관',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerSmall(),
            // //------------------------------------------------------------------------
            // // 운영정책
            // settingMenuBox(
            //     title: '운영정책',
            //     onTap: (() {
            //       Navigator.of(context).push(pageRouteAnimationSimple(
            //           TermsPageForm(
            //             child: Html(data: htmlPolicy),
            //             termsTitle: '운영정책',
            //           ),
            //           EmlMoveDirection.rightToLeft));
            //     }),
            //     isViewArrowRight: true),
            // dividerSmall(),
            //------------------------------------------------------------------------
            // 개인정보처리방침
            settingMenuBox(
                title: '개인정보처리방침',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      TermsPageForm(
                        child: wordPersonalInformation(),
                        termsTitle: '개인정보처리방침',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerSmall(),
          ],
        ),
      ),
    ),
  );
}


//==============================================================================
// 약관, 운영 정책
//==============================================================================
// List<Widget> _polishSubMenu(BuildContext context) {
//   return [
//     settingSubMenuBox(
//       title: '이용약관',
//       onTap: (() {
//         //------------------- 앱으로 제작한 이용약관 (상대적으로 깔끔)
//         openBottomSheetHelp(context,
//             title: '이용약관', child: terms(), height: Get.height * 0.96);
//       }),
//     ),
//     settingSubMenuBox(
//       title: '운영정책',
//       onTap: (() {
//         //------------------- 한글 -> html 데이터에서 불러오는 것
//         openBottomSheetHelp(context,
//             title: '운영정책',
//             child: Html(data: htmlPolicy),
//             height: Get.height * 0.96);
//       }),
//     ),
//     settingSubMenuBox(
//       title: '개인정보처리방침',
//       onTap: (() {}),
//     ),
//   ];
// }

