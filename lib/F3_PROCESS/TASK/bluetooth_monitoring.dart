import '/F0_BASIC/common_import.dart';
import 'dart:io' show Platform;
//==============================================================================
// 블루투스 연결 상태 감시 - 500ms loop
//==============================================================================
Timer? deviceIconTimer;
Rx<bool> isDeviceIconOn = false.obs;
void taskBluetoothQualityMonitoring() async{
  int d = 0; //device index
  // print('bluetooth_monitoring :: taskBluetoothQualityMonitoring : cntPacket=${gv.deviceStatus[d].cntPacket}');

  //----------------------------------------------------------------------------
  // 블루투스 연결된 경우
  //----------------------------------------------------------------------------
  if (gv.deviceStatus[d].isDeviceBtConnected.value == true && dvSetting.firmwareStatus.value != EmaFirmwareStatus.isUpdating) {
    //--------------------------------------------------------------------------
    // packet error 가 발생한 경우
    //--------------------------------------------------------------------------
    if (gv.deviceStatus[d].flagPacketError == true) {
      gv.deviceStatus[d].flagPacketError = false;
      gv.deviceStatus[d].btLinkQualityStatus.value = EmlBtLinkQualityStatus.packetError;
      //----------------------------------------------------
      // DSP 외부 판단 예외처리 호출 - 통신 에러 (3초 데이터 삭제)
      DspManager.setExternalException(deviceIndex: d);
      if (kDebugMode) {
        print('bluetooth_monitoring :: 패킷 에러 -> DSP 예외 처리');
      }

    }
    //--------------------------------------------------------------------------
    // 데이터 정상 수신 여부 판단
    // 500ms에 12.5패킷 들어오면 정상 (40ms에 1 패킷)
    // 1초에 500샘플 들어오면 정상
    // 0.5초에 3패킷 미만으로 들어오면 예외처리 (웬만한 건 패킷 넘버에러로 예외처리)
    // 실시간 그래프도 0처리 검토 (높게 떠서 사용자 혼란 방지~)
    // 조건 미달 시 DSP 외부 판단 예외처리 호출 - 통신 에러 (3초 데이터 삭제)
    //--------------------------------------------------------------------------
    else if (gv.deviceStatus[d].cntPacket < 3) {
      //----------------------------------------------------
      // 연속적 패킷 제로 감지 : 데이터 끊어짐 감지
      if (gv.deviceStatus[d].cntPacket == 0){
        gv.deviceStatus[d].cntZeroPacket++;
        // print('bluetooth_monitoring :: taskBluetoothQualityMonitoring : cntZeroPacket=${gv.deviceStatus[d].cntZeroPacket}');
      }

      gv.deviceStatus[d].btLinkQualityStatus.value = EmlBtLinkQualityStatus.bpsLow;
      //----------------------------------------------------
      // DSP 외부 판단 예외처리 호출 - 통신 에러 (3초 데이터 삭제)
      // 통신 저하의 경우 일단 에러난 것은 아니므로 예외처리 안하는 것으로 결정(221103)
      // DspManager.setExternalException(deviceIndex: d);
      // if (kDebugMode) {
      //   print('bluetooth_monitoring.dart :: 데이터 수신속도 저하 -> DSP 예외 처리는 안함');
      // }
    }
    //--------------------------------------------------------------------------
    // 데이터 품질 상태 양호
    //--------------------------------------------------------------------------
    else {
      gv.deviceStatus[d].btLinkQualityStatus.value = EmlBtLinkQualityStatus.good;
      gv.deviceStatus[d].cntZeroPacket = 0;
    }
    gv.deviceStatus[d].cntPacket = 0; //다음 감지를 위해 패킷 수 0 처리

    //--------------------------------------------------------------------------
    // [예외상황] 장비 전원꺼짐 감지 : 연결 종료 절차
    //--------------------------------------------------------------------------
    if (gv.deviceStatus[d].cntZeroPacket >= 2){
      if (kDebugMode) {
        String time = printPresentTime(printEnable: false);
        print('----------------------------------');
        print('taskBluetoothQualityMonitoring() :: 예외상황 : 연결 후 데이터가 1초이상 수신되지 않음  $time');
        print('----------------------------------');
      }
      gv.deviceStatus[d].cntZeroPacket = 0; //중복실행 방지 목적
      isDeviceIconOn.value = true; // 디바이스 아이콘은 강제 On
      BleManager.flagIgnoreSound[d] = true; // 예외상황이므로 연결해제(이후 자동연결)음을 무식하기위해 flag 셋팅
      await gv.btStateManager[d].disconnectCommand(isException: true); //연결 해제 절차 진행

      if(deviceIconTimer != null){
        deviceIconTimer!.cancel();
      }

      // 재연결시도 만료 시간을 iOS 8초, 안드로이드 10초로 설정
      // 시간 체크를 해보니 연결을 시도하고 OS 레벨에서 연결되기 까지 1.8초 소요되고, 앱 레벨에서 연결까지 0.3초가 추가로 소요
      // 정전기가 2번 연속 일어날 경우 다시 연결이 되기까지 5초 이상이 소요될 때도 있어서 iOS 에서도 8초로 길게 설정
      // 안드로이드의 경우 2번 연속 정전기시 8초가 짧아서 10초로 설정 (2023.02.13)
      deviceIconTimer = Timer( Duration(seconds: Platform.isIOS ? 8 : 10), (){
        isDeviceIconOn.value = false;
      });
    }
  }
  // else if(dvSetting.firmwareStatus.value == EmaFirmwareStatus.isUpdating){
  //   print('taskBluetoothQualityMonitoring() :: 예외상황 : Updating Firmware');
  // }
  //----------------------------------------------------------------------------
  // 블루투스 연결 해제 된 경우 (장비 꺼져서 데이터가 안들어오는 상태)
  //----------------------------------------------------------------------------
  else {
    gv.deviceStatus[d].cntPacket = 0;
    gv.deviceStatus[d].cntZeroPacket = 0;
    gv.deviceStatus[d].btLinkQualityStatus.value = EmlBtLinkQualityStatus.none;
  }
}

//
// //------------------------------------------------------------------
// // 블루투스 상태 설정
// //------------------------------------------------------------------
// if (gv.setting.isBluetoothAutoConnect.value == true) {
// //-----------------------------------------
// // [BT_STATE] 자동연결 on 연결상태
// gv.deviceStatus[deviceIndex].btControlState.value =
// EmlBtControlState.connectedEn;
// if (kDebugMode) {
// print('■■■■■■■■■■■[BT_STATE] connectedEn');
// }
// //-----------------------------------------
// // 재 연결 수행 (장비 켜지면 자동 연결 됨)
// gv.bleManager[deviceIndex]
//     .connectModule(gv.bleManager[deviceIndex].bleAdaptor.recentDevice!);
// } else {
// //-----------------------------------------
// // [BT_STATE] 자동연결 off 연결상태
// gv.deviceStatus[deviceIndex].btControlState.value =
// EmlBtControlState.connectedDis;
// if (kDebugMode) {
// print('■■■■■■■■■■■[BT_STATE] connectedDis');
// }
// }