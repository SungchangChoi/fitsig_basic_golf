import '/F0_BASIC/common_import.dart';

//==============================================================================
// BLE callback : 장비별 call back
//==============================================================================

class BleCallback {
  final int deviceIndex;

  BleCallback({required this.deviceIndex});

  ///---------------------------------------------------------------------------
  /// 연결된 경우
  ///---------------------------------------------------------------------------
  callbackConnected() async {
    //------------------------------------------------------------------
    // 연결 명령에 따른 콜백 이벤트라면
    //------------------------------------------------------------------
    if (BleManager.flagIsCmdConnect == true) {
      BleManager.flagIsCmdConnect = false;

      // 연결에 성공할 경우, 재연결 종료 타이머 취소(연결되자마자 다시 정전기 재부팅 되면 타이머가 살아있다가..재연결 시도중에 중단시키는 문제때문에. 2023.02.07)
      if (gv.setting.isBluetoothAutoConnect.value == false) {
        gv.btStateManager[deviceIndex]
            .cancelReconnectExpirationTimer();
      }
      if (kDebugMode) {
        String time = printPresentTime(printEnable: false);
        print('----------------------------------');
        print('BleCallback :: callbackConnected() :: 블루투스가 연결 되었습니다. $time');
        print('----------------------------------');
      }
      //------------------------------------------------------------------
      // 연결된 장비 초기화 (MTU 크기, 노티 설정)
      bool success =
          await BleManager.connectedDeviceInit(deviceIndex: deviceIndex);

      if (success == true) {
        // 블루투스 연결 프로세스 실행 (DSP 변수 초기화, 오디오 실행 등)
        whenBluetoothConnected(
            deviceIndex); // 함수안에 api 에 데이터를 보내는 부분이 await 문이라 그걸 살제하려다가 대신 여기 앞의 await 를 삭제(221219)
        // 블루투스 상태 설정
        gv.btStateManager[deviceIndex].connectedEvent();
      } else {
        if (kDebugMode) {
          String time = printPresentTime(printEnable: false);
          print(
              '▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ BleCallback :: callbackConnected() :: 연결된 장비 초기화 실패  $time');
        }
      }
    }
    //------------------------------------------------------------------
    // 오류에 따른 이벤트라면
    //------------------------------------------------------------------
    else {
      if (kDebugMode) {
        String time = printPresentTime(printEnable: false);
        print(
            '▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ BleCallback :: callbackConnected() :: 명령과 무관한 콜백 이벤트  $time');
      }
    }

    //------------------------------------------------------------------
    // 예외상황에 의한 disconnect 후 연결된 것일 경우, 사운드 무시 flag reset
    //------------------------------------------------------------------
    if(BleManager.flagIgnoreSound[deviceIndex] == true){
      BleManager.flagIgnoreSound[deviceIndex] = false;
    }
  }

  ///---------------------------------------------------------------------------
  /// 해제된 경우 - 실제 (OS는 잠시동안 연결상태로 인식할 수 있음)
  ///---------------------------------------------------------------------------
  callbackDisconnectedReal() async {
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('----------------------------------');
      print(
          'BleCallback :: callbackDisconnectedReal() :: 블루투스가 실제로 해제되었습니다. $time');
      print('(OS는 일정시간 동안 아직 연결된 상태로 인식할 수 있음)');
      print('----------------------------------');
    }
    //------------------------------------------------------------------
    // 블루투스 종료 프로세스 실행
    //------------------------------------------------------------------
    await whenBluetoothDisconnected(deviceIndex);
  }

  ///---------------------------------------------------------------------------
  /// [OS 에서 올라오는 해제 메시지]
  /// 재연결은 매우 조심스럽게 처리 필요 (221129)
  /// 정상 종료에서는 리스너가 사라져서 볼 수 없는 메시지
  /// OS에서 종료하기 전에 재 연결을 하면, 리스너가 복구되고 그때 disconnected 메시지 볼 수 있음
  /// disconnected 메시지가 뜨는 상황은 비정상적 상황이지만 처리 필요 (전원을 껐다가 다시 빨리 켜는 경우)
  /// 조건부 재연결을 시도하여 상태 보완
  /// 시험해본 결과 빠르게 재부팅하는 정전기 상황에서는 disconnected 이벤트 발생 안함
  ///---------------------------------------------------------------------------
  callbackDisconnectedOs() async {
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('----------------------------------');
      print(
          'BleCallback ::   callbackDisconnectedOs() :: 블루투스가 OS 에서 해제되었습니다. $time');
      print('이 메세지가 보이면, OS 종료 전 재 시작한 상황으로 꼬인 상황 -> 조건부 재 시작 필요!');
      print('----------------------------------');
    }
    bt[deviceIndex].bleDevice.isBtConnectedReal.value = false;
    BleManager.flagIgnoreSound[deviceIndex] = true; // 예외상황이므로 연결해제(이후 자동연결) 음을 무식하기위해 flag 셋팅

    //------------------------------------------------------------------
    // 블루투스 종료 프로세스 실행
    //------------------------------------------------------------------
    await whenBluetoothDisconnected(deviceIndex);
    //------------------------------------------------------------------
    // 블루투스 종료 프로세스 실행 : 비정상 종료 상황에서 조건부 재 연결
    // OS 종료 후 제품을 다시 빠르게 켠 경우 연결된 후에 다시 os 에서 disconnected 수행
    // 종료에 5초가 소요되는 안드로이드에서만 필요함
    // 버튼을 눌러 전원을 끈 후 다시 빨리 켜는 동작에서 연결->해제->재연결 될 듯
    // 위 문제 외에는 아래 구문 주석 처리 해도 됨
    //------------------------------------------------------------------
    // if (gv.system.isAndroid == true){
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (kDebugMode) {
        String time = printPresentTime(printEnable: false);
        print(
            'BleCallback ::   callbackDisconnectedOs() :: 1초 후 조건부 재연결 프로세스 수행');
      }
      gv.btStateManager[deviceIndex].reconnectConditional();
    });
    // }
  }

  ///---------------------------------------------------------------------------
  /// 콜백 : 블루투스 데이타 스트림
  /// 블루투스 모듈에서 실시간으로 들어오는 데이터 DPS 모듈로 전달
  ///---------------------------------------------------------------------------
  callbackDataStreamFromDevice(Uint8List data) {
    DspManager.bluetoothToDsp(deviceIndex, data);
  }
}
