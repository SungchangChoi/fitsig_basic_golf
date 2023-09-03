import '/F0_BASIC/common_import.dart';

//==============================================================================
// splash pre
// fade 효과를 주기위한 페이지
// 부팅시간 늘리는 것 같아 pass
//==============================================================================
class SplashPre extends StatefulWidget {
  const SplashPre({Key? key}) : super(key: key);

  @override
  State<SplashPre> createState() => _SplashPreState();
}

class _SplashPreState extends State<SplashPre> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1), () {
      Get.off(() => const Splash(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(),
    );
  }
}

//==============================================================================
// splash
//==============================================================================
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  late Timer _timer; //타이머
  // bool isLoadComplete = false;

  // int count = 0;
  // int cnt100ms = 0;

  //----------------------------------------------------------------------------
  // 앱 활성화/비활성화 감지
  // 여기서 한번 코딩하면 계속 동작 함
  //----------------------------------------------------------------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    int d = 0;
    //---------------------------------------------------------------
    // 앱이 부분적으로 보이거나 비 포커스 상태
    //---------------------------------------------------------------
    if (state == AppLifecycleState.inactive) {
      // for (int d = 0; d < GvDef.maxDeviceNum; d++) cmdOfDevice[d].screenState = 1;
      if (kDebugMode) {
        print('앱이 부분적으로 보이거나 비 포커스');
      }
    }
    //---------------------------------------------------------------
    // 앱이 화면상에 표시되고 있음
    //---------------------------------------------------------------
    else if (state == AppLifecycleState.resumed) {
      //스크린 off 명령 전송
      BleManager.notifyScreenState(isScreenOff: false);
      // if (kDebugMode) {
      //   print('V00_Intro_main.dart :: 앱이 화면상에 표시되고 있음. 디바이스에게 스크링상태(on)를 전송합니다.');
      // }
    }
    //---------------------------------------------------------------
    // 앱이 백그라운드 상태에 있음
    //---------------------------------------------------------------
    else if (state == AppLifecycleState.paused) {
      //스크린 off 명령 전송
      BleManager.notifyScreenState(isScreenOff: true);
      // if (kDebugMode) {
      //   print('V00_Intro_main.dart :: 앱이 백그라운드 상태에 있음. 디바이스에게 스크링상태(off)를 전송합니다.');
      // }
    }
    //---------------------------------------------------------------
    // 앱이 종료되었음
    //---------------------------------------------------------------
    else if (state == AppLifecycleState.detached) {
      if (kDebugMode) {
        print('앱이 종료되었음');
      }
    }
  }

  //----------------------------------------------------------------------------
  // 초기 설정
  //----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    //-------------------------------------------
    // 타이머로 1초 단위 전체 화면 갱신
    _timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        // cnt100ms++;
        // if (cnt100ms == 10) {
        //   cnt100ms = 0;
        //   count++;
        //   setState(() {});
        // }
        //------------------------------------
        // loading 완료되면 메인 화면으로 이동 (여기서는 타이머로 종료 처리)
        // if (count == 1) {
        //   _timer.cancel();
        //   // print(gv.control.idxMuscle.value);
        //   // print(gv.control.idxMuscle.value);
        //   // print('-----------------------');
        //
        //   // 처음으로 앱을 시작하는 것이라면 첫 사용자 페이지로
        //   if (gv.system.isFirstUser == true) {
        //     Get.off(() => const FirstUserPage()); //조건부
        //   }
        //   // 처음이 아니라면 대기모드로
        //   else {
        //     Get.off(() => const MeasureIdle());
        //   }
        // }

        if (gv.control.flagAppInitComplete == true) {
          if (gv.system.isFirstUser == true) {
            Get.off(() => const FirstUserPage()); //조건부
          }
          // 처음이 아니라면 대기모드로
          else {
            Get.off(() => const MeasureIdle());
          }
          // _timer.cancel();
          // Get.off(() => const MeasureIdle(),
              // transition: Transition.fade,
              // duration: const Duration(milliseconds: 500)
          // );
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const MeasureIdle()));
        }
      },
    );

    //--------------------------------------------------
    // 앱 초기화 실행
    appInit();
    //화면기 그려진 후에 앱 초기화 수행...
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _asyncInitMethod();
    // });

    //--------------------------------------------------
    // 앱 활성화 살펴보는 구문
    WidgetsBinding.instance.addObserver(this);

    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□ [BOOT TIME CHECK] '
          'splash init 마지막 지점 $time');
    }
  }

  // Future<void> _asyncInitMethod() async {
  //   await appInit();
  //   setState(() {
  //     isLoadComplete = true;
  //   });
  // }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //--------------------------------------------
  // 앱 활성화/비활성화
  //--------------------------------------------
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.inactive) {
  //     for (int d = 0; d < MAX_DEVICE_NUM; d++) cmdOfDevice[d].screenState = 1;
  //     print('입이 부분적으로 보이거나 비 포커스');
  //   } else if (state == AppLifecycleState.resumed) {
  //     for (int d = 0; d < MAX_DEVICE_NUM; d++) cmdOfDevice[d].screenState = 0;
  //     print('입이 화면상에 표시되고 있음');
  //   }
  //   else if (state == AppLifecycleState.paused) {
  //     for (int d = 0; d < MAX_DEVICE_NUM; d++) cmdOfDevice[d].screenState = 1;
  //     print('앱이 백그라운드 상태에 있음');
  //   }
  //   else if (state == AppLifecycleState.detached) {
  //     for (int d = 0; d < MAX_DEVICE_NUM; d++) cmdOfDevice[d].screenState = 1;
  //     print('앱이 종료되었음');
  //   }
  // }

  //----------------------------------------------------------------------------
  // 빌드
  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□ [BOOT TIME CHECK] '
          '첫 화면 뿌리는 시점 $time');
    }
    // var textn = TextN('');
    // textn.setTextScaleFactor(1);
    //--------------------------------------------------------------------------
    // 첫 이미지 생성
    //--------------------------------------------------------------------------
    return Material(
        color: Colors.white,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: gv.setting.skinColor.value < 2 ? SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ): SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //----------------------------------------------
              // 로고
              Image.asset(
                'assets/images/logo_fitsig_basic.png',
                fit: BoxFit.scaleDown,
                height: asHeight(52),
                // color: Colors.lightGreenAccent,
              ),
              // //----------------------------------------------
              // // 대기 표시
              // asSizedBox(height: 30),
              // CircularProgressIndicator(
              //   value: null,
              //   strokeWidth: asWidth(7),
              //   color: Colors.blue,
              // ),
              // //----------------------------------------------
              // // 데이터 로딩 글씨 및 카운트
              // asSizedBox(height: 30),
              // // Row(
              // //   mainAxisAlignment: MainAxisAlignment.center,
              // //   children: [
              // Align(
              //   alignment: Alignment.center,
              //   child: TextN(
              //     'data loading  ......',
              //     color: Colors.blue,
              //     fontSize: tm.s15,
              //   ),
              // ),

              // (() {
              //   if (kDebugMode) {
              //     String time = printPresentTime(printEnable: false);
              //     print('□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□ [BOOT TIME CHECK] '
              //         '스플래시 화면 다 그린 상태 $time');
              //   }
              //   return Container();
              // }()),
            ],
          ),
        ));
  }
}
