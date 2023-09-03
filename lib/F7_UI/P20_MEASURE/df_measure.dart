import '/F0_BASIC/common_import.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

//==============================================================================
// 측정 종료 절차
// 소수점을 적절히 제한하여 저장하는 것이 필요 (저장 효율 개선)
//==============================================================================
saveMeasureData() async {
  gv.dbRecordIndexes.add(DbRecordIndex()); //class 추가
  int recordIndex = gv.dbmRecord.numberOfData; //마지막 index + 1
  var iData = gv.dbRecordIndexes[recordIndex];
  var cData = gv.dbRecordContents;
  int setIdx = 0;
  int d = 0; //device index

  //----------------------------------------------------------------------------
  // 기본 정보 버퍼에 저장
  //----------------------------------------------------------------------------

  //------------------------- 기본정보
  iData.idxMuscle = gv.control.idxMuscle.value;
  iData.muscleName = gv.deviceData[d].muscleName.value;
  iData.targetPrm = gv.deviceData[d].targetPrm.value;
  iData.targetCount = gv.deviceData[d].targetCount.value;
  iData.muscleTypeIndex = gv.deviceData[d].muscleTypeIndex.value;
  iData.isLeft = gv.deviceData[d].isLeft.value;
  iData.startTime = DspManager.startTime;
  iData.endTime = DspManager.endTime;
  iData.exerciseTime = DspManager.timeMeasure.value;
  if (gv.setting.isSaveEcgData.value == true) {
    iData.isEcgEmpty = false;
  } else {
    iData.isEcgEmpty = true;
  }
  //----------------------------------------------------------------------------
  // todo : 심박 데이터 추가 저장 필요
  // todo : 데이터 베이스에 변수 추가
  // todo : 결과 및 리포트에 심박 데이터 추가 및 버튼 추가
  // 심박은 -0.5 ~ +0.5mV 고정 크기로 그리기
  //----------------------------------------------------------------------------
  // dm[0].g.report.ecgPowBuff[setIdx]; //심박 데이터 (근전도 시간의 2배 해상도로 그래프 그리기)
  // dm[0].g.report.ecgCountDetectTime[setIdx];  //심박 카운트 된 시간 (오류 있을 수 있음)
  // dm[0].g.report.ecgHeartRateMax[setIdx]; //심박 최대
  // dm[0].g.report.ecgHeartRateMin[setIdx]; //심박 최소
  // dm[0].g.report.ecgHeartRateAv[setIdx]; //심박 평균

  //----------------------------------------------------------------------------
  // 분석정보
  //----------------------------------------------------------------------------

  // 기록 되는 최대근력은 새롭게 측정 된 최대 근력 값
  // 이 값은 현재의 최대근력보다 크거나 작을 수 있음
  iData.mvcMv =
      (max(dm[d].g.report.w1RmNew[setIdx], dm[d].g.report.w1Rm[setIdx]))
          .toPrecision(4);

  // 역대 최대 근력 (이번에 측정한 값과, 기존의 최대근력 역대 최대값을 비교해서 큰 값을 입력)
  iData.greatestEverMvcMv = gv.control.greatestEverMvcMv > iData.mvcMv
      ? gv.control.greatestEverMvcMv
      : iData.mvcMv;

  // 측정된 최대근력
  cData.measureMvcMv = (dm[d].g.report.w1RmNew[setIdx]).toPrecision(4);

  //------------------------- 근활성도 최대/평균 (시간)
  cData.emgTimeMax = (dm[d].g.report.continuousPowMax[setIdx]).toPrecision(3);
  cData.emgTimeAv = (dm[d].g.report.continuousPowAv[setIdx]).toPrecision(3);
  //------------------------- 근활성도 최대/평균 (카운트)
  cData.emgCountMax = (dm[d].g.report.countPowMax[setIdx]).toPrecision(3);
  cData.emgCountAv = (dm[d].g.report.countPowMean[setIdx]).toPrecision(3);
  //-------------------------- 운동량
  iData.aoeSet = (dm[d].g.report.aoeSet[setIdx]).toPrecision(2);
  cData.aoeTarget = (dm[d].g.report.aoeTargetSet[setIdx]).toPrecision(2);
  //-------------------------- 반복횟수
  cData.repetition = dm[d].g.report.numCntTotal[setIdx];
  cData.repetitionTargetSuccess = dm[d].g.report.numTarget[setIdx];
  //-------------------------- 주파수
  cData.freqBegin = (dm[d].g.report.sef50freqBegin[setIdx]).toPrecision(2);
  cData.freqEnd = (dm[d].g.report.sef50FreqEnd[setIdx]).toPrecision(2);

  //----------------------------------------------------------------------------
  // 근전도 파형 (json string 을 고려하여 소숫점 제한)
  //----------------------------------------------------------------------------
  //-------------------------- 근전도 상세데이터 소숫점 제한하여 저장
  int dLen = dm[d].g.report.emgPowBuff[setIdx].length;
  // if (kDebugMode) {
  //   print('상세 근전도 : ${dm[d].g.dsp.emgPowBuff[1]}');
  //   print('운동량 : ${cData.aoeSet}');
  //   print('저장된 데이터 내용 ${dm[d].g.report.emgPowBuff[setIdx]}');
  //   print('저장된 데이터 길이 : $dLen');
  // }
  cData.emgData.clear();
  cData.emgTime.clear();
  for (int n = 0; n < dLen; n++) {
    double data = dm[d].g.report.emgPowBuff[setIdx][n].toPrecision(4);
    double time = dm[d].g.report.emgTimeBuff[setIdx][n].toPrecision(2);
    cData.emgData.add(data); //근전도 값
    cData.emgTime.add(time); //시간
  }
  //-------------------------- 마크 데이터 소숫점 제한하여 저장
  dLen = dm[d].g.report.countPowBuff[setIdx].length;
  cData.markValue.clear();
  cData.markTime.clear();
  for (int n = 0; n < dLen; n++) {
    double data = dm[d].g.report.countPowBuff[setIdx][n].toPrecision(4);
    double time = dm[d].g.report.countTimeBuff[setIdx][n].toPrecision(2);
    cData.markValue.add(data);
    cData.markTime.add(time);
  }
  cData.targetResult = dm[d].g.report.targetResultBuff[setIdx];

  // print('저장하는 영역에서의 target 데이터');
  // print(dm[d].g.report.countPowBuff[setIdx]);
  // print(dm[d].g.report.countTimeBuff[setIdx]);
  // print(dm[d].g.report.targetResultBuff[setIdx]);

  //----------------------------------------------------------------------------
  // 전극 접촉 품질 : 소숫점 적절한 수준 제한
  //----------------------------------------------------------------------------
  cData.electrodeContactData.clear();
  for (int n = 0; n < dm[d].g.report.electrodeContactData[setIdx].length; n++) {
    double data = dm[d].g.report.electrodeContactData[setIdx][n].toPrecision(3);
    cData.electrodeContactData.add(data); //전극 접촉 품질
  }
  cData.isExBufferCleared.clear();
  for (int n = 0; n < dm[d].g.report.isExBufferCleared[setIdx].length; n++) {
    double data = dm[d].g.report.isExBufferCleared[setIdx][n].toPrecision(0);
    cData.isExBufferCleared.add(data); //버퍼 삭제 발생 여부
  }
  cData.endTime = (dm[d].g.report.timeSet[setIdx]).toPrecision(2); //측정 종료 시간
  cData.electrodeContactMax =
      (dm[0].g.report.electrodeContactMax[setIdx]).toPrecision(3); //접촉 품질 최대 값
  cData.exCntDetach = (dm[0].g.report.exCntDetach[setIdx]); //전극 분리 횟수
  cData.exTimeDetached =
      (dm[0].g.report.exTimeDetached[setIdx]).toPrecision(2); //전극 분리 시간
  cData.exCntExternal = (dm[0].g.report.exCntExternal[setIdx]); //무선 손실 예외 횟수
  cData.exTimeFake =
      (dm[0].g.report.exTimeFake[setIdx]).toPrecision(2); //가짜 신호 시간

  //----------------------------------------------------------------------------
  // 심전도 데이터
  //----------------------------------------------------------------------------
  cData.ecgData.clear();
  cData.ecgCountTime.clear();

  // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  // print(gv.setting.isSaveEcgData.value);
  // print(dm[d].g.report.ecgDataBuff[setIdx].length);

  if (gv.setting.isSaveEcgData.value == true) {
    // 심전도 데이터 : 대략 0.5 ~ -0.5mV (심장 부근에서)
    for (int n = 0; n < dm[d].g.report.ecgDataBuff[setIdx].length; n++) {
      double data = dm[d].g.report.ecgDataBuff[setIdx][n].toPrecision(4);
      cData.ecgData.add(data);
    }
    // 심박 발생 감지시간 (R-peak 시간)
    for (int n = 0; n < dm[d].g.report.ecgCountTime[setIdx].length; n++) {
      double data = dm[d].g.report.ecgCountTime[setIdx][n].toPrecision(2);
      cData.ecgCountTime.add(data);
    }
  }
  // 감지된 심박 수는 항상 저장
  cData.ecgHeartRateMax = dm[d].g.report.ecgHeartRateMax[setIdx];
  cData.ecgHeartRateMin = dm[d].g.report.ecgHeartRateMin[setIdx];
  cData.ecgHeartRateAv = dm[d].g.report.ecgHeartRateAv[setIdx];

  //----------------------------------------------------------------------------
  // 기록 데이터 베이스 저장
  //----------------------------------------------------------------------------
  await gv.dbmRecord
      .insertData(indexMap: iData.toJson(), contentsMap: cData.toJson());
  // 리스트 갱신
  gvRecord.totalNumOfRecord.value = gv.dbmRecord.numberOfData;
  RefreshRecordList.list();

  //----------------------------------------------------------------------------
  // 근육 데이터 베이스 정보 갱신 - (통계관련 정보 포함)
  //----------------------------------------------------------------------------
  saveReportStats(
      idxMuscle: gv.control.idxMuscle.value, iData: iData, cData: cData);
  gv.dbMuscleIndexes[gv.control.idxMuscle.value].mvcMv = iData.mvcMv;
  //----------------------------------------------------------------------------
  // 근육 데이터 베이스 DB에 저장
  //----------------------------------------------------------------------------
  await gv.dbmMuscle.updateData(
      index: gv.control.idxMuscle.value,
      indexMap: gv.dbMuscleIndexes[gv.control.idxMuscle.value].toJson(),
      contentsMap: gv.dbMuscleContents.toJson());

  //----------------------------------------------------------------------------
  // Hive DB에  기록 및 근육 데이터 저장
  //----------------------------------------------------------------------------
  // var recordData = DbHiveDataRecord.parseDbRecord(gv.dbRecordIndexes[recordIndex]);
  // gv.dbHiveManager.insert(data: recordData);
  // var muscleData = DbHiveDataMuscle.parseDbMuscle(gv.dbMuscleIndexes[gv.control.idxMuscle.value]);
  // gv.dbHiveManager.insertWithKey(data: muscleData, key: muscleData.muscleId.toString());

  if (kDebugMode) {
    print('측정 결과가 저장되었습니다.');
  }

  //----------------------------------------------------------------------------
  // API 전송하기
  //----------------------------------------------------------------------------
  //----------------------------------------------
  // 전송 할 body
  Map<String, String> body = {
    'bm_age': gv.setting.bornYearApi(gv.setting.bornYearIndex.value),
    'bm_sex': gv.setting.genderApi(gv.setting.genderIndex.value),
    'bm_muscle': 'unspecified',
    // todo : 27개 근육에 대한 세부적 return 구조 필요 (추후 반여)
    // gv.deviceData[d]
    //     .muscleTypeIndexApi(gv.deviceData[d].muscleTypeIndex.value),
//0 미선택, 1 팔, 2 어깨, 3 가슴, 4 복부, 5 등, 6 엉덩이, 7 다리
    'bm_time': '${iData.exerciseTime}',
    'bm_set': '${(dm[d].g.report.aoeSet[setIdx]).toPrecision(2)}',
    'bm_target': '${(dm[d].g.report.aoeTargetSet[setIdx]).toPrecision(2)}',
    'bm_max_strength': '${iData.mvcMv}',
    'bm_max_strength_measure':
        '${(dm[d].g.report.w1RmNew[setIdx]).toPrecision(4)}',
    'bm_max_active':
        '${dm[d].g.report.continuousPowMax[setIdx].toPrecision(2)}',
    'bm_avg_active': '${dm[d].g.report.continuousPowAv[setIdx].toPrecision(2)}',
    'bm_start_freq': '${dm[d].g.report.sef50freqBegin[setIdx].toPrecision(2)}',
    'bm_end_freq': '${dm[d].g.report.sef50FreqEnd[setIdx].toPrecision(2)}',
  };
  Map<String, String> ackMap =
      await apiPost(subUrl: 'insert/measure', body: body);
  //----------------------------------------------
  // 성공 메시지
  if (ackMap['response'] == 's') {
    if (kDebugMode) {
      print('측정결과 API 전송 성공');
    }
  } else {
    if (kDebugMode) {
      print('측정결과 API 전송 실패!');
    }
  }
}

//==============================================================================
// MVC 기준 값을 새로 계산한 값으로 변경
// 측정 중에 사용자가 버튼을 눌러서 갱신
// 값이 true가 된 경우 라이브러리 auto 1rm control 에서 값 낮추기를 1회 실행 함
//==============================================================================
// setMvcRefAsNew() {
//   dm[0].g.parameter.mlFlagMvcRefAsNew = true;
//   // // [1] 실시간 계산한 현재의 MVC 읽기
//   // double mvcNew = dm[0].g.parameter.mlMvcNewRt;
//   //
//   // // [2] 실시간 MVC reference 변경
//   // dm[0].g.parameter.mvcRefRt = mvcNew;
//   //
//   // // [3] 앱에서 표시하는 MVC 값 변경
//   // gv.deviceData[0].mvc.value = mvcNew;
//   //
//   // // [4] 종속 파라미터 업데이트
//   // DspManager.update1RmRt(deviceIndex: 0, value: mvcNew);
//   // // [5] 카운트 갱신
//   // updateMeasureCountRt(g: g);
//   // // [6] 시간 측정 값 갱신
//   // updateMeasureTimeRt(g: g);
// }

void showGuide() async {
  // 현재 화면에 표시되고 있는 가이드알림이 없을 경우 가이드알림을 표시하고 타이머 설정
  if (gvMeasure.isShowingGuide.value == false) {
    gvMeasure.isShowingGuide.value = true;
    gvMeasure.guideCloseTimer = Timer(const Duration(seconds: 2), () {
      gvMeasure.isShowingGuide.value = false;
    });
  }
  // 현재 화면에 표시되고 있는 가이드알림이 있을 경우, 타이머 종료 후 가이드알림을 화면에서 닫고 새 가이드알림을 표시하고 타이머 설정
  else {
    gvMeasure.guideCloseTimer?.cancel();
    gvMeasure.isShowingGuide.value = false;
    await Future.delayed(const Duration(milliseconds: 200));
    gvMeasure.isShowingGuide.value = true;
    gvMeasure.guideCloseTimer = Timer(const Duration(seconds: 2), () {
      gvMeasure.isShowingGuide.value = false;
    });
  }
}

void showBarText(EmlTargetResult value) async {
  if (value == EmlTargetResult.perfect) {
    gvMeasure.barText = '훌륭해요!';
  } else if (value == EmlTargetResult.success) {
    gvMeasure.barText = '좋아요!';
  }

  // 현재 화면에 바 그래프 위에 텍스트가 없을 경우 텍스트를 표시하고 타이머 설정
  if (gvMeasure.isShowingBarText.value == false) {
    gvMeasure.isShowingBarText.value = true;
    gvMeasure.previousValue = value;
    gvMeasure.barTextCloseTimer = Timer(const Duration(milliseconds: 1000), () {
      gvMeasure.isShowingBarText.value = false;
    });
  }
  // 현재 화면에 표시되고 있는 가이드알림이 있을 경우, 타이머 종료 후 가이드알림을 화면에서 닫고 새 가이드알림을 표시하고 타이머 설정
  else {
    if (value == gvMeasure.previousValue) {
      gvMeasure.barTextCloseTimer?.cancel();
      gvMeasure.barTextCloseTimer =
          Timer(const Duration(milliseconds: 1000), () {
        gvMeasure.isShowingBarText.value = false;
      });
      return;
    } else if (value != gvMeasure.previousValue &&
        value == EmlTargetResult.success) {
      // 현재 '훌륭해요!' 가 화며에 표시되고 있다면 타이머가 종료될때까지 '좋아요!'는 무시
      return;
    }
    gvMeasure.barTextCloseTimer?.cancel();
    gvMeasure.isShowingBarText.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
    gvMeasure.isShowingBarText.value = true;
    gvMeasure.previousValue = value;
    gvMeasure.barTextCloseTimer = Timer(const Duration(milliseconds: 1000), () {
      gvMeasure.isShowingBarText.value = false;
    });
  }
}

//==============================================================================
// MVC 기준 값을 새로 계산한 값으로 변경
// 측정 중에 사용자가 버튼을 눌러서 갱신
// idel 화면에서 측정 시작시 실행
//==============================================================================
void initMeasure() {
  // 새롭게 측정이 시작하면 "1RM 현재 값으로 갱신" 버튼 활성화
  // 전극을 새로 붙인 경우에만 활성화!
  // 한번 비활성화 되면, 전극을 새로 붙이기 전까지 계속 비활성화
  // gv.deviceData[0].disableReset1RM.value = false;
  gvMeasure.isMvcChanged.value = false;
  gvMeasure.flagAoeComplete = false;
  gvMeasure.isGuideDownPosition = false;

  if (gvMeasure.isShowingGuide.value != false) {
    gvMeasure.isShowingGuide.value = false;
  }

  // 실시간 보고서 저장하기가 활성화 되어있을 경우, 실시간 측정 데이터와 csv 파일을 저장하는 함수를 연결
  if (DspCommonParameter.enableRtDataReport) {
    int fileNumber = 0;
    dm[0].g.rtReportData.init();  // afe, emg 를 저장하는 리스트 변수 초기화
    gvMeasure.rtReportListener = dm[0].g.rtReportData.isDataAvailable.listen((value) {
      if(value==true){
        List<List<double>> result = dm[0].g.rtReportData.getRtData();
        saveCsvFile(fileName: 'test${fileNumber.toString()}', dataList: result);
        fileNumber++;
        if(fileNumber > 9){
          fileNumber = 0;
        }
      }
    });
  }

  // 셋트 운동량이 100% 이상이 되면 가이드알림 표시를 위한 리스너
  gvMeasure.aoeSetListener = gv.deviceData[0].aoeSet.listen((value) {
    if (value >= GvDef.aoeFull && gvMeasure.flagAoeComplete == false) {
      gvMeasure.guideText = '1세트 완료!';
      gvMeasure.guideImage = gvMeasure.aoeCompleteImage;
      gvMeasure.guideBackgroundColor = tm.mainBlue;
      gvMeasure.guideWidgetHeight = asHeight(50);
      showGuide();
      gvMeasure.flagAoeComplete = true;
    }
  });

  // 최대 근력이 갱신되면 가이드알림 표시를 위한 리스너
  gvMeasure.mvcListener = gv.deviceData[0].mvc.listen((value) {
    // if(gvMeasure.disableReset1RM.value == false) {
    //   gvMeasure.disableReset1RM.value = true;
    // }
    // print(' :: initMeasure :: mvc갱신=$value  mvcRef=${dm[0].g.parameter.mvcRef}');
    if (gvMeasure.isMvcChanged.value == false &&
        value > dm[0].g.parameter.mvcRef) {
      gvMeasure.isMvcChanged.value = true;
      // 최대근력이 갱신되면, 최대근력 재설정 버튼 비활성화
      gv.deviceData[0].disableReset1RM.value = true;
      //최대 근력 갱신에 따라 측정 페이지 상단 layout height 변경으로 가이드 메세지 위치 변경
      gvMeasure.isGuideDownPosition = true;
    }

    if (value <= dm[0].g.parameter.mvcRef) {
      gvMeasure.guideText = '최대근력이 재설정 되었습니다';
    } else {
      gvMeasure.guideText = '최대근력 갱신!';
    }
    gvMeasure.guideImage = gvMeasure.mvcUpdateAnimation;
    gvMeasure.guideBackgroundColor = tm.mainBlue;
    gvMeasure.guideWidgetHeight = asHeight(50);
    showGuide();
  });

  gvMeasure.electrodeQualityGradeListener =
      gv.deviceData[0].electrodeQualityGrade.listen((value) {
    if (value == 4) {
      gvMeasure.guideText = '전극이 피부에서 떨어졌습니다\n전극이 잘 붙어 있는지 확인 하세요';
      gvMeasure.guideBackgroundColor = tm.red;
    } else if (value == 3 || value == 2) {
      gvMeasure.guideText = '장비의 접촉상태가 불안정합니다\n전극이 잘 붙어 있는지 확인 하세요';
      gvMeasure.guideBackgroundColor = tm.yellow;
    }
    gvMeasure.guideImage = gvMeasure.noticeImage;
    gvMeasure.guideWidgetHeight = asHeight(35) *
        2; // 접촉 불량 관련 메세지(가이드)의 경우 메세지가 길어 2줄로표시해야 하므로 widget height 를 키움
    showGuide();
  });
}

void endMeasure() {
  gvMeasure.rtReportListener?.cancel();
  gvMeasure.guideCloseTimer?.cancel();
  gvMeasure.aoeSetListener?.cancel();
  gvMeasure.mvcListener?.cancel();
  gvMeasure.electrodeQualityGradeListener?.cancel();
  gvMeasure.isShowingGuide.value = false;
}

//==============================================================================
// 측정 결과 csv 파일로 저장
// todo : 아래 코드를 참조하여 파일로 저장 하기
//==============================================================================
Future<void> saveCsvFile(
    {required String fileName, required List<List<double>> dataList}) async {
  // Android 11 이상일 경우, 저장할 디렉토리를 사용자로부터 입력 필요
  if (Platform.isAndroid && int.parse(gv.system.osVersion!) > 10) {
    gvMeasure.externalDirectoryUri = await selectFileDirectory();

    //사용자로부터 입력받은 폴더가 없을 경우, 프로세스 종료
    if (gvMeasure.externalDirectoryUri == null) {
      openSnackBarBasic('EDF 생성 실패', '저장할 폴더를 선택하지 않아 종료합니다.');
      return;
    }
  }

  // CSV 파일에 입력할 데이터를 넣을 변수. 바깥쪽 리스트는 행, 안쪽은 열
  List<List<String>> csvData = [];

  // afe 데이터
  csvData.add(dataList[0].map((e) => e.toPrecision(4).toString()).toList());
  // emg 데이터
  csvData.add(dataList[1].map((e) => e.toPrecision(4).toString()).toList());

  //------------------------------------------------------------------------
  // 준비된 CSV 데이터를 CSV 형식의 String 으로 변환하여 파일에 쓰기
  //------------------------------------------------------------------------
  String csv = const ListToCsvConverter().convert(csvData);
  Directory appDirectory = Platform.isIOS
      ? await getApplicationSupportDirectory()
      : await getApplicationDocumentsDirectory();
  String path = join(appDirectory.path, 'CSV.csv');
  final File csvFile = File(path);
  csvFile.writeAsStringSync(csv);

  await saveFileAtVisibleDirectory(
    newFileNames: ['$fileName.csv'],
    files: [csvFile],
    externalDirectoryUri: gvMeasure.externalDirectoryUri,
  );

  // 선택한 폴더로 파일을 복사하였으므로 앱 디렉토리의 파일 삭제
  if (File(path).existsSync()) {
    File(path).deleteSync(); // 이전 파일 삭제
  }
}
