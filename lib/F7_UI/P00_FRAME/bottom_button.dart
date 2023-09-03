import '/F0_BASIC/common_import.dart';

//==============================================================================
// Bottom button
//==============================================================================
class BottomButtonControl extends StatefulWidget {
  const BottomButtonControl({Key? key}) : super(key: key);

  @override
  State<BottomButtonControl> createState() => _BottomButtonControlState();
}

class _BottomButtonControlState extends State<BottomButtonControl> {
  StreamSubscription? listenBtControlState;
  int d = 0;
  // bool isCompleteFromButton = false;

  // bool isException = false;

  ///---------------------------------------------------------------------------
  /// init & dispose
  ///---------------------------------------------------------------------------
  @override
  void initState() {
    listenBtControlState =
        gv.deviceStatus[d].btControlState.listen((btControlState) {
          // 만약, 측정 중에 예외 종료 상황이 발생한다면
          if (btControlState == EmlBtControlState.exDisconnectingDis ||
              btControlState == EmlBtControlState.exDisconnectingEn) {
            measureStopProcess(); //종료 알림 팝업
          }
        });
    super.initState();
  }

  @override
  void dispose() {

    // if (isCompleteFromButton == false){
    //   measureCancelProcess();
    //   await Future.delayed(Duration(milliseconds: 1500));
    // }


    listenBtControlState?.cancel();
    listenBtControlState = null;
    super.dispose();
  }

  ///---------------------------------------------------------------------------
  /// build
  ///---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    //--------------------------------------------------------------------------
    // 스마트앱 back 버튼에 의한 비 정상 종료 시 동작 : 종료 메시지 후 복귀
    return WillPopScope(
      onWillPop: () async {
        measureCancelProcess();
        return true;
      },
      //--------------------------------------------------------------------------
      // 실행화면
      child: Container(
        // width: double.maxFinite,
        width: asWidth(GvDef.widthRef),
        height: asHeight(160),
        color: tm.mainBlue,
        child: Container(
          width: asWidth(104),
          height: asHeight(114),
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  //------------------- 측정 중단하기
                  onTap: (() async {
                    // isCompleteFromButton = true;
                    measureStopProcess();
                  }),
                  borderRadius: BorderRadius.circular(asHeight(20)),
                  child: Container(
                    width: asWidth(104),
                    height: asHeight(114),
                    alignment: Alignment.center,
                    // color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        asSizedBox(height: 10),
                        //--------------------------------------------------------------------
                        // 종료 버튼
                        Container(
                          width: asHeight(44),
                          height: asHeight(44),
                          decoration: BoxDecoration(
                            color: tm.fixedWhite, //todo : click 시 색상이 먹히도록 수정
                            borderRadius: BorderRadius.circular(asHeight(8)),
                          ),
                        ),
                        //--------------------------------------------------------------------
                        // 하단 측정 시간
                        asSizedBox(height: 20),
                        Obx(() {
                          int sec = DspManager.timeMeasure.value % 60;
                          int min = DspManager.timeMeasure.value ~/ 60;
                          return Container(
                            width: asWidth(84),
                            alignment: Alignment.center,
                            // color: Colors.green,
                            child: TextN(
                              '${min.toStringAsFixed(0).padLeft(2, '0')}'
                                  ':${sec.toStringAsFixed(0).padLeft(2, '0')}',
                              fontSize: tm.s20,
                              color: tm.fixedWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//==============================================================================
// 측정 종료 프로세스 팝업 창
//==============================================================================
measureStopProcess() {
  int d = 0;

  var context = Get.context!;
  DspManager.isMeasureOnScreen = false; //화면상 측정 종료 (애니메이션 에러 방지 목적)
  // 측정 중일,면
  if (DspManager.stateMeasure.value == EmlStateMeasure.onMeasure) {
    //--------------------------------------------------------------------------
    // 측정 UI 에서 사용하던 리스너 및 타이머 종료
    //--------------------------------------------------------------------------
    endMeasure();


    //--------------------------------------------------------------------------
    // 측정 종료 명령 - 중복클릭 방지
    //--------------------------------------------------------------------------
    DspManager.commandMeasureComplete();

    //--------------------------------------------------------------------------
    // 팝업 열기
    //--------------------------------------------------------------------------
    var _dialog = openPopupProcessIndicator(
      context,
      text: bt[d].bleDevice.isBtConnectedReal.value
          ? '측정 종료 중 입니다'
          : '블루투스 연결이 끊어져서 측정이 중단됩니다.',
    );
    //--------------------------------------------------------------------------
    // 측정 종료 명령 후 상태 대기
    //--------------------------------------------------------------------------
    late Timer _timer;
    int cntTimeout = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      cntTimeout++; //응답 타임아웃 체크
      //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
      // 정상적 종료
      //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
      if (DspManager.stateMeasure.value == EmlStateMeasure.idle) {
        _timer.cancel();
        //--------------------------------------------------
        // 다이올로그 닫기
        Navigator.pop(context, _dialog);
        //--------------------------------------------------
        // 종료 페이지로 이동 (애니메이션)
        Navigator.of(context).pushReplacement(pageRouteAnimationSimple(
            const MeasureEnd(), EmlMoveDirection.rightToLeft));
      }
      //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
      // 타임아웃 종료 - 2초 이상 지난 경우
      // 블루투스 연결 해제 등으로 비정상 종료 된 경우
      //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
      else if (cntTimeout > 20) {
        _timer.cancel();
        if (kDebugMode) {
          print('bottom_button.dart :: 타임아웃 종료.');
        }
        //--------------------------------------------------
        // 다이올로그 닫기
        Navigator.pop(context, _dialog);
        //--------------------------------------------------
        // 종료 페이지로 이동 (애니메이션)
        Navigator.of(context).pushReplacement(pageRouteAnimationSimple(
            const MeasureEnd(), EmlMoveDirection.rightToLeft));
      }
    });
  }
}

//==============================================================================
// 측정 취소 프로세스 (앱에서 back 버튼)
//==============================================================================
measureCancelProcess() {
  int d = 0;

  var context = Get.context!;
  DspManager.isMeasureOnScreen = false; //화면상 측정 종료 (애니메이션 에러 방지 목적)
  // 측정 중일,면
  if (DspManager.stateMeasure.value == EmlStateMeasure.onMeasure) {
    //--------------------------------------------------------------------------
    // 측정 UI 에서 사용하던 리스너 및 타이머 종료
    //--------------------------------------------------------------------------
    endMeasure();


    //--------------------------------------------------------------------------
    // 측정 종료 명령 - 중복클릭 방지
    //--------------------------------------------------------------------------
    DspManager.commandMeasureComplete();

    //--------------------------------------------------------------------------
    // 팝업 열기
    //--------------------------------------------------------------------------
    var _dialog = openPopupProcessIndicator(
      context,
      text: '측정 취소 중입니다.',
    );
    //--------------------------------------------------------------------------
    // 측정 종료 명령 후 상태 대기
    //--------------------------------------------------------------------------
    late Timer _timer;
    int cntTimeout = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      cntTimeout++; //응답 타임아웃 체크
      //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
      // 정상적 종료
      //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
      if (DspManager.stateMeasure.value == EmlStateMeasure.idle) {
        _timer.cancel();
        //--------------------------------------------------
        // 다이올로그 닫기 후 대기 화면으로 이동
        Navigator.pop(context, _dialog);
        Get.back();
      }
      //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
      // 타임아웃 종료 - 2초 이상 지난 경우
      // 블루투스 연결 해제 등으로 비정상 종료 된 경우
      //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
      else if (cntTimeout > 20) {
        _timer.cancel();
        if (kDebugMode) {
          print('bottom_button.dart :: 타임아웃 종료.');
        }
        //--------------------------------------------------
        // 다이올로그 닫기 후 대기 화면으로 이동
        Navigator.pop(context, _dialog);
        Get.back();
      }
    });
  }
}


//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// 블루투스 연결이 끊어진 경우
// 데모신호 생성중이 아니면서, 장비가 꺼져있다면, EmlStateMeasure.idle 를 기다리지 않고 종료
// 다른곳에서 처리하므로 실제로 실행될 가능성 없는 상태 (221021 - CSC)
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// else if ((gv.bleManager[0].device1 == null ||
//         gv.bleManager[0].device1?.wvIsConnected.value ==
//             false) &&
//     gv.setting.isEnableDemo.value == false) {
//   _timer.cancel();
//   // 장비가 꺼져서 측정을 종료하는 것이므로, 원래 값으로 복귀
//   gv.deviceData[0].mvcLevel.value = gv
//           .dbMuscleIndexes[gv.control.idxMuscle.value]
//           .mvcMv *
//       GvDef.convLv;
//   if (kDebugMode) {
//     print(
//       'bottom_button.dart :: 측정 중 장비의 연결이 해제되어 측정을 취소합니다.');
//     print(
//         'bottom_button.dart :: gv.bleManager[0].device1=${gv.bleManager[0].device1}, wvIsConnected.value=${gv.bleManager[0].device1?.wvIsConnected.value}');
//   }
//   //바로 창이 닫히는 문제 때문에
//   await Future.delayed(const Duration(seconds: 2));
//   //--------------------------------------------------
//   // 다이올로그 닫기
//   Navigator.pop(context, _dialog);
//   Get.back();
// }
