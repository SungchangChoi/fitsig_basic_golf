import 'package:flutter/cupertino.dart';

import '/F0_BASIC/common_import.dart';
import 'package:flutter_switch/flutter_switch.dart';

//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// setting icon
// 좌/우 이미지 2개만 있어 아래와 위는 rotate
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

//==============================================================================
// 화살표 왼쪽
//==============================================================================
Widget settingArrowLeft() {
  return Image.asset(
    'assets/icons/ic_banner_arrow_l.png',
    fit: BoxFit.scaleDown,
    height: asHeight(30),
    color: tm.grey03,
  );
}

//==============================================================================
// 화살표 왼쪽
//==============================================================================
Widget settingArrowRight() {
  return Image.asset(
    'assets/icons/ic_banner_arrow_r.png',
    fit: BoxFit.scaleDown,
    height: asHeight(30),
    color: tm.grey03,
  );
}

//==============================================================================
// 화살표 위
//==============================================================================
Widget settingArrowUp() {
  return RotatedBox(
    quarterTurns: 3, //1 = down, 3 = up
    child: Image.asset(
      'assets/icons/ic_banner_arrow_r.png',
      fit: BoxFit.scaleDown,
      height: asHeight(30),
      color: tm.grey03,
    ),
  );
}

//==============================================================================
// 화살표 아래
//==============================================================================
Widget settingArrowDown() {
  return RotatedBox(
    quarterTurns: 1, //1 = down, 3 = up
    child: Image.asset(
      'assets/icons/ic_banner_arrow_r.png',
      fit: BoxFit.scaleDown,
      height: asHeight(30),
      color: tm.grey03,
    ),
  );
}

//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// menu box
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

//==============================================================================
// 기본 메뉴 box
//==============================================================================
Widget settingMenuBox(
    {required Function() onTap,
    String iconName = '',
    String title = '제목',
    bool isViewArrowRight = false,
    bool isViewRedDot = false}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            alignment: Alignment.center,
            height: asHeight(60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //-----------------------------------------------
                // 제목
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    asSizedBox(width: 18),
                    // 아이콘 파일이 존재하는 경우
                    if (iconName.isNotEmpty)
                      Image.asset(
                        'assets/icons/$iconName',
                        height: asHeight(24),
                      ),
                    if (iconName.isNotEmpty) asSizedBox(width: 10),
                    TextN(
                      title,
                      fontSize: tm.s16,
                      color: tm.grey05,
                    ),
                  ],
                ),
                //-----------------------------------------------
                // 펼침 아이콘
                if (isViewArrowRight)
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_banner_arrow_r.png',
                        fit: BoxFit.scaleDown,
                        height: asHeight(30),
                        color: tm.grey03,
                      ),
                      asSizedBox(width: 18),
                    ],
                  ),
              ],
            ),
          ),
          //-----------------------------------------------
          // 업데이트 알리는 붉은 색 점
          isViewRedDot
              ? Container(
                  margin: EdgeInsets.only(right: asHeight(12)),
                  height: asHeight(16),
                  width: asHeight(16),
                  decoration: BoxDecoration(
                      color: tm.red,
                      borderRadius: BorderRadius.circular(asHeight(8)),
                      border: Border.all(width: asHeight(1), color: tm.grey02)),
                )
              : Container(),
        ],
      ),
    ),
  );
}

//==============================================================================
// 확장 가능한 메뉴박스
//==============================================================================
Widget settingMenuBoxExpandable(BuildContext context,
    {List<Widget> children = const [], String title = '제목'}) {
  return Column(
    children: [
      Theme(
        data: Theme.of(context).copyWith(
          // unselectedWidgetColor: tm.grey03, //펼치기 전 아이콘 색상
          // colorScheme: ColorScheme.light(primary: tm.blue), //펼쳐진 후의 내장 icon 컬러
          dividerColor: Colors.transparent, //가이드 라인 색상
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.only(left: asWidth(18), right: asWidth(18)),
          iconColor: tm.mainBlue,
          //펼쳐지면 보이는 색
          collapsedIconColor: tm.grey03,
          //펼쳐지기 전 색
          title: TextN(
            title,
            fontSize: tm.s20,
            color: tm.grey05,
          ),
          children: children,
          childrenPadding: EdgeInsets.only(bottom: asHeight(20)), //하단 여유
        ),
      ),
    ],
  );
}

//==============================================================================
// 확장 가능한 메뉴박스 (아이콘 변경 가능 - 애니메이션은 안됨)
//==============================================================================
class SettingExpansionTime extends StatefulWidget {
  final List<Widget> children;
  final String title;

  const SettingExpansionTime(
      {this.children = const [], this.title = '제목', Key? key})
      : super(key: key);

  @override
  State<SettingExpansionTime> createState() => _SettingExpansionTimeState();
}

class _SettingExpansionTimeState extends State<SettingExpansionTime> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    //------------------------ 여유
    double padWidth18 = Get.width * 18 / 360;
    double padHeight20 = Get.height * 20 / 800;
    return Column(
      children: [
        ExpansionTile(
          tilePadding: EdgeInsets.only(left: padWidth18, right: padWidth18),
          iconColor: tm.mainBlue,
          collapsedIconColor: tm.grey03,
          title: TextN(
            widget.title,
            fontSize: tm.s20,
            color: tm.grey05,
          ),
          children: widget.children,
          childrenPadding: EdgeInsets.only(bottom: padHeight20),
          //하단 여유
          //------------------ 조건부 아이콘
          trailing: _customTileExpanded ? settingArrowUp() : settingArrowDown(),
          //------------------ 변화 감지
          onExpansionChanged: (bool expanded) {
            setState(() => _customTileExpanded = expanded);
          },
        ),
      ],
    );
  }
}

//==============================================================================
// 서브리스트 메뉴박스
//==============================================================================
Widget settingSubMenuBox({Function()? onTap, String title = '서브제목'}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        margin: EdgeInsets.only(left: asWidth(38)),
        alignment: Alignment.center,
        height: asHeight(40),
        child: Row(
          children: [
            TextN(
              title,
              fontSize: tm.s16,
              color: tm.grey05,
            ),
          ],
        )),
  );
}

//==============================================================================
// 설정용 스위치 박스
//==============================================================================
Widget settingSwitchBox(
    {required Function(bool) onChanged,
      String iconName = '',
    String title = '제목',
    String subText = '',
    required RxBool switchValue}) {
  return Container(
    alignment: Alignment.center,
    padding:
        EdgeInsets.symmetric(horizontal: asWidth(18), vertical: asHeight(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //----------------------------------------------------------------------
        // 상단 타이틀 및 스위치
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //-----------------------------------------------
            // 제목
            Row(
              children: [
                // 아이콘 파일이 존재하는 경우
                if (iconName.isNotEmpty)
                  Image.asset('assets/icons/$iconName', height: asHeight(24)),
                if (iconName.isNotEmpty) asSizedBox(width: 10),
                TextN(
                  title,
                  fontSize: tm.s16,
                  color: tm.grey05,
                ),
              ],
            ),
            //-----------------------------------------------
            // enable 스위치
            Obx(() {
              // 쿠퍼티노 스위치
              // 필요시 추후 custom switch 로 변경
              return Transform.scale(
                scale: 1.2,
                child: CupertinoSwitch(
                  activeColor: tm.mainBlue,
                  value: switchValue.value,
                  onChanged: onChanged,
                ),
              );

              // return FlutterSwitch(
              //   width: asWidth(68),
              //   height: asHeight(40),
              //   toggleSize: asHeight(36),
              //   //45.0,
              //   value: switchValue.value,
              //   borderRadius: asHeight(20),
              //   // padding: padSwitch,
              //   toggleColor: tm.grey01,
              //   activeColor: tm.mainBlue,
              //   inactiveColor: tm.grey03,
              //   onToggle: onChanged,
              //   // 텍스트
              //   activeText: '켜짐',
              //   inactiveText: '꺼짐',
              //   activeTextColor: tm.white,
              //   inactiveTextColor: tm.white,
              //   valueFontSize: tm.s14 <= 15 ? tm.s14 : 15,
              //   //크기 제한
              //   showOnOff: true,
              // );
            }),
          ],
        ),
        //----------------------------------------------------------------------
        // 하단 설명 글
        if (subText.isNotEmpty) asSizedBox(height: 10),
        if (subText.isNotEmpty)
          TextN(
            subText,
            fontSize: tm.s12,
            color: tm.grey03,
            height: 1.5,
          ),
      ],
    ),
  );
}

//==============================================================================
// 설정용 버튼 박스
//==============================================================================
Widget settingButtonBox({
  required Function()? onTap,
  String iconName = '',
  String title = '제목',
  String subTitle = '',
  Color subTitleColor = Colors.blue,
  String buttonName = '실행',
  String lowerDescription = '',
}) {
  // double boxHeight = Get.height * 60 / 800;
  //
  // double buttonHeight = Get.height * 36 / 800;
  // double buttonWidth = Get.width * 54 / 360;
  // double borderWidth = Get.height * 3 / 800;
  // double toggleSize = Get.height * 36 / 800;
  // //------------------------ 여유
  // double padWidth18 = Get.width * 18 / 360;
  // double padHeight20 = Get.width * 20 / 360;
  //----------------------------------------------------------------------------
  // 상단 타이틀
  //----------------------------------------------------------------------------
  return Column(
    children: [
      //------------------------------------------------------------------------
      // 상단 타이틀
      //------------------------------------------------------------------------
      Container(
        alignment: Alignment.center,
        height: asHeight(60),
        margin: EdgeInsets.only(left: asWidth(18), right: asWidth(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //-----------------------------------------------
            // 제목
            Row(
              children: [
                // 아이콘 파일이 존재하는 경우
                if (iconName.isNotEmpty)
                  Image.asset('assets/icons/$iconName', height: asHeight(24)),
                if (iconName.isNotEmpty) asSizedBox(width: 10),
                TextN(title, fontSize: tm.s16, color: tm.grey05),
              ],
            ),
            //-----------------------------------------------
            // 버튼
            Row(
              children: [
                //--------------------------------------- 버튼 앞 텍스트
                if (subTitle.isNotEmpty)
                  TextN(
                    subTitle,
                    fontSize: tm.s16,
                    color: subTitleColor,
                  ),
                asSizedBox(width: 8),
                //--------------------------------------- 텍스트 버튼
                textButtonG(
                  title: buttonName,
                  textColor: tm.mainBlue,
                  fontSize: tm.s14,
                  width: asWidth(54),
                  height: asHeight(36),
                  touchWidth: asWidth(74),
                  touchHeight: asHeight(56),
                  borderColor: tm.softBlue,
                  onTap: onTap,
                ),
              ],
            ),
          ],
        ),
      ),
      //------------------------------------------------------------------------
      // 하단 설명 글
      //------------------------------------------------------------------------
      if (lowerDescription.isNotEmpty)
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
          child: Column(
            children: [
              TextN(lowerDescription, fontSize: tm.s12, color: tm.grey03),
              asSizedBox(height: 20),
            ],
          ),
        ),
    ],
  );
}

//==============================================================================
// 설정용 슬라이더 박스
//==============================================================================
Widget settingSliderBox({
  required Function(double) onChanged,
  required Function(double) onChangedEnd,
  required Rx<double> sliderValue,
  String title = '제목',
  String subTitle = '',
  Color subTitleColor = Colors.blue,
  String iconName = '',
  Color iconColor = Colors.blue,
  String lowerDescription = '',
  IconData? icons,
}) {
  //----------------------------------------------------------------------------
  // 상단 타이틀
  //----------------------------------------------------------------------------
  return Column(
    children: [
      //------------------------------------------------------------------------
      // 상단 타이틀
      //------------------------------------------------------------------------
      Container(
        alignment: Alignment.center,
        height: asHeight(60),
        margin: EdgeInsets.only(left: asWidth(18), right: asWidth(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //-----------------------------------------------
            // 제목
            Row(
              children: [
                // 아이콘 파일이 존재하는 경우
                if (iconName.isNotEmpty)
                  Image.asset('assets/icons/$iconName', height: asHeight(24)),
                if (iconName.isNotEmpty) asSizedBox(width: 10),
                TextN(
                  title,
                  fontSize: tm.s16,
                  color: tm.grey05,
                ),
              ],
            ),
            //-----------------------------------------------
            // 슬라이더
            Row(
              children: [
                if (icons != null)
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Icon(
                        icons,
                        color: iconColor,
                        size: asHeight(24),
                      )),
                SizedBox(
                  width: asWidth(150),
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: tm.mainBlue,
                      inactiveTrackColor: tm.grey02,
                      thumbColor: tm.mainBlue,
                      trackHeight: asHeight(5),
                      overlayColor: tm.softBlue,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: asHeight(17)),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: asHeight(8),
                        elevation: 0,
                      ),
                      valueIndicatorShape:
                          const PaddleSliderValueIndicatorShape(),
                    ),
                    child: Slider(
                      value: sliderValue.value,
                      min: 0,
                      max: 1,
                      divisions: 100,
                      onChanged: onChanged,
                      onChangeEnd: onChangedEnd,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      //------------------------------------------------------------------------
      // 하단 설명 글
      //------------------------------------------------------------------------
      if (lowerDescription.isNotEmpty)
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
          child: Column(
            children: [
              TextN(lowerDescription, fontSize: tm.s16, color: tm.grey03),
              asSizedBox(height: 20),
            ],
          ),
        ),
    ],
  );
}
