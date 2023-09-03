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
//   /// 상태 초기화
//   ///---------------------------------------------------------------------------
//   Future init() async {
//     bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
//     //------------------------------------------------------------------------
//     // 최초 상태
//     //------------------------------------------------------------------------
//     if (gv.deviceStatus[deviceIndex].recentDeviceInfo.isEmpty) {
//       // 자동 연결을 강제로 disable (혼란 방지) - 초기값은 false
//       gv.setting.isBluetoothAutoConnect.value = false;
//       gv.spMemory.write('isBluetoothAutoConnect', false);
//       setState(EmlBtControlState.idleInit);
//       if (kDebugMode) {
//         print('ble_module_manager.dart :: 최근에 연결된 블루투스 장비 정보가 없습니다');
//       }
//     }
//     //------------------------------------------------------------------------
//     // 자동 연결이 enable: 재 연결 수행
//     //------------------------------------------------------------------------
//     else if (autoConnectEnable == true) {
//       await BleManager.reconnectRecentDevice(
//           deviceIndex: deviceIndex); // 재 연결 수행
//       setState(EmlBtControlState.idleConnectingEn);
//     }
//     //------------------------------------------------------------------------
//     // 자동 연결이 disable : 상태만 설정
//     //------------------------------------------------------------------------
//     else {
//       setState(EmlBtControlState.idleDis);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 새로운 장비 연결 시도 하는 경우 (자동연결 아닌 상태에서만)
//   ///---------------------------------------------------------------------------
//   Future connectNewDevice(BleDevice device) async {
//     bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//
//     //------------------------------------------------------------------------
//     // 기존 기록 존재 여부에 따라 구분
//     if (presentState == EmlBtControlState.idleInit) {
//       setState(EmlBtControlState.connectingInit); //최초 연결중
//     } else {
//       setState(EmlBtControlState.connectingDis); // 연결중 (자동 disable)
//     }
//     //------------------------------------------------------------------------
//     // 연결 수행
//     await BleManager.connectNewDevice(device, deviceIndex: deviceIndex);
//     //------------------------------------------------------------------------
//     // 2초 뒤 연결상태 판단
//     //   - 연결되지 않은 경우 초기 상태로 재 설정
//     Future.delayed(const Duration(milliseconds: 2000), () {
//       presentState = gv.deviceStatus[deviceIndex].btControlState.value;
//       //------------------------------------------------------------------------
//       // 최초 연결되지 않은 경우 : 해제 후 초기상태로 복귀
//       if (presentState == EmlBtControlState.connectingInit) {
//         BleManager.disconnect(deviceIndex: deviceIndex); // 연결 해제
//         setState(EmlBtControlState.idleInit);
//       }
//       //------------------------------------------------------------------------
//       // 연결되지 않은 경우 : 해제 후 초기상태로 복귀
//       else if (presentState == EmlBtControlState.connectingDis) {
//         BleManager.disconnect(deviceIndex: deviceIndex); // 연결 해제
//         setState(EmlBtControlState.idleDis);
//       }
//     });
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 연결 된 경우 - 연결감지 리스너에서 연결된 경우 호출
//   ///---------------------------------------------------------------------------
//   void connectedEvent() {
//     bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
//     //------------------------------------------------------------------------
//     // 자동연결 enable 인 경우
//     //------------------------------------------------------------------------
//     if (autoConnectEnable == true) {
//       setState(EmlBtControlState.connectedEn);
//     }
//     //------------------------------------------------------------------------
//     // 자동연결 disable인 경우
//     //------------------------------------------------------------------------
//     else {
//       setState(EmlBtControlState.connectedDis);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 연결 해제 명령이 실행된 경우
//   ///---------------------------------------------------------------------------
//   Future disconnectCommand() async {
//     bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
//     //------------------------------------------------------------------------
//     // 연결 해제
//     //------------------------------------------------------------------------
//     BleManager.disconnect(deviceIndex: deviceIndex); // 연결 해제
//     //------------------------------------------------------------------------
//     // 자동연결 enable
//     //------------------------------------------------------------------------
//     if (autoConnectEnable == true) {
//       setState(EmlBtControlState.disconnectingEn);
//     }
//     //------------------------------------------------------------------------
//     // 자동연결 disable
//     //------------------------------------------------------------------------
//     else {
//       setState(EmlBtControlState.disconnectingDis);
//     }
//
//     //------------------------------------------------------------------------
//     // OS 내부 연결 해제시간 대기
//     //------------------------------------------------------------------------
//     int reconnectWaitTimeMs = 0;
//     if (gv.system.isAndroid == true) {
//       reconnectWaitTimeMs = GvDef.disconnectWaitTimeAndroid + 500; // 안드로이드 : 최소 5초 후에 재 연결
//     } else {
//       reconnectWaitTimeMs = GvDef.disconnectTimeIos + 500; // iOS : 최소 0.8초 후에 재 연결
//     }
//     Future.delayed(Duration(milliseconds: reconnectWaitTimeMs), () {
//       //------------------------------------------------------------------------
//       // 자동연결 enable : 재연결 수행
//       //------------------------------------------------------------------------
//       if (autoConnectEnable == true) {
//         BleManager.reconnectRecentDevice(deviceIndex: deviceIndex); // 재연결
//         setState(EmlBtControlState.idleConnectingEn);
//       }
//       //------------------------------------------------------------------------
//       // 자동연결 disable
//       //------------------------------------------------------------------------
//       else {
//         setState(EmlBtControlState.idleDis);
//       }
//     });
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 장비 전원 꺼짐이 감지 된 경우 : 상태만 변경하며 disconnected 이벤트 대기
//   /// todo : 안드로이드에서 5초보다 빠른 접속을 위해 재연결 명령하는 것 시험 검토
//   ///---------------------------------------------------------------------------
//   Future detectDevicePowOff() async {
//     bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//     //------------------------------------------------------------------------
//     // 자동연결 enable
//     //------------------------------------------------------------------------
//     if (autoConnectEnable == true) {
//       setState(EmlBtControlState.waitDisconnectedWhenPowOffDetectEn);
//     }
//     //------------------------------------------------------------------------
//     // 자동연결 disable
//     //------------------------------------------------------------------------
//     else {
//       setState(EmlBtControlState.waitDisconnectedWhenPowOffDetectDis);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 파워 off 명령이 실행된 경우 : 상태만 변경하며 disconnected 이벤트 대기
//   ///---------------------------------------------------------------------------
//   Future devicePowOffCommand() async {
//     bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//     //------------------------------------------------------------------------
//     // 자동연결 enable
//     //------------------------------------------------------------------------
//     if (autoConnectEnable == true) {
//       setState(EmlBtControlState.waitDisconnectedWhenPowOffCmdEn);
//     }
//     //------------------------------------------------------------------------
//     // 자동연결 disable
//     //------------------------------------------------------------------------
//     else {
//       setState(EmlBtControlState.waitDisconnectedWhenPowOffCmdDis);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// disconnect event 가 발생한 경우
//   /// d이전 상태에 따라 다양한 처리
//   ///---------------------------------------------------------------------------
//   Future disconnectEvent() async {
//     bool autoConnectEnable = gv.setting.isBluetoothAutoConnect.value;
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//     //--------------------------------------------------------------------------
//     // 전원꺼짐 명령 종료 - 자동연결 disable
//     // 변수 초기화 : 이것을 라이브러리 구현 필요
//     //--------------------------------------------------------------------------
//     if (presentState == EmlBtControlState.waitDisconnectedWhenPowOffCmdDis){
//
//     }
//     //--------------------------------------------------------------------------
//     // 전원꺼짐 명령 종료 - 자동연결 enable
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.waitDisconnectedWhenPowOffCmdEn){
//
//     }
//     //--------------------------------------------------------------------------
//     // 장비꺼짐 감지 - 자동연결 disable
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.waitDisconnectedWhenPowOffDetectDis){
//
//     }
//     //--------------------------------------------------------------------------
//     // 장비꺼짐 감지 - 자동연결 enable
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.waitDisconnectedWhenPowOffDetectEn){
//
//     }
//
//
//   }
//
//
//   ///---------------------------------------------------------------------------
//   /// 자동 연결이 설정되는 경우 : 상태 값만 변화
//   ///---------------------------------------------------------------------------
//   void whenAutoConnectChangeToEnable() {
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//     //--------------------------------------------------------------------------
//     // 대기 혹은 연결 중이라면 상태라면
//     //--------------------------------------------------------------------------
//     if (presentState == EmlBtControlState.idleDis ||
//         presentState == EmlBtControlState.connectingDis) {
//       BleManager.reconnectRecentDevice(deviceIndex: deviceIndex); // 자동연결 설정
//       setState(EmlBtControlState.idleConnectingEn);
//     }
//     //--------------------------------------------------------------------------
//     // 연결된 상태라면
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.connectedDis) {
//       setState(EmlBtControlState.connectedEn);
//     }
//     //--------------------------------------------------------------------------
//     // 연결 해제중이라면
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.exDisconnectingDis) {
//       setState(EmlBtControlState.exDisconnectingEn);
//     }
//     //--------------------------------------------------------------------------
//     // 예외 상태라면
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.exDisconnectingDis) {
//       setState(EmlBtControlState.exDisconnectingEn);
//     }
//   }
//
//   ///---------------------------------------------------------------------------
//   /// 자동 연결이 해제되는 경우 : 주로 상태값만 변화
//   ///---------------------------------------------------------------------------
//   void whenAutoConnectChangeToDisable() {
//     EmlBtControlState presentState =
//         gv.deviceStatus[deviceIndex].btControlState.value;
//     //--------------------------------------------------------------------------
//     // 대기 상태라면 : 자동 연결 해제
//     //--------------------------------------------------------------------------
//     if (presentState == EmlBtControlState.idleConnectingEn) {
//       BleManager.disconnect(deviceIndex: deviceIndex); // 자동연결 해제
//       setState(EmlBtControlState.idleDis);
//     }
//     //--------------------------------------------------------------------------
//     // 연결된 상태라면
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.connectedEn) {
//       setState(EmlBtControlState.connectedDis);
//     }
//     //--------------------------------------------------------------------------
//     // 해제 중이라면
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.disconnectingEn) {
//       setState(EmlBtControlState.disconnectingDis);
//     }
//     //--------------------------------------------------------------------------
//     // 예외 해제 중이라면
//     //--------------------------------------------------------------------------
//     else if (presentState == EmlBtControlState.exDisconnectingEn) {
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
//       print('■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■'
//           '[DEV$deviceIndex BT_STATE] $state');
//     }
//   }
// }
