import '/F0_BASIC/common_import.dart';

//==============================================================================
// 첫 사용자 background
//==============================================================================

class FirstUserPage extends StatelessWidget {
  const FirstUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    gv.system.maxHeightExcludeTopPadding = Get.height - MediaQuery.of(context).padding.top;
    if (gv.system.isFirstUser == true) {
      Future.delayed(
        Duration.zero,
            () => openBottomSheetBasic(
          child: const WelcomeBottomSheet(),

          height: gv.system.maxHeightExcludeTopPadding, //Get.height - asHeight(80),
          isDismissible: false,
          enableDrag: false,
        ),
      );
    }

    return Material(
      color: tm.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //------------------------------------------------------------------
            // 상단 바
            // topBarBasic(context),
          ],
        ),
      ),
    );
  }
}
