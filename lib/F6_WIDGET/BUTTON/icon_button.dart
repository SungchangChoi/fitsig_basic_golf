import '/F0_BASIC/common_import.dart';

//==============================================================================
// 아이콘 버튼
//==============================================================================
Widget iconButtonBasic({
  required IconData icon,
  GestureTapCallback? onTap,
  double width = 54,
  double height = 36,
  double iconSize = 16,
  double radius = -1,
  double touchWidth = 0,
  double touchHeight = 0,
  double touchRadius = -1,
  Color iconColor = Colors.blue,
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
          alignment: Alignment.center,
          width: width,
          height: height,
          // padding: EdgeInsets.all(asHeight((3))),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                width: isViewBorder ? 2 : 0,
                color: borderColor,
              )),
          child: FittedBoxN(
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ), ),
        ),
      ),
    ),
  );
}