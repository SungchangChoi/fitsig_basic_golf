import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 데모신호 주기적 생성
//==============================================================================
// int _cntDemo = 0;

class DemoSignal {
  static late Timer timer;

  //----------------------------------------------------------------------------
  // 데모신호 생성
  //----------------------------------------------------------------------------
  static void startDemoSignal() {
    var dspInCh1 = List<int>.generate(
        DefFs100V1.packetDataLen, (index) => 0); //DSP 모듈 입력 CH1 데이터
    var dspInCh2 = List<int>.generate(
        DefFs100V1.packetDataLen, (index) => 0); //DSP 모듈 입력 CH2 데이터 (사용 안함)

    timer = Timer.periodic(const Duration(milliseconds: 40), (Timer t) {
      for (int d = 0; d < GvDef.maxDeviceNum; d++) {
        //--------------------------------------------------------------------------
        // 디바이스 마다 랜덤 데이터 전송
        if (gv.deviceStatus[d].isDeviceBtConnected.value == false &&
            gv.setting.isEnableDemo.value == true) {
          for (int n = 0; n < DefFs100V1.packetDataLen; n++) {
            int chData = randomSignalGenerator(d);
            dspInCh1[n] = chData;
          }
          dm[d].dspStreamInput(dspInCh1, dspInCh2);
        }
      }
    });
  }

  //----------------------------------------------------------------------------
  // 타이머 해제
  //----------------------------------------------------------------------------
  static stopDemoSignal() {
    timer.cancel();
  }

  //----------------------------------------------------------------------------
  // 랜덤 신호 생성
  //----------------------------------------------------------------------------
  static final List<double> _cntEmgTest =
      List<double>.generate(GvDef.maxDeviceNum, (index) => 0);
  static final _random =
      List<Random>.generate(GvDef.maxDeviceNum, (index) => Random());

  static int randomSignalGenerator(int deviceIndex) {
    int d = deviceIndex;
    double scale = 1.5; //20.5; //1.5;// * 3.5;
    // double fc = 3; //Hz

    //----------------------------------------
    // 채널 별 크기 조절
    scale = scale * gv.deviceControl[d].signalMagnitude;
    // if (d == 1) scale = scale * 0.8;
    // if (d == 2) scale = scale * 1.5;
    // if (d == 3) scale = scale * 0.5;

    //----------------------------------------
    // 랜덤 신호 생성
    double rng = 0;
    double sigCH = 0;

    rng = _random[d].nextDouble() - 0.5; // 0~1 -> -0.5~0.5
    rng = rng * scale;

    double fc = 1 / gv.deviceControl[d].signalPeriod;
    sigCH = sin(fc / DefDsp.fs * _cntEmgTest[d] * pi) *
            rng *
            sin(0.07 / DefDsp.fs * _cntEmgTest[d] * pi + (pi / 10 * d)) +
        gv.deviceControl[d].signalOffset;

    //----------------------------------------
    // 크기 신호 생성
    // ADC_TO_MV = ADC_VOLT_RANGE / ADC_BIT_RESOLUTION / IN_PGA_GAIN;
    // ADC 입력은 -Vref(-8388608) ~ +Vref(8388607) = 24비트
    // +Vref값 2420mV(ADC_VOLT_RANGE)
    // ADC_BIT_RESOLUTION = 8388608 (+Vref 최대 값)
    // IN_PGA_GAIN = 1
    // 1mV = 8388608(2420mV) / 2420 = 3466

    //----------------------------------------
    // INT 로 변경
    int returnData = (sigCH * 3466).toInt();
    if (returnData < 0) returnData = returnData + 16777216;

    _cntEmgTest[d] += 1;

    return returnData;
  }
}
