import '/F0_BASIC/common_import.dart';

//==============================================================================
// 디바이스별 제어 (장비별 제어가 필요한 경우)
//==============================================================================
class GvDeviceControl {
  //----------------------------------------------------------------------------
  // 생성자
  //----------------------------------------------------------------------------
  final int deviceIndex;
  GvDeviceControl({required this.deviceIndex});
  //----------------------------------------------------------------------------
  // 데모신호 관련
  //----------------------------------------------------------------------------
  // bool isEnableEachDemoSignal = false; //세팅 변수 1개만 사용할 목적으로 주석처리! (혼돈 유발)
  double signalMagnitude = 1; //mV
  double signalPeriod = 1.6; //초
  double signalOffset = 0; //mV

  // GvDeviceControl(this.deviceNumber):deviceNumberAsInt = deviceNumber.index+1;
  //----------------------------------------------------------------------------
  // 디바이스 control packet data 를 구성하는 변수
  //----------------------------------------------------------------------------
  // EmlDeviceNumber deviceNumber;
  int id = 0xD0;          // 500Hz 40ms (Address: 0)
  // int deviceNumberAsInt = 0;  // 장치 번호 (Address: 1)
  int wearIndex = 0;      // 착용상태 (Address: 2)
  int touchTime = 15 ;     // 터치 버튼 종료 시간  (Address: 3)
  bool isSavingMode = false;  // 절약 모드 (Address:4, [b0])
  bool isLEDBlinking = false; //LED 깜박임 (Address:4, [b1])
  bool isScreenOff = false ;  // 스크린 상태. true: 꺼져있음(pause), false: 켜져있음(active) (Address: 4, [b2])
  bool isMeasuring = false ;  //측정상태, 측정중 = 1  (Address: 5)
  bool isCharging = false; //장비 충전 중 여부
  int bor = 0;            // BOR, 0xA9: 시스템 종료, 0xEF: MSP 시스템 재부팅 (Address: 8)

  // touchTime 변경 메소드
  void changeTouchTime({required int value}) {
    touchTime = value;
  }

  // 스크린 상태 정보 변경 메소드 (꺼져있으면 true, 켜져있으면 false)
  void changeScreenState({required bool value}) {
    isScreenOff = value;
  }

  // 장비 착용 상태 정보 변경 메소드 (미챡용=0, 불안정=1, 정상착용=2)
  void changeDeviceAttachState({required int value}){
    wearIndex = value;
  }

  // 측정 상태 정보 변경 메소드 (정지=0, 측정중=1)
  void changeMeasuringState({required bool value}){
    isMeasuring = value;
  }


  List<int> getControlPacketData() {
    final List<int> _controlPacketData = List.filled(20, 0);

    _controlPacketData[0] = id;
    _controlPacketData[1] = deviceIndex + 1; //장비번호는 + 1
    _controlPacketData[2] = wearIndex;
    _controlPacketData[3] = touchTime;

    if(isSavingMode) {
      _controlPacketData[4] = _controlPacketData[4] | 0x01;
    }else{
      _controlPacketData[4] = _controlPacketData[4] | 0x00;
    }
    if(isLEDBlinking) {
      _controlPacketData[4] = _controlPacketData[4] | 0x02;
    }else{
      _controlPacketData[4] = _controlPacketData[4] | 0x00;
    }
    if(isScreenOff) {
      _controlPacketData[4] = _controlPacketData[4] | 0x04;
    }else{
      _controlPacketData[4] = _controlPacketData[4] | 0x00;
    }

    _controlPacketData[5] = isMeasuring ? 1 : 0;
    _controlPacketData[8] = bor;

    return _controlPacketData;
  }

//----------------------------------------------------------------------------
// 그래프 설정 등 다양한 디바이스별 변수들~
//----------------------------------------------------------------------------
}