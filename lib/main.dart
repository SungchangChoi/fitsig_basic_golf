import '/F0_BASIC/common_import.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//==============================================================================
// main
//==============================================================================
void main() async {
  //준비를 완료하고 main 시작 (초기 dB test 에러. 정상 코드에서는 지워도 됨)


    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□ [BOOT TIME CHECK] '
          '시작 부분  $time');
    }
    WidgetsFlutterBinding.ensureInitialized();


    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□ [BOOT TIME CHECK] '
          'ensureInitialized  $time');
    }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    //화면 상단의 status 바와 아랫쪽에 gesture bar 둘다 없앰
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□ [BOOT TIME CHECK] '
          'SystemChrome.setPreferredOrientations()  $time');
    }

    await preAppProcess(); //앱 시작 전 사전 준비 : 대략 1.2초 정도 소요

    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□ [BOOT TIME CHECK] '
          'preAppProcess() 끝난 후  $time');
    }
    runApp(const MyApp());
}

//==============================================================================
// 앱 시작
//==============================================================================

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // //--------------------------------------------------------------------------
    // // app 초기화
    // //--------------------------------------------------------------------------
    // appInit();

    return GetMaterialApp(
      //------------------------------------------------------------------------
      // 디버그 표시 없애기
      //------------------------------------------------------------------------
      debugShowCheckedModeBanner: false,
      //------------------------------------------------------------------------
      // 언어 번역 설정
      //------------------------------------------------------------------------
      translations: LanguageTranslation(),
      //언어 번역 데이터 있는 곳
      locale: LanguageData.supportedLocales[gv.setting.languageIndex.value],
      //gv.setting.locale.value,
      //기본은 한국 및 한국어
      fallbackLocale: const Locale('en', 'US'),
      //Locale('ko', 'KR'), //
      //기본 다른 지역 설정 시 영어로 보임
      // var locale = Locale('en', 'US');
      // Get.updateLocale(locale); // 지역 변경 시 명령
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ko', 'KO'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      title: 'FITSIG BASIC',
      //------------------------------------------------------------------------
      // 테마
      // 변경 : Get.changeTheme(ThemeData.light());
      //------------------------------------------------------------------------

      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'NanumSquare',
      ),

      //------------------------------------------------------------------------
      // 라우트 이름 정의
      //------------------------------------------------------------------------
      // getPages: [
      //   GetPage(name: '/RecordMain', page: () => const RecordMain()),
      // ],

      //------------------------------------------------------------------------
      //시작 화면
      //------------------------------------------------------------------------
      home: const Splash(),
    );
  }
}
