// import '/F0_BASIC/common_import.dart';
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
//
// // 전역변수로 dsp module 생성
// // late List<BleModule> btm; //dsp module
// // callback 함수 생성
// // late List<DspCallback> _dspCallback;
//
// //==============================================================================
// // BLE module : 장비의 수 만큼 생성
// //==============================================================================
//
// class BleManager {
//   ///---------------------------------------------------------------------------
//   /// 변수 생성
//   ///---------------------------------------------------------------------------
//
//   // 블루투스 모듈
//   static late List<BleModule> bm;
//
//   // 디바이스로 주는 응답 클래스 변수
//   static List<FitsigDeviceAck> fitsigDeviceAck = List.generate(
//       GvDef.maxDeviceNum, (index) => FitsigDeviceAck(deviceIndex: index));
//
//
//   ///---------------------------------------------------------------------------
//   /// 초기화
//   ///---------------------------------------------------------------------------
//   initModule() {
//     //--------------------------------------------------------------------------
//     // BLE 모듈 생성
//     //--------------------------------------------------------------------------
//     bm = List.generate(
//         GvDef.maxDeviceNum, (index) =>
//         BleModule(dataStreamFromDevice: callbackDataStreamFromDevice)..init());
//   }
//
//   //----------------------------------------------------------------------------
//   // 콜백 : 블루투스 데이타 스트림
//   //----------------------------------------------------------------------------
//   void callbackDataStreamFromDevice(Uint8List data) {
//
//   }
//
//
// //----------------------------------------------------------------------------
// // 생성자
// //----------------------------------------------------------------------------
// // final int deviceIndex; //디바이스 번호 - 생성할 때 정의 됨
// // late final BleModule bleAdaptor;
//
// // BleManager({required this.deviceIndex}) {
// //   fitsigDeviceAck = FitsigDeviceAck(deviceIndex: deviceIndex);
// //플랫폼 인스턴스 생성
// // bleAdaptor = BleAdaptor(g: BleData())..init();
// }
//
// //----------------------------------------------------------------------------
// // 변수정의
// //----------------------------------------------------------------------------
// late FitsigDeviceAck fitsigDeviceAck; //장비의 응답 데이터
// late StreamSubscription _notifyDataListen;
//
// ///----------------------------------------------------------------------------
// /// 블루투스 모듈 초기화
// ///----------------------------------------------------------------------------
// Future<void> init() async {
//   //--------------------------------------------------------------------------
//   // bleAdaptor 상태 감지
//   // - 사용자에게 블루투스 알림 목적 활용 가능 (기능 꺼져 있거나)
//   //--------------------------------------------------------------------------
//   bleAdaptor.flutterReactive.statusStream.listen((status) {
//     print('****************************************************');
//     if (status == BleStatus.poweredOff) {
//       print('ble_module :: bleAdaptor 상태 = poweredOff'); //블루투스 사용불가 상태(앱에서)
//     } else if (status == BleStatus.ready) {
//       print('ble_module :: bleAdaptor 상태 = ready'); //블루투스 연결 가능 상태 : 대부분 여기
//     } else if (status == BleStatus.unauthorized) {
//       print('ble_module :: bleAdaptor 상태 = unauthorized'); //처음에 이 앱에 허용 안한 경우
//     } else if (status == BleStatus.unknown) {
//       print('ble_module :: bleAdaptor 상태 = unknown');
//     } else {
//       print('ble_module :: bleAdaptor 상태 = 기타');
//     }
//     print('****************************************************');
//   });
//   //--------------------------------------------------------------------------
//   // 장비 연결 감지 리스너 : 앱이 실행되는 동안 계속 살아 있음
//   //--------------------------------------------------------------------------
//   bleAdaptor.g.isBtConnectedReal.listen((isConnectedReal) async {
//     //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//     // 블루투스 연결 된 경우
//     //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//     // if (bleAdaptor.wvReactiveDevice.value != null) {
//     if (isConnectedReal == true) {
//       if (kDebugMode) {
//         print('-----------------------------------------------');
//         print('ble_module_manager.dart :: 블루투스가 연결 되었습니다.');
//         print('-----------------------------------------------');
//       }
//       //------------------------------------------------------------------
//       // 입력 데이터 감지 리스너 생성 : DSP 모듈로 전송
//       //------------------------------------------------------------------
//       _notifyDataListen =
//           bleAdaptor.reactiveDevice!.notifyData.listen((data) {
//             DspManager.bluetoothToDsp(deviceIndex, data);
//           });
//       // print('----------------------------------');
//       // print(bleAdaptor.reactiveDevice.wvNotifyData.listenerList.length);
//       // print('----------------------------------');
//       //------------------------------------------------------------------
//       // 블루투스 연결 프로세스 실행 (1회만)
//       //------------------------------------------------------------------
//       await whenBluetoothConnected(deviceIndex); //블루투스 연결 된 경우 실행되는 프로세서 모음
//
//       //------------------------------------------------------------------
//       // 블루투스 상태 설정
//       //------------------------------------------------------------------
//       gv.btStateManager[deviceIndex].connected();
//     }
//     //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//     // 블루투스 해제된 경우 : disconnect 완료 후 실행됨
//     //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//     else {
//       if (kDebugMode) {
//         print('----------------------------------');
//         print('ble_module_manager.dart :: 블루투스가 해제되었습니다.');
//         // print('ble_module_manager.dart :: OS에 의한 블루투스 비연결 이벤트 발생');
//         print('----------------------------------');
//       }
//
//       //----------------------------------------------
//       // 근전도 실시간 데이터 받는 리스너 해제
//       _notifyDataListen.cancel();
//       // if (kDebugMode) {
//       //   print(
//       //       'ble_module_manager.dart :: 삭제후 wvNotifyData Listener 목록=${device!.wvNotifyData.listenerList}');
//       // }
//       //----------------------------------------------
//       // 장비에서 온 정보 메모리 초기화
//       fitsigDeviceAck.init(); // FitsigDeviceAck 에 가지고 있떤 device 정보를 초기화
//
//       await whenBluetoothDisconnected(deviceIndex);
//
//       //------------------------------------------------------------------
//       // 블루투스 상태 설정
//       // 비정상 종료인 경우 다른 곳에서 처리
//       //------------------------------------------------------------------
//
//       //--------------------------------------------------------
//       // 이전 상태가 정상적 연결상태 (auto on)
//       if (gv.deviceStatus[deviceIndex].btControlState.value ==
//           EmlBtControlState.connectedEn) {
//         //-----------------------------------------
//         // [BT_STATE] 대기상태 (auto off)
//         gv.deviceStatus[deviceIndex].btControlState.value =
//             EmlBtControlState.idleConnectingEn;
//         if (kDebugMode) {
//           print('■■■■■■■■■■■[BT_STATE] idleConnectingEn');
//         }
//         //-----------------------------------------
//         // 1초 후 재 연결 수행 (장비 켜지면 자동 연결 됨)
//         Future.delayed(const Duration(milliseconds: 1000), () {
//           gv.bleManager[deviceIndex].connectModule(
//               gv.bleManager[deviceIndex].bleAdaptor.recentDevice!);
//         });
//       }
//       //--------------------------------------------------------
//       // 이전 상태가 정상적 연결상태 (auto off)
//       else if (gv.deviceStatus[deviceIndex].btControlState.value ==
//           EmlBtControlState.connectedDis) {
//         //-----------------------------------------
//         // [BT_STATE] 자동연결 off 연결상태
//         gv.deviceStatus[deviceIndex].btControlState.value =
//             EmlBtControlState.idleDis;
//         if (kDebugMode) {
//           print('■■■■■■■■■■■[BT_STATE] idleDis');
//         }
//       }
//     }
//   });
//
//   //--------------------------------------------------------------------------
//   // 마지막 연결된 장비 기록 읽어오기
//   //--------------------------------------------------------------------------
//   String recentDeviceInfo = gv.spMemory.read('recentDeviceInfo') ?? '';
//
//   //---------------------------------------------------------
//   // 최근 연결 장비에 대한 정보를 이용해서 Ble 모듈에 Ble 장치 인스턴스 생성
//   if (recentDeviceInfo.isNotEmpty) {
//     if (kDebugMode) {
//       print('ble_module_manager.dart :: 최근에 연결된 블루투스 장비 정보 : $recentDeviceInfo');
//     }
//     gv.setting.recentDeviceInfo =
//     List<String>.from(jsonDecode(recentDeviceInfo));
//
//     //---------------------------------------------------------
//     // 연결 장비 정보를 이용하여 BleDevice 생성
//     bleAdaptor.makeBleDeviceFromRecentInfo(gv.setting.recentDeviceInfo);
//
//     //---------------------------------------------------------
//     // 상태 관리
//     gv.btStateManager[deviceIndex].initWithDeviceInfo();
//
//     await Future.delayed(const Duration(milliseconds: 200));
//   }
//   //--------------------------------------------------------------------------
//   // 연결 된 장비 정보가 없는 경우
//   else {
//     //---------------------------------------------------------
//     // 상태 관리
//     gv.btStateManager[deviceIndex].initFirst();
//   }
// }
//
// ///----------------------------------------------------------------------------
// /// 장비 연결하기
// ///----------------------------------------------------------------------------
// Future connectModule(ReactiveDevice device) async {
//   try {
//     // print(
//     //     'ble_module_manager.dart :: connect() : target deviceId=${device.name} hashCode=${device.hashCode}');
//     print('----------------------------------------');
//     print('블루투스 연결 시작 : 모듈');
//     print('----------------------------------------');
//     await bleAdaptor.connectAdaptor(device);
//
//     // 필요 없을 수도 있음
//     // 플러터 블루 기준 MTU 길이 설정을 바로하면 에러나서 100ms 정도 뒤에 했었음
//     // 지연 시간 주지 않아도 문제 없어 보임(221121)
//     // await Future.delayed(const Duration(milliseconds: 100), () {});
//     if (kDebugMode) {
//       print('ble_module_manager.dart :: connect() : middle');
//     }
//
//     // 현재 연결된 장비를, 최근 연결 장비로 등록
//     bleAdaptor.recentDevice = device;
//
//     // get.spMemory 에 저장을 위해 json string 으로 변환
//     List<String> connectedDeviceInfo = [];
//     connectedDeviceInfo.add(device.id);
//     connectedDeviceInfo.add(device.name);
//     connectedDeviceInfo.add(device.serviceUuids);
//     String jsonConnectDeviceInfo = jsonEncode(connectedDeviceInfo);
//
//     // get.spMemory 에 현재 연결된 장비를 최근 연결 장비로 저장
//     gv.spMemory.write('recentDeviceInfo', jsonConnectDeviceInfo);
//   } catch (e) {
//     if (kDebugMode) {
//       print('----------------------------------------------');
//       print('ble_module :: 블루투스 연결 시도 에러');
//       print('----------------------------------------------');
//     }
//     throw Exception(e.toString());
//   }
// }
//
// ///----------------------------------------------------------------------------
// /// 등록된 장비 재 연결
// ///----------------------------------------------------------------------------
// Future reconnectRecentDevice() async {
//   try {
//     if (bleAdaptor.recentDevice != null) {
//       await bleAdaptor.connectAdaptor(bleAdaptor.recentDevice!);
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print('----------------------------------------------');
//       print('ble_module :: 블루투스 재연결 시도 에러');
//       print('----------------------------------------------');
//     }
//     throw Exception(e.toString());
//   }
//
//   // try {
//   // await bleAdaptor.reconnectRecentDevice(deviceNumber,
//   //     prescanDuration: const Duration(seconds: 1), autoReconnect: autoReconnect);
//   // } catch (e) {
//   //   throw Exception(e.toString());
//   // }
// }
//
// ///----------------------------------------------------------------------------
// /// 장비 연결 해제
// ///----------------------------------------------------------------------------
// Future<void> disconnectModule() async {
//   if (kDebugMode) {
//     print('-----------------------------------------------');
//     print('ble_module_manager.dart :: disconnect() 모듈');
//     print('-----------------------------------------------');
//   }
//   // if (deviceNumber == EmlDeviceNumber.device1) {
//   // 장비가 꺼졌으므로, 해당 장비의 bluetoothToDspCnt 값 초기화
//   // previousBluetoothToDspCnt = 0;
//   // bluetoothToDspCnt = 0;
//
//   // wvDevice 에 장비가 연결 되었다면,
//   if (bleAdaptor.g.isBtConnectedReal.value == true) {
//     // disconnect 명령에 의한 정상적인 종료이므로, 비정상적인 종료에 대처하기위한 wvIsConnected 구독은 해제
//     // bleAdaptor.wvDevice.value!.wvIsConnected.removeListener(hashCode);
//
//     // 이 클래스의 init 에서 설정한 wvDevice.wvIsConnected listen 해제. 강제 종료인지 확인하기 위한 것이므로, 정상 종료가 입력되면 바로 해제
//     // await doDisconnectProcess();
//     await bleAdaptor.reactiveDevice.disconnectDevice();
//
//     // bleAdaptor.wvDevice.value = null; // null 을 입력하면 event 발생
//
//     // disconnect 후 5초 뒤에 자동 재연결 타이머 셋팅
//     // await Future.delayed(const Duration(seconds: 5));
//
//     // 자동 연결이 설정되어 있을 경우 disconnect 후 autoConnectionTimer 설정
//     // if (gv.setting.isBluetoothAutoConnect.value == true) {
//     //   // setAutoConnectionTimer();
//     // }
//     // print('ble_module_manager.dart :: disconnect() : 프로세스 종료');
//   }
//   // }
//   // else {
//   //   if (kDebugMode) {
//   //     print('ble_module_manager.dart :: Should not happen');
//   //   }
//   // }
//   if (kDebugMode) {
//     print('ble_module_manager.dart :: disconnect() : 프로세스 종료. ');
//   }
// }
//
// ///----------------------------------------------------------------------------
// /// 장비 연결 해제
// ///----------------------------------------------------------------------------
// // Future<void> doDisconnectProcess() async {
// //   if (kDebugMode) {
// //     print('ble_module_manager.dart :: doDisconnectProcess() 실행');
// //   }
// //   // if (kDebugMode) {
// //   //   print(
// //   //       'ble_module_manager.dart :: doDisconnectProcess() : wvNotifyData removeListener $hashCode');
// //   // }
// //   //----------------------------------------------
// //   // 근전도 실시간 데이터 받는 리스너 해제
// //   bleAdaptor.reactiveDevice.wvNotifyData.removeListener(hashCode);
// //   // if (kDebugMode) {
// //   //   print(
// //   //       'ble_module_manager.dart :: doDisconnectProcess() : 삭제후 wvNotifyData Listener 목록=${device!.wvNotifyData.listenerList}');
// //   // }
// //   //----------------------------------------------
// //   // 장비에서 온 정보 메모리 초기화
// //   fitsigDeviceAck.init(); // FitsigDeviceAck 에 가지고 있떤 device 정보를 초기화
// //   //----------------------------------------------
// //   // ?
// //   // bleAdaptor.wvDevice.value = null;
// // }
//
// ///---------------------------------------------------------------------------
// /// 장치 연결 해제 후 파워 끄기
// ///---------------------------------------------------------------------------
// void disconnectAndPowerOff() async {
//   if (bleAdaptor.g.isBtConnectedReal.value == true) {
//     List<int> data = gv.deviceControl[deviceIndex].getControlPacketData();
//     data[8] = 0xA9; // 장비 전원 끄기 = 0xA9, BOR = OxEF (생산때만)
//     bleAdaptor.reactiveDevice.sendQcCommand(data);
//
//     // 명령 전달 시간 대기
//     await Future.delayed(const Duration(milliseconds: 500), () {});
//     // disconnect(deviceNumber: deviceNumber);
//   } else {
//     if (kDebugMode) {
//       print('ble_module_manager.dart :: Should not happen disconnectAndPowerOff');
//     }
//   }
// }
//
// ///---------------------------------------------------------------------------
// /// [스마트앱 COMMAND] 장비 LED 깜박이기
// ///---------------------------------------------------------------------------
// void blinkDeviceLED() async {
//   if (bleAdaptor.g.isBtConnectedReal.value == true) {
//     List<int> data = gv.deviceControl[deviceIndex].getControlPacketData();
//     // 깜박임 control message 는 1회성이므로 gv.deviceControl[deviceIndex] 의 controlPacketData 값을 바꿀필요 없음
//     data[4] = 0x02; // 2번째 bit 를 true 로 하면 LED 깜박이기
//     bleAdaptor.reactiveDevice.sendQcCommand(data);
//     await Future.delayed(const Duration(seconds: 5), () {});
//     data[4] = 0x00; // 2번째 bit 를 false 로 하면 LED 원상복구
//     bleAdaptor.reactiveDevice.sendQcCommand(data);
//   } else {
//     if (kDebugMode) {
//       print('gv.dart :: Should not happen blinkDeviceLED');
//     }
//   }
// }
//
// ///---------------------------------------------------------------------------
// /// [스마트앱 COMMAND] 장비 터치버튼 전원꺼짐 시간 설정
// ///---------------------------------------------------------------------------
// void setTouchTime({required int touchTime}) async {
//   if (bleAdaptor.g.isBtConnectedReal.value == true) {
//     gv.deviceControl[deviceIndex].changeTouchTime(value: touchTime);
//     // device control packet data 를 가져오기
//     List<int> data = gv.deviceControl[deviceIndex].getControlPacketData();
//     bleAdaptor.reactiveDevice.sendQcCommand(data);
//     dvSetting.touchTime.value = touchTime;
//   } else {
//     if (kDebugMode) {
//       print('gv.dart :: Should not happen setTouchTime');
//     }
//   }
// }
//
// ///----------------------------------------------------------------------------
// /// [스마트앱 COMMAND] 스크린 노출 여부 알림
// /// 스크린 on 이면 address[4]의 bit[2]=0, 숨겨져있으면 bit[2]=1
// ///----------------------------------------------------------------------------
// void notifyScreenState({required bool isScreenOff}) async {
//   if (bleAdaptor.g.isBtConnectedReal.value == true) {
//     gv.deviceControl[deviceIndex].changeScreenState(value: isScreenOff);
//
//     // device control packet data 를 가져오기
//     List<int> data = gv.deviceControl[deviceIndex].getControlPacketData();
//     bleAdaptor.reactiveDevice.sendQcCommand(data);
//   } else {
//     if (kDebugMode) {
//       print('gv.dart :: Should not happen notifyScreenState');
//     }
//   }
// }
//
// ///----------------------------------------------------------------------------
// /// [스마트앱 COMMAND] 장비 착용 상태 전송 메소드
// ///----------------------------------------------------------------------------
// void notifyDeviceAttachState({required EmlElectrodeStatus attachState}) async {
//   int value;
//
//   if (bleAdaptor.g.isBtConnectedReal.value == true) {
//     if (attachState == EmlElectrodeStatus.none ||
//         attachState == EmlElectrodeStatus.detached) {
//       value = 0;
//     } else if (attachState == EmlElectrodeStatus.attachBad) {
//       value = 1;
//     } else if (attachState == EmlElectrodeStatus.attachGood) {
//       value = 2;
//     } else {
//       value = 3; //발생 불가능한 상태
//     }
//
//     // device control packet data 의 부착상태 설정 값을 수정
//     gv.deviceControl[deviceIndex].changeDeviceAttachState(value: value);
//
//     // device control packet data 를 가져오기
//     List<int> data = gv.deviceControl[deviceIndex].getControlPacketData();
//
//     bleAdaptor.reactiveDevice.sendQcCommand(data);
//     // if (bleAdaptor.reactiveDevice != null) {
//     //   bleAdaptor.reactiveDevice.sendQcCommand(data);
//     // }
//   } else {
//     if (kDebugMode) {
//       print('gv.dart :: Should not happen notifyDeviceAttachState');
//     }
//   }
// }
//
// ///----------------------------------------------------------------------------
// /// 장비로 데이터 전송
// ///----------------------------------------------------------------------------
// void notifyMeasurementState({required bool isMeasuring}) {
//   if (bleAdaptor.g.isBtConnectedReal.value == true) {
//     // device control packet data 의 isScreenOff 설정 값을 수정
//     gv.deviceControl[deviceIndex].changeMeasuringState(value: isMeasuring);
//     // device control packet data 를 가져오기
//     List<int> data = gv.deviceControl[deviceIndex].getControlPacketData();
//
//     // print('ble_module_manager.dart :: notifyMeasurementState() : 측정  상태 변화  장치Index=$deviceIndex,  isMeasuring:$isMeasuring');
//     bleAdaptor.reactiveDevice.sendQcCommand(data);
//   } else {
//     if (kDebugMode) {
//       print('gv.dart :: Should not happen notifyMeasurementState');
//     }
//   }
// }}
//
// //==============================================================================
// // 블루투스 연결 시 실행
// //==============================================================================
// whenBluetoothConnected(int deviceIndex) async {
//   //----------------------------------------------------------------------------
//   // OTA 파일 로드 (기존 코드르 블루트스와 연동되어 로드)
//   // 앱 초기화에서 로드하는 것이 바람직 (향후)
//   //----------------------------------------------------------------------------
//   dvSetting
//       .findFirmwareFileAndOpen(); // ble_device 에서 OTA Version 을 관리하고 있어서, 장치가 연결되면 OTA 파일 정보도 열어서 로딩
//
//   //----------------------------------------------------------------------------
//   // control 변수 갱신
//   //----------------------------------------------------------------------------
//   if (kDebugMode) {
//     print('ble_module_manager.dart :: isDeviceBtConnected = true 로 변경됨');
//   }
//   gv.deviceStatus[deviceIndex].isDeviceBtConnected.value = true;
//
//   //----------------------------------------------------------------------------
//   // 블루투스 연결음
//   // todo : 장비가 여러개인 경우 외부에서 처리 검토
//   //----------------------------------------------------------------------------
//   gv.audioManager.play(type: EmaSoundType.btConnect); // 블루투스 연결음 플레이
//
//   //----------------------------------------------------------------------------
//   // API 실행 - 장비 연결 메시지
//   //----------------------------------------------------------------------------
//   //----------------------------------------------
//   // 전송 할 body
//   Map<String, String> body = {
//     'bc_age': gv.setting.bornYearApi(gv.setting.bornYearIndex.value),
//     'bc_sex': gv.setting.genderApi(gv.setting.genderIndex.value),
//   };
//   Map<String, String> ackMap =
//   await apiPost(subUrl: 'insert/connect', body: body);
//   //----------------------------------------------
//   // 성공 메시지
//   if (ackMap['response'] == 's') {
//     if (kDebugMode) {
//       print('장비연결 API 전송 성공');
//     }
//   } else {
//     if (kDebugMode) {
//       print('장비연결 API 전송 실패!');
//     }
//   }
//   //----------------------------------------------------------------------------
//   // 통신상태 측정 변수만 초기화
//   //----------------------------------------------------------------------------
//   gv.deviceStatus[deviceIndex].initMeasureData();
//
//   //----------------------------------------------------------------------------
//   // DSP 모듈 초기화
//   //----------------------------------------------------------------------------
//   DspManager.whenBluetoothConnected(deviceIndex);
// }
//
// //==============================================================================
// // 블루투스 해제 시 실행
// //==============================================================================
//
// whenBluetoothDisconnected(int deviceIndex) async {
//   //----------------------------------------------------------------------------
//   // control 변수 갱신
//   //----------------------------------------------------------------------------
//   if (kDebugMode) {
//     print('ble_module_manager.dart :: isDeviceBtConnected = false 로 변경됨');
//   }
//   gv.deviceStatus[deviceIndex].isDeviceBtConnected.value = false;
//   gv.deviceStatus[deviceIndex].isAppConnected.value = false;
//
//   //----------------------------------------------------------------------------
//   // DSP 모듈 해제
//   //----------------------------------------------------------------------------
//   DspManager.whenBluetoothDisconnected(deviceIndex);
//
//   //----------------------------------------------------------------------------
//   // 블루투스 연결 해제 사운드
//   //----------------------------------------------------------------------------
//   gv.audioManager.play(type: EmaSoundType.btDisconnect); // 블루투스 연결 해제음 플레이
// }
