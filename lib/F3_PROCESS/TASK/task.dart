import '/F0_BASIC/common_import.dart';
import 'dart:io' show Platform;

//==============================================================================
// 100ms 주기 task
//==============================================================================
late Timer _timer100ms;
int _cntDbRecord = 10;
int task100msCnt = 0; // task100ms 함수가 실행될때마다 count

void task100ms() {
  _timer100ms =
      Timer.periodic(const Duration(milliseconds: 100), (timer) async {
    task100msCnt++;

    //--------------------------------------------------------------------------
    // 블루투스 연결 관리
    // iOS 는 정전기에 의한 장치 종료시, OS 에서 약 0.8초 후에 disconnected 로 판단하여 event 를 발생
    // 따라서 500ms 주기로 모니터링으로 disconnected 를 OS 보다 먼저 잡아낼 확률이 낮으므로, iOS 일 때는
    // 모니터링 실행 주기를 200ms 로 줄임 (2023.02.13)
    //--------------------------------------------------------------------------
    if (task100msCnt == (Platform.isIOS ? 2 : 5)) {
      task100msCnt = 0;
      taskBluetoothQualityMonitoring();
    }
  });
}

//==============================================================================
// 1s 주기 task
//==============================================================================
late Timer _timer1s;
int nDspLoopCntIce = 0;

void task1s() {
  _timer1s = Timer.periodic(const Duration(seconds: 1), (timer) {
    bool isConnected = gv.deviceStatus[0].isDeviceBtConnected.value == true;
    //--------------------------------------------------------------------------
    // 통신 품질 측정 : 에러가 심하면 측정을 중단할 수 있음
    gv.deviceStatus[0].taskEvery1sec();

    //--------------------------------------------------------------------------
    // 화면 크기 변화 감지
    //--------------------------------------------------------------------------
    checkScreenSizeChane();

    //--------------------------------------------------------------------------
    // 휴식시간 감소시키기
    //--------------------------------------------------------------------------
    if (DspManager.timeSetRelax.value > -1) {
      DspManager.timeSetRelax.value--;
    }

    // testIsConnected.value = !testIsConnected.value;
    //--------------------------------------------------------------------------
    // 측정시간 표시용
    // if (gv.control.stateMeasure.value == EmlStateMeasure.onMeasure){
    //   gv.control.measureTime++;
    // }
  });
}
