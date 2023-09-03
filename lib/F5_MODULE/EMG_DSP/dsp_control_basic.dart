import '/F0_BASIC/common_import.dart';

//==============================================================================
// 측정 관리 타이머
//==============================================================================
void measureTaskInit() {
  //--------------------------------------------------------------------------
  // manager 변수 초기화
  DspManager.timeMeasure.value = 0;
  DspManager.timeMeasureSet.value = 0;
  DspManager.timeMeasureRest.value = 0;
  for (int d = 0; d < GvDef.maxDeviceNum; d++) {
    DspManager.isMeasureComplete[d] = false;
  }
  DspManager.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //--------------------------------------------------------------------------
    // 측정 중이라면
    if (DspManager.stateMeasure.value == EmlStateMeasure.onMeasure) {
      DspManager.timeMeasure.value++; //측정 시간
      DspManager.timeMeasureSet.value++; //세트 측정 시간
    }
    //--------------------------------------------------------------------------
    // 휴식 중이라면
    else if (DspManager.stateMeasure.value == EmlStateMeasure.onRest) {
      DspManager.timeMeasureRest.value++; //휴식 시간
    }
  });

  // [Audio Play] 측정 시작시 'start' sound (1회)
  gv.audioManager.play(type: EmaSoundType.measureStart);
}

//==============================================================================
// 측정 종료
//==============================================================================
void measureTaskComplete() {
  DspManager.timer.cancel();
  // 1.5초는 지연경로 대기 시간
  //
  // 500ms 후에 종료 대기 상태로 전환
  // 데이터베이스 저장 시간 등을 종합적으로 고려
  // Future.delayed(const Duration(milliseconds: 1550), (() {
  // }));

  // [Audio Play] 측정 종료시 'end' sound (1회)
  gv.audioManager.play(type: EmaSoundType.measureEnd);
}

//==============================================================================
// 측정 파라미터 갱신 - 설정 등에 의해 변경된 값 반영
//==============================================================================
// void measureParameterUpdate() {
//   //----------------------------------------------------------------------------
//   // 최대근력 자동 초기화 값 조절 - 시작 값은 앱에서 다양하게 조절될 수 있음
//   //----------------------------------------------------------------------------
//   for (int d = 0; d < GvDef.maxDeviceNum; d++) {
//     dm[d].g.parameter.mlTh1RmRtInitialValue = DefDsp.default1RmRtInit;
//     dm[d].g.parameter.mlTh1RmRtFromSetGauge = DefDsp.default1RmRtInit;
//   }
// }

//==============================================================================
// 측정 시작 조건 체크
//==============================================================================
bool checkIsEnableMeasureStartTotally(BuildContext context) {
  int cntEnable = 0;
  int cntDisable = 0;

  //----------------------------------------------------------------------------
  // [1] 데모 신호 체크 :데모 신호가 가능하게 설정되어 있으면 시작 가능
  // 디바이스가 여러개인 경우 각각 체크해야 함
  //----------------------------------------------------------------------------
  if (gv.setting.isEnableDemo.value == true) {
    return true;
  }

  //----------------------------------------------------------------------------
  // [2] 연결된 블루투스 장비가 없다면 시작 불가
  //----------------------------------------------------------------------------
  cntEnable = 0;
  cntDisable = 0;
  for (int d = 0; d < GvDef.maxDeviceNum; d++) {
    if (gv.deviceStatus[d].isDeviceBtConnected.value == true) {
      cntEnable++;
    }
  }
  //----------------------------------------------
  // 연결된 장비가 하나도 없는 경우
  //----------------------------------------------
  if (cntEnable == 0) {
    // 메시지 창 변경
    // openSnackBarBasic('장비 미연결', '연결된 FITSIG 장비가 없습니다.');
    gv.audioManager.play(type: EmaSoundType.warning); //경고음

    // measuer_idle 화면 우측 상단에 fitsig 장비 연결 버튼을 알려주는 말풍선 띄우기
    if (gvMeasure.showBubble.value == false) {
      gvMeasure.showBubble.value = true;
      gvMeasure.showBubbleTimer = Timer(const Duration(seconds: 7), () {
        gvMeasure.showBubble.value = false;
      });
    }
    return false;
  }

  //----------------------------------------------------------------------------
  // [3] 장비가 하나라도 충전 중이라면 시작 불가
  //----------------------------------------------------------------------------
  cntEnable = 0;
  cntDisable = 0;
  for (int d = 0; d < GvDef.maxDeviceNum; d++) {
    //----------------------------------------------------------------
    // 전압이 3V 이상이라면 충전중을 의믜함
    if (gv.deviceStatus[d].isDeviceBtConnected.value == true &&
        BleManager.fitsigDeviceAck[d].usbVoltage > 3) {
      cntDisable++;
    }
  }
  //----------------------------------------------
  // 충전중인 장비가 하나라도 있는 경우
  //----------------------------------------------
  if (cntDisable > 0) {
    // 메시지 창 변경
    openSnackBarBasic('장비 충전 중', '장비 충전 중에는 측정을 시작할 수 없습니다.');
    gv.audioManager.play(type: EmaSoundType.warning); //경고음
    // openSnackBarBasic('장비$electrodeNotGoodDevice 접촉 불량', '장비의 전극이 신체에 부착되어 있지 않거나 접촉이 불안정합니다.');
    return false;
  }

  //----------------------------------------------------------------------------
  // [4] 블루투스가 연결 되었고, 몸에 잘 붙지 않은 장비가 있는가?
  // 하나라도 제대로 붙어있지 않다면 알려주는 것이 필요
  // 여러개를 사용하는 경우, 몇번 장비가 불량인지 알려 줄 필요 있음
  //----------------------------------------------------------------------------
  cntEnable = 0;
  cntDisable = 0;
  int electrodeNotGoodDevice = 0;
  for (int d = 0; d < GvDef.maxDeviceNum; d++) {
    if (gv.deviceStatus[d].isDeviceBtConnected.value == true &&
        gv.deviceStatus[d].electrodeStatus.value !=
            EmlElectrodeStatus.attachGood) {
      cntDisable++;
      electrodeNotGoodDevice = d;
    }
  }
  //----------------------------------------------
  // 하나라도 제대로 붙지 않은 장비가 있는 경우
  //----------------------------------------------
  if (cntDisable > 0) {
    // 메시지 창 변경
    openSnackBarBasic('장비 접촉 불량', '장비의 전극이 신체에 부착되어 있지 않거나 접촉이 불안정합니다.');
    gv.audioManager.play(type: EmaSoundType.warning); //경고음
    // openSnackBarBasic('장비$electrodeNotGoodDevice 접촉 불량', '장비의 전극이 신체에 부착되어 있지 않거나 접촉이 불안정합니다.');
    return false;
  }

  //----------------------------------------------------------------------------
  // [5] 기존 측정이 진행 중인가?
  // 에러 난 경우 이 메시지가 발생 함
  //----------------------------------------------------------------------------
  cntEnable = 0;
  cntDisable = 0;
  for (int d = 0; d < GvDef.maxDeviceNum; d++) {
    if (dm[d].g.dsp.controlState != EmlStateDsp.measureCompleteE &&
        dm[d].g.dsp.controlState != EmlStateDsp.idle) {

      // 이전 측정 중이라는 메시지가 반복적으로 뜨는 경우 존재
      // 주로 측정이나 혹은 기록 중에 에러가 발생하여 완전히 진행 못한 것이 원인으로 보임
      //예상치 못한 문제가 발생한 경우 일단 대기모드로 해서 다시 시작할 수 있게 변경 (230412)
      dm[d].g.dsp.controlState = EmlStateDsp.idle;
      DspManager.stateMeasure.value = EmlStateMeasure.idle;
      cntDisable++;
    }
  }
  //----------------------------------------------
  // 측정 실행 중
  //----------------------------------------------
  if (cntDisable > 0 || DspManager.stateMeasure.value != EmlStateMeasure.idle) {
    // 메시지 창 변경
    // openSnackBarBasic('측정 미 완료(cntDisable=$cntDisable)',
    //     '이전에 실행한 측정이 아직 종료되지 않았습니다.(stateMeasure=${DspManager.stateMeasure.value})');
    //----------------------------------------------
    // 혹시나 실행중이라면, 종료 처리
    // endMeasure();
    // DspManager.commandMeasureComplete();
    //----------------------------------------------
    // 메시지
    openSnackBarBasic(
        '이전 측정 비정상 종료',
        '이전 측정이 정상적으로 완료되지 않았습니다.'
            ' 이 메시지가 자주 뜬다면, 앱을 종료한 후에 다시 시작해 주세요.');

    return false;
  }
  return true;
}

//==============================================================================
// 개별 장비 제어 명령 가능 조건 체크
// 부착이 떨어져도 중간 명령은 계속 실행 됨
// 대기 중 일때는 명령 불가 (시작 멍령만 가능)
//==============================================================================
bool checkIsEnableMeasureStart(int deviceIndex) {
  int d = deviceIndex;
  //----------------------- 장비가 연결되어 있다면 명령 가능
  if (gv.deviceStatus[d].isDeviceBtConnected.value == true) {
    return true;
  }
  //----------------------- 데모 신호가 동작중에 있다면 명령 가능
  else if (gv.setting.isEnableDemo.value == true) {
    return true;
  }
  return false;
}

//==============================================================================
// 개별 장비 제어 명령 가능 조건 체크
// 부착이 떨어져도 중간 명령은 계속 실행 됨
// 대기 중 일때는 명령 불가 (시작 멍령만 가능)
//==============================================================================
bool checkIsEnableMeasureControl(int deviceIndex) {
  int d = deviceIndex;
  //----------------------- 대기 상태라면 명령 불가
  if (dm[d].g.dsp.controlState == EmlStateDsp.idle) {
    return false;
  }
  //----------------------- 장비가 연결되어 있다면 명령 가능
  else if (gv.deviceStatus[d].isDeviceBtConnected.value == true) {
    return true;
  }
  //----------------------- 데모 신호가 동작중에 있다면 명령 가능
  else if (gv.setting.isEnableDemo.value == true) {
    return true;
  }

  return false;
}
