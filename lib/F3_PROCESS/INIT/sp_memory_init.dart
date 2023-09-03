import '/F0_BASIC/common_import.dart';

//==============================================================================
// 통계 데이터 베이스 초기화
// 마지막 선택된 근육 정보
//==============================================================================
Future<void> sharedPreferenceInit({bool deleteSp = false}) async {
  if (kDebugMode) {
    print('공유 메모리 정보 읽기');
  }

  // gv.spMemory.erase(); //전체 지우기

  // gv.spMemory.write('idxMuscle.value', 1); //공유 메모리 기록

  //----------------------- 선택된 근육 정보
  // if (gv.spMemory.read('idxMuscle.value') != null) {
  //   gv.control.idxMuscle.value= gv.spMemory.read('idxMuscle.value');
  //   if (kDebugMode) {
  //     print(gv.spMemory.read('idxMuscle.value'));
  //   }
  // }
  // else{
  //   print('value is null');
  // }
  //----------------------------------------------------------------------------
  // 데이터 삭제 (기록삭제 시 DB와 함께 실행하는 것 필요)
  //----------------------------------------------------------------------------
  if (deleteSp == true) {
    gv.spMemory.erase(); //기존 기록 지우기
  }

  //----------------------------------------------------------------------------
  // 화면 관련 사용자 정보
  //----------------------------------------------------------------------------
  //----------------------- 선택된 근육 정보
  gv.control.idxMuscle.value = gv.spMemory.read('idxMuscle.value') ?? 0;
  if (kDebugMode) {
    print('근육 번호 : ${gv.control.idxMuscle.value}');
  }

  //----------------------- 측정화면 간단/상세 보기
  gvMeasure.isViewMeasureSimple =
      gv.spMemory.read('isViewMeasureSimple') ?? true;
  //----------------------- 기록화면 리스트/통계 보기 - 리스트 보기가 기본
  gvRecord.isSelectedStatsView.value =
      gv.spMemory.read('isSelectedStatsView') ?? false;
  //----------------------- 기록화면 리스트 간단/상세 보기 - 상세 보기가 기본
  gvRecord.isViewListSimple.value =
      gv.spMemory.read('isViewListSimple') ?? false;

  //----------------------- 통계화면 그래프 표시 기간
  gvRecord.graphTimePeriod.value = (gv.spMemory.read('graphTimePeriodIndex')!=null) ? GraphTimePeriod.values[gv.spMemory.read('graphTimePeriodIndex')]: GraphTimePeriod.aMonth;


  //----------------------------------------------------------------------------
  // 일반 설정 관련
  //----------------------------------------------------------------------------
  //----------------------- 스킨 컬러
  gv.setting.skinColor.value = gv.spMemory.read('skinColor') ?? 0;
  //----------------------- 빅폰트
  gv.setting.isBigFont.value = gv.spMemory.read('isBigFont') ?? false;
  if (gv.setting.isBigFont.value == true) {
    //빅 폰트 인 경우
    gv.setting.bigFontAddVal = 5;
    tm.convertFontSize();
  }
  //------------------------ 블루투스 자동연결
  gv.setting.isBluetoothAutoConnect.value =
      gv.spMemory.read('isBluetoothAutoConnect') ?? false;

  //----------------------- 성별 (0=남자 1 = 여자, 2 = 기타)
  gv.setting.genderIndex.value = gv.spMemory.read('genderIndex') ?? 2;
  //----------------------- 출생연도 (0=~1940 1 = ~1950 .... 6 = ~2000 ...)
  gv.setting.bornYearIndex.value = gv.spMemory.read('bornYearIndex') ?? 6;

  //----------------------------------------------------------------------------
  // 운동 설정 관련
  //----------------------------------------------------------------------------
  // 순 우리말 여부 읽어 오기
  gv.setting.is1RmAutoEstimate.value = gv.spMemory.read('is1RmAutoEstimate') ??
      GvSetting().is1RmAutoEstimate.value;

  // 자동 초기화 설정 읽어오기
  gv.setting.is1RmAutoEstimate.value = gv.spMemory.read('is1RmAutoEstimate') ??
      GvSetting().is1RmAutoEstimate.value;

  // 충격 감지 기능 읽어오기
  gv.setting.is1RmAutoEstimate.value = gv.spMemory.read('is1RmAutoEstimate') ??
      GvSetting().is1RmAutoEstimate.value;

  // 최대근력 디폴트 슬라이드 값 읽어오기
  gv.setting.mvcDefaultValue.value =
      gv.spMemory.read('mvcDefaultValue') ?? GvSetting().mvcDefaultValue.value;

  // 데모 신호 생성여부
  // 주석처리 함 (오동작 막기 위해) 23.2.18
  // gv.setting.isEnableDemo.value =
  //     gv.spMemory.read('isEnableDemo') ?? GvSetting().isEnableDemo.value;

  // 운동 가이드 방식
  // gv.setting.isGuideTypeTime.value =
  //     gv.spMemory.read('isGuideTypeTime') ?? GvSetting().isGuideTypeTime.value;

  // 평균과 시간 표시
  gv.setting.isViewAvMax.value =
      gv.spMemory.read('isViewAvMax') ?? GvSetting().isViewAvMax.value;

  // 단위 표시
  gv.setting.isViewUnitKgf.value =
      gv.spMemory.read('isViewUnitKgf') ?? GvSetting().isViewUnitKgf.value;
  //----------------------------------------------------------------------------
  // 기타 설정 관련
  //----------------------------------------------------------------------------
  // 처음사용자 여부 읽기
  gv.system.isFirstUser = gv.spMemory.read('isFirstUser') ?? true;
  // gv.system.isFirstUser = true; //시험목적
  // 첫 사용자라면 튜토리얼 단계적으로 보여주기
  if (gv.system.isFirstUser == true){
    dvIntro.cntIsViewTutorial.value = 4; //4가지 보여주기
    // gvIntro.isViewTutorialContactQuality.value = true;
    // gvIntro.isViewTutorialBtConnectFull.value = true; //대화면
    // gvIntro.isViewTutorialBtConnect.value = true; //작은 화면
    // gvIntro.isViewTutorialCamera.value = true;
  }

  // print('gv.system.isFirstUser ${gv.system.isFirstUser}');
  // 오늘 날짜 읽기
  int dateToday = todayInt8();
  // 고객 의견 횟수 읽기
  gv.setting.cntSuggestionTransfer.value =
      gv.spMemory.read('cntSuggestionTransfer') ?? 0;
  // 카운트 기록된 날짜 (없다면 오늘 날짜로 기록)
  gv.setting.dateSuggestion = gv.spMemory.read('dateSuggestion') ?? dateToday;
  // 만약 카운트 기록 날짜와 오늘 날짜가 다르다면 : 카운트 값 초기화
  if (dateToday != gv.setting.dateSuggestion) {
    gv.setting.cntSuggestionTransfer.value = 0;
    gv.spMemory
        .write('cntSuggestionTransfer', gv.setting.cntSuggestionTransfer.value);
  }
}
