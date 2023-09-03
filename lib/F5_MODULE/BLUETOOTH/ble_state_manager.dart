import '/F0_BASIC/common_import.dart';
import 'dart:io' show Platform;

//==============================================================================
// 블루투스 상태 관리
//==============================================================================
class BtStateManager {
  final int deviceIndex;
  Timer?
      reconnectExpirationTimer; // 재연결 만료 타이머. 기존이 Future.delayed 인 것을, 중간에 취소가능하게 하기 위해 Timer 로 변경

  BtStateManager({required this.deviceIndex});

  ///---------------------------------------------------------------------------
  /// 상태 초기화
  ///---------------------------------------------------------------------------
  Future init() async {
    bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
    if (kDebugMode) {
      print('BtStateManager :: init() :: 블루투스 상태 초기화 실행');
    }
    //------------------------------------------------------------------------
    // 최초 상태
    //------------------------------------------------------------------------
    if (gv.deviceStatus[deviceIndex].recentDeviceInfo.isEmpty) {
      // 자동 연결을 강제로 disable (혼란 방지) - 초기값은 false
      gv.setting.isBluetoothAutoConnect.value = false;
      gv.spMemory.write('isBluetoothAutoConnect', false);
      setNewState(EmlBtControlState.idleInit);
      if (kDebugMode) {
        print('BtStateManager :: init() :: 최근에 연결된 블루투스 장비 정보가 없습니다');
      }
    }
    //------------------------------------------------------------------------
    // 자동 연결이 enable: 재 연결 수행
    //------------------------------------------------------------------------
    else if (autoConnectEnable == true) {
      await BleManager.reconnectRecentDevice(
          deviceIndex: deviceIndex); // 재 연결 수행
      setNewState(EmlBtControlState.idleConnectingEn);
    }
    //------------------------------------------------------------------------
    // 자동 연결이 disable : 상태만 설정
    //------------------------------------------------------------------------
    else {
      setNewState(EmlBtControlState.idleDis);
    }
  }

  ///---------------------------------------------------------------------------
  /// 새로운 장비 연결 시도 하는 경우 (자동연결 아닌 상태에서만)
  ///---------------------------------------------------------------------------
  Future connectNewDevice(BleDevice device) async {
    //------------------------------------------------------------------------
    // 블루투스 사용 가능여부 체크
    //------------------------------------------------------------------------
    if (BleManager.flagIsBleReady == false) {
      bluetoothStatusErrorMessage();
      return;
    }
    bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
    EmlBtControlState presentState =
        gv.deviceStatus[deviceIndex].btControlState.value;

    //------------------------------------------------------------------------
    // 기존 기록 존재 여부에 따라 구분
    if (presentState == EmlBtControlState.idleInit) {
      setNewState(EmlBtControlState.connectingInit); //최초 연결중
    } else {
      setNewState(EmlBtControlState.connectingDis); // 연결중 (자동 disable)
    }
    //------------------------------------------------------------------------
    // 연결 수행
    await BleManager.connectNewDevice(device, deviceIndex: deviceIndex);
    //------------------------------------------------------------------------
    // 2초 뒤 연결상태 판단
    //   - 연결되지 않은 경우 초기 상태로 재 설정
    Future.delayed(const Duration(milliseconds: 2000), () {
      presentState = gv.deviceStatus[deviceIndex].btControlState.value;
      //------------------------------------------------------------------------
      // 최초 연결되지 않은 경우 : 해제 후 초기상태로 복귀
      if (presentState == EmlBtControlState.connectingInit) {
        BleManager.disconnect(deviceIndex: deviceIndex); // 연결 해제
        setNewState(EmlBtControlState.idleInit);
      }
      //------------------------------------------------------------------------
      // 연결되지 않은 경우 : 해제 후 초기상태로 복귀
      else if (presentState == EmlBtControlState.connectingDis) {
        BleManager.disconnect(deviceIndex: deviceIndex); // 연결 해제
        setNewState(EmlBtControlState.idleDis);
        openSnackBarBasic('장비 연결 실패',
            '장비의 전원이 켜져 있는지 확인해 주세요.'
                '\n장비가 켜져 있음에도 이 메시지가 반복해서 뜬다면 앱을 종료 후 다시 실행해 주세요.');
      }
    });
  }

  ///---------------------------------------------------------------------------
  /// 연결 된 경우 - 연결감지 리스너에서 연결된 경우 호출
  ///---------------------------------------------------------------------------
  void connectedEvent() {
    bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
    //------------------------------------------------------------------------
    // 자동연결 enable 인 경우
    //------------------------------------------------------------------------
    if (autoConnectEnable == true) {
      setNewState(EmlBtControlState.connectedEn);
    }
    //------------------------------------------------------------------------
    // 자동연결 disable 인 경우
    //------------------------------------------------------------------------
    else {
      setNewState(EmlBtControlState.connectedDis);
    }
  }

  ///---------------------------------------------------------------------------
  /// 연결 해제 (예외상황 포함)
  ///---------------------------------------------------------------------------
  Future disconnectCommand({bool isException = false}) async {
    bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;

    //------------------------------------------------------------------------
    // 재연결시도 종료 타이머가 동작 중이라면 cancel
    //------------------------------------------------------------------------
    if (reconnectExpirationTimer != null) {
      if (reconnectExpirationTimer!.isActive) {
        if (kDebugMode) {
          print('BtStateManager : disconnectCommand() : 재연결시도만료 타이머를 해제');
        }
        reconnectExpirationTimer!.cancel();
      }
    }

    //------------------------------------------------------------------------
    // 연결 해제
    //------------------------------------------------------------------------
    await BleManager.disconnect(deviceIndex: deviceIndex); // 연결 해제

    //------------------------------------------------------------------------
    // 재 연결 명령 : 이 명령을 해도 disconnected 이벤트가 뜸
    // 끊어지자 마자 1회 실행하면..
    // disconnected 를 바로 실행하면 다시 끊어지는 등 잘 안됨(221129)
    //------------------------------------------------------------------------
    // if (isException == true) {
    //   await BleManager.reconnectRecentDevice(deviceIndex: deviceIndex);
    // } // 연결 해제
    // printTimeDiff(isStart: true, title: '연결해제 시작');
    //------------------------------------------------------------------------
    // 자동연결 enable
    //------------------------------------------------------------------------
    if (autoConnectEnable == true) {
      if (isException == true) {
        setNewState(EmlBtControlState.exDisconnectingEn);
      } else {
        setNewState(EmlBtControlState.disconnectingEn);
      }
    }
    //------------------------------------------------------------------------
    // 자동연결 disable
    //------------------------------------------------------------------------
    else {
      if (isException == true) {
        setNewState(EmlBtControlState.exDisconnectingDis);
      } else {
        setNewState(EmlBtControlState.disconnectingDis);
      }
    }

    //------------------------------------------------------------------------
    // OS 내부 연결 해제시간 대기
    // 5~6초로 하면, 해제가 덜 된 상태로, 장비가 다시 오연결 되는 현상 발생...
    // 시간 여유를 생각보다 조금 길게 가져가야
    // <정전기 재부팅>
    // 8초, 7초 ~ 4.5초 모두 동작 (예외 감지시간 1초 추가하면 실제 시간)
    // 5초 뒤에 명령을 주는 것이 안정적
    // <전원 버튼 재부팅 후 다시 붙는 오류 1차>
    // 4.5초 : 비정상 동작
    // 5.5초 : 비정상 동작
    // 6 초 : 정상동작 (다시 붙는 현상 없음) - 실제 7초로 좀 긴 시간....
    // 안드로이드 7000ms 이상 여유주고 재연결 명령을 하면 안정적으로 동작
    // 그 이하 시간에서는 오류 발생
    // 6.5초 : 정상동작 (다시 붙는 현상 없음) - 실제 7.5초로 좀 긴 시간....
    // MTU 값 정상여부 확인 후 서비스 연결하는 방식으로 위 문제 해결

    //------------------------------------------------------------------------
    int reconnectWaitTimeMs = 0;
    int addTime =
        isException ? -500 : 500; //1000 : 2000 -> 동작, 0 : 1000; //-500 : 500;
    if (gv.system.isAndroid == true) {
      // 안드로이드 : 최소 5초 후에 재 연결
      reconnectWaitTimeMs = GvDef.disconnectWaitTimeAndroid + addTime;
    } else {
      // iOS : 최소 0.8초 후에 재 연결
      reconnectWaitTimeMs = GvDef.disconnectTimeIos + addTime;
    }

    Future.delayed(Duration(milliseconds: reconnectWaitTimeMs), () {
      EmlBtControlState presentState =
          gv.deviceStatus[deviceIndex].btControlState.value;
      print('BtStateManager :: disconnectCommand :: 현재 상태는 무조건 체크하겠지');

      //------------------------------------------------------------------------
      // 이미 연결 진행 중 혹은 연결 된 상태라면 : 함수 빠져 나가기
      // disconnected event 에서 이미 재연결을 시도했을 수 있음
      // disconnected event 가 발생하지 않으면 아래 구문이 실행 됨
      // (정전기 발생 상황의 경우)
      //------------------------------------------------------------------------
      if (presentState == EmlBtControlState.connectingDis ||
          presentState == EmlBtControlState.idleConnectingEn ||
          presentState == EmlBtControlState.connectedDis ||
          presentState == EmlBtControlState.connectedEn ||
          presentState == EmlBtControlState.exReconnectingDis) {
        if (kDebugMode) {
          print('BtStateManager : 이미 무선 연결된 상황이어서 아무것도 안하고 빠져 나감');
        }
      } else {
        //----------------------------------------------------------------------
        // 자동연결 해제 상태에서 정상 종료라면  : 종료 후 대기 모드
        //----------------------------------------------------------------------
        if (presentState == EmlBtControlState.disconnectingDis) {
          setNewState(EmlBtControlState.idleDis);
        }
        //----------------------------------------------------------------------
        // 비정상 종료, 자동연결 상태라면 조건부 재연결 수행 (버튼 클릭 종료의 경우)
        //----------------------------------------------------------------------
        else {
          reconnectConditional();
        }
      }
    });
  }

  ///---------------------------------------------------------------------------
  /// 조건부 재연결
  ///---------------------------------------------------------------------------
  Future<void> reconnectConditional() async {
    late String reconnectTryTime;
    //------------------------------------------------------------------------
    // 블루투스 사용 가능여부 체크
    //------------------------------------------------------------------------
    if (BleManager.flagIsBleReady == false) {
      bluetoothStatusErrorMessage();
      return;
    }
    bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
    EmlBtControlState presentState =
        gv.deviceStatus[deviceIndex].btControlState.value;
    //------------------------------------------------------------------------
    // disconnect 후 재연결은 조건에 관계 없이 무조건 실행 : 예외 상황 대응
    // 다른 곳에서 이미 연결을 시도할 수 있어 따져보며 실행
    // 연결 시도 중이거나, 이미 연결되었다면 구문을 빠져 나감
    // iOS 에서 문제를 해결하기 위한 코드 (221220)
    //------------------------------------------------------------------------
    if (presentState != EmlBtControlState.idleConnectingEn &&
            presentState != EmlBtControlState.connectingDis &&
            presentState != EmlBtControlState.exReconnectingDis
        // && presentState != EmlBtControlState.connectedDis &&
        // presentState != EmlBtControlState.connectedEn
        ) {
      // if (kDebugMode) {
      //   print('BtStateManager :: reconnectConditional() :: 재연결을 시도하는 시점의 EmlBtControlSate=${presentState.toString()}');
      // }
      // reconnectTryTime = printPresentTime(printEnable: false);
      BleManager.reconnectRecentDevice(deviceIndex: deviceIndex); // 재연결
    } else if (presentState == EmlBtControlState.exReconnectingDis) {
      cancelReconnectExpirationTimer();
      await BleManager.disconnect(deviceIndex: deviceIndex);
      // reconnectTryTime = printPresentTime(printEnable: false);
      BleManager.reconnectRecentDevice(deviceIndex: deviceIndex); // 재연결
    } else if (presentState == EmlBtControlState.idleConnectingEn) {
      await BleManager.disconnect(deviceIndex: deviceIndex);
      // reconnectTryTime = printPresentTime(printEnable: false);
      BleManager.reconnectRecentDevice(deviceIndex: deviceIndex); // 재연결
    } else {
      return;
    }

    //------------------------------------------------------------------------
    // 자동연결 enable : 재연결 후 상태 유지
    //------------------------------------------------------------------------
    if (autoConnectEnable == true) {
      if (kDebugMode) {
        print('BtStateManager :: reconnectConditional() :: 자동 재 연결');
      }
      // BleManager.reconnectRecentDevice(deviceIndex: deviceIndex); // 재연결
      setNewState(EmlBtControlState.idleConnectingEn);
    }
    //------------------------------------------------------------------------
    // 자동연결 disable : 3초 후에 연결되어 있지 않으면 대기상태로 전환
    // 예외상황 재 연결 (정전기)
    //------------------------------------------------------------------------
    // else if (presentState == EmlBtControlState.exDisconnectingDis) {
    else {
      if (kDebugMode) {
        print('BtStateManager :: reconnectConditional() :: 예외 상황 재 연결');
      }
      // BleManager.reconnectRecentDevice(deviceIndex: deviceIndex); // 재연결
      // printTimeDiff(title: '해제 완료 후 재연결');
      setNewState(EmlBtControlState.exReconnectingDis);
      //--------------------------------------------------------------------
      // 3초 후 연결이 안되어 있으면 disconnect()
      // 정전기 문제였다면 장비 전원이 켜져 있어 다시 연결 됨
      // 장비 전원 껐거나 무선 이탈한 경우에는 장비 전원 꺼져 있음 -> disconnect 수행
      //--------------------------------------------------------------------
      // print('BtStateManager :: reconnectConditional() : $reconnectTryTimer 에 타이머 설정');
      reconnectExpirationTimer =
          Timer(Duration(seconds: Platform.isIOS ? 6 : 8), () {
        EmlBtControlState presentState =
            gv.deviceStatus[deviceIndex].btControlState.value;
        //-----------------------------------------
        // 연결 재시도 중인 상태에서 연결이 안되어 있는 경우 종료처리 (무선이탈, 전원버튼 꺼짐)
        if (presentState == EmlBtControlState.exReconnectingDis) {
          if (bt[deviceIndex].bleDevice.isBtConnectedReal.value == false) {
            // printTimeDiff(title: '재연결 종료');
            // if (kDebugMode) {
            //   print(
            //       'BtStateManager :: reconnectConditional() :: 6초 후 연결된 장비가 없어 종료');
            // }
            BleManager.disconnect(deviceIndex: deviceIndex);
            setNewState(EmlBtControlState.idleDis);
          }
        }
      });
    }
  }

  ///---------------------------------------------------------------------------
  /// 자동 연결이 설정되는 경우 : 상태 값만 변화
  ///---------------------------------------------------------------------------
  void whenAutoConnectChangeToEnable() {
    //------------------------------------------------------------------------
    // 블루투스 사용 가능여부 체크
    //------------------------------------------------------------------------
    if (BleManager.flagIsBleReady == false) {
      openSnackBarBasic('블루투스 에러', 'contents');
      return;
    }
    EmlBtControlState presentState =
        gv.deviceStatus[deviceIndex].btControlState.value;
    //--------------------------------------------------------------------------
    // 대기 혹은 연결 중이라면 상태라면
    //--------------------------------------------------------------------------
    if (presentState == EmlBtControlState.idleDis ||
        presentState == EmlBtControlState.connectingDis) {
      BleManager.reconnectRecentDevice(deviceIndex: deviceIndex); // 자동연결 설정
      setNewState(EmlBtControlState.idleConnectingEn);
    }
    //--------------------------------------------------------------------------
    // 연결된 상태라면
    //--------------------------------------------------------------------------
    else if (presentState == EmlBtControlState.connectedDis) {
      setNewState(EmlBtControlState.connectedEn);
    }
    //--------------------------------------------------------------------------
    // 연결 해제중이라면
    //--------------------------------------------------------------------------
    else if (presentState == EmlBtControlState.exDisconnectingDis) {
      setNewState(EmlBtControlState.exDisconnectingEn);
    }
    //--------------------------------------------------------------------------
    // 예외 상태라면
    //--------------------------------------------------------------------------
    else if (presentState == EmlBtControlState.exDisconnectingDis) {
      setNewState(EmlBtControlState.exDisconnectingEn);
    }
  }

  ///---------------------------------------------------------------------------
  /// 자동 연결이 해제되는 경우 : 주로 상태값만 변화
  ///---------------------------------------------------------------------------
  void whenAutoConnectChangeToDisable() {
    //------------------------------------------------------------------------
    // 블루투스 사용 가능여부 체크
    //------------------------------------------------------------------------
    if (BleManager.flagIsBleReady == false) {
      openSnackBarBasic('블루투스 에러', 'contents');
      return;
    }
    EmlBtControlState presentState =
        gv.deviceStatus[deviceIndex].btControlState.value;
    //--------------------------------------------------------------------------
    // 대기 상태라면 : 자동 연결 해제
    //--------------------------------------------------------------------------
    if (presentState == EmlBtControlState.idleConnectingEn) {
      BleManager.disconnect(deviceIndex: deviceIndex); // 자동연결 해제
      setNewState(EmlBtControlState.idleDis);
    }
    //--------------------------------------------------------------------------
    // 연결된 상태라면
    //--------------------------------------------------------------------------
    else if (presentState == EmlBtControlState.connectedEn) {
      setNewState(EmlBtControlState.connectedDis);
    }
    //--------------------------------------------------------------------------
    // 해제 중이라면
    //--------------------------------------------------------------------------
    else if (presentState == EmlBtControlState.disconnectingEn) {
      setNewState(EmlBtControlState.disconnectingDis);
    }
    //--------------------------------------------------------------------------
    // 예외 해제 중이라면
    //--------------------------------------------------------------------------
    else if (presentState == EmlBtControlState.exDisconnectingEn) {
      setNewState(EmlBtControlState.exDisconnectingDis);
    }
  }

  ///---------------------------------------------------------------------------
  /// 상태전환 및 메시지 표시
  ///---------------------------------------------------------------------------
  void setNewState(EmlBtControlState state) {
    gv.deviceStatus[deviceIndex].btControlState.value = state;
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■'
          '[DEV$deviceIndex BT_STATE] $state  $time');
    }
  }

  ///---------------------------------------------------------------------------
  /// 재연결만료 타이머를 취소 메서드
  ///---------------------------------------------------------------------------
  void cancelReconnectExpirationTimer({String? callingFunctionName}) {
    // if(callingFunctionName != null){
    //   print('BtStateManager : $callingFunctionName()에서 cancelReconnectExpirationTimer()를 호출');
    // }
    if (reconnectExpirationTimer != null) {
      if (reconnectExpirationTimer!.isActive) {
        // if (kDebugMode) {
        //   print(
        //       'BtStateManager : cancelReconnectExpirationTimer() : 기존의 재연결시도만료 타이머를 취소');
        // }
        reconnectExpirationTimer!.cancel();
      }
    }
  }
}

//==============================================================================
// 블루투스 연결 에러 메시지
//==============================================================================
void bluetoothStatusErrorMessage() {
  BleCommonData bleCommonData = BleCommonData.instance; //공통 instance
  var status = bleCommonData.bleStatus.value;

  //------------------------------------------------------------------
  // 전원 꺼진 상태 : 블루투스 사용불가 상태(앱에서)
  if (status == BleStatus.poweredOff) {
    openSnackBarBasic('블루투스 실행 에러', '스마트기기의 블루투스 기능이 꺼져 있습니다.');
  }
  //------------------------------------------------------------------
  // 권한이 없는 상태 : 처음에 이 앱에 허용 안한 경우
  else if (status == BleStatus.unauthorized) {
    openSnackBarBasic(
        '블루투스 실행 에러', '어플리케이션에 블루투스 권한이 허용되지 않았습니다. 설정에서 변경하시기 바랍니다.');
  }
  //------------------------------------------------------------------
  // BLE 를 지원하지 않는 상태 : 장비 문제
  else if (status == BleStatus.unsupported) {
    openSnackBarBasic('블루투스 실행 에러', '블루투스를 지원하지 않는 장비입니다.');
  }
  //------------------------------------------------------------------
  // 로케이션 서비스가 꺼져 있음 : 안드로이드에서만 뜨는 메시지 (허용문제 인 듯)
  else if (status == BleStatus.locationServicesDisabled) {
    openSnackBarBasic('블루투스 실행 에러',
        '어플리케이션에 location service 권한이 허용되지 않았습니다. 설정에서 변경하시기 바랍니다.');
  }
  //------------------------------------------------------------------
  // 모르는 상태
  else if (status == BleStatus.unknown) {
    openSnackBarBasic('블루투스 실행 에러', '알 수 없는 이유로 블루투스를 이용할 수 없습니다.');
  }
}
