import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
import 'package:lottie/lottie.dart';

//==============================================================================
// measure 관련 전역변수
//==============================================================================
GvMeasure gvMeasure = GvMeasure();

class GvMeasure {
  //----------------------------------------------------------------------------
  // 화면 보기 관련
  //----------------------------------------------------------------------------
  bool isViewMeasureSimple = false;

  RxBool showBubble = false.obs;
  Timer? showBubbleTimer;

  // preMVC 로 사용하는 dm[0].g.parameter.mvcRef 는 측정중에는 변하지 않음
  // 측정이 끝나고 저장을 하였을 때만 갱신됨
  // 측정중에 "최대 근력 재설정"을 터치하더라도 현재 MVC(gv.deviceData[0].mvc.value)만 수정됨
  RxBool isMvcChanged = false.obs; // 과거운동에서 측정한 MVC 보다 높은 값이 측정되면, 측정 페이지의 TopBar 높이가 변하고 이를 인지하기 위한 변수
  // RxBool disableReset1RM =
  //     false.obs; // 측정 중 "1RM을 현재 값으로 갱신" 버튼을 한번이라도 누르면 true 로 변경
  RxBool isShowingGuide = false.obs;  // 현재 화면에 가이드알림이 표시되고 있으면 true, 아니면 false
  bool flagAoeComplete = false; // 운동량이 100%를 처음 달성했을때 1번만 실행되도록 하기위한 flag
  Timer? guideCloseTimer; // 가이드 알림을 닫는 이벤트를 발생시키는 타이머
  String guideText='';
  Widget? guideImage;
  Color? guideBackgroundColor;
  bool isGuideDownPosition = false;  //측정 화면에서 "최대근력갱신", "1세트 완료" 등의 가이드 메세지 표시 위치 참고용(최대 근력 갱신시 페이지 상단 layout 이 변경되기때문)
  double guideWidgetHeight = asHeight(50);

  RxBool isShowingBarText = false.obs;  // 현재 근활성도 바그래프 위에 텍스트가 표시되고 있으면 true, 아니면 false
  RxBool isBarTextChanged = false.obs;  // 근활성도 바그래프 위의 텍스트 변경을 표시
  String barText='';  //측정 중 화면에서 근활성도 바그래프 위에 표시되는 텍스트
  Timer? barTextCloseTimer; // 가이드 알림을 닫는 이벤트를 발생시키는 타이머
  EmlTargetResult previousValue=EmlTargetResult.none;


  //----------------------------------------------------------------------------
  // 측정 중 "최대근력갱신", "1세트 완료", "전극 부착 상태" 알람을 계산하기 위해 받아보는 리스너
  //----------------------------------------------------------------------------
  StreamSubscription<double>? aoeSetListener;
  StreamSubscription<double>? mvcListener;
  StreamSubscription<int>? electrodeQualityGradeListener;


  StreamSubscription<bool>? rtReportListener;

  //----------------------------------------------------------------------------
  // 측정 화면에서 "최대근력갱신", "1세트 완료"에 사용되는 이미지 변수(simple, detail 에서 모두 사용하므로 공용변수로 여기저장)
  //----------------------------------------------------------------------------
  Image aoeCompleteImage = Image.asset('assets/icons/ic_shooting_star.png',
      fit: BoxFit.scaleDown, height: asHeight(24));
  Image noticeImage = Image.asset('assets/icons/ic_notice.png',
      fit: BoxFit.scaleDown, height: asHeight(24), color: Colors.white,);
  Widget mvcUpdateAnimation = Lottie.asset('assets/images/최대근력 달성 애니메이션.json');

  //----------------------------------------------------------------------------
  // 근육 설정 관련 변수
  //----------------------------------------------------------------------------
  // RxDouble sliderValueTargetPrm = 0.0.obs; //목표
  double sliderValueTargetPrm = 0.0; //목표 레벨
  double sliderValueMvc = 0.0; //최대근력 레벨
  double sliderMvcMaxRange = 0; // 0 ~ 4

  //----------------------------------------------------------------------------
  // 심전도 보기
  //----------------------------------------------------------------------------
  bool isViewEcg = false;


  //----------------------------------------------------------------------------
  // 운동 종료 단계
  //----------------------------------------------------------------------------
  // RxBool isIgnoreNew1rm = false.obs;

  //----------------------------------------------------------------------------
  // 애니메이션 관련
  //----------------------------------------------------------------------------
  RxInt animationCounter = 0.obs;
  int cntTargetArea = 0; //0 이상이면 기존 애니메이션 동작 중

  //----------------------------------------------------------------------------
  // 외부 저장 폴더 Uri
  //----------------------------------------------------------------------------
  Uri? externalDirectoryUri;

}
