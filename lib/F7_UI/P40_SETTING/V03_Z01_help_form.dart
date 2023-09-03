import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// contents
//==============================================================================

class HelpPageForm extends StatelessWidget {
  final Widget? child;
  final String helpTitle;

  const HelpPageForm({
    this.child = const SizedBox(),
    this.helpTitle = '도움말 제목',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
          child: Column(
            children: [
              //------------------------------------------------------------------
              // 상단 바
              _topBarBackHelp(context, title: helpTitle),
              asSizedBox(height: 10),
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: asWidth(18), vertical: asHeight(18)),
                        child: child),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class HelpPageFormNoPad extends StatelessWidget {
  final Widget? child;
  final String helpTitle;

  const HelpPageFormNoPad({
    this.child = const SizedBox(),
    this.helpTitle = '도움말 제목',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
          child: Column(
            children: [
              //------------------------------------------------------------------
              // 상단 바
              _topBarBackHelp(context, title: helpTitle),
              asSizedBox(height: 10),
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: asWidth(0), vertical: asHeight(0)),
                        child: child),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

//==============================================================================
// top bar back help : 도움말, 약관 등에 쓰이는 상단
//==============================================================================
Widget _topBarBackHelp(
  BuildContext context, {
  String title = '',
  bool isBackFromSetMuscle = false,
}) {
  return Container(
    height: asHeight(50),
    margin: EdgeInsets.only(top: asHeight(2)), //상단 여유
    // height: icHeight,
    alignment: Alignment.center,
    child: Stack(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      alignment: Alignment.center,
      children: [
        //--------------------------------------------------------------
        // back 화살표
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (() {
                Get.back();
              }),
              borderRadius: BorderRadius.circular(asHeight(10)),
              child: Container(
                width: asWidth(50),
                height: asHeight(50),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/ic_banner_arrow_l.png',
                  fit: BoxFit.scaleDown,
                  height: asHeight(30),
                  color: tm.black,
                ),
              ),
            ),
            asSizedBox(width: 0),
          ],
        ),

        //------------------------------------------------------------------
        // title
        // asSizedBox(width: 10),
        // 여기 할 차례
        // TextN(
        //   '도움말'.tr,
        //   fontSize: tm.s18,
        //   color: tm.grey03,
        //   fontWeight: FontWeight.w400,
        // ),
        // asSizedBox(width: 20),
        Container(
          // width: asWidth(200),
          // height: asHeight(30),
          // alignment: Alignment.center,
          child: AutoSizeText(
            title,
            maxLines: 1,
            style: TextStyle(
              fontSize: tm.s18,
              color: tm.grey04, //tm.blue.withOpacity(0.7),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
