import '/F0_BASIC/common_import.dart';

//==============================================================================
// 환영합니다.
//==============================================================================
class WelcomeBottomSheet extends StatefulWidget {
  const WelcomeBottomSheet({Key? key}) : super(key: key);

  @override
  State<WelcomeBottomSheet> createState() => _WelcomeBottomSheetState();
}

class _WelcomeBottomSheetState extends State<WelcomeBottomSheet> {
  bool agreeToTermsOfUse = false;
  bool agreeToPrivacyStatement = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: asWidth(360), // asWidth(360) = 711.11
          height: asHeight(240), // asHeight(240) = 328.53
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: asWidth(360), // asWidth(360) = 711.11
                height: asHeight(240), // asHeight(240) = 328.53
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      asHeight(30),
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      asHeight(30),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/intro_img.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: asHeight(24)),
                child: Image.asset(
                  'assets/images/fitsig_basic_logo.png',
                  color: tm.white,
                  height: asHeight(28),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              asSizedBox(height: 60),
              TextN(
                '반가워요!',
                fontSize: tm.s20,
                fontWeight: FontWeight.bold,
              ),
              asSizedBox(height: 16),
              TextN(
                '본 애플리케이션은 FITSIG 근전도 측정장비(FS-100)와 연동하여 근력 운동 및 분석을 위해 사용됩니다.',
                fontSize: tm.s16,
                color: tm.grey04,
                height: 1.5,
              ),
              asSizedBox(height: 40),
              Container(
                height: asHeight(44),
                decoration: BoxDecoration(
                  color: tm.white.withOpacity(0.0),
                  borderRadius: BorderRadius.circular(asHeight(8)),
                  border: Border.all(width: asHeight(1), color: tm.grey02),
                ),
                child: checkBoxAndText(
                  title: '약관 확인 후 전체 동의합니다',
                  height: asHeight(20),
                  fontSize: tm.s16,
                  iconHeight: asWidth(20),
                  iconColor: agreeToTermsOfUse == true &&
                          agreeToPrivacyStatement == true
                      ? tm.mainBlue
                      : tm.grey02,
                  onIconTap: () {
                    setState(() {
                      if (agreeToPrivacyStatement == true &&
                          agreeToTermsOfUse == true) {
                        agreeToTermsOfUse = false;
                        agreeToPrivacyStatement = false;
                      } else {
                        agreeToTermsOfUse = true;
                        agreeToPrivacyStatement = true;
                      }
                    });
                  },
                  onTextTap: () {
                    setState(() {
                      agreeToTermsOfUse = true;
                      agreeToPrivacyStatement = true;
                    });
                  },
                ),
              ),
              SizedBox(height: asHeight(10)),
              checkBoxAndText(
                  title: '이용약관',
                  height: asHeight(18),
                  fontSize: tm.s12,
                  iconHeight: asWidth(20),
                  iconColor: agreeToTermsOfUse == true ? tm.mainBlue : tm.grey02,
                  onIconTap: () {
                    setState(() {
                      if (agreeToTermsOfUse == true) {
                        agreeToTermsOfUse = false;
                      } else {
                        agreeToTermsOfUse = true;
                      }
                    });
                  },
                  onTextTap: () {
                    Navigator.of(context).push(pageRouteAnimationSimple(
                        TermsPageForm(
                          child: wordTerms(), //Html(data: htmlTerms),
                          termsTitle: '이용약관',
                        ),
                        EmlMoveDirection.rightToLeft));
                  }),
              checkBoxAndText(
                title: '개인정보 취급방침',
                height: asHeight(40),
                fontSize: tm.s12,
                iconHeight: asWidth(20),
                iconColor:
                    agreeToPrivacyStatement == true ? tm.mainBlue : tm.grey02,
                onIconTap: () {
                  setState(() {
                    if (agreeToPrivacyStatement == true) {
                      agreeToPrivacyStatement = false;
                    } else {
                      agreeToPrivacyStatement = true;
                    }
                  });
                },
                onTextTap: () {
                  Navigator.of(context).push(pageRouteAnimationSimple(
                      TermsPageForm(
                        child: wordPersonalInformation(),
                        termsTitle: '개인정보처리방침',
                      ),
                      EmlMoveDirection.rightToLeft));
                },
              ),
            ],
          ),
        ),
        Expanded(child: SizedBox(height: asHeight(102))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
          child: textButtonI(
            width: asWidth(324),
            height: asHeight(52),
            radius: asHeight(8),
            backgroundColor: agreeToPrivacyStatement && agreeToTermsOfUse
                ? tm.mainBlue
                : tm.grey03,
            onTap: () {
              if (agreeToPrivacyStatement && agreeToTermsOfUse) {
                Get.back();
                openBottomSheetBasic(
                  child: const PersonalInfo(),
                  height: Get.height - asHeight(300),
                  isDismissible: false,
                  enableDrag: false,
                );
                // Get.off(
                //   () => const PersonalInfoPage()
                // );
              }
            },
            title: '다음'.tr,
            fontSize: tm.s16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: asHeight(20))
      ],
    );
  }

  Widget checkBoxAndText(
      {required String title,
      required onTextTap,
      required onIconTap,
      double height = 20,
      Color iconColor = Colors.grey,
      double iconHeight = 20,
      double fontSize = 12,
      FontWeight fontWeight = FontWeight.bold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onIconTap,
          borderRadius: BorderRadius.circular(asHeight(10)),
          child: Container(
            alignment: Alignment.center,
            height: asHeight(40),
            width: asHeight(40),
            child: Icon(
              Icons.check_circle_rounded,
              size: iconHeight,
              color: iconColor,
            ),
          ),
        ),
        InkWell(
          onTap: onTextTap,
          borderRadius: BorderRadius.circular(asHeight(10)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: asWidth(5)),
            height: asHeight(40),
            alignment: Alignment.centerLeft,
            child: TextN(
              title,
              fontSize: fontSize,
              color: tm.black,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}
