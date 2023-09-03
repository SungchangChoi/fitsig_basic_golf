import '/F0_BASIC/common_import.dart';

//==============================================================================
// 일반적 버튼
//==============================================================================
Widget wButtonGeneral({
  Widget child = const TextN('위젯'),
  GestureTapCallback? onTap,
  double width = 54,
  double height = 36,
  double radius = -1,
  double touchWidth = 0,
  double touchHeight = 0,
  Alignment alignment = Alignment.center,
  double touchRadius = -1,
  Color borderColor = Colors.grey,
  Color backgroundColor = Colors.transparent,
  bool isViewBorder = true,
}) {
  //-------------------------------------------------------
  // 조건 부 크기 정의
  //-------------------------------------------------------
  double borderRadius = 0;
  // double padding = height / 2;
  if (radius == -1) {
    borderRadius = height / 2; //언급이 없으면 좌우 완전 라운드 형태
  } else {
    borderRadius = radius;
  }
  //-------------------------------------------------------
  // 조건 부 터치 영역 크기 정의
  //-------------------------------------------------------
  double tWidth = 0; //터치 영역 넓이
  double tHeight = 0; //터치 영역 높이
  double tRadius = 0; //터치 영역 라운드
  if (touchWidth == 0) {
    tWidth = width;
    tHeight = height;
    tRadius = borderRadius;
  } else {
    tWidth = touchWidth;
    tHeight = touchHeight;

    if (touchRadius == -1) {
      tRadius = touchHeight / 2; //언급이 없으면 좌우 완전 라운드 형태
    } else {
      tRadius = touchRadius;
    }
  }

  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(tRadius), //클릭되는 모양
      // splashColor: tm.red, //계속 누를 경우의 컬러
      // highlightColor: tm.blue.withOpacity(0.3), //클릭 시의 기본 컬러
      child: Container(
        width: tWidth,
        height: tHeight,
        alignment: Alignment.center,
        child: Container(
          alignment: alignment,
          width: width,
          height: height,
          // padding: EdgeInsets.all(asHeight((3))),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: isViewBorder ? 2 : 0,
              color: borderColor,
            ),
          ),
          child: FittedBoxN(child: child),
        ),
      ),
    ),
  );
}

//==============================================================================
// 일반적 버튼 - 넓이가 내용물에 따라 자동 조절
//==============================================================================
Widget wButtonAwGeneral({
  Widget child = const TextN('위젯'),
  GestureTapCallback? onTap,
  double height = 36,
  double padWidth = 0,
  double touchHeight = 0,
  double padTouchWidth = 0,
  double radius = -1,
  double touchRadius = -1,
  Color borderColor = Colors.grey,
  Color backgroundColor = Colors.transparent,
  bool isViewBorder = true,
  double borderWidth = 2,
}) {
  //-------------------------------------------------------
  // 조건 부 크기 정의
  //-------------------------------------------------------
  double borderRadius = 0;
  // double padding = height / 2;
  if (radius == -1) {
    borderRadius = height / 2; //언급이 없으면 좌우 완전 라운드 형태
  } else {
    borderRadius = radius;
  }
  //-------------------------------------------------------
  // 조건 부 터치 영역 크기 정의
  //-------------------------------------------------------
  double tHeight = 0; //터치 영역 높이
  double tRadius = 0; //터치 영역 라운드
  if (touchHeight == 0) {
    tHeight = height;
    tRadius = borderRadius;
  } else {
    tHeight = touchHeight;
    if (touchRadius == -1) {
      tRadius = touchHeight / 2; //언급이 없으면 좌우 완전 라운드 형태
    } else {
      tRadius = touchRadius;
    }
  }

  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(tRadius), //클릭되는 모양
      // splashColor: tm.red, //계속 누를 경우의 컬러
      // highlightColor: tm.blue.withOpacity(0.3), //클릭 시의 기본 컬러
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padTouchWidth),
        height: tHeight,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: padWidth),
          height: height,
          // padding: EdgeInsets.all(asHeight((3))),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: isViewBorder ? borderWidth : 0,
              color: borderColor,
            ),
          ),
          child: child,
        ),
      ),
    ),
  );
}

//==============================================================================
// 선택 단추가 있는 버튼
//==============================================================================
Widget wButtonSel({
  GestureTapCallback? onTap,
  double width = 54,
  double height = 36,
  double radius = -1,
  double touchWidth = 0,
  double touchHeight = 0,
  double touchRadius = -1,
  bool isViewBorder = true,
  Widget? child,
  double padLeft = 0,
  Color backgroundColor = Colors.transparent,
}) {
  //-------------------------------------------------------
  // 조건 부 크기 정의
  //-------------------------------------------------------
  double borderRadius = 0;
  // double padding = height / 2;
  if (radius == -1) {
    borderRadius = height / 2; //언급이 없으면 좌우 완전 라운드 형태
  } else {
    borderRadius = radius;
  }
  //-------------------------------------------------------
  // 조건 부 터치 영역 크기 정의
  //-------------------------------------------------------
  double tWidth = 0; //터치 영역 넓이
  double tHeight = 0; //터치 영역 높이
  double tRadius = 0; //터치 영역 라운드
  if (touchWidth == 0) {
    tWidth = width;
    tHeight = height;
    tRadius = borderRadius;
  } else {
    tWidth = touchWidth;
    tHeight = touchHeight;

    if (touchRadius == -1) {
      tRadius = touchHeight / 2; //언급이 없으면 좌우 완전 라운드 형태
    } else {
      tRadius = touchRadius;
    }
  }

  double iconSize = height;
  double widgetWidth = width - iconSize - 4 - padLeft; //

  return Material(
    color: Colors.transparent,
    child: Ink(
      width: tWidth,
      height: tHeight,
      decoration: BoxDecoration(
        color: backgroundColor, //Colors.transparent,
        borderRadius: BorderRadius.circular(tRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(tRadius), //클릭되는 모양
        // splashColor: tm.sZone, //계속 누를 경우의 컬러
        // highlightColor: tm.lightBlue.withOpacity(0.3), //클릭 시의 기본 컬러
        child: Container(
          width: tWidth,
          height: tHeight,
          alignment: Alignment.center,
          // color: Colors.yellow,
          child: Container(
            padding: EdgeInsets.only(left: padLeft),
            alignment: Alignment.center,
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  width: isViewBorder ? 1 : 0,
                  color: tm.grey02,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //--------------------------------------
                // widget
                Container(
                    width: widgetWidth,
                    height: height,
                    alignment: Alignment.centerLeft,
                    child: child),
                //--------------------------------------
                // arrow
                Row(
                  children: [
                    SizedBox(
                        height: asHeight(12),
                        child:
                            Image.asset('assets/icons/ic_arrow_arrange.png')),
                    asSizedBox(width: 12),
                  ],
                ),
                // Icon(
                //   Icons.arrow_drop_down,
                //   size: height,
                //   color: tm.grey03,
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

//==============================================================================
// 좌우에 위젯 2개를 넣을 수 있는 버튼
//==============================================================================
Widget wButtonDualWidget({
  GestureTapCallback? onTap,
  double width = 54,
  double height = 36,
  double radius = -1,
  double touchWidth = 0,
  double touchHeight = 0,
  double touchRadius = -1,
  bool isViewBorder = true,
  Widget? childLeft,
  Widget? childRight,
  double padWidth = 0,
  Color backgroundColor = Colors.transparent,
}) {
  //-------------------------------------------------------
  // 조건 부 크기 정의
  //-------------------------------------------------------
  double borderRadius = 0;
  // double padding = height / 2;
  if (radius == -1) {
    borderRadius = height / 2; //언급이 없으면 좌우 완전 라운드 형태
  } else {
    borderRadius = radius;
  }
  //-------------------------------------------------------
  // 조건 부 터치 영역 크기 정의
  //-------------------------------------------------------
  double tWidth = 0; //터치 영역 넓이
  double tHeight = 0; //터치 영역 높이
  double tRadius = 0; //터치 영역 라운드
  if (touchWidth == 0) {
    tWidth = width;
    tHeight = height;
    tRadius = borderRadius;
  } else {
    tWidth = touchWidth;
    tHeight = touchHeight;

    if (touchRadius == -1) {
      tRadius = touchHeight / 2; //언급이 없으면 좌우 완전 라운드 형태
    } else {
      tRadius = touchRadius;
    }
  }

  // double iconSize = height;
  // double widgetWidth = width - iconSize - 4 - (padWidth * 2); //

  return Material(
    color: Colors.transparent,
    child: Ink(
      width: tWidth,
      height: tHeight,
      decoration: BoxDecoration(
        color: backgroundColor, //Colors.transparent,
        borderRadius: BorderRadius.circular(tRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(tRadius), //클릭되는 모양
        // splashColor: tm.sZone, //계속 누를 경우의 컬러
        // highlightColor: tm.lightBlue.withOpacity(0.3), //클릭 시의 기본 컬러
        child: Container(
          width: tWidth,
          height: tHeight,
          alignment: Alignment.center,
          // color: Colors.yellow,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: padWidth),
            alignment: Alignment.center,
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  width: isViewBorder ? 1 : 0,
                  color: tm.grey02,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //--------------------------------------
                // widget left
                Container(
                    // width: widgetWidth,
                    height: height,
                    alignment: Alignment.centerLeft,
                    child: childLeft),
                //--------------------------------------
                // widget right
                Container(
                    // width: widgetWidth,
                    height: height,
                    alignment: Alignment.centerRight,
                    child: childRight),
                //--------------------------------------
                // arrow
                // Row(
                //   children: [
                //     SizedBox(
                //         height: asHeight(12),
                //         child:
                //         Image.asset('assets/icons/ic_arrow_arrange.png')),
                //     asSizedBox(width: 12),
                //   ],
                // ),
                // Icon(
                //   Icons.arrow_drop_down,
                //   size: height,
                //   color: tm.grey03,
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

//==============================================================================
// 넓이가 글씨 길이에 따라 자동 조절되는 선택 단추가 있는 버튼
//==============================================================================
Widget wButtonAwSel({
  GestureTapCallback? onTap,
  double height = 36,
  double radius = -1,
  double padTouchWidth = 0,
  double touchHeight = 0,
  double touchRadius = -1,
  bool isViewBorder = true,
  bool isArrowFlip = false, //화살표 거꾸로 (펼침, 닫힘 용도로 사용할 때)
  Widget? child,
}) {
  //-------------------------------------------------------
  // 조건 부 크기 정의
  //-------------------------------------------------------
  double borderRadius = 0;
  // double padding = height / 2;
  if (radius == -1) {
    borderRadius = height / 2; //언급이 없으면 좌우 완전 라운드 형태
  } else {
    borderRadius = radius;
  }
  //-------------------------------------------------------
  // 조건 부 터치 영역 크기 정의
  //-------------------------------------------------------
  double tHeight = 0; //터치 영역 높이
  double tRadius = 0; //터치 영역 라운드
  if (touchHeight == 0) {
    tHeight = height;
    tRadius = borderRadius;
  } else {
    tHeight = touchHeight;

    if (touchRadius == -1) {
      tRadius = touchHeight / 2; //언급이 없으면 좌우 완전 라운드 형태
    } else {
      tRadius = touchRadius;
    }
  }
  return Material(
    color: Colors.transparent,
    child: Ink(
      height: tHeight,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(tRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(tRadius), //클릭되는 모양
        // splashColor: tm.sZone, //계속 누를 경우의 컬러
        // highlightColor: tm.lightBlue.withOpacity(0.3), //클릭 시의 기본 컬러
        child: Container(
          height: tHeight,
          padding: EdgeInsets.symmetric(horizontal: padTouchWidth),
          alignment: Alignment.center,
          // color: Colors.yellow,
          child: Container(
            alignment: Alignment.center,
            height: height,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  width: isViewBorder ? 1 : 0,
                  color: tm.grey02,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //--------------------------------------
                // widget
                asSizedBox(width: 12),
                Container(
                    height: height,
                    alignment: Alignment.centerLeft,
                    child: child),
                //--------------------------------------
                // arrow
                asSizedBox(width: 8),
                Row(
                  children: [
                    SizedBox(
                        height: asHeight(12),
                        child: RotatedBox(
                          quarterTurns: isArrowFlip ? 2 : 0,
                          child: Image.asset(
                            'assets/icons/ic_arrow_arrange.png',
                            color: tm.grey03,
                          ),
                        )),
                    asSizedBox(width: 12),
                  ],
                ),
                // Icon(
                //   Icons.arrow_drop_down,
                //   size: height,
                //   color: tm.grey03,
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

//==============================================================================
// 선택 상태 표시 버튼
//==============================================================================
Widget wButtonState({
  GestureTapCallback? onTap,
  double width = 54,
  double height = 36,
  double radius = -1,
  double touchWidth = 0,
  double touchHeight = 0,
  double touchRadius = -1,
  double padding = 0,
  int numOfState = 2, //2 이상
  int stateIndex = 0,
  Widget? child,
  Color touchAreaColor = Colors.transparent,
  Color buttonColor = Colors.blue,
}) {
  //-------------------------------------------------------
  // 조건 부 크기 정의
  //-------------------------------------------------------
  double borderRadius = 0;
  // double padding = height / 2;
  if (radius == -1) {
    borderRadius = height / 2; //언급이 없으면 좌우 완전 라운드 형태
  } else {
    borderRadius = radius;
  }
  //-------------------------------------------------------
  // 조건 부 터치 영역 크기 정의
  //-------------------------------------------------------
  double tWidth = 0; //터치 영역 넓이
  double tHeight = 0; //터치 영역 높이
  double tRadius = 0; //터치 영역 라운드
  if (touchWidth == 0) {
    tWidth = width;
    tHeight = height;
    tRadius = borderRadius;
  } else {
    tWidth = touchWidth;
    tHeight = touchHeight;

    if (touchRadius == -1) {
      tRadius = touchHeight / 2; //언급이 없으면 좌우 완전 라운드 형태
    } else {
      tRadius = touchRadius;
    }
  }

  //-------------------------------------------------------
  // 상태 표시 부 크기
  //-------------------------------------------------------
  double stateWidth =
      asWidth(8) + numOfState * asWidth(2) + (numOfState - 1) * asWidth(2);

  //-------------------------------------------------------
  // 위젯 크기 정의
  //-------------------------------------------------------
  double childWidth = 0;
  if (child != null) {
    childWidth = width - stateWidth - (padding * 2) - 2;
  }
  if (childWidth < 0) {
    childWidth = 0;
  }

  return Material(
    color: Colors.transparent,
    child: Ink(
      width: tWidth,
      height: tHeight,
      decoration: BoxDecoration(
        color: touchAreaColor,
        borderRadius: BorderRadius.circular(tRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(tRadius), //클릭되는 모양
        // splashColor: tm.sZone, //계속 누를 경우의 컬러
        // highlightColor: tm.lightBlue.withOpacity(0.3), //클릭 시의 기본 컬러
        child: Container(
          width: tWidth,
          height: tHeight,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: padding),
            alignment: Alignment.center,
            width: width,
            height: height,
            decoration: BoxDecoration(
                // color: Colors.yellow, //transparent,
                borderRadius: BorderRadius.circular(tRadius),
                border: Border.all(
                  width: 1,
                  color: tm.softBlue,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //--------------------------------------
                // Child
                Container(
                  width: childWidth,
                  height: height,
                  alignment: Alignment.centerLeft,
                  child: FittedBoxN(child: child),
                ),
                //--------------------------------------
                // 상태 표시 : 추후 상황에 맞게 조절 필요
                SizedBox(
                  width: stateWidth,
                  height: height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //줄표 : 선택 값에 따라 상태 변화
                      _stateBar(
                          width: stateWidth,
                          numOfState: numOfState,
                          stateIndex: stateIndex),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _stateBar({double width = 10, int numOfState = 3, int stateIndex = 0}) {
  return SizedBox(
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List<Widget>.generate(
          numOfState, (index) => _line(index == stateIndex)),
    ),
  );
}

Widget _line(bool isSelected) {
  return Container(
    width: isSelected ? asWidth(8) : asWidth(2),
    height: asHeight(2),
    color: isSelected ? tm.mainBlue : tm.softBlue,
  );
}
