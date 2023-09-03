import '/F0_BASIC/common_import.dart';

//==============================================================================
// 텍스트 형식의 기본 버튼 (54 x 36)
//==============================================================================
Widget textButtonBasic({
  String title = '제목',
  GestureTapCallback? onTap,
  double width = 54,
  double height = 36,
  double fontSize = 16,
  double radius = -1,
  double touchWidth = 0,
  double touchHeight = 0,
  Alignment alignment = Alignment.center,
  double touchRadius = -1,
  FontWeight fontWeight = FontWeight.normal,
  Color textColor = Colors.blue,
  Color borderColor = Colors.grey,
  Color backgroundColor = Colors.transparent,
  TextAlign textAlign = TextAlign.center,
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
          child: FittedBoxN(
              child: TextN(
            title,
            fontSize: fontSize, //tm.s16,
            color: textColor, //tm.blue,
            fontWeight: fontWeight,
            textAlign: TextAlign.center,
          )),
        ),
      ),
    ),
  );
}

//==============================================================================
// 기본 사용 버튼
//==============================================================================
Widget textButtonG({
  String title = '제목',
  GestureTapCallback? onTap,
  double width = 54,
  double height = 36,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  double radius = -1,
  double touchWidth = 0,
  double touchHeight = 0,
  double touchRadius = -1,
  Color textColor = Colors.blue,
  Color borderColor = Colors.blue,
  Color backgroundColor = Colors.transparent,
  bool isViewBorder = true,
  bool isUpdateInfo = false,
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
    color: backgroundColor,
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
          alignment: Alignment.center,
          width: width,
          height: height,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              //------------------------------------------------------------------
              // 버튼
              Container(
                alignment: Alignment.center,
                width: width,
                height: height,
                // padding: EdgeInsets.all(asHeight((3))),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      width: isViewBorder ? 2 : 0,
                      color: borderColor,
                    )),
                child: FittedBoxN(
                    child: TextN(
                  title,
                  fontSize: fontSize, //tm.s16,
                  fontWeight: fontWeight,
                  color: textColor, //tm.blue,
                )),
              ),
              //-------------------------------------------------------
              // 업데이트 알리는 붉은 색 점
              isUpdateInfo
                  ? Container(
                      margin: EdgeInsets.only(right: height * 0.3),
                      height: height * 0.4,
                      width: height * 0.4,
                      decoration: BoxDecoration(
                          color: tm.red,
                          borderRadius: BorderRadius.circular(height * 0.2),
                          border:
                              Border.all(width: asHeight(1), color: tm.grey02)),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    ),
  );
}

//==============================================================================
// 기본 사용 버튼
//==============================================================================
Widget textButtonAwG({
  String title = '제목',
  GestureTapCallback? onTap,
  double height = 36,
  double padWidth = 0,
  double touchHeight = 0,
  double padTouchWidth = 0,
  double radius = -1,
  double touchRadius = -1,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  Color textColor = Colors.blue,
  Color borderColor = Colors.grey,
  double borderWidth = 1,
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
    color: backgroundColor,
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(width: borderWidth, color: borderColor)),
          child: FittedBoxN(
              child: TextN(
            title,
            fontSize: fontSize, //tm.s16,
            fontWeight: fontWeight,
            color: textColor, //tm.blue,
          )),
        ),
      ),
    ),
  );
}

//==============================================================================
// 바탕이 채워진 버튼
//==============================================================================
Widget textButtonI({
  String title = '제목',
  GestureTapCallback? onTap,
  double width = 54,
  double height = 36,
  double radius = -1,
  double touchWidth = 0,
  double touchHeight = 0,
  double touchRadius = -1,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  Color textColor = Colors.white,
  Color borderColor = Colors.transparent,
  Color backgroundColor = Colors.blue,
  double borderLineWidth = 1,
  // bool isViewBorder = true,
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
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              width: borderLineWidth,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: FittedBoxN(
              child: TextN(
            title,
            fontSize: fontSize, //tm.s16,
            color: textColor, //tm.blue,
            fontWeight: fontWeight,
          )),
        ),
      ),
    ),
  );
}

//==============================================================================
// 선택 버튼
//==============================================================================
Widget textButtonSel({
  String title = '제목',
  GestureTapCallback? onTap,
  double width = 54,
  double height = 36,
  double radius = -1,
  double touchWidth = 0,
  double touchHeight = 0,
  double touchRadius = -1,
  double fontSize = 16,
  bool isSelected = false,

  // bool isViewBorder = true,
}) {
  //-------------------------------------------------------
  // 조건 부 크기 정의
  //-------------------------------------------------------
  double borderRadius = 8;
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: isSelected ? tm.mainBlue : tm.white, //tm.blue,
          ),
          child: FittedBoxN(
              child: TextN(title,
                  fontSize: fontSize, //tm.s16,
                  color: isSelected ? tm.white : tm.black //tm.white, //tm.blue,
                  )),
        ),
      ),
    ),
  );
}
