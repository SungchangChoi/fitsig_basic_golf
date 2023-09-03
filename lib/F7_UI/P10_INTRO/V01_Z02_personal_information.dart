import '/F0_BASIC/common_import.dart';

//==============================================================================
// personal info
//==============================================================================
class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String? selectedGender;
  String? selectedBornYear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Obx (() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: asHeight(40)),
          Align(
            alignment: Alignment.center,
            child: TextN(
              '기본정보 입력',
              fontSize: tm.s20,
              color: tm.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: asHeight(50)),
          TextN(
            '성별을 선택해 주세요',
            fontWeight: FontWeight.bold,
            fontSize: tm.s14,
          ),
          SizedBox(height: asHeight(12)),
          //--------------------------------------------------------------------
          // 성별 드랍박스
          //--------------------------------------------------------------------
          wButtonSel(
            onTap: () {
              openBottomSheetBasic(
                  height:asHeight(350),
                  // gv.setting.isBigFont.value
                  //     ? asHeight(360)
                  //     : asHeight(360),
                  child: genderPicker(
                    initialIndex: gv.setting.genderIndex.value,
                    callbackOnTap: (idxPresent) async {
                      setState(() {
                        selectedGender =
                            gv.setting.genderList.elementAt(idxPresent);
                      });
                      gv.setting.genderIndex.value = idxPresent;
                      await gv.spMemory
                          .write('genderIndex', gv.setting.genderIndex.value);
                      Get.back();
                    },
                  ));
            },
            height: asHeight(44),
            width: asWidth(324),
            touchRadius: asHeight(8),
            radius: asHeight(8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: asHeight(15)),
              child: Text(
                selectedGender == null ? '성별 선택' : selectedGender!,
                style: TextStyle(
                  fontSize: tm.s14,
                  fontWeight: FontWeight.bold,
                  color: selectedGender == null ? tm.grey03 : tm.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          SizedBox(height: asHeight(30)),
          TextN(
            '출생연도를 선택해 주세요',
            fontWeight: FontWeight.bold,
            fontSize: tm.s14,
          ),
          SizedBox(height: asHeight(12)),
          //--------------------------------------------------------------------
          // 출생연도 드랍박스
          //--------------------------------------------------------------------
          wButtonSel(
            onTap: () {
              openBottomSheetBasic(
                height: asHeight(350),
                    // gv.setting.isBigFont.value ? asHeight(360) : asHeight(360),
                child: bornYearPicker(
                  initialIndex: gv.setting.bornYearIndex.value,
                  callbackOnTap: (idxPresent) async {
                    setState(() {
                      selectedBornYear =
                          gv.setting.bornYearList.elementAt(idxPresent);
                    });
                    gv.setting.bornYearIndex.value = idxPresent;
                    await gv.spMemory
                        .write('bornYearIndex', gv.setting.bornYearIndex.value);
                    Get.back();
                  },
                ),
              );
            },
            height: asHeight(44),
            width: asWidth(324),
            touchRadius: asHeight(8),
            radius: asHeight(8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: asHeight(15)),
              child: Text(
                selectedBornYear == null ? '출생연도 선택' : selectedBornYear!,
                style: TextStyle(
                  fontSize: tm.s14,
                  fontWeight: FontWeight.bold,
                  color: selectedBornYear == null ? tm.grey03 : tm.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(height: asHeight(20)),
          //--------------------------------------------------------------------
          // 큰 글씨 보기
          //--------------------------------------------------------------------
          InkWell(
            onTap: () {
              gv.setting.isBigFont.value = !(gv.setting.isBigFont.value);
              if (gv.setting.isBigFont.value == true) {
                gv.setting.bigFontAddVal = 5;
                tm.convertFontSize();
              } else {
                gv.setting.bigFontAddVal = 0;
                tm.convertFontSize();
              }
            },
            borderRadius: BorderRadius.circular(asHeight(10)),
            child: Container(
              alignment: Alignment.centerLeft,
              height: asHeight(36),
              width: asWidth(120),
              child: Row(
                children: [
                  Image.asset('assets/icons/ic_check_square.png', height: asHeight(16),
                  color: gv.setting.isBigFont.value == true
                      ? tm.mainBlue
                      : tm.grey02,),
                  // Icon(
                  //   Icons.check_box_rounded,
                  //   size: asWidth(16),
                  //   color: gv.setting.isBigFont.value == true
                  //       ? tm.blue
                  //       : tm.grey02,
                  // ),
                  SizedBox(width: asWidth(6)),
                  TextN(
                    '큰글씨보기',
                    fontSize: tm.s14,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: SizedBox(height: asHeight(60))),
          textButtonI(
            width: asWidth(324),
            height: asHeight(52),
            radius: asHeight(8),
            backgroundColor:
                (selectedGender != null && selectedBornYear != null)
                    ? tm.mainBlue
                    : tm.grey03,
            onTap: () {
              // 처음 사용자 기록 해제 : 영상 화면에서
              // gv.system.isFirstUser = false;
              // gv.spMemory.write('isFirstUser', false);
              // 대기 화면으로 이동
              Get.back();
              // 비디오 화면으로 이동
              Get.off(() => const IntroVideoPage(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 500)
              );
              // openBottomSheetBasic(
              //   child: const IntroVideoPage(),
              //   height: gv.system.maxHeightExcludeTopPadding, //Get.height - MediaQuery.of(context).padding.top-50, //asHeight(770) + asHeight(20),
              //   isDismissible: false,
              //   enableDrag: false,
              // );
            },
            title: '확인'.tr,
            fontSize: tm.s18,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: asHeight(20))
        ],
      ),),
    );
  }
}
