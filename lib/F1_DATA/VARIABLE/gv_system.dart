import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
import 'package:new_version_plus/new_version_plus.dart';

//==============================================================================
// 시스템 관련 정보
//==============================================================================
class GvSystem {
  //----------------------------------------------------------------------------
  // 시스템 기본 정보
  //----------------------------------------------------------------------------
  //--------------화면 크기 추정
  bool isPhone = false; //폰 여부
  bool isTablet = false; //태블릿 여부
  bool isSmallTablet = false; //600~720P 태블릿 여부
  bool isLargeTablet = false; //720P 이상 태블릿 여부
  //--------------화면 방향 (계속 변하는 값)
  bool isLandScape = false; //가로방향
  bool isPortrait = false; //세로방향
  //--------------OS 종류
  bool isAndroid = false; //안드로이드 여부
  bool isIos = false; //iOS 여부
  bool isMacOs = false; //MAC OS 여부
  bool isWindows = false; //윈도우 여부
  bool isLinux = false; //리눅스 여부
  bool isFuchsia = false; //퓨시아 여부
  //--------------device 종류
  bool isMobile = false; //mobile 여부
  bool isDesktop = false; //데스크탑 여부
  //--------------- OS & SDK 버전
  String? osVersion;
  int? osSdkVersion;

  //--------------- 앱 정보
  String appName = '';        // 앱 이름 (= 핏시그 베이직)
  String packageName = '';    // 패키지 이름(= com.fitsig.fitsig-basic)
  String localVersion = '';     // device 에 설치되어있는 앱의 버전
  String appBuildNumber = '';   // device 에 설치되어있는 앱의 버전의 빌드 넘버
  String storeVersion = '';     // Store 에 있는 앱의 버전 (최신)
  Uri storeUri = Uri();
  Uri storeDownloadUri = Uri();   // 앱을 다운 받을 수 있는 url (구글은 storeUri 와 동일, apple 은 다름)
  Rx<bool> isNeedUpdate = false.obs;
  late NewVersionPlus appVersion = NewVersionPlus(iOSId: 'com.fitsig.fitsig-basic', androidId: 'com.fitsig.fitsig_basic', androidPlayStoreCountry: 'ko_KR', iOSAppStoreCountry: 'KR' );
  late VersionStatus versionStatus;

  //----------------------------------------------------------------------------
  // 레이아웃
  //----------------------------------------------------------------------------
  double maxHeightExcludeTopPadding = 700;
  //top padding (safety area)을 제외한 최고 높이
  // 화면이 변경되거나 context에 따라 달라질 수도 있으니 사용에 주의

  //----------------------------------------------------------------------------
  // 네트웍크/서버 정보
  //----------------------------------------------------------------------------
  String smartPhoneId = '';
  bool isServerConnected = false;

  //----------------------------------------------------------------------------
  // 사용자 정보
  //----------------------------------------------------------------------------
  bool isFirstUser = true;
  //----------------------------------------------------------------------------
  // 튜토리얼 진행 여부 (향후 필요시 다양하게 추가)
  //----------------------------------------------------------------------------
  bool isCompleteTutorialCamera = false;
  bool isCompleteTutorialElectrodeQuality = false;
  bool isCompleteTutorialDeviceConnect = false;

}
