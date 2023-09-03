import '/F0_BASIC/common_import.dart';

//==============================================================================
// popup
//==============================================================================
openPopupBasic(Widget child,
    {Color? backgroundColor,
    AlignmentGeometry? alignment,
    ShapeBorder? shape,
    EdgeInsets? insetPadding}) {
  if (insetPadding == null) {
    Get.dialog(
      AlertDialog(
        content: child,
        backgroundColor: backgroundColor,
        alignment: alignment,
        shape: shape,
      ),
    );
  } else {
    Get.dialog(
      AlertDialog(
        content: child,
        backgroundColor: backgroundColor,
        alignment: alignment,
        shape: shape,
        insetPadding: insetPadding,
      ),
    );
  }
}

//==============================================================================
// popup
//==============================================================================
openPopupWarning(String text) {
  openPopupBasic(
    TextN(
      text,
      color: tm.white,
      fontSize: tm.s18,
      fontWeight: FontWeight.bold,
      height: 1.2,
      textAlign: TextAlign.center,
    ),
    backgroundColor: tm.red,
    alignment: Alignment.topCenter,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(asWidth(16)))),
    insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
  );
}

//==============================================================================
// popup process indicator
//==============================================================================
Dialog openPopupProcessIndicator(BuildContext context,
    {String text = 'wait...',
    Color backgroundColor = Colors.transparent,
    EdgeInsets? insetPadding}) {
  Dialog _dialog = Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(asHeight(10)),
    // ),
    child: Container(
      width: asWidth(200),
      height: asHeight(200),
      decoration: BoxDecoration(
        color: tm.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(asHeight(20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(asWidth(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: asHeight(50),
              height: asHeight(50),
              child: FittedBoxN(
                fit: BoxFit.scaleDown,
                child: Image.asset(
                  'assets/icons/spin_loading.gif',
                  width: asHeight(49),
                  height: asHeight(49),
                ),
              ),

              // CircularProgressIndicator(
              //   color: tm.mainBlue,
              //   strokeWidth: asWidth(4),
              // )
            ),
            asSizedBox(height: 20),
            TextN(
              text,
              fontSize: tm.s18,
              color: tm.white,
              height: 1.5,
            ),
          ],
        ),
      ),
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return _dialog;
    },
  );

  return _dialog;
}

//==============================================================================
// popup
//==============================================================================
openSnackBarBasic(String title, String contents,
    {Duration duration = const Duration(seconds: 3)}) {
  // 색상 등 추후에 적절하게 디자인 보완하기
  if (SnackbarController.isSnackbarBeingShown != true) {
    Get.snackbar(title, contents, duration: duration);
  }
}

//==============================================================================
// 전극 접촉 경고 - stack 과 함께 사용 (팝업 아닌 위젯)
//==============================================================================

class ElectrodeWarning extends StatefulWidget {
  const ElectrodeWarning({Key? key}) : super(key: key);

  @override
  State<ElectrodeWarning> createState() => _ElectrodeWarningState();
}

class _ElectrodeWarningState extends State<ElectrodeWarning> {
  late Timer _timer;
  late StreamSubscription _streamSubscription;
  bool flagException = false;

  // bool flagDetached = false; //전극에 떨어진 상태
  int cntElectrodeDetached = 0; //전극 분리상태
  int cntElectrodeNotGood = 0; //전극 접촉 불량 - 괴첼 주파수
  int cntFakeTouch = 0; // 가짜신호 - 터치 감지
  int cntFakePeakTooBig = 0; // 가짜신호 - 평균 대비 기준 이상 톤 신호 감지
  int cntBigTouch = 0; // 외부 강한 터치
  int cntBtUnstable = 0; // 블루투스 패킷 loss 시 큰 신호 나오기도
  int displayTime = 15; //1.5초

  ///---------------------------------------------------------------------------
  /// init
  ///---------------------------------------------------------------------------
  @override
  void initState() {
    //--------------------------------------------------------------------------
    // 1회 감지가 되면 일정 시간 경고화면 유지하기
    //--------------------------------------------------------------------------
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      //------------------------------------------------------------------------
      // 전극 분리 된 상태
      if (cntElectrodeDetached > 0) {
        if (gv.deviceStatus[0].exceptionStatus.value !=
            EmlExceptionType.detached) {
          cntElectrodeDetached--;
        }
      }
      //------------------------------------------------------------------------
      // 전극 분리 순간
      if (cntElectrodeNotGood > 0) {
        cntElectrodeNotGood--;
      }
      //------------------------------------------------------------------------
      // 가짜신호 분석 - 터치
      if (cntFakeTouch > 0) {
        if (dm[0].g.dsp.exFakeType != EmlExFakeType.lowFreqVsHighTooBig) {
          cntFakeTouch--;
        }
      }
      //------------------------------------------------------------------------
      // 가짜신호 분석 - 피크신호
      if (cntFakePeakTooBig > 0) {
        if (dm[0].g.dsp.exFakeType != EmlExFakeType.lowFreqVsHighTooBig) {
          cntFakePeakTooBig--;
        }
      }
      //------------------------------------------------------------------------
      // 큰 터치 (값의 큰 변화)
      if (cntBigTouch > 0) {
        if (gv.deviceStatus[0].exceptionStatus.value !=
            EmlExceptionType.touch) {
          cntBigTouch--;
        }
      }
      //------------------------------------------------------------------------
      // 무선통신 연결 불량
      if (cntBtUnstable > 0) {
        if (gv.deviceStatus[0].exceptionStatus.value !=
            EmlExceptionType.external) {
          cntBtUnstable--;
        }
      }
      //------------------------------------------------------------------------
      // 경고 화면 띄울지 여부 선택
      if (cntElectrodeDetached > 0 ||
          cntElectrodeNotGood > 0 ||
          cntFakeTouch > 0 ||
          cntFakePeakTooBig > 0 ||
          cntBigTouch > 0 ||
          cntBtUnstable > 0) {
        flagException = true;
        setState(() {});
      }
      //------------------------------------------------------------------------
      // 정상으로 돌아 왔을 때 화면 갱신 1회
      else {
        if (flagException == true) {
          flagException = false;
          setState(() {});
        }
      }

      //------------------------------------------------------------------------
      // 시작 후 3초 및 종료 단계에서는 메시지 띄우지 않기!!!
      // 시작과 끝 단계에서 단절 효과로 저주파/고주파 비율 에러나는 듯
      if (DspManager.timeMeasureSet < 3) {
        flagException = false;
      } else if (DspManager.stateMeasure.value != EmlStateMeasure.onMeasure) {
        flagException = false;
      }
    });

    //--------------------------------------------------------------------------
    // 이벤트 감지 리스너
    // 1회 감지가 되면 2~3초간 화면 띄우기
    //--------------------------------------------------------------------------

    _streamSubscription =
        gv.deviceStatus[0].exceptionStatus.listen((exceptionStatus) {
      //------------------------------------------------------------------------
      // 전극 분리 상태 - 이벤트가 1회만 뜸
      //------------------------------------------------------------------------
      if (exceptionStatus == EmlExceptionType.detached) {
        cntElectrodeDetached = displayTime;
        if (kDebugMode) {
          print('[EXCEPTION] 전극 분리 상태유지 --------------------------------');
          // print(gv.deviceStatus[0].exceptionStatus);
          // print(dm[0].g.dsp.exFakeType);
        }
      }
      //------------------------------------------------------------------------
      // 전극 분리 순간
      //------------------------------------------------------------------------
      if (exceptionStatus == EmlExceptionType.detach) {
        cntElectrodeNotGood = displayTime;
        if (kDebugMode) {
          print('[EXCEPTION] 전극 분리 발생 --------------------------------');
        }
      }
      //------------------------------------------------------------------------
      // fake
      //------------------------------------------------------------------------
      else if (exceptionStatus == EmlExceptionType.fake &&
          cntElectrodeDetached == 0) {
        //----------------------------------------------------------------------
        // 터치가 의심되는 경우
        if (dm[0].g.dsp.exFakeType == EmlExFakeType.lowFreqVsHighTooBig) {
          cntFakeTouch = displayTime;
          if (kDebugMode) {
            print('[EXCEPTION] touch --------------------------------');
          }
        }
        //----------------------------------------------------------------------
        // 접촉 불안정
        // 접촉이 불안정하여 피크가 높게 뜨는 경우 - 주의!
        else if (dm[0].g.dsp.exFakeType != EmlExFakeType.none &&
            cntElectrodeDetached == 0) {
          cntFakePeakTooBig = displayTime;
          if (kDebugMode) {
            print('[EXCEPTION] 전극 접점 불량 --------------------------------');
          }
        }
      }
      //------------------------------------------------------------------------
      // touch or 값의 큰 변화
      //------------------------------------------------------------------------
      else if (exceptionStatus == EmlExceptionType.touch &&
          cntElectrodeDetached == 0) {
        cntBigTouch = displayTime;
        if (kDebugMode) {
          print('[EXCEPTION] big touch --------------------------------');
        }
      }
      //------------------------------------------------------------------------
      // 블루투스 불안정 - 패킷 소실
      //------------------------------------------------------------------------
      else if (exceptionStatus == EmlExceptionType.external) {
        cntBtUnstable = displayTime;
        if (kDebugMode) {
          print('[EXCEPTION] BT unstable --------------------------------');
        }
      }
      //------------------------------------------------------------------------
      // 정상상태
      //------------------------------------------------------------------------
      else if (exceptionStatus == EmlExceptionType.none) {
        if (kDebugMode) {
          print('[EXCEPTION] 정상상태 --------------------------------');
        }
      }
    });
    super.initState();
  }

  ///---------------------------------------------------------------------------
  /// dispose
  ///---------------------------------------------------------------------------
  @override
  void dispose() {
    _timer.cancel();
    _streamSubscription.cancel();
    super.dispose();
  }

  ///---------------------------------------------------------------------------
  /// build
  ///---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    //------------------------------------------------------------------
    // 경고문구 - 장비가 연결되어 있고, 접촉 상태가 좋지 않을 때 발생

    return flagException == true
        ? Positioned(
            top: asHeight(30),
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(asHeight(16)),
                width: asWidth(300),
                height: asHeight(100),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(asHeight(20)),
                  color: tm.red.withOpacity(0.8),
                ),
                child: AutoSizeText(
                  cntElectrodeDetached > 0
                      ? '전극이 피부에서 떨어졌습니다. 전극 2개가 모두 잘 붙어 있는지 확인하세요.'
                      : cntElectrodeNotGood > 0
                          ? '전극-피부 접촉 상태가 좋지 않습니다. 전극 2개가 모두 잘 붙어 있는지 확인하세요.'
                          : cntFakePeakTooBig > 0
                              ? '전극-피부 접촉이 불안정합니다. 전극 2개가 모두 잘 붙어 있는지 확인하세요.'
                              : cntBigTouch > 0
                                  ? '전극 상태에 변화가 감지되었습니다. 장비에 충격이 가지 않도록 주의하세요.'
                                  : cntFakeTouch > 0
                                      ? '충격이 감지되었습니다. 장비에 충격이 가지 않도록 주의하세요.'
                                      : cntBtUnstable > 0
                                          ? '장비와의 무선통신이 불안정합니다.'
                                          : '--------------',
                  style: TextStyle(
                    color: tm.white,
                    fontSize: tm.s18,
                  ),
                  maxLines: 2,
                ),
              ),
            ),
          )
        : Container();
  }
}
