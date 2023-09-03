

import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';


double _wScaleRatio = 1;
double _hScaleRatio = 1;
double _width_1p = 0;
//==============================================================================
// scale 기준 값 초기화
// 연산량을 줄이기 위해 최초 한번만 불러 오기
// 상부 높이 공간 반영
// 화면 사이즈가 변경되는 경우 -> 매번 호출 필요
//==============================================================================
void asRatioReferenceInit() {
  double screenWidth = Get.width;
  double screenHeight = Get.height;
  //------------------------------------------------------------------
  // 화면 크기 조절
  //------------------------------------------------------------------
  double topPad = MediaQuery.of(Get.context!).padding.top;
  _wScaleRatio = screenWidth / GvDef.widthRef;
  _hScaleRatio = (screenHeight - topPad) / GvDef.heightRef;

  //------------------작아지는 크기 70% 수준으로 제한
  //너무 작아지지 않게 - 더 작아지면 오토 스케일 포기
  _wScaleRatio = max(_wScaleRatio, 0.7);
  _hScaleRatio = max(_hScaleRatio, 0.7);
  //------------------------------------------------------------------
  // 텍스트 크기 조절 (화면 크기가 갱신된 경우에만)
  //------------------------------------------------------------------
  // if (_width_1p != screenWidth){ //갱신 될 때만 display
  //   _width_1p = screenWidth;

    // // 가로/세로 모드 어떻게 시작할지 모르므로 큰 값을 반영 (과거)
    // double bigScreenSize = max(screenWidth, screenHeight);
    // double bigRefSize = max(GvDef.widthRef, GvDef.heightRef);
    // gv.setting.fontScale = bigScreenSize  / bigRefSize / Get.textScaleFactor;

    // 가로/세로 모드 어떻게 시작할지 모르므로 작은 값을 반영
    // double bigScreenSize = min(screenWidth, screenHeight);
    // double bigRefSize = max(GvDef.widthRef, GvDef.heightRef);

    double minConvRatio = min(_wScaleRatio, _hScaleRatio);

    // Get.textScaleFactor
    // web 에서는 1
    // 삼성 갤럭시 구형폰 1.1
    // 삼성 태블릿 1
    // 왜 나누기 하는지 추후 재 점검 필요
    // 글씨 크기 제한했을 때 넘쳐서 텍스트 스케일 팩터로 나눈 것으로 기억
    gv.setting.fontScale = minConvRatio / Get.textScaleFactor;
    gv.setting.fontScale = max(gv.setting.fontScale, 0.3); //0.8보다는 크게
    gv.setting.fontScale = min(gv.setting.fontScale, 1.5); //1.2보다는 작게 (추후 조절)
    // 새로운 폰트 크기로 반영
    tm.convertFontSize();


    if (kDebugMode) {
      print('-----------------------------------------------------------');
      print('상단 스마트앱 공간 : $topPad');
      print('화면 넓이 : $screenWidth  디자인 넓이 : ${GvDef.widthRef}  비율 $_wScaleRatio');
      print('화면 높이 : $screenHeight  실제 화면 높이 : ${screenHeight - topPad}'
          ' 디자인 넓이 : ${GvDef.heightRef}  비율 $_hScaleRatio');
      print('글씨 크기 비율 (통상적으로는 1) : ${Get.textScaleFactor}');
      print('-----------------------------------------------------------');
    }
  // }
}

//==============================================================================
// auto Scale sized box
//==============================================================================
Widget asSizedBox({
  double width = 0,
  double height = 0,
}) {
  double w = width * _wScaleRatio; //Get.width / GvDef.widthRef;
  double h = height * _hScaleRatio; //Get.height / GvDef.heightRef;
  return SizedBox(
    width: w,
    height: h,
  );
}

//==============================================================================
// 자동 넓이, 높이 계산
//==============================================================================
asWidth(double value) {
  return value * _wScaleRatio; //Get.width / GvDef.widthRef;
}

asHeight(double value) {
  return value * _hScaleRatio; //Get.height / GvDef.heightRef;
}


// //==============================================================================
// // auto Scale sized box
// //==============================================================================
//
// Widget asSizedBox({double width = 0, double height = 0,}) {
//   double w = Get.width * width / 360;
//   double h = Get.height * height / 800;
//   return SizedBox(
//     width: w,
//     height: h,
//   );
// }
//
// //==============================================================================
// // 자동 넓이, 높이 계산
// //==============================================================================
// asWidth(double value)
// {
//   return Get.width * value / 360;
// }
// asHeight(double value)
// {
//   return Get.height * value / 800;
// }
