import 'package:fitsig_basic_golf/F6_WIDGET/CHART_LIVE/live_emg_time_chart.dart';

import '/F0_BASIC/common_import.dart';

//==============================================================================
// DSP callback : 장비별 call back
//==============================================================================
// List<bool> _flagCallbackSlow =
//     List<bool>.generate(GvDef.maxDeviceNum, (index) => false);

class DspCallback {
  final int deviceIndex;

  DspCallback({required this.deviceIndex});

  //----------------------------------------------------------------------------
  // 제어 관련 응답 콜백
  // 장비 중 1개의 종료가 감지되면 모든 장비의 종료로 처리해도 됨
  // 장비가 4개 인 경우 최대 4번씩 화면 갱신이 발생할 수 있음
  // (1) 연결된 블루투스 디바이스에 측정종료 정보 전달
  // (2) 리포트 데이터 확인 : dm[deviceIndex].g.reportData
  //----------------------------------------------------------------------------
  callbackControlAck() async {
    var gd = dm[deviceIndex].g.dsp;
    int d = deviceIndex;

    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    // 콜백 - 측정 시작 (1세트 시작을 포함)
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    if (gd.controlState == EmlStateDsp.measureStartS) {
      // GvCon.isOnWorkS.value = true;
      // GvCon.isOnMeasureS.value = true;
      // GvCon.isOnHoldS.value = false;
    } else if (gd.controlState == EmlStateDsp.measureStartE) {
      // GvCon.isOnWorkE.value = true;
      // GvCon.isOnMeasureE.value = true;
      // GvCon.isOnHoldE.value = false;
    }
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    // 콜백 - hold
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    else if (gd.controlState == EmlStateDsp.holdS) {
      // GvCon.isOnHoldS.value = true;
    } else if (gd.controlState == EmlStateDsp.holdE) {
      // GvCon.isOnHoldE.value = true;
    }
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    // 콜백 - hold 상태에서 재 시작
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    else if (gd.controlState == EmlStateDsp.measureRestartS) {
      // GvCon.isOnHoldS.value = false;
    } else if (gd.controlState == EmlStateDsp.measureRestartE) {
      // GvCon.isOnHoldE.value = false;
    }
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    // 콜백 - 세트 시작 (2세트 시작부터 이곳에서 응답)
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    else if (gd.controlState == EmlStateDsp.setStartS) {
      // GvCon.isOnMeasureS.value = true;
      // GvCon.setNumber = gd.setNumberRecord;
    } else if (gd.controlState == EmlStateDsp.setStartE) {
      // GvCon.isOnMeasureE.value = true;
    }
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    // 콜백 - 세트 종료 (= 휴식중)
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    else if (gd.controlState == EmlStateDsp.setCompleteS) {
      // GvCon.isOnHoldS.value = false;
      // GvCon.isOnMeasureS.value = false;
    } else if (gd.controlState == EmlStateDsp.setCompleteE) {
      // GvCon.isOnHoldE.value = false;
      // GvCon.isOnMeasureE.value = false;
      //개별 그래프 버튼 갱신
      // refreshIndividualGraphControlButton(deviceIndex);
    }
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    // 콜백 - 측정종료
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    else if (gd.controlState == EmlStateDsp.measureCompleteS) {
      // GvCon.isOnWorkS.value = false;
      // GvCon.isOnMeasureS.value = false;
      // GvCon.isOnHoldS.value = false;
    } else if (gd.controlState == EmlStateDsp.measureCompleteE) {
      //종료시간 기록

      // GvCon.isOnWorkE.value = false;
      // GvCon.isOnMeasureE.value = false;
      // GvCon.isOnHoldE.value = false;
      //개별 그래프 버튼 갱신
      // refreshIndividualGraphControlButton(deviceIndex);

      //------------------------------------------------------------------------
      // 측정 중 장비 버튼 클릭 꺼짐 해제
      // if (dm[deviceIndex].g.gv.deviceStatus[0].isDeviceConnected == true) {
      //   // cmdOfDevice[d].working = 0;
      //   // await btCmdToDevice(d);
      // }

      //------------------------------------------------------------------------
      // 종료 여부 확인
      //------------------------------------------------------------------------
      // 현재 디바이스도 종료된 것으로 처리
      int cntComplete = 0;
      bool isComplete = false;
      DspManager.isMeasureComplete[d] = true;
      // 연결되지 않았거나, 데모 중이 아닐때는 종료된 것으로 처리
      // basic 에서는 데모신호가 1개 이므로 세팅 만 조건으로 살펴봄
      // 다채널 일 경우 개별 채널의 데모신호 enable 살펴야 함
      for (int dn = 0; dn < GvDef.maxDeviceNum; dn++) {
        if (gv.deviceStatus[dn].isDeviceBtConnected.value == false &&
            gv.setting.isEnableDemo.value == false) {
          DspManager.isMeasureComplete[dn] = true;
        }
        // 종료나 무시된 디바이스 카운트
        if (DspManager.isMeasureComplete[dn] == true) {
          cntComplete++;
        }
      }
      // 측정 종료 여부 체크
      if (cntComplete == GvDef.maxDeviceNum) {
        isComplete = true;
      }
      //------------------------------------------------------------------------
      // 측정 종료에 다른 처리
      //------------------------------------------------------------------------
      if (isComplete == true) {
        //-----------------------------------------------------
        // 상태전환 및 시간 기록
        DspManager.stateMeasure.value = EmlStateMeasure.idle;
        DspManager.endTime = DateTime.now();
      }
    }
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    // 콜백 - 대기상태
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    else if (gd.controlState == EmlStateDsp.idle) {
      // 특별히 수행할 것은 없음
      // 측정 시작 시 idle 상태인지 체크 후 시작
    }

    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    // DB 저장 안될 때 디버그
    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    //--------------------------------------------------------------------------
    // 저장에 문제가 발생하면 report 데이터에 NaN이 있는지 아래 코드로 체크
    // print('--------------------------------------------');
    // print('deviceIndex : $deviceIndex');
    // reportDataCheck(dm[deviceIndex].g.reportData);
    // DBReportManager.strReportData[deviceIndex] = jsonEncode(_reportData);
    // print(DBReportManager.strReportData[deviceIndex]);

    // 보고서를 위한 데이터
    // 데이터 베이스 저장, 보고서 표시 등에 활용
    // ex) 상세 그래프 데이터
    // dm[deviceIndex].g.reportData.detailGraphPowBuff
    // ex) 카운트 값
    // dm[deviceIndex].g.reportData.wBlockMaxBuffmV

    //새로운 데이터베이스 추가
    //바로 추가하지 않고, 좀 기다렸다가 추가하는 것 시도!
    //채널별로 끝나는 시간이 다를 수 있음
    // await DBReportManager.newReport();
  }

  //----------------------------------------------------------------------------
  // 콜백 40ms : 파워 그래프 표시
  // 그래프 데이터 버퍼 : dm[deviceIndex].g.rtGraphData.powBuff
  // 단일 데이터 : dm[deviceIndex].g.fastData.pow (혹은 위 버퍼의 last)
  // 시간 버퍼 : dm[deviceIndex].g.rtGraphData.timeBuff
  // todo : 갱신 할 파일 통일 필요! (obx() 에서 공통 활용)
  //----------------------------------------------------------------------------

  static int cntCallbackFast = 0;
  static double _pow_1p = 0;
  static bool _flagTargetEffect = false;

  callbackFast() {
    int d = deviceIndex;

    //--------------------------------------------------------------------------
    // 신호 유입 체크
    //--------------------------------------------------------------------------
    cntCallbackFast++;
    if (cntCallbackFast % 25 == 0) {
      // print('$cntCallbackFast');
    }
    //--------------------------------------------------------------------------
    // 근 활성도 : 정상상황
    //--------------------------------------------------------------------------
    // if (dm[0].g.dsp.exceptionType == EmlExceptionType.none ||
    //     dm[0].g.dsp.exceptionType == EmlExceptionType.attach) //  or 을 and 로 바꿈. 이상 동작시 확인 필요  (23.08.21)
    if (dm[0].g.dsp.exceptionType == EmlExceptionType.none &&
        dm[0].g.dsp.exceptionType == EmlExceptionType.attach) {
      // 근활성도
      gv.deviceData[d].emgData.value = dm[d].g.fastData.pow;
    } else {
      // 근활성도
      gv.deviceData[d].emgData.value = dm[d].g.fastData.powDelay; //0으로 해도 됨
    }
    // 근활성도 평균
    gv.deviceData[d].emgDataAv = dm[d].g.fastData.continuousPowAv;
    // 근활성도 최대
    gv.deviceData[d].emgDataMax = dm[d].g.fastData.continuousPowMax;

    // 시간
    gv.deviceData[d].emgTime = dm[d].g.fastData.timeFast;

    //--------------------------------------------------------------------------
    // 근 활성도 버퍼링
    //--------------------------------------------------------------------------
    gv.deviceData[d].yData.add(gv.deviceData[d].emgData.value); //.value);
    gv.deviceData[d].yData.removeAt(0);
    gv.deviceData[d].xData.add(gv.deviceData[d].emgTime);
    gv.deviceData[d].xData.removeAt(0);

    //--------------------------------------------------------------------------
    // 심전도 버퍼링 : 샘플 2개 추가 (심전도는 근전도 2배 속도인 20ms 주기로 저장되므로)
    // 심전도 보기 기능제어를 어디에 둘지 고민
    //--------------------------------------------------------------------------
    int ecgDataLen = dm[d].g.dsp.ecgDataBuff.length;

    if (ecgDataLen >= 2) {
      int last2ndIndex = ecgDataLen - 2;

      //심전도 데이터 2개 추가
      gv.deviceData[d].ecgYData.add(dm[d].g.dsp.ecgDataBuff[last2ndIndex]);
      gv.deviceData[d].ecgYData.removeAt(0);
      gv.deviceData[d].ecgYData.add(dm[d].g.dsp.ecgDataBuff.last);
      gv.deviceData[d].ecgYData.removeAt(0);
      //시간 데이터 2개 추가
      gv.deviceData[d].ecgXData.add(gv.deviceData[d].emgTime);
      gv.deviceData[d].ecgXData.removeAt(0);
      gv.deviceData[d].ecgXData
          .add(gv.deviceData[d].emgTime + (DefDsp.fastPeriod * 0.5));
      gv.deviceData[d].ecgXData.removeAt(0);

      //심박 카운트 데이터 추가 (심박이 감지된 경우만)
      //-----------------------------------
      //  심박 카운트 데이터가 존재할 때
      if (dm[d].g.dsp.ecgCountTime.isNotEmpty) {
        // 첫번째 데이터라면
        if (gv.deviceData[d].ecgCountTime.isEmpty) {
          gv.deviceData[d].ecgCountData.add(1);
          gv.deviceData[d].ecgCountTime
              .add(dm[d].g.dsp.ecgCountTime.last);
        }
        // 심박 마지막 데이터가 새로 갱신 되었다면
        else if (dm[d].g.dsp.ecgCountTime.last !=
            gv.deviceData[d].ecgCountTime.last) {
          gv.deviceData[d].ecgCountData.add(1);
          gv.deviceData[d].ecgCountTime
              .add(dm[d].g.dsp.ecgCountTime.last);
        }

        // 만일 일정 시간 초과라면 삭제하기
        if (gv.deviceData[d].ecgCountTime.first <
            gv.deviceData[d].ecgXData.first) {
          gv.deviceData[d].ecgCountData.removeAt(0);
          gv.deviceData[d].ecgCountTime.removeAt(0);
        }

      }

      // if (dm[d].g.dsp.ecgCountDetectTime.last !=
      //     gv.deviceData[d].ecgCountTime.last) {
      //   gv.deviceData[d].ecgCountData.add(1);
      //   gv.deviceData[d].ecgCountTime.add(gv.deviceData[d].emgTime);
      //
      //   // 만일 일정 시간 초과라면 삭제하기
      //   if (gv.deviceData[d].ecgCountTime.first <
      //       gv.deviceData[d].ecgXData.first) {
      //     gv.deviceData[d].ecgCountData.removeAt(0);
      //     gv.deviceData[d].ecgCountTime.removeAt(0);
      //   }
      // }
      // gv.deviceData[d].ecgCountData
      //     .add(dm[d].g.dsp.ecgPowBuffCountDetect[last2ndIndex]);
      // gv.deviceData[d].ecgCountData.removeAt(0);
      // gv.deviceData[d].ecgCountData.add(dm[d].g.dsp.ecgPowBuffCountDetect.last);
      // gv.deviceData[d].ecgCountData.removeAt(0);
    }

    //--------------------------------------------------------------------------
    // 카운트 데이터 버퍼 삭제 (x 영역을 벗어난 경우)
    //--------------------------------------------------------------------------
    if (gv.deviceData[d].xMark.isNotEmpty) {
      if (gv.deviceData[d].xMark.first < gv.deviceData[d].xData.first) {
        gv.deviceData[d].yMark.removeAt(0);
        gv.deviceData[d].xMark.removeAt(0);

        // print('---------------');
        // print(gv.deviceData[d].xData.last);
        // print(dm[0].g.parameter.mvcRefRt);
        // print(dm[0].g.dsp.histNormTimeBuff);
      }
    }
    //--------------------------------------------------------------------------
    // 그래프 갱신 : 값이 동일하면 멈추는 느낌이 들 수도 있어 갱신 구조로 변경
    //--------------------------------------------------------------------------
    RefreshLiveEmgTimeChart.chart(); //시간 차트는 데이터 변경 없을 때도 갱신 필요(x 값 변화)
    RefreshLiveEmgTimeChartOnlyLine.chart();

    //--------------------------------------------------------------------------
    // 애니메니션 및 사운드 - 시간방식 가이드이면서 측정 중일 때
    // 예외가 발생한 상황이 아닐 때!
    // 값의 변화가 크면 영역에 들어오지 않을 수 있음
    //--------------------------------------------------------------------------
    if (gv.setting.isGuideTypeTime.value == true &&
        DspManager.stateMeasure.value == EmlStateMeasure.onMeasure &&
        dm[0].g.dsp.exceptionType == EmlExceptionType.none) {
      //-----------------------------------------------------------------------
      // 파워 값이 목표 영역에 머무르고 있을 때
      if (dm[d].g.fastData.pow <= dm[0].g.parameter.targetZoneHRt &&
          dm[d].g.fastData.pow >= dm[0].g.parameter.targetZoneLRt) {
        _flagTargetEffect = true;
      }
      //-----------------------------------------------------------------------
      // 파워 값이 목표값을 상승 통과했을때
      else if (dm[d].g.fastData.pow > dm[0].g.parameter.targetZoneHRt &&
          _pow_1p < dm[0].g.parameter.targetZoneLRt) {
        _flagTargetEffect = true;
      }
      //-----------------------------------------------------------------------
      // 파워 값이 목표값을 하향 통과했을 때
      if (_pow_1p > dm[0].g.parameter.targetZoneHRt &&
          dm[d].g.fastData.pow < dm[0].g.parameter.targetZoneLRt) {
        _flagTargetEffect = true;
      }
    }
    //--------------------------------------------------------------------------
    // 애니메니션 및 사운드 - 시간방식 가이드이면서 측정 중일 때
    if (_flagTargetEffect == true) {
      _flagTargetEffect = false;
      //-------------------------------
      // 기존 애니메이션 / 오디오가 동작 중이 아니라면
      if (gvMeasure.cntTargetArea == 0) {
        rippleAnimationExecution();
        gv.audioManager.play(type: EmaSoundType.targetSuccess); //2 기본음
        gvMeasure.cntTargetArea = 2; //2x40 = 80ms
      } else {
        gvMeasure.cntTargetArea--;
      }
      //훌륭해요
      showBarText(EmlTargetResult.perfect);
    }
    //좋아요
    else if (dm[d].g.fastData.pow > dm[0].g.parameter.targetZoneLRt * 0.5) {
      showBarText(EmlTargetResult.success);
    }

    //   }
    // }
    _pow_1p = dm[d].g.fastData.pow;

    //--------------------------------------------------------------------------
    // 게이지
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    // for multi channel graph line data
    //--------------------------------------------------------------------------
    // //---------------------------------------------
    // // 버퍼에 데이터 저장
    // GvDsp.syncBuffY[d][GvDsp.syncBuffIdxW[d]] =
    //     dm[d].g.rtGraphData.powBuff.last;
    // //----------------------write index 증가
    // GvDsp.syncBuffIdxW[d]++;
    // GvDsp.syncBuffIdxW[d] %= GvDsp.BUFF_LEN;

    //--------------------------------------------------------------------------
    // 갱신 체크
    // 모든 디바이스 버퍼에 데이터 저장 되었는지 확인
    // 연결되지 않은 디바이스는 무시
    // 디바이스가 4개 일 경우 아래 루틴 4번 실행 (즉 밀린 데이터도 언제든지 처리 가능)
    // slow loop(0.5초 주기) event 도 동시 체크 (화면 refresh 효율화 목적)
    //--------------------------------------------------------------------------
    int refreshCnt = 0;
    int refreshSlowCnt = 0; //slow loop 갱신 체크
    // for (int n = 0; n < GvDef.maxDeviceNum; n++) {
    //   if (gv.deviceStatus[0][n].isDeviceConnected == true ||
    //       GcMeasure.isGenerateDemoSignal[n] == true) {
    //     if (GvDsp.syncBuffIdxR != GvDsp.syncBuffIdxW[n]) {
    //       refreshCnt++;
    //     }
    //
    //     if (_flagCallbackSlow[deviceIndex]) {
    //       refreshSlowCnt++;
    //     }
    //   } else {
    //     refreshCnt++;
    //     refreshSlowCnt++;
    //   }
    // }

    // //--------------------------------------------------------------------------
    // // 데이터가 모두 갱신 되었다면 버퍼에 저장
    // if (refreshCnt == GvDef.maxDeviceNum) {
    //   //------------------------------------------------------
    //   // 공통 X 시간 추가
    //   // 여기서 해야 시간 표시, 마크 모두 안정적
    //   GvDsp.commonX.add(GvDsp.xTime);
    //   GvDsp.commonX.removeAt(0);
    //   GvDsp.xTime += 0.04;
    //
    //   //------------------------------------------------------
    //   // 장비 별 Y 추가
    //   for (int n = 0; n < GvDef.maxDeviceNum; n++) {
    //     if (gv.deviceStatus[0][n].isDeviceConnected == true ||
    //         GcMeasure.isGenerateDemoSignal[n] == true) {
    //       //신규 데이터 추가
    //       GvDsp.lineDataY[n].add(GvDsp.syncBuffY[n][GvDsp.syncBuffIdxR]);
    //       //끝 데이터 제거
    //       GvDsp.lineDataY[n].removeAt(0);
    //     }
    //   }
    //   //---------------------- read index 증가
    //   GvDsp.syncBuffIdxR++;
    //   GvDsp.syncBuffIdxR %= GvDsp.BUFF_LEN;
    //
    //   //-------------------------- 다중 그래프 갱신
    //   refreshDeviceMultiGraph();
    // }

    //--------------------------------------------------------------------------
    // mark graph
    // 지우는 것만 여기서, 나머지는 count event callback 에서
    //--------------------------------------------------------------------------

    // //------------------ 그래프 표시영역 초과 시 버퍼에서 제거
    // if (GvDsp.markDataX[deviceIndex].isNotEmpty && GvDsp.commonX.isNotEmpty) {
    //   if (GvDsp.markDataX[deviceIndex].first < GvDsp.commonX.first) {
    //     GvDsp.markDataX[deviceIndex].removeAt(0);
    //     GvDsp.markDataY[deviceIndex].removeAt(0);
    //   }
    // }

    // //--------------------------------------------------------------------------
    // // 개별 채널 화면 갱신
    // //--------------------------------------------------------------------------
    // LiveEmgChartKey.key[deviceIndex].currentState?.refresh();
    //
    // //--------------------------------------------------------------------------
    // // slow event 발생 건 처리
    // //--------------------------------------------------------------------------
    // if (refreshSlowCnt == GvDef.maxDeviceNum) {
    //   //게이지 히스토그램 그래프 갱신
    //   LiveHistogramChartRowKey.key[deviceIndex].currentState?.refresh();
    //   //게이지 토탈 그래프 갱신
    //   LiveGaugeChartKey.key[deviceIndex].currentState?.refresh();
    //
    //   //------------------------ 스펙트럼 갱신(카운트 값이 변할 때 마다)
    //   // 0 나누기 방지
    //   if (dm[deviceIndex].g.rtGraphData.freqYAccCnt > 0)
    //     GvDsp.yAccCnt[deviceIndex].value =
    //         dm[deviceIndex].g.rtGraphData.freqYAccCnt;
    //
    //   //------------------------ 1RM 변경 반영 (이부분은 별도로 적절하게 수정)
    //   refreshMuscleList();
    // }

    //--------------------------------------------------------------------------
    // count event 발생
    //--------------------------------------------------------------------------


    //--------------------------------------------------------------------------
    // 실시간 보고서용 data 추가 및 리포트 가능 여부 체크
    if(DspManager.enableRtDataReport && DspManager.isMeasureOnScreen){
      if(dm[0].g.dsp.afeOutBuff.length >= 20) {
        List<double> afeDataList = dm[0].g.dsp.afeOutBuff.sublist(
            dm[0].g.dsp.afeOutBuff.length - 20);
        DspManager.rtReportData.afeOutBuff.addAll(
            afeDataList); // 실시간 보고서용 afe data 추가
        DspManager.rtReportData.emgOutBuff.add(
            dm[0].g.fastData.pow); // 실시간 보고서용 emg data 추가
        DspManager.rtReportData
            .checkAvailability(); // 한개의 packet 처리가 끝났을 때, 실시간 리포트 가능 여부 체크
      }
    }
  }

  //----------------------------------------------------------------------------
  // 콜백 400ms~1000ms(설정 확인) : 피로도 등 느리게 표시할 데이터
  //----------------------------------------------------------------------------
  callbackSlow() {
    int d = deviceIndex;

    //--------------------------------------------------------------------------
    // 운동량 기록
    //--------------------------------------------------------------------------
    gv.deviceData[d].aoeSet.value = dm[d].g.dsp.aoeSet;
    gv.deviceData[d].aoeTargetSet.value = dm[d].g.dsp.aoeTargetSet;
    //--------------------------------------------------------------------------
    // 주파수 기록
    //--------------------------------------------------------------------------
    gv.deviceData[d].freqBegin.value =
        dm[d].g.normalData.freqBegin.toPrecision(1);
    gv.deviceData[d].freqEnd.value = dm[d].g.normalData.freqEnd.toPrecision(1);

    //--------------------------------------------------------------------------
    // 전극 접촉 품질
    //--------------------------------------------------------------------------
    // AC lead-off 주파수 평균 값으로 quality 판정
    // 재사용 전극은 1 미만으로 좋게 나옴
    // 일회용 전극은 보틍 1.2 수준
    // 접촉 저항이 커지면 값이 커지는 경향
    int qualityGrade = 0;
    //---------------------------------------------------
    // 매우 좋은 상태 : 재사용 전극 정도만 가능 (땀이 나거나 물 묻은 경우도 OK)
    if (dm[0].g.dsp.exGoertzelAv < GvDef.electrodeContactQuality[0]) {
      qualityGrade = 0;
    }
    //---------------------------------------------------
    // 비교적 양호한 상태
    else if (dm[0].g.dsp.exGoertzelAv < GvDef.electrodeContactQuality[1]) {
      qualityGrade = 1;
    }
    //---------------------------------------------------
    // 약간 나쁜 상태
    else if (dm[0].g.dsp.exGoertzelAv < GvDef.electrodeContactQuality[2]) {
      qualityGrade = 2;
    }
    //---------------------------------------------------
    // 많이 나쁜 상태
    else if (dm[0].g.dsp.exGoertzelAv < GvDef.electrodeContactQuality[3]) {
      qualityGrade = 3;
    }
    //---------------------------------------------------
    // 거의 불가한 상태
    else {
      qualityGrade = 4;
    }
    gv.deviceData[d].electrodeQualityGrade.value = qualityGrade;

    // //--------------------------------------------------------------------------
    // // 전극 상태 주기적 체크
    // exception callback으로 이동
    // //--------------------------------------------------------------------------
    // if(gv.deviceStatus[d].electrodeStatus.value != dm[d].g.dsp.exFlagWear){
    //   if (kDebugMode) {
    //     print('dsp_callback.dart :: callbackSlow() : 장치의 착용상태가 변경되어 착용상태 정보를 전송합니다 (${dm[d].g.dsp.exFlagWear})');
    //   }
    //   // 장비이 상태변경 명령 전송
    //   gv.bleManager[0].notifyDeviceAttachState(deviceIndex: d, attachState: dm[d].g.dsp.exFlagWear);
    // }
    // gv.deviceStatus[d].electrodeStatus.value = dm[d].g.dsp.exFlagWear;

    // _flagCallbackSlow[deviceIndex] = true;

    //
    // //게이지 히스토그램 그래프 갱신
    // LiveHistogramChartRowKey.key[deviceIndex].currentState?.refresh();
    // //게이지 토탈 그래프 갱신
    // LiveGaugeChartKey.key[deviceIndex].currentState?.refresh();
    // // print('-');

    //------------------------ 스펙트럼 갱신(카운트 값이 변할 때 마다)
    // 0 나누기 방지
    // if (dm[deviceIndex].g.rtGraphData.freqYAccCnt > 0)
    //   GvDsp.yAccCnt[deviceIndex].value =
    //       dm[deviceIndex].g.rtGraphData.freqYAccCnt;

    //------------------------ SEF50 trend line 갱신
    // if (dm[deviceIndex].g.rtGraphData.fatigueTimeBuff.isNotEmpty)
    //   GvDsp.fatigueTime.value =
    //       dm[deviceIndex].g.rtGraphData.fatigueTimeBuff;

    //근육 리스트 갱신 (1RM 값 변경 반영)
    // refreshMuscleList();

    //-------------------------------------------
    // 측정 시간 표시
  }

  //----------------------------------------------------------------------------
  // 목표 근접 시 사운드
  //----------------------------------------------------------------------------
  callbackAlmostTarget() {
    // print('$deviceIndex 목표 근접');
  }

  //----------------------------------------------------------------------------
  // 카운트 발생 시 표시, 사운드
  //----------------------------------------------------------------------------
  callbackCountRt() {
    int d = deviceIndex;
    //--------------------------------------------------------------------------
    // 카운트 데이터 버퍼링 (삭제는 fast callback 에서 수행
    //--------------------------------------------------------------------------
    gv.deviceData[d].yMark.add(dm[d].g.fastData.countPow);
    gv.deviceData[d].xMark.add(dm[d].g.fastData.countTime);
    // print(gv.deviceData[0].yMark);
    // print('dsp_callback.dart :: callbackCountRt() :: DspManager.stateMeasure = ${DspManager.stateMeasure.value}');
    // print('dsp_callback.dart :: callbackCountRt() :: dm[0].g.fastData.targetResult = ${dm[d].g.fastData.targetResult}');

    //--------------------------------------------------------------------------
    // 운동 방식이 카운트 이면서 측정 중 경우 : 애니메이션 및 사운드 피드백
    //--------------------------------------------------------------------------
    if (gv.setting.isGuideTypeTime.value == false &&
        DspManager.stateMeasure.value == EmlStateMeasure.onMeasure) {
      //-------------------------------------------------------------
      // 카운트 값이 완벽이나 성공인 경우
      if ((dm[d].g.fastData.targetResult == EmlTargetResult.perfect)) {
        //-----------------------------------------------------------
        // 오디오 플레이
        // [Audio Play] 횟수 가이드 일때  'good' sound (1회)
        gv.audioManager.play(type: EmaSoundType.targetSuccess);
        //-----------------------------------------------------------
        // 애니메이션 효과 발생
        // [Animation Play] 횟수 가이드 일때 애니메이션 실행
        // gvMeasure.animationCounter.value++;
        rippleAnimationExecution();
      } else if (dm[d].g.fastData.targetResult == EmlTargetResult.success) {
        //-----------------------------------------------------------
        // 오디오 플레이
        // [Audio Play] 횟수 가이드 일때  'good' sound (1회)
        gv.audioManager.play(type: EmaSoundType.targetSuccess);
        //-----------------------------------------------------------
        // 애니메이션 효과 발생
        // [Animation Play] 횟수 가이드 일때 애니메이션 실행
        // gvMeasure.animationCounter.value++;
        rippleAnimationExecution();
      }
    }

    // 반복 횟수 방식 운동일 때 사운드/진동/애니메이션 피드백에 활용
    // if (dm[0].g.dsp.targetResult.last == EmlTargetResult.perfect) {}

    //--------------------------------------------------------------------------
    // 카운트 값
    //--------------------------------------------------------------------------
    gv.deviceData[d].countNum.value = dm[d].g.fastData.countNum;

    //   // print('$deviceIndex 근력 카운트');
    //
    //   //--------------------------------------------------------------------------
    //   // for multi channel mark data
    //   //--------------------------------------------------------------------------
    //   //---------------- x time
    //   GvDsp.markDataX[deviceIndex].add(GvDsp.xTime);
    //   // print(GvDsp.xTime);
    //   // GvDsp.markDataX[deviceIndex]
    //   //     .add(dm[deviceIndex].g.rtGraphData.countTimeBuff.last);
    //   //---------------- mark value
    //   // 그래프 카운트 버퍼 데이터는 1박자 느림에 주의!
    //   // 실시간 블록 최대 값을 불러와야 문제가 없음
    //   GvDsp.markDataY[deviceIndex]
    //       .add(dm[deviceIndex].g.fastData.blockMaxPow);
    //
    //   // .add(dm[deviceIndex].g.rtGraphData.countPowBuff.last);
    //
    //   //------------------ 그래프 표시영역 초과 시 버퍼에서 제거
    //   // 빠른 루프에서 실행
    //   // if (GvDsp.markDataX[deviceIndex].first < GvDsp.commonX.first) {
    //   //   GvDsp.markDataX[deviceIndex].removeAt(0);
    //   //   GvDsp.markDataY[deviceIndex].removeAt(0);
    //   // }
    //
    //   // print('--------------------------------');
    //   // print(GvDsp.markDataX);
    //   // print(GvDsp.markDataY);
  }

  //----------------------------------------------------------------------------
  // 카운트 발생 시 표시, 사운드
  //----------------------------------------------------------------------------
  callbackCountDelay() {
    int d = deviceIndex;
  }

  //----------------------------------------------------------------------------
  // 실시간 최대근력 갱신 시 업데이트
  //----------------------------------------------------------------------------
  callback1RmRtUpdate() {
    //실시간 최대근력 갱신
    gv.deviceData[0].mvc.value = dm[0].g.parameter.mvcRefRt;
    if (kDebugMode) {
      print('1rm update callback');
    }

    //-----------------------------------------------------------
    // 오디오 플레이
    // 1RM 갱신이라는 의미로
    // 오디오 소리 의미가 혼동을 줄 수 있어 끄기 (230317)
    // gv.audioManager.play(type: EmaSoundType.update1Rm);

    // 최대 근력 갱신 되었음을 알리는 간단하고 짧은 팝업 (1~2초) // 나중에 검토...
    //   MuscleTargetKey.muscleTargetKey[deviceIndex].currentState?.refresh();
    //   // print('$deviceIndex 최대근력 갱신');
    //
    //   if (GcMeasure.isAuto1RmGaugeFull[deviceIndex] == true) {
    //     // dm[deviceIndex].g.parameter.mvcRefRt = dm[deviceIndex].g.parameter.mvcRefRt
    //   }
  }

  //----------------------------------------------------------------------------
  // 게이지 관련 이벤트 - 추후 결정
  //----------------------------------------------------------------------------
  callbackGauge() {
    // print('$deviceIndex 게이지 이벤트');
  }

  //----------------------------------------------------------------------------
  // 예외상황 (전극 탈부착, 터치, 가짜신호 등) 발생 시 발생하는 이벤트
  // 발생한 예외 종류 : dm[deviceIndex].g.dsp.exceptionType
  // 현재의 전극부착 상태 : dm[deviceIndex].g.dsp.exFlagWear
  //----------------------------------------------------------------------------
  callbackException() {
    int d = deviceIndex;
    // gv.deviceStatus[deviceIndex].electrodeStatus.value
    if (kDebugMode) {
      // print('$deviceIndex ${dm[d].g.dsp.exceptionType}');
    }
    //--------------------------------------------------------------------------
    // 예외 상황 종합 감지
    gv.deviceStatus[d].exceptionStatus.value = dm[d].g.dsp.exceptionType;
    //--------------------------------------------------------------------------
    // 부착상태 변화 감지
    if (dm[d].g.dsp.exceptionType == EmlExceptionType.attach ||
        dm[d].g.dsp.exceptionType == EmlExceptionType.detach) {
      //전극을 새로 부착하면, 최대근력 재설정 버튼 활성화
      gv.deviceData[0].disableReset1RM.value = false;

      if (dm[d].g.dsp.exceptionType == EmlExceptionType.attach) {
        if (kDebugMode) {
          print('$deviceIndex 전극이 부착되었습니다.');
        }
      } else {
        //-----------------------------------------------------------
        // 오디오 플레이 - 경고
        gv.audioManager.play(type: EmaSoundType.warning);
        if (kDebugMode) {
          print('$deviceIndex 전극이 떨어졌습니다.');
        }
      }

      gv.deviceStatus[d].electrodeStatus.value = dm[d].g.dsp.exFlagWear;
      // 장비에 변화된 상태정보 전송 (LINK LED 색상 변화)
      BleManager.notifyDeviceAttachState(
          deviceIndex: deviceIndex, attachState: dm[d].g.dsp.exFlagWear);
    }
  }
}
