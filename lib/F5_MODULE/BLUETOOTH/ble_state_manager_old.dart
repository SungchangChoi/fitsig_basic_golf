// import '/F0_BASIC/common_import.dart';
//
// //==============================================================================
// // 블루투스 상태 관리
// //==============================================================================
// class BtStateManager {
//   final int deviceIndex;
//
//   BtStateManager({required this.deviceIndex});
//
//   ///---------------------------------------------------------------------------
//   /// 최초 상태
//   ///---------------------------------------------------------------------------
//   void initFirst() {
//     // 자동 연결을 강제로 disable (혼란 방지) - 초기값은 false
//     gv.setting.isBluetoothAutoConnect.value = false;
//     gv.spMemory.write('isBluetoothAutoConnect', false);
//     //-----------------------------------------
//     // [BT_STATE] 연결 대기 (Auto disable)
//     setState(EmlBtControlState.idleInit);
//     if (kDebugMode) {
//       print('ble_module_manager.dart :: 최근에 연결된 블루투스 장비 정보가 없습니다');
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 초기상태 - 디바이스 정보 있음
//   ///---------------------------------------------------------------------------
//   void initWithDeviceInfo() {
//     bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
//     //------------------------------------------------------------------------
//     // 자동연결 여부에 따라 초기 대기 상태 결정
//     if (autoConnectEnable == true) {
//       //-----------------------------------------
//       // 재 연결 수행 (장비 켜지면 자동 연결 됨)
//       BleManager.reconnectRecentDevice(deviceIndex: deviceIndex);
//       //-----------------------------------------
//       // [BT_STATE] 연결 대기 (Auto enable)
//       setState(EmlBtControlState.idleConnectingEn);
//     } else {
//       //-----------------------------------------
//       // [BT_STATE] 연결 대기 (Auto disable)
//       setState(EmlBtControlState.idleDis);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 연결 시도 하는 경우 (자동연결 아닌 상태에서만)
//   ///---------------------------------------------------------------------------
//   void connectingWhenAutoDisable() {
//     bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
//     // late Timer _timer;
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//     //------------------------------------------------------------------------
//     // 기존 기록 존재 여부에 따라 구분
//     if (presentState == EmlBtControlState.idleInit) {
//       //-----------------------------------------
//       // [BT_STATE] 최초 연결시도 중 (Auto enable)
//       setState(EmlBtControlState.connectingInit);
//     } else {
//       //-----------------------------------------
//       // [BT_STATE] 연결시도 중 (Auto disable)
//       setState(EmlBtControlState.connectingDis);
//     }
//     //------------------------------------------------------------------------
//     // 2초 뒤 연결상태 판단 후 상태 변경
//     // 연결되지 않은 경우 초기 상태로 재 설정
//     Future.delayed(const Duration(milliseconds: 2000), () {
//       presentState = gv.deviceStatus[deviceIndex].btControlState.value;
//       if (presentState == EmlBtControlState.connectingInit){
//         //-----------------------------------------
//         // 연결 해제
//
//         //-----------------------------------------
//         // [BT_STATE] 최초 연결시도 중 (Auto enable)
//         setState(EmlBtControlState.idleInit);
//       }
//     });
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 정상 연결된 경우
//   ///---------------------------------------------------------------------------
//   void connected() {
//     //------------------------------------------------------------------------
//     // 자동연결 여부에 따라 초기 대기 상태 결정
//     if (gv.setting.isBluetoothAutoConnect.value == true) {
//       //-----------------------------------------
//       // [BT_STATE] 연결 (Auto enable)
//       setState(EmlBtControlState.connectedEn);
//     } else {
//       //-----------------------------------------
//       // [BT_STATE] 연결 (Auto disable)
//       setState(EmlBtControlState.connectedDis);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 정상적으로 해제되는 경우 (앱에서 장비꺼짐 명령으로 해제된 상태)
//   ///---------------------------------------------------------------------------
//   void disconnectNormal() {
//     //------------------------------------------------------------------------
//     // 5초 대기 후 장비 재 연결
//     //------------------------------------------------------------------------
//     int reconnectWaitTimeMs = 0;
//     if (gv.system.isAndroid == true) {
//       reconnectWaitTimeMs = GvDef.disconnectWaitTimeAndroid + 500; // 안드로이드 : 최소 5초 후에 재 연결
//     } else {
//       reconnectWaitTimeMs = GvDef.disconnectTimeIos + 500; // iOS : 최소 0.8초 후에 재 연결
//     }
//     Future.delayed(Duration(milliseconds: reconnectWaitTimeMs), () {
//       //------------------------------------------------------------------------
//       // AutoOn
//       //------------------------------------------------------------------------
//       if (gv.setting.isBluetoothAutoConnect.value == true) {
//         //-----------------------------------------
//         // 앱에서 종료처리가 되는 시간을 기다린 후 재 연결 수행 (장비 켜지면 자동 연결 됨)
//         BleManager.reconnectRecentDevice(deviceIndex: deviceIndex);
//
//         //-----------------------------------------
//         // [BT_STATE] 연결 대기 (Auto enable)
//         setState(EmlBtControlState.idleConnectingEn);
//       }
//       //------------------------------------------------------------------------
//       // AutoOff
//       //------------------------------------------------------------------------
//       else {
//         //-----------------------------------------
//         // [BT_STATE] 연결 대기 (Auto disable)
//         setState(EmlBtControlState.idleDis);
//       }
//     });
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 비정상 해제되는 경우 (감지에 1초 걸림)
//   ///---------------------------------------------------------------------------
//   void disconnectedException() {
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//     //------------------------------------------------------------------------
//     // AutoOn
//     //------------------------------------------------------------------------
//     if (gv.setting.isBluetoothAutoConnect.value == true) {
//       //-----------------------------------------
//       // [BT_STATE] 예외 (Auto enable)
//       setState(EmlBtControlState.exDisconnectingEn);
//     }
//     //------------------------------------------------------------------------
//     // AutoOff
//     //------------------------------------------------------------------------
//     else {
//       //-----------------------------------------
//       // [BT_STATE] 예외 (Auto disable)
//       setState(EmlBtControlState.exDisconnectingDis);
//     }
//
//     //--------------------------------------------------------------------------
//     // 종료처리
//     // 전원꺼짐 감지(데이터 수신 없는 상태)에 이미 1초 이상 소요
//     //--------------------------------------------------------------------------
//     BleManager.disconnect(deviceIndex: deviceIndex);
//
//     int reconnectWaitTimeMs = 0;
//     if (gv.system.isAndroid == true) {
//       reconnectWaitTimeMs = 4500; // 안드로이드 : 4.5초 후에 재 연결
//     } else {
//       reconnectWaitTimeMs = 500; // 안드로이드 : 0.5초 후에 재 연결
//     }
//     //--------------------------------------------------------------------------
//     // 앱 내부 연결지속시간 지난 후
//     //--------------------------------------------------------------------------
//     Future.delayed(Duration(milliseconds: reconnectWaitTimeMs), () {
//       //------------------------------------------------------------------------
//       // 공통으로 재 연결 수행
//       //------------------------------------------------------------------------
//       BleManager.reconnectRecentDevice(deviceIndex: deviceIndex);
//       //------------------------------------------------------------------------
//       // AutoOn : 상태만 변경
//       //------------------------------------------------------------------------
//       if (gv.setting.isBluetoothAutoConnect.value == true) {
//         //-----------------------------------------
//         // [BT_STATE] 연결 대기 (Auto enable)
//         setState(EmlBtControlState.idleConnectingEn);
//       }
//       //------------------------------------------------------------------------
//       // AutoOff : 2초 후 연결이 안되어 있으면 disconnect()
//       // 정전기 문제였다면 장비 전원이 켜져 있어 다시 연결 됨
//       // 장비 전원 껐거나 무선 이탈한 경우에는 장비 전원 꺼져 있음 -> disconnect 수행
//       //------------------------------------------------------------------------
//       else {
//         Future.delayed(const Duration(milliseconds: 2000), () {
//           //-----------------------------------------
//           // 연결이 안되어 있는 경우 종료처리 (무선이탈, 전원버튼 꺼짐)
//           if (bt[deviceIndex].bleDevice.isBtConnectedReal.value == false) {
//             // 연결 해제
//             BleManager.disconnect(deviceIndex: deviceIndex);
//             //-----------------------------------------
//             // [BT_STATE] 연결 대기 (Auto disable)
//             setState(EmlBtControlState.idleDis);
//           }
//         });
//       }
//     });
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 예외 상황 재연결 시도 하는 경우
//   ///---------------------------------------------------------------------------
//   void exceptionReconnecting() {
//     //------------------------------------------------------------------------
//     // 자동연결 여부에 따라 초기 대기 상태 결정
//     if (gv.setting.isBluetoothAutoConnect.value == true) {
//       //-----------------------------------------
//       // [BT_STATE] 연결 (Auto enable)
//       setState(EmlBtControlState.connectedEn);
//     } else {
//       //-----------------------------------------
//       // [BT_STATE] 연결 (Auto disable)
//       setState(EmlBtControlState.connectedDis);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 자동 연결이 설정되는 경우
//   ///---------------------------------------------------------------------------
//   void whenAutoConnectChangeToEnable() {
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//     //--------------------------------------------------------------------------
//     // 대기 상태라면 : 자동 연결 설정
//     //--------------------------------------------------------------------------
//     if (presentState == EmlBtControlState.idleDis) {
//       //-----------------------------------------
//       // 자동연결 설정 (장비 켜지면 자동 연결 됨)
//       BleManager.reconnectRecentDevice(deviceIndex: deviceIndex);
//       //-----------------------------------------
//       // [BT_STATE] 연결 대기 (Auto enable)
//       setState(EmlBtControlState.idleConnectingEn);
//     }
//     //--------------------------------------------------------------------------
//     // 연결된 상태라면 : 상태 값만 변화
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.connectedDis) {
//       //-----------------------------------------
//       // [BT_STATE] 연결 (Auto enable)
//       setState(EmlBtControlState.connectedEn);
//     }
//     //--------------------------------------------------------------------------
//     // 예외 상태라면 : 상태 값만 변화
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.exDisconnectingDis) {
//       //-----------------------------------------
//       // [BT_STATE] 예외 (Auto enable)
//       setState(EmlBtControlState.exDisconnectingEn);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 자동 연결이 해제되는 경우
//   ///---------------------------------------------------------------------------
//   void whenAutoConnectChangeToDisable() {
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//     //--------------------------------------------------------------------------
//     // 대기 상태라면 : 자동 연결 해제
//     //--------------------------------------------------------------------------
//     if (presentState == EmlBtControlState.idleConnectingEn) {
//       //-----------------------------------------
//       // 자동연결 해제
//       BleManager.disconnect(deviceIndex: deviceIndex);
//       //-----------------------------------------
//       // [BT_STATE] 대기 (Auto disable)
//       setState(EmlBtControlState.idleDis);
//     }
//     //--------------------------------------------------------------------------
//     // 연결된 상태라면 : 상태 값만 변화
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.connectedEn) {
//       //-----------------------------------------
//       // [BT_STATE] 연결 (Auto disable)
//       setState(EmlBtControlState.connectedDis);
//     }
//     //--------------------------------------------------------------------------
//     // 예외 상태라면 : 상태 값만 변화
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.exDisconnectingEn) {
//       //-----------------------------------------
//       // [BT_STATE] 예외 (Auto disable)
//       setState(EmlBtControlState.exDisconnectingDis);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 상태전환 및 메시지 표시
//   ///---------------------------------------------------------------------------
//   void setState(EmlBtControlState state) {
//     gv.deviceStatus[deviceIndex].btControlState.value = state;
//     if (kDebugMode) {
//       print('■■■■■■■■■■■[DEV$deviceIndex BT_STATE] $state');
//     }
//   }
// }
