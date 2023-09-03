import '/F0_BASIC/common_import.dart';
import 'package:flutter_html/flutter_html.dart';

//==============================================================================
// setting main
//==============================================================================

class HelpMainPage extends StatelessWidget {
  const HelpMainPage({Key? key}) : super(key: key);

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
              topBarBack(context, title: '도움말'),
              //------------------------------------------------------------------
              // 하단 메뉴
              asSizedBox(height: 26),
              _helpList(context),
            ],
          ),
        ));
  }
}

//==============================================================================
// menuList
//==============================================================================
Widget _helpList(BuildContext context) {
  // String fileHtmlContents = await rootBundle.loadString('EMG란.htm');
  return Expanded(
    child: Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //------------------------------------------------------------------------
            // 제품 소개
            // dividerSmall(),
            settingMenuBox(
                title: 'FITSIG-BASIC 소개',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      HelpPageFormNoPad(
                        child: helpAboutFitsigBasic(),
                        helpTitle: 'FITSIG-BASIC 소개',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerSmall(),
            //------------------------------------------------------------------------
            // 사용법 요약
            settingMenuBox(
              title: '사용법 요약',
              onTap: (() {
                Navigator.of(context).push(pageRouteAnimationSimple(
                    HelpPageFormNoPad(
                      child: helpInstructionsBrief(),
                      helpTitle: '사용법 요약',
                    ),
                    EmlMoveDirection.rightToLeft));
              }),
              isViewArrowRight: true,
            ),
            dividerSmall(),
            //------------------------------------------------------------------------
            // 장비사용법
            settingMenuBox(
                title: '장비 사용법',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      HelpPageFormNoPad(
                        child: helpDeviceInstructions(),
                        helpTitle: '장비 사용법',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerBig(),
            //------------------------------------------------------------------------
            // 운동 프로그램
            settingMenuBox(
                title: '운동 프로그램',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      HelpPageFormNoPad(
                        child: helpAboutProgram(),
                        helpTitle: '운동 프로그램',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerSmall(),

            //------------------------------------------------------------------------
            // 근력운동에 활용하기
            settingMenuBox(
                title: '근력운동에 활용하기',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      HelpPageFormNoPad(
                        child: helpAboutExercise(),
                        helpTitle: '근력운동에 활용하기',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerBig(),

            //------------------------------------------------------------------------
            // 근전도 신호
            settingMenuBox(
                title: '근전도 신호란?',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      HelpPageFormNoPad(
                        child: helpAboutEmg(),
                        helpTitle: '근전도 신호란?',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerSmall(),
            //------------------------------------------------------------------------
            // 심전도 신호
            settingMenuBox(
                title: '심전도 측정기능',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      HelpPageFormNoPad(
                        child: helpAboutEcg(),
                        helpTitle: '심전도 측정기능',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerBig(),
            //------------------------------------------------------------------------
            // 최대근력 이해
            settingMenuBox(
                title: '최대 근력(1RM)',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      HelpPageFormNoPad(
                        child: helpAbout1rm(),
                        helpTitle: '최대 근력(1RM)',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerSmall(),
            //------------------------------------------------------------------------
            // 운동량 이해
            settingMenuBox(
                title: '운동량 이해하기',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      HelpPageFormNoPad(
                        child: helpAboutAoe(),
                        helpTitle: '운동량 이해하기',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerSmall(),
            //------------------------------------------------------------------------
            // 주파수 이해
            settingMenuBox(
                title: '근전도 주파수',
                onTap: (() {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      HelpPageFormNoPad(
                        child: helpAboutFrequency(),
                        helpTitle: '근전도 주파수',
                      ),
                      EmlMoveDirection.rightToLeft));
                }),
                isViewArrowRight: true),
            dividerBig(),
            //------------------------------------------------------------------------
            // 전극
            settingMenuBox(
              title: '패치 전극',
              onTap: (() {
                Navigator.of(context).push(pageRouteAnimationSimple(
                    HelpPageFormNoPad(
                      child: helpAboutElectrode(),
                      helpTitle: '패치 전극',
                    ),
                    EmlMoveDirection.rightToLeft));
              }),
              isViewArrowRight: true,
            ),
            dividerSmall(),
            //구분선
          ],
        ),
      ),
    ),
  );
}
