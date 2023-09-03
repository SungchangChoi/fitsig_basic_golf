import '/F0_BASIC/common_import.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:new_version_plus/new_version_plus.dart';
import 'package:path_provider/path_provider.dart';

//==============================================================================
// main 실행 전 사전 실행 함수
//==============================================================================
Future<void> preAppProcess() async {
  //--------------------------------
  // OS 정보 획득
  await readOsInfo();
  // App 정보 획득
  await readAppInfo();

  if (kDebugMode) {
    String time = printPresentTime(printEnable: false);
    print('□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□ [BOOT TIME CHECK] '
        'readAppInfo(); $time');
  }

  //--------------------------------
  // DSP 모듈 초기화
  DspManager.initModule();

  //--------------------------------
  // 데이터 베이스 초기화 (delay 가 크다면 splash 이후에 할 수도 있음)

  //--------------------------------
  // 공유메모리 초기화 대기
  // iOS 에서 GetStorage.init() 을 사용할 경우 Document 디렉토리에 생성되어 접근이 가능하게 되므로 주석처리(2023.02.06)
  // 대신 path 를 지정할 수있는 GetStorage 컨스트럭터 를 이용

  // await GetStorage.init();
  Directory getStorageDir = await getApplicationSupportDirectory();
  Platform.isIOS ? GetStorage('FitsigStorage', getStorageDir.path) : await GetStorage.init();

  //----------------------------------------------------------------------------
  // 사용할 언어는 공유메모리에서 먼저 읽어오기
  //----------------------------------------------------------------------------
  // 장비에서 설정 된 지역 설정 읽기
  var locale = Get.deviceLocale;
  int defaultIndex =
      LanguageData.supportedLocales.indexWhere((element) => element == locale);
  // 검색되지 않는 기타 국가의 경우 모두 미국식 영어로 설정
  if (defaultIndex < 0) {
    defaultIndex = 1;
  }
  // 설정된 언어가 있으면 해당 언어로 읽기, 없으면 기본 언어 인덱스로 설정
  gv.setting.languageIndex.value =
      gv.spMemory.read('languageIndex') ?? defaultIndex;

  //--------------------------------
  // task 생성
  task100ms();
  task1s();
  // checkBluetoothDisconnection();

  //--------------------------------
  // 테스트 코드
  //json 변환 시험 임시 코드
  //jsonTest();
  //데이터 베이스 테스트
  // dbBasicTest();
}

//==============================================================================
// 시스템 기본 정보 읽기
//==============================================================================
Future<void> readOsInfo() async {
  //----------------------------------------------------------------------------
  // OS 종류
  gv.system.isAndroid = GetPlatform.isAndroid;
  gv.system.isIos = GetPlatform.isIOS;
  gv.system.isMacOs = GetPlatform.isMacOS;
  gv.system.isWindows = GetPlatform.isWindows;
  gv.system.isLinux = GetPlatform.isLinux;
  gv.system.isFuchsia = GetPlatform.isFuchsia;
  //----------------------------------------------------------------------------
  // device 종류
  //--------------device 종류
  gv.system.isMobile = GetPlatform.isMobile;
  gv.system.isDesktop = GetPlatform.isDesktop;
  gv.system.osVersion = await getDeviceVersion();
  gv.system.osSdkVersion = await getDeviceSdkVersion();

  if (kDebugMode) {
    print('===============================================================');
    print('  FITSIG BASIC APP ${GvDef.appVersion}');
    print('===============================================================');
    print('GvSystem.isAndroid [${gv.system.isAndroid}]');
    print('GvSystem.isIos [${gv.system.isIos}]');
    print('GvSystem.isMacOs [${gv.system.isMacOs}]');
    print('GvSystem.isWindows [${gv.system.isWindows}]');
    print('GvSystem.isLinux [${gv.system.isLinux}]');
    print('GvSystem.isFuchsia [${gv.system.isFuchsia}]');
    print('GvSystem.isMobile [${gv.system.isMobile}]');
    print('GvSystem.isDesktop [${gv.system.isDesktop}]');
  }
}

Future<void> readAppInfo() async {
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    gv.system.appName = packageInfo.appName;
    gv.system.packageName = packageInfo.packageName;
    gv.system.localVersion = packageInfo.version;
    gv.system.appBuildNumber = packageInfo.buildNumber;
  });
}

//----------------------------------------------------------------------------
//Device 의 OS version 정보를  가져오는 메소드
//----------------------------------------------------------------------------
Future<String?> getDeviceVersion() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String? deviceVersion;
  try {
    if (Platform.isAndroid) {
      deviceVersion = await deviceInfoPlugin.androidInfo
          .then((value) => value.version.release);
    } else if (Platform.isIOS) {
      await deviceInfoPlugin.iosInfo.then((value) => value.systemVersion);
    }
  } catch (error) {
    deviceVersion = 'Error: Fail to get OS version ';
  }
  return deviceVersion;
}

//----------------------------------------------------------------------------
//Device 의 OS SDK version 정보를  가져오는 메서드
//----------------------------------------------------------------------------
Future<int?> getDeviceSdkVersion() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  int? deviceVersion;
  try {
    if (Platform.isAndroid) {
      deviceVersion = await deviceInfoPlugin.androidInfo
          .then((value) => value.version.sdkInt);
    } else if (Platform.isIOS) {
      String? deviceVersionString =
          await deviceInfoPlugin.iosInfo.then((value) => value.systemVersion);
      if (deviceVersionString != null) {
        deviceVersion = int.parse(deviceVersionString);
      } else {
        deviceVersion = null;
      }
    }
  } catch (error) {
    deviceVersion = -1;
  }
  return deviceVersion;
}

//----------------------------------------------------------------------------
// App 의 update 가 필요한지 확인하는 메서드
//----------------------------------------------------------------------------
Future<void> checkUpdate() async {
  // await getAppleStoreVersion();
  await getStoreVersion();
  // if (Platform.isAndroid) {
  //   await getAndroidStoreVersion(gv.system.localVersion, gv.system.packageName);
  // } else if (Platform.isIOS) {
  //   await getAppleStoreVersion(gv.system.localVersion, gv.system.packageName);
  // } else {
  //   print(
  //       'The target platform "${Platform.operatingSystem}" is not yet supported by this package.');
  // }
  // print('pre_init :: checkUpdate() : local :${gv.system.localVersion}  store:${gv.system.storeVersion}');
  // print('pre_init :: checkUpdate() : 직접:${gv.system.storeUri.toString()}  업데이트패키지:${gv.system.versionStatus.appStoreLink}');
  gv.system.isNeedUpdate.value = convertVersion(
      version: gv.system.localVersion, versionStore: gv.system.storeVersion);
}


//----------------------------------------------------------------------------
// version 정보들을 비교하여 update 가 필요한지 판단하는 메서드
//----------------------------------------------------------------------------
bool convertVersion({String? version, String? versionStore}) {
  List<String>? localVersion = [];
  List<String>? storeVersion = [];

  /// verify version string contains + char.
  if (version!.contains('+')) {
    localVersion = [version.split('+').last];
  }

  /// add all values of array in localVersion array.
  localVersion.addAll(
      [version.split('.')[0], version.split('.')[1], version.split('.')[2][0]]);

  /// verify if exist + char in content version string.
  if (versionStore!.contains('+')) {
    storeVersion = [versionStore.split('+').last];
  }

  /// add all elements of array.
  storeVersion.addAll([
    versionStore.split('.')[0],
    versionStore.split('.')[1],
    versionStore.split('.')[2][0]
  ]);

  /// Loop for verify values.
  for (int i = 0; i < localVersion.length; i++) {
    // print('pre_init :: checkUpdate :  localVerson[$i]=${localVersion[i]} stroeVersion[$i]=${storeVersion[i]}');

    /// if any of the store elements is smaller than a corresponding element of local version we will exit the function with false.
    if (int.parse(storeVersion[i]) < int.parse(localVersion[i])) {
      return false;
    }

    /// if any element of the store version is greater than the corresponding local version, there is an update.
    if (int.parse(storeVersion[i]) > int.parse(localVersion[i])) {
      return true;
    }
  }

  /// default false
  return false;
}



//----------------------------------------------------------------------------
//  new_version_plus 패키지를 사용할 경우 store 에서 버전을 받아오는 메서드
//----------------------------------------------------------------------------
Future<void> getStoreVersion() async {
  VersionStatus? versionStatus = await gv.system.appVersion.getVersionStatus();
  if(versionStatus != null){
    gv.system.versionStatus = versionStatus;
    gv.system.storeVersion = versionStatus.storeVersion;
  }
}


//----------------------------------------------------------------------------
// Android 일 경우, google store 에서 app version 정보를 가져오는 메서드
//----------------------------------------------------------------------------
// Future<void> getAndroidStoreVersion(
//     String currentVersion, String packageName) async {
//   String? errorMsg;
//   String country = "ko_KR";
//   gv.system.storeUri = Uri.https("play.google.com", "/store/apps/details",
//       {"id": packageName, "hl": country});
//   try {
//     final response = await http.get(gv.system.storeUri);
//     if (response.statusCode != 200) {
//       errorMsg =
//           "Can't find an app in the Google Play Store with the id: $packageName";
//     } else {
//       gv.system.storeVersion = RegExp(r',\[\[\["([0-9,\.]*)"]],')
//               .firstMatch(response.body)!
//               .group(1) ??
//           '0.0.0';
//       gv.system.storeDownloadUri = gv.system.storeUri;
//     }
//   } catch (e) {
//     errorMsg = "$e";
//   }
// }

//----------------------------------------------------------------------------
// Apple 일 경우, apple store 에서 app version 정보를 가져오는 메서드
//----------------------------------------------------------------------------
// Future<void> getAppleStoreVersion() async {
//   String? errorMsg;
//   String country = 'KR';
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   String packageName = packageInfo.packageName;
//   final parameters = {"bundleId": packageName};
//   parameters.addAll({"country": country});
//   gv.system.storeUri = Uri.https("itunes.apple.com", "/lookup", parameters);
//
//   try {
//     final response = await http.get(gv.system.storeUri);
//     if (response.statusCode != 200) {
//       errorMsg =
//           "Can't find an app in the Apple Store with the id: $packageName";
//     } else {
//       final jsonObj = jsonDecode(response.body);
//       final List results = jsonObj['results'];
//       if (results.isEmpty) {
//         errorMsg =
//             "Can't find an app in the Apple Store with the id: $packageName";
//       } else {
//         gv.system.storeVersion = jsonObj['results'][0]['version'];
//         gv.system.storeDownloadUri = Uri.parse(results.first['trackViewUrl']);
//       }
//     }
//     print('pre_init :: getAppleStoreVersion : storeVersion=${gv.system.storeVersion}');
//   } catch (e) {
//     errorMsg = "$e";
//   }
// }
