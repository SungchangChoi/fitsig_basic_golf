import '/F0_BASIC/common_import.dart';

//==============================================================================
// emg 바 그래프
//==============================================================================

class OpenSourceLicensePage extends StatelessWidget {
  const OpenSourceLicensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
          child: Column(
            children: [
              //----------------------------------------------------------------
              // 상단 바
              topBarBack(context, title: '오픈소스 라이선스'),
              //----------------------------------------------------------------
              // 하단 내용
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: asWidth(18), vertical: asHeight(18)),
                      child: const LicensePage(),
                      // child: Column(
                      //   children: [
                      //     //----------------------------------------------------
                      //     // 라이선스
                      //     const LicensePage(),
                      //     textNormal(text),
                      //   ],
                      // ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
