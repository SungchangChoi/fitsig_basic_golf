import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 약관 및 정책
// HTML 이 좀 더 깨지지 않고 잘 보일 수 있게 하는 방법 검토필요
//==============================================================================

class TermsPageForm extends StatelessWidget {
  final Widget? child;
  final String termsTitle;

  const TermsPageForm({
    this.child = const SizedBox(),
    this.termsTitle = '도움말 제목',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
          child:
          Column(
            children: [
              //------------------------------------------------------------------
              // 상단 바
              _topBarBackTerms(context, title: termsTitle),
              asSizedBox(height: 10),
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: asWidth(18), vertical: asHeight(18)),
                            child: child),
                      ],
                    ),
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
Widget _topBarBackTerms(
    BuildContext context, {
      String title = '',
      bool isBackFromSetMuscle = false,
    }) {
  return Container(
    height: asHeight(50),
    margin: EdgeInsets.only(top: asHeight(2)), //상단 여유
    // height: icHeight,
    child: Stack(
      children: [
        //--------------------------------------------------------------
        // back 화살표
        Row(
          children: [
            asSizedBox(width: 0),
            InkWell(
              onTap: (() {
                Get.back();
              }),
              borderRadius: BorderRadius.circular(asHeight(10)),
              child: Container(
                height: asHeight(50),
                width: asWidth(50),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/ic_banner_arrow_l.png',
                  fit: BoxFit.scaleDown,
                  height: asHeight(30),
                  color: tm.black,
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Container(
            width: asWidth(200),
            height: asHeight(30),
            alignment: Alignment.center,
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
        ),
      ],
    ),
  );
}
