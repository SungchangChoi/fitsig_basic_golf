import '/F0_BASIC/common_import.dart';
import 'package:flutter_html/flutter_html.dart';

//==============================================================================
// setting main
//==============================================================================

class SettingMain extends StatelessWidget {
  const SettingMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padHeight26 = Get.height * 26 / 360;
    return Material(
        color: tm.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //------------------------------------------------------------------
              // 상단 바
              topBarBack(context, title: '설정'),
              //------------------------------------------------------------------
              // 하단 메뉴
              SizedBox(height: padHeight26),
              _menuList(context),
            ],
          ),
        ));
  }
}

//==============================================================================
// menuList
//==============================================================================
Widget _menuList(BuildContext context) {
  // String fileHtmlContents = await rootBundle.loadString('EMG란.htm');
  return Expanded(
    child: Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //------------------------------------------------------------------------
            // 일반설정
            settingMenuBox(
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      const SettingGeneral(), EmlMoveDirection.rightToLeft));
                }),
                title: '일반설정'),
            dividerSmall(),
            //구분선
            //------------------------------------------------------------------------
            // 도움말
            // SizedBox(height: padHeight30),
            // SettingExpansionTime(title: '도움말', children: _helpSubMenu()),
            settingMenuBoxExpandable(context,
                title: '도움말', children: _helpSubMenu(context)),
            dividerBig(),
            // 굵은 구분선
            //------------------------------------------------------------------------
            // 약관 및 정책
            // SizedBox(height: padHeight30),
            settingMenuBoxExpandable(context,
                title: '약관 및 정책', children: _polishSubMenu(context)),
            dividerSmall(),
            //------------------------------------------------------------------------
            // sw 정보
            settingMenuBox(onTap: (() {}), title: 'SW 정보'),
            dividerSmall(),
            //구분선
          ],
        ),
      ),
    ),
  );
}

//==============================================================================
// 도움ㅁㄹ
//==============================================================================
List<Widget> _helpSubMenu(BuildContext context) {
  return [
    //------------------------------
    settingSubMenuBox(
        onTap: (() {
          openBottomSheetHelp(context,
              title: '핏시그 소개',
              child: helpAboutFitsigBasic(),
              height: Get.height * 0.96);
        }),
        title: '도움말은 마지막 단계에 종합 정리'),
    //------------------------------
    settingSubMenuBox(
        onTap: (() {
          openBottomSheetHelp(context,
              title: '근전도란', child: helpAboutEmg(), height: Get.height * 0.96);
        }),
        title: '근전도(EMG) 이해하기'),
    settingSubMenuBox(onTap: (() {}), title: 'FITSIG 장비사용법'),
    settingSubMenuBox(onTap: (() {}), title: '앱 사용법 요약'),
    settingSubMenuBox(onTap: (() {}), title: '측정하기'),
    settingSubMenuBox(onTap: (() {}), title: '결과 분석하기'),
    settingSubMenuBox(onTap: (() {}), title: '도움말 분류를 어떻게?'),
    settingSubMenuBox(onTap: (() {}), title: '팝업이 아닌 창으로 할 수도 있음'),
  ];
}
//==============================================================================
// 약관, 운영 정책
//==============================================================================
List<Widget> _polishSubMenu(BuildContext context) {
  return [
    settingSubMenuBox(
      title: '이용약관',
      onTap: (() {
        //------------------- 앱으로 제작한 이용약관 (상대적으로 깔끔)
        // openBottomSheetHelp(context,
        //     title: '이용약관', child: terms(), height: Get.height * 0.96);
      }),
    ),
    settingSubMenuBox(
      title: '운영정책',
      onTap: (() {
        //------------------- 한글 -> html 데이터에서 불러오는 것
        openBottomSheetHelp(context,
            title: '운영정책', child: Html(data : htmlPolicy), height: Get.height * 0.96);
      }),
    ),
    settingSubMenuBox(
      title: '개인정보처리방침',
      onTap: (() {}),
    ),
  ];
}

//==============================================================================
// 확장 가능한 메뉴 - 기존 것 중 적절한 것 활용 (아래는 임시)
// 약간의 애니메이션 되면서 펼쳐지는 위젯
//==============================================================================
Widget _menuBoxExpandable(String title) {
  return Container(
    alignment: Alignment.center,
    height: asHeight(60),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //----------------------------------------------------------------------
        // 상단 제목
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //-----------------------------------------------
            // 제목
            Row(
              children: [
                asSizedBox(width: 18),
                TextN(
                  title,
                  fontSize: tm.s20,
                  color: tm.grey05,
                ),
              ],
            ),
            //-----------------------------------------------
            // 펼침 아이콘
            Row(
              children: [
                settingArrowDown(), //펼침 화살표
                asSizedBox(width: 18),
              ],
            ),
          ],
        ),
        //----------------------------------------------------------------------
        // 하단 펼침 부
      ],
    ),
  );
}
