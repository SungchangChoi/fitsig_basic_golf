import '/F0_BASIC/common_import.dart';
import 'package:path/path.dart';

//==============================================================================
// 주기적으로 스크린 사이즈 변화 감지
// 이벤트 감지 방식으로 체크 방식으로 변경
// 100ms 마다 체크 (주기는 변경될 수 있음)
//==============================================================================

double _screenWidth_1p = 0;
double _screenHeight_1p = 0;

void checkScreenSizeChane() {
  BuildContext? context = Get.context;

  if (context != null) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;
    //----------------------------------------------
    // 스크린 변화가 감지 된 경우
    if (screenWidth != _screenWidth_1p || screenHeight != _screenHeight_1p) {
      _screenWidth_1p = screenWidth;
      _screenHeight_1p = screenHeight;
      //----------------------------------------------
      // 스케일 전반적으로 변경
      asRatioReferenceInit(); //사이즈 재 변경
      //----------------------------------------------
      // 화면 갱신
      // refreshMainHomePage(); //메인 홈페이지 화면 갱신
      // gv.control.refreshPageWhenSettingChange.value++; //대기화면 갱신
      // var route = ModalRoute.of(context);
      // if(route!=null){
      //   print(route.settings.name);
      // }

      String currentRoute = Get.currentRoute;
      if (kDebugMode) {
        print('current page $currentRoute');
      }

      //release mode 에서 동작하는지 확인 필요
      // 디버그 모드에서만 동작 할 수도
      Get.forceAppUpdate();
      gv.control.refreshPageWhenSettingChange.value++; //대기화면 갱신
      // (context as Element).reassemble();

      // //대기화면 갱신
      // if (currentRoute == '/MeasureIdle') {
      //   gv.control.refreshPageWhenSettingChange.value++; //대기화면 갱신
      // } else {
      //   // 창 닫은 후 다시 열기
      //   Get.back();
      //   // Navigator.pop(context);
      //
      //   Future.delayed(const Duration(milliseconds: 500), (() {
      //     // context = Get.context;
      //     // Navigator.push(
      //     //   context!,
      //     //   MaterialPageRoute(builder: (context) => RecordMain()),
      //     // );
      //
      //     Get.toNamed(
      //       currentRoute, //RecordMain(), //currentRoute,
      //       // duration: const Duration(milliseconds: 500),
      //       // transition: Transition.rightToLeft,
      //     );
      //   }));
    }

    // if (kDebugMode) {
    //   print(Get.currentRoute);
    // }
    // Get.back();
    // Get.to(() => Get.currentRoute);

    // print('current page ${ModalRoute.of(context)?.settings.name}');
    // }
  }
}
