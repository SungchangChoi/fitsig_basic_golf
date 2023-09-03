import '/F0_BASIC/common_import.dart';

//==============================================================================
// 상태 관련 정보 - 장비별
//==============================================================================
class GvDeviceStatus {
  //----------------------------------------------------------------------------
  // 블루투스, USB, 충전중 등...
  //----------------------------------------------------------------------------

  // sharedPreference 에서 불러온 최근 연결한 device 정보를 저장하기 위한 변수
  List<String> recentDeviceInfo = <String>[];

  RxBool isDeviceBtConnected = false.obs; //블루투스 연결 여부
  Rx<EmlBtLinkQualityStatus> btLinkQualityStatus =
      EmlBtLinkQualityStatus.none.obs; //블루투스 연결 상태
  RxBool isAppConnected = false.obs; // 앱과 연결 여부 (디바이스 번호를 제대로 받았는지 확인하여 판단)
  RxBool isDeviceUsbConnected = false.obs; //USB 연결 여부
  RxBool isDeviceIsCharging = false.obs; //충전여부
  RxBool isDeviceWaterDetected = false.obs; //USB 단자 물기 감지 여부
  RxBool isDeviceHighTemperature = false.obs; //고온 여부 (45도 이상) - 이때 충전 금지
  // RxBool isDeviceOTAUpdating = false.obs; // OTA 업데이트 중 인지 여부
  Rx<EmlBtControlState> btControlState =
      EmlBtControlState.idleInit.obs; // 블루투스 연결 상태

  //----------------------------------------------------------------------------
  // 디바이스 - 필요에 따라 경고알람 표시
  //----------------------------------------------------------------------------
  Rx<EmlElectrodeStatus> electrodeStatus = EmlElectrodeStatus.detached.obs;
  Rx<EmlExceptionType> exceptionStatus = EmlExceptionType.none.obs;
  RxInt batteryCapacity = 0.obs; //1 = 0~10%, 2 = 10~20% ... 10 = 90~100%

  //USB voltage
  //water voltage
  //device 온도
  //

  //----------------------------------------------------------------------------
  // 통신 상태 감시용 변수
  //----------------------------------------------------------------------------
  bool flagPacketError = false;
  int cntPacket = 0; // 통신 상태 감시 태스크에서 활용
  int cntZeroPacket = 0; //하나도 없는 데이터가 들어 온 횟수
  //----------------------------------------------------------------------------
  // 통신 관련 디버깅용 변수
  //----------------------------------------------------------------------------
  double gamma = 0.9;
  List<int> packetByte = [];
  int packetNumber = 0; //입력 패킷 번호
  int packetNumber1p = 0; //이전 패킷 입력 번호
  int packetError = 0; //패킷 수신 에러
  double packetErrorAverage = 0; //초당 평균 에러율
  int packetTotalCount = 0; //패킷 수신 개수 합계
  double samplePerSec = 0; //초당 받은 샘플 수

  int byteCount = 0; //수신 바이트 수
  double bpsAverage = 0.0; //평균 bps

  int rssi = 0; //무선 수신 감도
  double fRssiAverage = 0; //평균 무선 수신 감도

  int adsDeviceId = 0; //ADS1292 = 92
  int adsStatus = 0; //ADS1292 상태

  //--------------------------------------------------------------------------
  // 측정 데이터 초기화 (매 블루투스 연결 마다 실행)
  //--------------------------------------------------------------------------
  void initMeasureData() {
    flagPacketError = false;
    cntPacket = 0;
    cntZeroPacket = 0;
    packetNumber = 0;
    packetNumber1p = 0;
    packetError = 0;
    packetErrorAverage = 0;
    packetTotalCount = 0;

    byteCount = 0;

    bpsAverage = 0.0;

    fRssiAverage = 0;
  }

  //--------------------------------------------------------------------------
  // 패킷 넘버 체크
  //--------------------------------------------------------------------------
  void checkPacketNumber() {
    packetTotalCount = packetTotalCount + 1; //받은 패킷 개수

    if (packetNumber1p != 0 && packetNumber != 0) {
      // 처음이 아니라면
      // 패킷 번호 값이 1차이가 나야하는데 1보다 크다면 (혹은 작다면)
      if (packetNumber != packetNumber1p + 1) {
        packetError += 1; //무선 수신 에러 발생
        //----------------------------------------------------------------------
        // 패킷 에러 발생 -> taskBluetoothQualityMonitoring() 에서 초기화
        flagPacketError = true;
      }
    }
    packetNumber1p = packetNumber; //현재 패킷넘버 저장
    byteCount = byteCount + 68; //무선 패킷은 68 byte (8 = head, 60 = data)
    cntPacket =
        cntPacket + 1; //통신감지 태스크에서 활용 (taskBluetoothQualityMonitoring()에서 초기화)
    // 1패킷은 20샘플로 구성 = 68byte (헤더 포함)
    // 500SPS -> 1초에 25패킷 = 500샘플 = 1700byte = 13.6kbps
  }

  //--------------------------------------------------------------------------
  // 1초마다 실행하는 함수 (타이머에서 호출)
  // 디버깅 페이지에서 주로 활용
  //--------------------------------------------------------------------------
  void taskEvery1sec() {
    //----------------------------------------------------------------------
    // 초당 평균 전송속도 계산
    if (bpsAverage == 0) {
      bpsAverage = byteCount * 8;
    } else {
      bpsAverage = (bpsAverage * gamma) + (byteCount * 8 * (1 - gamma));
    }
    //------------------------------
    // 초당 샘플 수 (직관 목적 계산)
    samplePerSec = bpsAverage / 13600 * 500;
    //------------------------------
    // 값 초기화
    byteCount = 0;

    //----------------------------------------------------------------------
    // 확실하게 끊어짐 (일단 장비의 disconnect 메시지로만 판단)
    // 통신속도로 체크하는것은 나중이 필요 시 검토 (221024)

    //---------------------------------------------------
    // 패킷 에러율 계산
    if (packetErrorAverage == 0) {
      packetErrorAverage = packetError.toDouble();
    } else {
      packetErrorAverage =
          (packetErrorAverage * gamma) + (packetError * (1 - gamma));
    }
    //------------------------------
    // 값 초기화
    packetError = 0;
  }

//---------------------------------------------------
// 블루투스 상태 변경 메소드
// todo : 각 이벤트 발생하는 곳에서 상태를 변경하는 방법 1차 시도 검토
//---------------------------------------------------
// void changeBtState(EmaBtState currentBtState) {
// int d = 0;
// // 이전 연결 장비 정보가 있는가?  gv.bleManager[0].bleAdaptor.recentDevice
// bool existRecentDevice = (gv.bleManager[d].bleAdaptor.recentDevice != null);
// // 현재 연결 되어 있는가? gv.bleManager[0].bleAdaptor.device1 또는  gv.bleManager[0].bleAdaptor.wvDevice1
// bool isConnected = (gv.bleManager[d].bleAdaptor.wvReactiveDevice.value != null);
// // 자동 연결 설정이 되어있는가?  gv.setting.isBluetoothAutoConnect.value
// bool isAutoConnection = gv.setting.isBluetoothAutoConnect.value;
// // 스캔 중인가? gv.bleManager[0].bleAdaptor.wvIsScanning.value

// switch (currentBtState) {
//   case EmaBtState.idle:
//     break;
//   case EmaBtState.connectedDis:
//     break;
//   case EmaBtState.connectedEn:
//     break;
//   case EmaBtState.scan:
//     break;
//   case EmaBtState.scanFirst:
//     break;
// }

//   if (existRecentDevice) {
//     if (isAutoConnection) {
//       if (isConnected) {
//         btState.value = EmaBtState.connectedEn;
//       }else{
//         btState.value = EmaBtState.connectIdle;
//       }
//     } else {
//       if(isConnected){
//         btState.value = EmaBtState.connectedDis;
//       }
//       else{
//         if(gv.bleManager[0].bleAdaptor.wvIsScanning.value){
//           btState.value = EmaBtState.scan;
//         }else{
//           btState.value = EmaBtState.idle;
//         }
//
//       }
//
//     }
//   } else {
//     if (gv.bleManager[0].bleAdaptor.wvIsScanning.value == true) {
//       btState.value = EmaBtState.scanFirst;
//     } else {
//       btState.value = EmaBtState.scanFirst;
//     }
//   }
// }
// }
}
