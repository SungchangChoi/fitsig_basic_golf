import '/F0_BASIC/common_import.dart';

//==============================================================================
// 장비별 데이터 - 화면 표시에 주로 활용 됨
//==============================================================================
class GvDeviceData {
  //----------------------------------------------------------------------------
  // 입력 신호
  //----------------------------------------------------------------------------
  RxDouble emgData = 0.0.obs; //실시간 근전도 신호
  double emgTime = 0; //시간 데이터
  double emgDataAv = 0.0; //실시간 근전도 평균 값
  double emgDataMax = 0.0; //실시간 근전도 최대 값

  RxInt countNum = 0.obs; //측정된 반복 횟수

  RxDouble aoeSet = 0.0.obs; //세트 운동량
  RxDouble aoeTargetSet = 0.0.obs; //세트 목표영역 운동량

  RxInt electrodeQualityGrade = 0.obs; //전극 접촉 품질

  //----------------------------------------------------------------------------
  // 화면표시
  //----------------------------------------------------------------------------
  RxString muscleName = '근육이름'.obs; //현재 근육 명

  Rx<String> imagePath = ''.obs;

  // ignore: unnecessary_Cast
  Uint8List? imageBytes = (null as Uint8List?);
  RxInt muscleTypeIndex = 0.obs; //현재 근육 종류
  RxBool isLeft = true.obs; //좌우 여부

  // String muscleTypeIndexApi(int idx) {
  //   //0 미선택, 1 팔, 2 어깨, 3 가슴, 4 복부, 5 등, 6 엉덩이, 7 다리
  //   if (idx == 0) {
  //     return 'unspecified'; //미선택
  //   } else if (idx == 1) {
  //     return 'arm';
  //   } else if (idx == 2) {
  //     return 'shoulder';
  //   } else if (idx == 3) {
  //     return 'chest';
  //   } else if (idx == 4) {
  //     return 'abdomen'; //복부
  //   } else if (idx == 5) {
  //     return 'back'; //등
  //   } else if (idx == 6) {
  //     return 'hip'; //엉덩이
  //   } else {
  //     return 'leg'; //다리
  //   }
  // }

  RxInt targetPrm = 0.obs; //목표 PRM
  RxInt targetCount = 0.obs; //목표 반복횟수
  RxDouble mvc = 0.0.obs; //최대근력
  RxDouble freqBegin = GvDef.freqInit.obs; //시작 주파수
  RxDouble freqEnd = GvDef.freqInit.obs; //종료 주파수

  //----------------------------------------------------------------------------
  // 근전도 데이터 버퍼링 (40ms 주기)
  //----------------------------------------------------------------------------
  // 근전도 데이터
  List<double> yData = List<double>.generate(GvDef.lenTimeGraph, (index) => 0);

  // 시간 데이터
  List<double> xData = List<double>.generate(
      GvDef.lenTimeGraph,
      (index) =>
          (index * DefDsp.fastPeriod) -
          (GvDef.lenTimeGraph * DefDsp.fastPeriod));

  //----------------------------------------------------------------------------
  // 심진도데이터 버퍼링 (20ms 주기)
  //----------------------------------------------------------------------------
  // 심전도 데이터
  List<double> ecgYData =
      List<double>.generate(GvDef.lenTimeGraph * 2, (index) => 0);

  // 시간 데이터
  List<double> ecgXData = List<double>.generate(
      GvDef.lenTimeGraph * 2,
      (index) =>
          (index * DefDsp.fastPeriod * 0.5) -
          (GvDef.lenTimeGraph * 2 * DefDsp.fastPeriod * 0.5));

  // 심박 카운트 데이터
  List<double> ecgCountData = [];
  List<double> ecgCountTime  = [];
  // List<double>.generate(GvDef.lenTimeGraph * 2, (index) => 0);


  //----------------------------------------------------------------------------
  // 카운트 데이터 버퍼링
  //----------------------------------------------------------------------------
  List<double> yMark = []; //근전도 마크
  List<double> xMark = []; //시간 마크

  //----------------------------------------------------------------------------
  // 최대근력 제어
  //----------------------------------------------------------------------------
  RxBool disableReset1RM = false.obs;

  // 측정 중 "1RM을 현재 값으로 갱신" 버튼을 한번이라도 누르면 true 로 변경
  // 전극을 새로 붙이는 경우에만 false

  //----------------------------------------------------------------------------
  // 초기화
  //----------------------------------------------------------------------------
  initData() {
    //---------------------------------------
    // 시간 및 근전도 데이터 초기화
    yData = List<double>.generate(GvDef.lenTimeGraph, (index) => 0);
    xData = List<double>.generate(
        GvDef.lenTimeGraph,
        (index) =>
            (index * DefDsp.fastPeriod) -
            (GvDef.lenTimeGraph * DefDsp.fastPeriod));
    //---------------------------------------
    // 심전도 데이터 초기화
    ecgYData = List<double>.generate(GvDef.lenTimeGraph * 2, (index) => 0);
    ecgXData = List<double>.generate(
        GvDef.lenTimeGraph * 2,
        (index) =>
            (index * DefDsp.fastPeriod * 0.5) -
            (GvDef.lenTimeGraph * 2 * DefDsp.fastPeriod * 0.5));
    //---------------------------------------
    // 심박 데이터 초기화
    ecgCountData = [];
    ecgCountTime = [];
    //---------------------------------------
    // 카운트 데이터
    yMark = []; //근전도 마크
    xMark = []; //시간 마크
  }
}
