import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 디바이스 정보
// 총 72Byte 이며, 1초 주기로 장비에서 전송 함
//==============================================================================
// var fitsigDeviceAck = List<FitsigDeviceAck>.generate(
//     GvDef.maxDeviceNum, (index) => FitsigDeviceAck());

class FitsigDeviceAck {
  final int deviceIndex;

  FitsigDeviceAck({required this.deviceIndex});

  int productId = 0; //2B, FS-100 = 100
  int qnFwVersion = 0;

  // 4B, hexa 로 해석, 0x10000002 = version 1000.0002
  // OTA 업데이터 목적으로 활용
  int hwVersion = 0; //3B
  int mspVersion = 0; // 2B
  double batteryVoltage = 0; //3B  -> 활용
  Rx<double> usbVoltage = 0.0.obs; //2B  -> 활용
  double waterVoltage = 0; //2B  -> 활용
  int temperature = 0; //1B  -> 활용

  FitsigDeviceStateMsp mspState = FitsigDeviceStateMsp(); //1B
  FitsigDeviceStateError errorState = FitsigDeviceStateError(); //1B

  int batteryState = 0; //1B
  int batteryCapacity = 0; //1B (0~100%) -> 활용
  Rx<int> rssi = 0.obs; //디바이스가 감지하는 RSSI
  int bps = 0; //디바이스에서 계산한 전송 속도
  int sentPackets = 0; //보낸 패킷 수
  int failPackets = 0; //실패한 패킷 수
  int skipPackets = 0; //못보낸 패킷 수
  List<int> macAddress = []; //6B, 블루투스 MAC address - 시리얼 넘버로 사용 검토
  int bootCount = 0; //부팅 횟수 (BOR 전송하면 0이 됨)
  int serialNumber = 0; // 4B 시리얼 번호
  int productYear = 0; // 3B 제조년월 (년)
  int productMonth = 0; // 3B 제조년월 (월)
  int productDay = 0; // 3B 제조년월 (일)
  int packageNumber = 0;  // 패키지넘버 (0:패키지넘버 정의전 나간 제품 & basic 패키지, 77:pro 패키지, 99:ultra 패키지



  List<int> reserved = []; //9B, 예비 용도
  int deviceNumber =
      0; //디바이스 번호 (디바이스가 앱으로부터 명령을 받았는지 확인하는 용도, 값이 0일 경우 100으로 응답)
  int commandFeedBackMeasurement = 0; // (장치가 가지고 있는) 측정 상태
  int commandFeedBackScreen = 0; // (장치가 가지고 있는) 앱 스크린 상태
  int commandFeedBackAttach = 0; // (장치가 가지고 있는) 장비 부착상태
  int powerOffInfo =
      0; // 정상 전원꺼짐 여부 0x00=비정상 전원꺼짐, 0x33=베터리 부족 전원꺼짐, 0x77=버튼에 의한 정상 전원꺼짐

  // device 와 disconnect 되면 모든 field(변수)들을 초기화 시킬 필요가 있어서 만든 함수
  void init() {
    productId = 0; //2B, FS-100 = 100
    qnFwVersion = 0;

    // 4B, hexa 로 해석, 0x10000002 = version 1000.0002
    // OTA 업데이터 목적으로 활용
    hwVersion = 0; //3B
    mspVersion = 0; // 2B
    batteryVoltage = 0; //3B  -> 활용
    usbVoltage.value = 0; //2B  -> 활용
    waterVoltage = 0; //2B  -> 활용
    temperature = 0; //1B  -> 활용

    mspState = FitsigDeviceStateMsp(); //1B
    errorState = FitsigDeviceStateError(); //1B

    batteryState = 0; //1B
    batteryCapacity = 0; //1B (0~100%) -> 활용
    rssi.value = 0; //디바이스가 감지하는 RSSI
    bps = 0; //디바이스에서 계산한 전송 속도
    sentPackets = 0; //보낸 패킷 수
    failPackets = 0; //실패한 패킷 수
    skipPackets = 0; //못보낸 패킷 수
    macAddress = []; //6B, 블루투스 MAC address - 시리얼 넘버로 사용 검토
    bootCount = 0; //부팅 횟수 (BOR 전송하면 0이 됨)
    serialNumber = 0; // 4B 시리얼 번호
    productYear = 0; // 3B 제조년월 (년)
    productMonth = 0; // 3B 제조년월 (월)
    productDay = 0; // 3B 제조년월 (일)
    reserved = []; //9B, 예비 용도
    deviceNumber = 0; // 앱과 연결시 앱으로부터 할당 받은 디바이스 번호
    powerOffInfo = 0;
  }

  //----------------------------------------------------------------------------
  // 디바이스 정보 읽기
  //----------------------------------------------------------------------------
  void readDeviceInfo(List<int> data) {
    int add = 0;
    //---------------------첫 제품은 0x100
    add = 0;
    productId = (data[add] << 8) + data[add + 1];
    add = 2;
    qnFwVersion = (data[add] << 24) +
        (data[add + 1] << 16) +
        (data[add + 2] << 8) +
        data[add + 3];

    // FW version 은 4 bytes 구성되어있는데, 첫번째 byte 에 hex 값으로 01 가 입력되서, mask 를 이용해서 하위 2byte 만 사용
    String fwVersionMask = '0000FFFF';
    int fwVersionMaskAsInt = int.parse(fwVersionMask, radix: 16);
    qnFwVersion = qnFwVersion & fwVersionMaskAsInt;

    add = 6;
    hwVersion = (data[add] << 16) + (data[add + 1] << 8) + data[add + 2];
    add = 9;
    mspVersion = (data[add] << 8) + data[add + 1];
    //---------------------각종 전압 (volt)
    add = 11;
    batteryVoltage = ((data[add] << 8) + data[add + 1]) * 0.001;
    add = 13;
    usbVoltage.value = ((data[add] << 8) + data[add + 1]) * 0.001;
    add = 15;
    waterVoltage = ((data[add] << 8) + data[add + 1]) * 0.001;
    //---------------------온도 32 = 32도
    add = 17;
    temperature = data[add];
    //---------------------msp 상태
    add = 18;
    int tmp = data[add];
    mspState.chargeEnable = ((tmp >> 6) & 1 == 1) ? true : false;
    mspState.buttonTouch = ((tmp >> 5) & 1 == 1) ? true : false;
    mspState.isCharging = ((tmp >> 4) & 1 == 1) ? true : false;
    mspState.chargeStatus = (tmp >> 2) & 0x3;
    mspState.isWaterWet = ((tmp >> 1) & 1 == 1) ? true : false;
    mspState.isUsbConnected = (tmp & 1 == 1) ? true : false;
    //---------------------에러 상태
    add = 19;
    tmp = data[add];
    errorState.isError = (tmp & 1 == 1) ? true : false;
    errorState.isBoardError = ((tmp >> 1) & 1 == 1) ? true : false;
    errorState.isTempOver45Degree = ((tmp >> 2) & 1 == 1) ? true : false;
    errorState.isWaterChargeDisable = ((tmp >> 3) & 1 == 1) ? true : false;
    //---------------------QN 판단 배터리 상태 (0 = full, 1 = normal, 2 = low, 3 = very low, 4 = off)
    add = 20;
    batteryState = data[add];
    //---------------------배터리 용량 (100 = 100%)
    add = 21;
    if (gv.deviceStatus[0].batteryCapacity.value != data[add]) {
      gv.deviceStatus[0].batteryCapacity.value = data[add];
    }
    batteryCapacity = data[add];
    //---------------------RSSI (40 = -40)
    add = 22;
    rssi.value = data[add] - 256; //값을 빼야 정상?
    //---------------------BPS
    add = 23;
    bps = (data[add] << 24) +
        (data[add + 1] << 16) +
        (data[add + 2] << 8) +
        data[add + 3];
    //---------------------보낸 패킷 수
    add = 27;
    sentPackets = (data[add] << 8) + data[add + 1];
    //---------------------실패 패킷 수
    add = 29;
    failPackets = (data[add] << 8) + data[add + 1];
    //---------------------스킵 패킷 수
    add = 31;
    skipPackets = (data[add] << 8) + data[add + 1];
    //--------------------- Mac address
    add = 33;
    macAddress = data.sublist(add, add + 6);
    //---------------------boot count
    add = 39;
    bootCount = (data[add] << 24) +
        (data[add + 1] << 16) +
        (data[add + 2] << 8) +
        data[add + 3];
    //---------------------serial number (4B)
    add = 43;
    serialNumber = (data[add] << 24) +
        (data[add + 1] << 16) +
        (data[add + 2] << 8) +
        data[add + 3];
    //print('fitsig_device_ack.dart :: serialNumber = $serialNumber' );
    //---------------------product year(1B)
    add = 47;
    productYear = data[add];
    //---------------------product month(1B)
    add = 48;
    productMonth = data[add];
    //---------------------product month(1B)
    add = 49;
    productDay = data[add];

    //--------------------- encoded package number
    add = 50;
    int encodedPackageNumber = data[add];
    int residual = encodedPackageNumber - (serialNumber&0xff);
    if(residual < 0){
      packageNumber = residual +256;
    }else {
      packageNumber = residual;
    }

    //--------------------- QN memory reserved
    add=51;
    macAddress = data.sublist(add, add + 2);
    //--------------------- device number
    add = 53;
    deviceNumber = data[add];
    //--------------------- command feedback
    add = 54;
    commandFeedBackMeasurement = (data[add] & 0x01);
    commandFeedBackScreen = (data[add] & 0x02) >> 1;
    commandFeedBackAttach = (data[add] & 0x0c) >> 2;
    //--------------------- 정상 전원 꺼짐 여부
    add = 55;
    powerOffInfo = (data[add]);

    // if(EmlDeviceNumber.device1.index + 1 == deviceNumber) {
    //--------------------------------------------------------------------------
    // 장비 번호 확인 = 디바이스가 명령을 잘 받았음을 의미 함
    //--------------------------------------------------------------------------
    if (deviceIndex + 1 == deviceNumber) {
      gv.deviceStatus[deviceIndex].isAppConnected.value = true;
    } else {
      gv.deviceStatus[deviceIndex].isAppConnected.value = false;
    }

    if (mspState.isCharging == true) {
      gv.deviceStatus[deviceIndex].isDeviceIsCharging.value = true;
    } else {
      gv.deviceStatus[deviceIndex].isDeviceIsCharging.value = false;
    }

    // 수신 받은 메세지의 powerOffInfo 값이 0x77 일 경우, 버튼에 의한 전원 꺼짐을 의미
    if (powerOffInfo == 0x77) {
      print('fitsig_device_ack ::  버튼에 의한 전원 꺼짐 메세지 수신');
      powerOffFitsig();
    }
  }

  Future<void> powerOffFitsig() async {
    await BleManager.devicePowerOff(deviceIndex: deviceIndex); //디바이스 전원끄기
    await Future.delayed(const Duration(milliseconds: 200)); //명령전달 시간 잠시 대기
    await gv.btStateManager[deviceIndex].disconnectCommand(); //연결 해제
    Future.delayed(const Duration(milliseconds: 100));
  }
}

//==============================================================================
// MSP 상태
//==============================================================================
class FitsigDeviceStateMsp {
  bool chargeEnable = false;
  bool buttonTouch = false;
  bool isCharging = false;
  int chargeStatus =
      0; //(00) can’t detect (충전중) (01) low power <20% (10) normal (11) full >80%
  bool isWaterWet = false;
  bool isUsbConnected = false;
}

//==============================================================================
// 에러 상태
//==============================================================================
class FitsigDeviceStateError {
  bool isError = false;
  bool isBoardError = false;
  bool isTempOver45Degree = false; //보드 내부 온도 45도 초과
  bool isWaterChargeDisable = false; //물기 감지로 충전 안되는 상황
}
