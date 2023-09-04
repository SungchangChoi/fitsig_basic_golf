import '/F0_BASIC/common_import.dart';

// 전역변수로 dsp module 생성
late List<DspModule> dm; //dsp module
// callback 함수 생성
late List<DspCallback> _dspCallback;

//==============================================================================
// DSP 제어
//==============================================================================
class DspManager {
  //----------------------------------------------------------------------------
  // 제어 변수
  //----------------------------------------------------------------------------
  //-------------------- 상태관리 변수
  static Rx<EmlStateMeasure> stateMeasure = EmlStateMeasure.idle.obs; //측정 상태
  static bool isMeasureOnScreen = false; // 스크린 상 측정 중인지 체크 - 애니메이션 에러 막을 목적

  //-------------------- 종합 측정 시간, 세트 측정 시간
  static RxInt timeMeasure = 0.obs; //측정시간
  static RxInt timeMeasureSet = 0.obs; //현재 세트 측정 시간
  static RxInt timeMeasureRest = 0.obs; //휴식시간
  static DateTime startTime = DateTime(0);
  static DateTime endTime = DateTime(0);
  //--------------------휴식시간 표시 관리
  static RxInt timeSetRelax = 0.obs; //운동 종료 후 휴식시간
  static int idxMuscleRelax = 0; //휴식시간이 설정 된 근육 index

  //----------------------------------------------------------------------------
  // 실시간 레포트
  //----------------------------------------------------------------------------
  static bool enableRtDataReport = true ;  // 측정 데이터 실시간 파일로 출력 여부 설정
  static int rtRawDataBufferingUnitLength = 500; // 1초에 500개 샘플(1개 패킷에 20개 샘플) (afe 데이터용)
  static int rtEmgDataBufferingUnitLength = 25; // 1초에 25개 패킷(emg 데이터용)
  static late DspRtReportData rtReportData;


  //-------------------- 개별 디바이스 종료여부 체크
  static List<bool> isMeasureComplete =
      List<bool>.generate(GvDef.maxDeviceNum, (index) => false);

  //-------------------- 세트 번호 (다중세트 운동 시 설정 필요. 1세트 = 0)
  static RxInt numOfSet = 0.obs;

  //-------------------- timer
  static late Timer timer; //1초 단위 증가

  //-------------------- bluetoothToDsp 호출 카운터 (장비별로 count)
  // static List<int> bluetoothToDspCnt =
  //     List<int>.generate(GvDef.maxDeviceNum, (_) => 0);

  //----------------------------------------------------------------------------
  // 장비 숫자만큼 dsp module 초기화
  //----------------------------------------------------------------------------
  static initModule() {
    //--------------------------------------------------------------------------
    // 파리미터 사전 설정 (그래프 길이 제외 나머지 사후 설정 가능)
    //--------------------------------------------------------------------------
    //-----------------------------------
    // 그래프 길이 - 사전 설정 필수
    DspCommonParameter.rtGraphLen = 1; //250; //40ms 주기, 250 = 10초
    DspCommonParameter.rtRawDataGraphLen = 1; //5000; // 2ms 주기, 5000 = 10초
    //-----------------------------------
    // 버퍼 관련 부 설정 (기본 값은 모두 false)
    DspCommonParameter.enableAdcDataRtGraph = false; //ADC 와 AFE 그래프
    DspCommonParameter.enableAdcDataSave = false; //ADC 저장
    DspCommonParameter.enableAfeDataRtGraph =true; //AFE 그래프
    DspCommonParameter.enableAfeDataSave = true; //AFE 저장
    DspCommonParameter.enableEmgDataRtGraph = false; //그래프는 앱에서
    DspCommonParameter.enableEmgDataSave = true; //상세 근전도 데이터
    DspCommonParameter.enableEcg = true; //심전도 가능하게
    //-----------------------------------
    // 국가 관련
    DspCommonParameter.electricFreqType = 0; //국가별 설정, 0 = 60Hz, 1 = 50Hz
    DspCommonParameter.setElectricFreqType(); //필터 변환
    //-----------------------------------
    // 최대근력 제어 관련
    DspCommonParameter.enableAuto1RmRt = true; //자동 1RM은 enable 이 기본
    DspCommonParameter.enableAuto1RmEmgMax = true; //더 큰 EMG가 들어 온 경우
    DspCommonParameter.enableAuto1RmCount = true; //카운트 값으로 자동 1RM 수행
    DspCommonParameter.enableAuto1RmTime = false; //시간 값으로 자동 1RM 수행 (계산양 오래 걸려 실시간은 안함)
    DspCommonParameter.enableAuto1RmHist = true; //히스토그램-시간 값으로 자동 1RM 수행
    DspCommonParameter.enableAuto1RmAoeFull = false; //운동량 값으로 자동 1RM 수행
    //-----------------------------------
    // 운동 제어 관련
    DspCommonParameter.setNumberPlanned = 1; //운동할 세트 수
    DspCommonParameter.targetPRange = 7; // 목표 인정 범위
    DspCommonParameter.targetPPerfect = 3; //퍼펙트 인정 범위
    //--------------------------------------------------------------------------
    // 콜백 함수 클래스 생성
    //--------------------------------------------------------------------------
    _dspCallback = List<DspCallback>.generate(
        GvDef.maxDeviceNum, (index) => DspCallback(deviceIndex: index));
    //--------------------------------------------------------------------------
    // DSP 모듈 생성
    //--------------------------------------------------------------------------
    dm = List<DspModule>.generate(
        GvDef.maxDeviceNum,
        (index) => DspModule(
              electricFreq: 0, //60Hz, 50Hz 모두 노치필터로 제거 (국가 옵션 없애기)
              // 제어관련 통합 응답 콜백
              callbackControlAck: _dspCallback[index].callbackControlAck,
              //40ms 주기
              callbackFast: _dspCallback[index].callbackFast,
              //0.5~1초 주기
              callbackSlow: _dspCallback[index].callbackSlow,
              //목표 근접
              callbackAlmostTarget: _dspCallback[index].callbackAlmostTarget,
              //카운트 발생 (반복운동 감지)
              callbackCountRt: _dspCallback[index].callbackCountRt,
              callbackCountDelay: _dspCallback[index].callbackCountDelay,
              //최대근력 실시간 갱신
              callback1RmRtUpdate: _dspCallback[index].callback1RmRtUpdate,
              //게이지 값
              callbackGauge: _dspCallback[index].callbackGauge,
              //예외 상황 발생
              callbackException: _dspCallback[index].callbackException,
            )); //편의 상 전역 변수화

    //--------------------------------------------------------------------------
    // DSP 초기화 함수 실행
    //--------------------------------------------------------------------------
    for (int d = 0; d < GvDef.maxDeviceNum; d++) {
      dm[d].initSystem();
    }

    rtReportData = DspRtReportData();
  }

  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  // 블루투스 연결/해제
  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  //----------------------------------------------------------------------------
  // 블루투스 연결 시 실행 - 장비별
  //----------------------------------------------------------------------------
  static whenBluetoothConnected(int deviceIndex) {
    dm[deviceIndex].whenBluetoothConnected();

    //---------------------------------------------
    // 이전에 연결된 장비가 없을 경우에만 그래프 버퍼 초기화
    int notConnectedDeviceNum = 0;
    for (int n = 0; n < GvDef.maxDeviceNum; n++) {
      if (gv.deviceStatus[0].isDeviceBtConnected.value == false) {
        notConnectedDeviceNum++;
      }
    }
    // if (notConnectedDeviceNum == GvDef.maxDeviceNum) GvDsp.init(); //개별 장비 변수 초기화
  }

  //----------------------------------------------------------------------------
  // 블루투스 해제 시 실행 - 장비별
  //----------------------------------------------------------------------------
  static whenBluetoothDisconnected(int deviceIndex) {
    // keyDeviceLinkIcon.currentState?.refresh(); //상단 장비 아이콘 표시 변경
    dm[deviceIndex].whenBluetoothDisconnected();
  }

  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  // DSP 제어
  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

  //----------------------------------------------------------------------------
  // 측정 시작 명령 - 조건이 맞아야 측정 시작 가능
  //----------------------------------------------------------------------------
  static bool commandMeasureStart(BuildContext context) {
    // 장비 전체적으로 측정 시작 가능 여부 체크
    bool isMeasureStartEnableTotally =
        checkIsEnableMeasureStartTotally(context);
    if (isMeasureStartEnableTotally) {
      // 측정 시작관련 파라미터 갱신
      // measureParameterUpdate();
      measureTaskInit(); //측정 시간관리 태스크 시작
      startTime = DateTime.now();
      stateMeasure.value = EmlStateMeasure.onMeasure; //상태 기록
      // 각 장비별 측정 조건 체크 후 시작 명령
      for (int d = 0; d < GvDef.maxDeviceNum; d++) {
        // 개별 장비 측정 시작 가능한지 조건 체크
        if (checkIsEnableMeasureStart(d) == true) {
          gv.deviceData[d].initData(); //디바이스 데이터 초기화
          dm[d].commandMeasureStart(); //시작 명령 실행

          // 장비에게 측정을 시작함을 알림
          BleManager.notifyMeasurementState(isMeasuring: true);
          // print('dsp_module_manager.dart :: commandMeasureStart() : 측정을 시작하여 장비에게 측정 상태 정보를 전송합니다.');
        }
      }
    }
    return isMeasureStartEnableTotally;
  }

  //----------------------------------------------------------------------------
  // 측정 중지
  //----------------------------------------------------------------------------
  static commandMeasureHold() {
    stateMeasure.value = EmlStateMeasure.onHold; //상태 기록
    for (int d = 0; d < GvDef.maxDeviceNum; d++) {
      if (checkIsEnableMeasureControl(d) == true) {
        dm[d].commandMeasureHold();
      }
    }
  }

  //----------------------------------------------------------------------------
  // 측정 재 시작
  //----------------------------------------------------------------------------
  static commandMeasureRestart() {
    stateMeasure.value = EmlStateMeasure.onMeasure; //상태 기록
    for (int d = 0; d < GvDef.maxDeviceNum; d++) {
      if (checkIsEnableMeasureControl(d) == true) {
        dm[d].commandMeasureRestart();
      }
    }
  }

  //----------------------------------------------------------------------------
  // 세트 종료
  //----------------------------------------------------------------------------
  static commandSetComplete() {
    stateMeasure.value = EmlStateMeasure.onRest; //상태 기록
    for (int d = 0; d < GvDef.maxDeviceNum; d++) {
      if (checkIsEnableMeasureControl(d) == true) {
        dm[d].commandSetComplete();
      }
    }
  }

  //----------------------------------------------------------------------------
  // 세트 시작
  //----------------------------------------------------------------------------
  static commandSetStart() {
    stateMeasure.value = EmlStateMeasure.onMeasure; //상태 기록
    for (int d = 0; d < GvDef.maxDeviceNum; d++) {
      if (checkIsEnableMeasureControl(d) == true) {
        dm[d].commandSetStart();
      }
    }
    numOfSet++; //세트 번호 증가
    timeMeasureSet.value = 0; //세트 타이머 초기화
  }

  //----------------------------------------------------------------------------
  // 측정 종료 (=운동 종료)
  //----------------------------------------------------------------------------
  static commandMeasureComplete() {
    stateMeasure.value = EmlStateMeasure.complete; //상태 기록
    for (int d = 0; d < GvDef.maxDeviceNum; d++) {
      if (checkIsEnableMeasureControl(d) == true) {
        dm[d].commandMeasureComplete();

        // 장비에게 측정을 종료함을 알림
        BleManager.notifyMeasurementState(isMeasuring: false);
        // print('dsp_module_manager.dart :: commandMeasureComplete() : 측정이 종료되어 장비에게 측정 상태 정보를 전송합니다.');
        if (kDebugMode) {
          print('dsp_module_manager.dart :: ($d)장비 -> 정상적 종료명령 실행');
        }
      } else {
        if (kDebugMode) {
          print('dsp_module_manager.dart :: ($d)장비 -> 비 정상적 종료');
        }
      }
    }
    measureTaskComplete(); //측정 시간관리 태스크 종료
  }

  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  // 파라미터
  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

  //----------------------------------------------------------------------------
  // 최대근력 갱신 - 장비별
  //----------------------------------------------------------------------------
  static update1Rm({
    required int deviceIndex,
    double value = 0.1,
  }) {
    dm[deviceIndex].update1Rm(value);
  }

  //----------------------------------------------------------------------------
  // 1RM RT 업데이트 - 장비별
  // 1RM 값을 변경 한 후에 실행
  //----------------------------------------------------------------------------
  static update1RmRt({
    required int deviceIndex,
    double value = 0.1,
  }) {
    if (DspCommonParameter.enableAuto1RmRt == false) {
      dm[deviceIndex].g.parameter.mvcRefRt =
          dm[deviceIndex].g.parameter.mvcRef;
      dm[deviceIndex].g.parameter.updateParameterRt();
    } else {
      dm[deviceIndex].g.parameter.mvcRefRt = value; //gv.dsp.default1RmRtInit;
      dm[deviceIndex].g.parameter.updateParameterRt();
    }
  }

  //----------------------------------------------------------------------------
  // 목표 갱신 - 장비별
  //----------------------------------------------------------------------------
  static updateTargetP1Rm({
    required int deviceIndex,
    double value = 70,
  }) {
    dm[deviceIndex].updateTargetP1Rm(value);
  }

  //----------------------------------------------------------------------------
  // 완벽 성공 범위 범위 갱신 - 장비별
  //----------------------------------------------------------------------------
  static updatePerfectP1Rm({
    required int deviceIndex,
    double value = 3,
  }) {
    dm[deviceIndex].updatePerfectP1Rm(value);
  }

  //----------------------------------------------------------------------------
  // 목표성공 범위 범위 갱신 - 장비별
  //----------------------------------------------------------------------------
  static updateTargetP1Range({
    required int deviceIndex,
    double value = 7,
  }) {
    dm[deviceIndex].updateTargetP1Range(value);
  }

  //----------------------------------------------------------------------------
  // 입력단 IIR HPF 값 조절 - 30Hz 이상 해야 심박 억제됨
  // 0.1, 1, 3, 5, 10, 15, 20, 25, 30, 35, 40
  //----------------------------------------------------------------------------
  static updateDcIirHpf({
    required int deviceIndex,
    EmlDcIirHpf value = EmlDcIirHpf.fc30, //30Hz 기본
  }) {
    dm[deviceIndex].updateDcIirHpf(value);
  }

  //----------------------------------------------------------------------------
  // 파워평균필터 길이 조절 (전체 디바이스 공통 적용)
  //----------------------------------------------------------------------------
  static updateMlWinLen({
    int value = 250, //250 = 0.5초
  }) {
    DspCommonParameter.mlWinSize = value;
    DspCommonParameter.mlWinSizeRt = value;
  }

  //----------------------------------------------------------------------------
  // 파워평균 필터 LPF 값 조절 - 1Hz는 느리고 안정적 5Hz는 빠르지만 거침
  // 0.5, 0.7, 1, 2, 3, 4, 5
  //----------------------------------------------------------------------------
  static updateMlIirLpf({
    required int deviceIndex,
    EmlMlIirLpf value = EmlMlIirLpf.fc3, //3Hz 기본
  }) {
    dm[deviceIndex].updateMlIirLpf(value);
  }

  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  // 기타  (예외처리 등)
  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

  //----------------------------------------------------------------------------
  // 외부 예외처리 명령 (명령시점 전후로 약 3초간 데이터 clear 처리)
  // 블루투스 통신 불량 등의 상황에서 예외처리 수행
  //----------------------------------------------------------------------------
  static setExternalException({
    required int deviceIndex,
  }) {
    dm[deviceIndex].setExternalException();
  }

  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  // dsp 입력 - 장비별
  //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  static bluetoothToDsp(int deviceIndex, List<int> data) {
    int d = deviceIndex;

    //blutetoothToDsp 가 호출 될때마다 1씩 증가 (장비명령, 측정 data 모두 포함하는 counter)
    // gv.bleManager[d].bluetoothToDspCnt++;

    //---------------------------------------------
    // MTU 길이 설정 긴 길이(20byte) 데이터 들어오면 무시 (MTU가 반영 안된 초기 데이터)
    if (data.length <= 20) {
      return;
    }

    //---------------------------------------------
    // 1초 마다 오는 장비 명령 (배터리 용량 등)
    if (data[4] != 92) {
      BleManager.fitsigDeviceAck[d].readDeviceInfo(data.sublist(8));
      //이 구문이 실행되기전에 otaFileVersion 이 메모리에 로딩되기 전일 때가 있었음 그래서 otaFileVersion 이 null 인지 check
      // if (gv.bleManager[d].isBtConnectedReal[deviceIndex].value ==
      //         true
      if (bt[deviceIndex].bleDevice.isBtConnectedReal.value == true && bt[deviceIndex].bleDevice.isCheckedFw == false) {
        dvSetting.compareFwVersion(); // 펌웨어 버전 비교(매번 할필요 없지만, 넣을 만한 곳을 못찾음)
        bt[deviceIndex].bleDevice.isCheckedFw = true;
      }
      return;
    }
    //---------------------------------------------
    // 패킷 데이터 저장 (디버깅용)
    gv.deviceStatus[d].packetByte = data;
    //---------------------------------------------
    // 패킷 넘버 (4B)
    gv.deviceStatus[d].packetNumber =
        data[3] << 24 | data[2] << 16 | data[1] << 8 | data[0];
    // 패킷 넘버 체크 : 전송속도 및 에러 계산
    gv.deviceStatus[d].checkPacketNumber();
    // print('dsp_module_manager :: gv.deviceStatus[$d].cntPacket = ${gv.deviceStatus[d].cntPacket}');
    // print('d$d ${gv.deviceStatus[0][d].byteCount} ${gv.deviceStatus[0][d].packetNumber}');
    //---------------------------------------------
    //ADS129x 디바이스 (1B) ADS1292 = 92
    gv.deviceStatus[d].adsDeviceId = data[4];

    //---------------------------------------------
    // ADS1292 status (3B)
    // 1100 + LOFF_STAT[4:0] + GPIO[1:0] + 13's0
    // 1 = connected [b4] RLD [b3] IN2N [b2]IN2P [b1]IN1N b0]IN1P
    // b3 IN2N은 GND로 연결되어 항상 연결될 것처럼 1로 뜨는 듯
    gv.deviceStatus[d].adsStatus = data[7] << 16 | data[6] << 8 | data[5];

    //--------------------------------------------------------------------------
    // ADS1292 CH1 data 추출 (20개 읽어서 리스트 저장)
    // 패킷 입력 데이터 (3B x 20 = 60B)
    // CH1 data : 3B x 20 = 20 sample, MSB first
    // CH2는 1차 상용버전에서 적용 안함
    //--------------------------------------------------------------------------
    var dspInCh1 = List<int>.generate(
        DefFs100V1.packetDataLen, (index) => 0); //DSP 모듈 입력 CH1 데이터
    var dspInCh2 = List<int>.generate(
        DefFs100V1.packetDataLen, (index) => 0); //DSP 모듈 입력 CH2 데이터
    double dspOut = 0; //DSP 모듈 출력

    int idx = 8;
    for (int n = 0; n < DefFs100V1.packetDataLen; n++) {
      dspInCh1[n] = data[idx] << 16 | data[idx + 1] << 8 | data[idx + 2];
      // dspInCh2[n] = data[idx + 3] << 16 | data[idx + 4] << 8 | data[idx + 5];
      idx = idx + 3; //1샘플 = 3 byte 건너뛰기
    }

    //--------------------------------------------------------------------------
    // dsp 블록으로 데이터 전달
    //--------------------------------------------------------------------------
    dm[d].dspStreamInput(dspInCh1, dspInCh2);
  }
}

//==============================================================================
// DSP 사용 예
//==============================================================================

// void exampleDspModule() {
//   int d = 0;
//
//   //-----------------------------------------
//   // 최대근력
//   //-----------------------------------------
//   //--------------- 1Rm 업데이트 방법 1
//   dm[d].g.parameter.mvcRef = 0.7; //mV로 변환 저장
//   dm[d].g.parameter.updateParameter();
//   //--------------- 1Rm 업데이트 방법 2
//   dm[d].update1Rm(deviceIndex: 0, value: 0.7);
//
//   //-----------------------------------------
//   // 목표
//   //-----------------------------------------
//   //--------------- 1Rm 업데이트 방법 1
//   dm[d].g.parameter.targetP1Rm = 70; //mV로 변환 저장
//   dm[d].g.parameter.updateParameter();
//   //--------------- 1Rm 업데이트 방법 2
//   dm[d].updateTargetP1Rm(deviceIndex: 0, value: 70);
//
//   //-----------------------------------------
//   // 목표영역
//   //-----------------------------------------
// }

//==============================================================================
// 실시간 리포트용 데이터
// 데이터 길이는 afe 데이터 1000개, emg 데이터 50개
//==============================================================================
class DspRtReportData {
  RxBool isDataAvailable= false.obs;
  List<double> afeOutBuff = [];
  List<double> emgOutBuff = [];

  //------------------------------------------------------------
  // 초기화
  //------------------------------------------------------------
  void init() {
    afeOutBuff = [];
    emgOutBuff = [];
    isDataAvailable.value = false;
  }

  //------------------------------------------------------------
  // 파일 저장 용도로 출력할 만큼의 데이터가 쌓였는지 확인하느 메서드
  // 데이터 입력 할 때마다 실행하면 되려나? 어느 데이터? afe? emg?
  //------------------------------------------------------------
  void checkAvailability({int seconds = 2}){
    int requestedAfeDataLength = seconds * DspManager.rtRawDataBufferingUnitLength;
    int requestedEmgDataLength = seconds * DspManager.rtEmgDataBufferingUnitLength;
    if(afeOutBuff.length > requestedAfeDataLength && emgOutBuff.length > requestedEmgDataLength){
      isDataAvailable.value = true;
    }
  }

  //------------------------------------------------------------
  // 데이터 호출 메서드 - 요청한 시간에 해당하는 동안의 데이터를 반환
  //------------------------------------------------------------
  List<List<double>> getRtData({int seconds = 2}) {
    List<List<double>> result = [];
    int requestedAfeDataLength = seconds * DspManager.rtRawDataBufferingUnitLength;
    int requestedEmgDataLength = seconds * DspManager.rtEmgDataBufferingUnitLength;
    if(isDataAvailable.value == true){
      result.add(afeOutBuff.sublist(0, requestedAfeDataLength));
      afeOutBuff = afeOutBuff.sublist(requestedAfeDataLength);
      result.add(emgOutBuff.sublist(0, requestedEmgDataLength));
      emgOutBuff = emgOutBuff.sublist(requestedEmgDataLength);
      isDataAvailable.value = false;
    }
    return result;
  }
}