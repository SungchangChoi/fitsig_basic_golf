import '/F0_BASIC/common_import.dart';

// 전역변수로 dsp module 생성
// late List<BleModule> btm; //dsp module
// callback 함수 생성
// late List<DspCallback> _dspCallback;

late List<BleModuleDevice> bt; //자주 사용해서 이렇게 정의

//==============================================================================
// BLE module : 장비의 수 만큼 생성
// 블루투스 제어는 여기를 직접 제어하지 않고, bleStateManager 에서 제어
//==============================================================================

class BleManager {
  ///---------------------------------------------------------------------------
  /// 변수 생성
  ///---------------------------------------------------------------------------
  // 블루투스 공통 모듈 초기화
  static BleModuleCommon bleModuleCommon = BleModuleCommon.instance;

  // 블루투스 데이터 콜백
  static late List<BleCallback> _bleCallback;

  // 디바이스로 주는 응답 클래스 변수
  static List<FitsigDeviceAck> fitsigDeviceAck = List.generate(
      GvDef.maxDeviceNum, (index) => FitsigDeviceAck(deviceIndex: index));

  static bool flagIsBleReady = false; //블루투스 가능 여부
  static bool flagIsCmdConnect = false; //명령에 의한 connected event 여부 체크용
  static List<bool> flagIgnoreSound = List.generate(GvDef.maxDeviceNum, (index) => false); // 예외상황(정전기)에 의해 disconnect, re-connect 되 audio sound 를 play 하지 않기 위해

  ///---------------------------------------------------------------------------
  /// 초기화
  ///---------------------------------------------------------------------------
  static initModule() async {
    int d = 0; //장비가 여러개 일 경우 for loop
    BleCommonData bleCommonData = BleCommonData.instance; //공통 instance
    //--------------------------------------------------------------------------
    // 블루투스 어댑터 초기화
    //--------------------------------------------------------------------------
    bleModuleCommon.initAdaptor();

    //--------------------------------------------------------------------------
    // 콜백 생성
    //--------------------------------------------------------------------------
    _bleCallback = List<BleCallback>.generate(
        GvDef.maxDeviceNum, (index) => BleCallback(deviceIndex: index));

    //--------------------------------------------------------------------------
    // 디바이스별 장비정보 모듈 생성 + 콜백 함수 연결
    //--------------------------------------------------------------------------
    bt = List.generate(
        GvDef.maxDeviceNum,
        (index) => BleModuleDevice(
            callbackConnected: _bleCallback[index].callbackConnected,
            callbackDisconnectedReal:
                _bleCallback[index].callbackDisconnectedReal,
            callbackDisconnectedOs: _bleCallback[index].callbackDisconnectedOs,
            callbackDataStreamFromDevice:
                _bleCallback[index].callbackDataStreamFromDevice));

    //--------------------------------------------------------------------------
    // 마지막 연결된 장비 기록 읽어오기
    //--------------------------------------------------------------------------
    String recentDeviceInfoJson = gv.spMemory.read('recentDeviceInfo') ?? '';

    //---------------------------------------------------------
    // 최근 연결 장비에 대한 정보를 이용해서 Ble 모듈에 Ble 장치 인스턴스 생성
    if (recentDeviceInfoJson.isNotEmpty) {
      gv.deviceStatus[d].recentDeviceInfo =
          List<String>.from(jsonDecode(recentDeviceInfoJson));

      //---------------------------------------------------------
      // 연결 장비 정보를 이용하여 BleDevice 생성
      bt[d].makeBleDeviceFromRecentInfo(gv.deviceStatus[d].recentDeviceInfo);

      if (kDebugMode) {
        print('::::::::::::::::::::::::::::::::::::::::');
        print('최근에 연결된 블루투스 장비 정보 : recentDeviceInfoJson');
        print('id discoveredDevice: ${bt[0].bleDevice.discoveredDevice.id}');
        print('id : ${bt[0].bleDevice.id}');
        print(
            'rssi discoveredDevice: ${bt[0].bleDevice.discoveredDevice.rssi}');
        print('rssi : ${bt[0].bleDevice.rssi}');
        print('::::::::::::::::::::::::::::::::::::::::');
      }
    }
    //--------------------------------------------------------------------------
    // 연결 된 장비 정보가 없는 경우
    else {
      gv.deviceStatus[d].recentDeviceInfo = []; //기록 존재 여부정보로 활용
    }

    //--------------------------------------------------------------------------
    // 블루투스 상태 관리
    //--------------------------------------------------------------------------
    bleCommonData.bleStatus.listen((status) {
      String time = printPresentTime(printEnable: false);

      //------------------------------------------------------------------
      // 준비된 상태 : 이 상태여야 나머지 동작 가능
      if (status == BleStatus.ready) {
        if (kDebugMode) {
          print('BleManager :: initModule() :: 스마트기기 블루투스 상태 : ready  $time');
        }
        flagIsBleReady = true;
        //---------------------------------------------------------
        // 준비가 되면 조금 기다린 후 초기화 수행
        Future.delayed(const Duration(milliseconds: 200), () async {
          await gv.btStateManager[d].init();
        });
      }
      //------------------------------------------------------------------
      // 전원 꺼진 상태 : 블루투스 사용불가 상태(앱에서)
      else if (status == BleStatus.poweredOff) {
        flagIsBleReady = false;
        if (kDebugMode) {
          print(
              'BleManager :: initModule() :: 스마트기기 블루투스 상태 : poweredOff  $time');
        }
      }
      //------------------------------------------------------------------
      // 권한이 없는 상태 : 처음에 이 앱에 허용 안한 경우
      else if (status == BleStatus.unauthorized) {
        flagIsBleReady = false;
        if (kDebugMode) {
          print(
              'BleManager :: initModule() :: 스마트기기 블루투스 상태 : unauthorized  $time');
        }
      }
      //------------------------------------------------------------------
      // BLE 를 지원하지 않는 상태 : 장비 문제
      else if (status == BleStatus.unsupported) {
        flagIsBleReady = false;
        if (kDebugMode) {
          print(
              'BleManager :: initModule() :: 스마트기기 블루투스 상태 : unsupported  $time');
        }
      }
      //------------------------------------------------------------------
      // 로케이션 서비스가 꺼져 있음 : 안드로이드에서만 뜨는 메시지 (허용문제 인 듯)
      else if (status == BleStatus.locationServicesDisabled) {
        flagIsBleReady = false; // 체크 필요
        if (kDebugMode) {
          print(
              'BleManager :: initModule() :: 스마트기기 블루투스 상태 : locationServicesDisabled  $time');
        }
      }
      //------------------------------------------------------------------
      // 모르는 상태
      else if (status == BleStatus.unknown) {
        flagIsBleReady = false;
        if (kDebugMode) {
          print('BleManager :: initModule() :: 스마트기기 블루투스 상태 : unknown  $time');
        }
      }
    });
  }

  ///----------------------------------------------------------------------------
  /// 스캔 하기
  ///----------------------------------------------------------------------------
  static Future scan(bool isScanStart, {String filter = ''}) async {
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      isScanStart
          ? print('ble_module :: scan() 스캔 시작  $time')
          : print('ble_module :: 스캔 종료  $time');
    }
    await BleManager.bleModuleCommon.scan(isScanStart, filter: filter);
  }

  ///----------------------------------------------------------------------------
  /// 장비 연결하기
  ///----------------------------------------------------------------------------
  static Future connectNewDevice(BleDevice deviceNew,
      {required int deviceIndex}) async {
    try {
      if (kDebugMode) {
        String time = printPresentTime(printEnable: false);
        print('BleManager :: connectNewDevice() :: 블루투스 연결 시작  $time');
      }
      // 모듈의 연결 절차 진행
      flagIsCmdConnect = true;
      await bt[deviceIndex].connect(deviceNew);

      //---------------------------------------------
      // get.spMemory 에 저장을 위해 json string 으로 변환
      List<String> connectedDeviceInfo = [];
      connectedDeviceInfo.add(deviceNew.id);
      connectedDeviceInfo.add(deviceNew.name);
      connectedDeviceInfo.add(deviceNew.serviceUuids);
      String jsonConnectDeviceInfo = jsonEncode(connectedDeviceInfo);

      // get.spMemory 에 현재 연결된 장비를 최근 연결 장비로 저장
      gv.spMemory.write('recentDeviceInfo', jsonConnectDeviceInfo);
    } catch (e) {
      if (kDebugMode) {
        print('▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶'
            'BleManager :: connectNewDevice() 블루투스 연결 시도 에러');
      }
      throw Exception(e.toString());
    }
  }

  ///----------------------------------------------------------------------------
  /// 등록된 장비 재 연결
  ///----------------------------------------------------------------------------
  static Future reconnectRecentDevice({required int deviceIndex}) async {
    flagIsCmdConnect = true;
    await bt[deviceIndex].reconnect();
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('BleManager :: reconnectRecentDevice() :: 최근 장비와 연결  $time');
    }
  }

  ///----------------------------------------------------------------------------
  /// 연결된 디바이스 초기화
  ///----------------------------------------------------------------------------
  static Future<bool> connectedDeviceInit({required int deviceIndex}) async {
    // 재연결 후 처음으로 장비에 전송할 명령
    List<int> firstCmdData =
        gv.deviceControl[deviceIndex].getControlPacketData();
    bool success =
        await bt[deviceIndex].connectDeviceInit(firstCmdData: firstCmdData);
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('BleManager :: connectedDeviceInit() :: 연결 된 장비 초기화  $time');
    }
    return success;
  }

  ///----------------------------------------------------------------------------
  /// 장비 연결 해제
  ///----------------------------------------------------------------------------
  static Future<void> disconnect({required int deviceIndex}) async {
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('BleManager :: disconnect() :: 연결 해제  $time');
    }
    flagIsCmdConnect = false;
    await bt[deviceIndex].disconnect();
    // if ( bt[d].bleDevice.isBtConnectedReal.value == true) {}
  }

  ///----------------------------------------------------------------------------
  /// Roem Notification 해제
  ///----------------------------------------------------------------------------
  static Future<void> setRoemNotification({required int deviceIndex}) async {
    // 재연결 후 처음으로 장비에 전송할 명령
    List<int> firstCmdData =
        gv.deviceControl[deviceIndex].getControlPacketData();
    await bt[deviceIndex].setRoemNotification(firstCmdData: firstCmdData);
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print(
          'BleManager :: cancelRoemNotification() :: Notification 설정 및 Qc명령 전송 $time');
    }
  }

  ///----------------------------------------------------------------------------
  /// Roem Notification 해제
  ///----------------------------------------------------------------------------
  static Future<void> cancelRoemNotification({required int deviceIndex}) async {
    await bt[deviceIndex].cancelRoemNotification();
    if (kDebugMode) {
      String time = printPresentTime(printEnable: false);
      print('BleManager :: cancelRoemNotification() :: Notification 해제  $time');
    }
  }

  ///---------------------------------------------------------------------------
  /// 장치 연결 해제 후 파워 끄기
  ///---------------------------------------------------------------------------
  static devicePowerOff({required int deviceIndex}) async {
    //-------------------------------------------------
    // 장비 전원이 켜져 있다면
    //-------------------------------------------------
    if (bt[deviceIndex].bleDevice.isBtConnectedReal.value == true) {
      if (kDebugMode) {
        print('BleManager :: devicePowerOff() :: 장비 끄기 명령 전송');
      }
      List<int> data = gv.deviceControl[deviceIndex].getControlPacketData();
      data[8] = 0xA9; // 장비 전원 끄기 = 0xA9, BOR = OxEF (생산때만)
      bt[deviceIndex].sendQcCommand(data);
      // 명령 전달 시간 0.5초 대기 후 종료절차
      // await Future.delayed(const Duration(milliseconds: 500), () {});
      // await gv.btStateManager[deviceIndex].disconnectCommand();
      // await Future.delayed(const Duration(milliseconds: 500), () {});
      // await bt[deviceIndex].disconnect();
    }
    //-------------------------------------------------
    // 장비 전원이 꺼졌다면
    //-------------------------------------------------
    else {
      if (kDebugMode) {
        print('▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶'
            ' BleManager :: devicePowerOff() :: 장비 끄기 명령 전송 실패 : 장비가 이미 꺼져 있음');
      }
      await bt[deviceIndex].disconnect();
    }
  }

  ///----------------------------------------------------------------------------
  /// 블루투스 캐시 클리어 (안드로이드 전용, iOS는 필요 없음)
  /// 사용 상 주의 필요!
  ///----------------------------------------------------------------------------
  static Future<void> clearGattCache({required int deviceIndex}) async {
    if (gv.system.isAndroid == true) {
      if (kDebugMode) {
        print('-----------------------------------------------');
        print('BleManager :: clearGattCache()');
        print('-----------------------------------------------');
      }
      await bt[deviceIndex].clearGattCache();
    } else {
      if (kDebugMode) {
        print('-----------------------------------------------');
        print('BleManager :: clearGattCache()');
        print('명령이 실행되지 않음');
        print('안드로이드에서만 사용 가능!');
        print('-----------------------------------------------');
      }
    }
  }

  ///---------------------------------------------------------------------------
  /// [스마트앱 COMMAND] 장비 LED 깜박이기
  /// device index 정보 필요
  ///---------------------------------------------------------------------------
  static blinkDeviceLED({required int deviceIndex}) async {
    if (bt[deviceIndex].bleDevice.isBtConnectedReal.value == true) {
      if (kDebugMode) {
        print('BleManager :: blinkDeviceLED()');
      }
      List<int> data = gv.deviceControl[deviceIndex].getControlPacketData();
      // 깜박임 control message 는 1회성이므로 gv.deviceControl[d] 의 controlPacketData 값을 바꿀필요 없음
      data[4] = 0x02; // 2번째 bit 를 true 로 하면 LED 깜박이기
      bt[deviceIndex].sendQcCommand(data);
      await Future.delayed(const Duration(seconds: 5), () {});
      data[4] = 0x00; // 2번째 bit 를 false 로 하면 LED 원상복구
      bt[deviceIndex].sendQcCommand(data);
    }
  }

  ///---------------------------------------------------------------------------
  /// [스마트앱 COMMAND] 장비 터치버튼 전원꺼짐 시간 설정 (켜져 있는 장비들만)
  ///---------------------------------------------------------------------------
  static setTouchTime({required int touchTime}) async {
    int d = 0; //장비 여러개인 경우 for loop
    if (bt[d].bleDevice.isBtConnectedReal.value == true) {
      if (kDebugMode) {
        print('BleManager :: setTouchTime()');
      }
      gv.deviceControl[d].changeTouchTime(value: touchTime);
      // device control packet data 를 가져오기
      List<int> data = gv.deviceControl[d].getControlPacketData();
      bt[d].sendQcCommand(data);
      dvSetting.touchTime.value = touchTime;
    }
  }

  ///----------------------------------------------------------------------------
  /// [스마트앱 COMMAND] 스크린 노출 여부 알림
  /// 스크린 on 이면 address[4]의 bit[2]=0, 숨겨져있으면 bit[2]=1
  ///----------------------------------------------------------------------------
  static notifyScreenState({required bool isScreenOff}) async {
    int d = 0; //장비 여러개인 경우 for loop
    if (bt[d].bleDevice.isBtConnectedReal.value == true) {
      if (kDebugMode) {
        print('BleManager :: notifyScreenState()');
      }
      gv.deviceControl[d].changeScreenState(value: isScreenOff);
      // device control packet data 를 가져오기
      List<int> data = gv.deviceControl[d].getControlPacketData();
      bt[d].sendQcCommand(data);
    }
  }

  ///----------------------------------------------------------------------------
  /// [스마트앱 COMMAND] 장비 착용 상태 전송 메소드
  /// device index 정보 필요
  ///----------------------------------------------------------------------------
  static notifyDeviceAttachState(
      {required int deviceIndex,
      required EmlElectrodeStatus attachState}) async {
    int value;

    if (bt[deviceIndex].bleDevice.isBtConnectedReal.value == true) {
      if (kDebugMode) {
        print('BleManager :: notifyDeviceAttachState()');
      }
      if (attachState == EmlElectrodeStatus.none ||
          attachState == EmlElectrodeStatus.detached) {
        value = 0;
      } else if (attachState == EmlElectrodeStatus.attachBad) {
        value = 1;
      } else if (attachState == EmlElectrodeStatus.attachGood) {
        value = 2;
      } else {
        value = 3; //발생 불가능한 상태
      }

      // device control packet data 의 부착상태 설정 값을 수정
      gv.deviceControl[deviceIndex].changeDeviceAttachState(value: value);

      // device control packet data 를 가져오기
      List<int> data = gv.deviceControl[deviceIndex].getControlPacketData();

      bt[deviceIndex].sendQcCommand(data);
      // if (bleAdaptor.reactiveDevice != null) {
      //   bleAdaptor.reactiveDevice.sendQcCommand(data);
      // }
    } else {
      if (kDebugMode) {
        print('BleManager :: 장비가 연결되어 있지 않아, 부착 상태정보 전송 안함');
      }
    }
  }

  ///----------------------------------------------------------------------------
  /// 장비로 데이터 전송
  ///----------------------------------------------------------------------------
  static notifyMeasurementState({required bool isMeasuring}) {
    int d = 0; //장비 여러개인 경우 for loop
    if (bt[d].bleDevice.isBtConnectedReal.value == true) {
      if (kDebugMode) {
        print('BleManager :: notifyMeasurementState()');
      }
      // device control packet data 의 isScreenOff 설정 값을 수정
      gv.deviceControl[d].changeMeasuringState(value: isMeasuring);
      // device control packet data 를 가져오기
      List<int> data = gv.deviceControl[d].getControlPacketData();
      bt[d].sendQcCommand(data);
    }
  }
}

//==============================================================================
// 블루투스 연결 시 실행
//==============================================================================
whenBluetoothConnected(int d) async {
  //----------------------------------------------------------------------------
  // OTA 파일 로드 (기존 코드르 블루트스와 연동되어 로드)
  // 앱 초기화에서 로드하는 것이 바람직 (향후)
  //----------------------------------------------------------------------------
  // dvSetting
  //     .findOtaFileAndOpen(); // ble_device 에서 OTA Version 을 관리하고 있어서, 장치가 연결되면 OTA 파일 정보도 열어서 로딩

  //----------------------------------------------------------------------------
  // control 변수 갱신
  //----------------------------------------------------------------------------
  // if (kDebugMode) {
  //   print('ble_module_manager.dart :: isDeviceBtConnected = true 로 변경됨');
  // }
  gv.deviceStatus[d].isDeviceBtConnected.value = true; // task100ms 에서 호출하는 taskBluetoothQualityMonitoring 에 사용

  //----------------------------------------------------------------------------
  // 블루투스 연결음
  // todo : 장비가 여러개인 경우 외부에서 처리 검토
  //----------------------------------------------------------------------------
  if(BleManager.flagIgnoreSound[d] == false) {
    gv.audioManager.play(type: EmaSoundType.btConnect); // 블루투스 연결음 플레이
  }

  //----------------------------------------------------------------------------
  // 통신상태 측정 변수만 초기화
  //----------------------------------------------------------------------------
  gv.deviceStatus[d].initMeasureData();

  //----------------------------------------------------------------------------
  // DSP 모듈 초기화
  //----------------------------------------------------------------------------
  DspManager.whenBluetoothConnected(d);

  //----------------------------------------------------------------------------
  // 새로운 블루투스 연결에 따른 전극 리셋 정보 초기화
  //----------------------------------------------------------------------------
  gv.deviceData[0].disableReset1RM.value = false;

  //----------------------------------------------------------------------------
  // API 실행 - 장비 연결 메시지 : 통계 수집 목적으로, 실행늦게하거나 혹은 안되도 되는 함수
  //----------------------------------------------------------------------------
  //----------------------------------------------
  // 전송 할 body
  Map<String, String> body = {
    'bc_age': gv.setting.bornYearApi(gv.setting.bornYearIndex.value),
    'bc_sex': gv.setting.genderApi(gv.setting.genderIndex.value),
  };
  Map<String, String> ackMap =
      await apiPost(subUrl: 'insert/connect', body: body);
  //----------------------------------------------
  // 성공 메시지
  if (ackMap['response'] == 's') {
    if (kDebugMode) {
      print('장비연결 API 전송 성공');
    }
  } else {
    if (kDebugMode) {
      print('장비연결 API 전송 실패!');
    }
  }
}

//==============================================================================
// 블루투스 해제 시 실행
//==============================================================================

whenBluetoothDisconnected(int d) async {
  //----------------------------------------------------------------------------
  // control 변수 갱신
  //----------------------------------------------------------------------------
  if (kDebugMode) {
    print('ble_module_manager.dart :: isDeviceBtConnected = false 로 변경됨');
  }
  gv.deviceStatus[d].isDeviceBtConnected.value = false;
  gv.deviceStatus[d].isAppConnected.value = false;
  gv.deviceStatus[d].isDeviceIsCharging.value = false;
  dvSetting.firmwareStatus.value = EmaFirmwareStatus.noDevice; // 펌웨어 상태 변경
  bt[d].bleDevice.isCheckedFw = false; // 펌웨어 비교 Flag 변경

  //------------------------------------------------------------------
  // 장비에서 온 정보 메모리 초기화 : FitsigDeviceAck 에 가지고 있떤 device 정보를 초기화
  //------------------------------------------------------------------
  BleManager.fitsigDeviceAck[d].init();

  //----------------------------------------------------------------------------
  // DSP 모듈 해제
  //----------------------------------------------------------------------------
  dm[0].g.dsp.setInit(g: dm[0].g); // 장비 연결 해제 후에도 MeasureIdle 화면에서 TopBar 의 접촉상태 예전 값으로 표시되는 문제때문에 초기화 호출
  DspManager.whenBluetoothDisconnected(d);

  //----------------------------------------------------------------------------
  // 블루투스 연결 해제 사운드
  //----------------------------------------------------------------------------
  if(BleManager.flagIgnoreSound[d] == false) {
    gv.audioManager.play(type: EmaSoundType.btDisconnect); // 블루투스 연결 해제음 플레이
  }
}
