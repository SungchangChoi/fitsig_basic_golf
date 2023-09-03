import '/F0_BASIC/common_import.dart';
import '/F7_UI/P30_RECORD/generate_dbmuscle_contents.dart';
import 'package:platform_device_id/platform_device_id.dart';

//==============================================================================
// 앱 초기 splash 단계에서 실행
//==============================================================================
bool _flagAppInit = false;
// RxBool testIsConnected = false.obs;
Future<void> appInit() async {
  //----------------------------------------------------------------------------
  // 1회만 실행 할 목적
  //----------------------------------------------------------------------------
  if (_flagAppInit == false) {
    _flagAppInit = true;

    // 테스트 코드
    // var a = testIsConnected.listen((p0) {print('111 $p0');});
    // // a.cancel(); //리스너 취소 가능
    // a = testIsConnected.listen((p0) {print('222 $p0');});
    // a = testIsConnected.listen((p0) {print('333 $p0');});
    // a.cancel();

    //에러가 발생하여 다음에 실행
    // systemBasicInfo(context);
    //--------------------------------------------------------------------------
    // 화면 크기에 따라 폰트 크기 조절  (높이 정보로 조절)
    // 기본 디자인은 360 x 800
    //--------------------------------------------------------------------------
    asRatioReferenceInit();
    //gv.setting.fontScale
    // if (kDebugMode) {
    //   print('화면 넓이 : ${Get.width}');
    //   print('화면 높이 : ${Get.height}');
    //   print('글씨 크기 비율 (통상적으로는 1) : ${Get.textScaleFactor}');
    // }
    // //기기마다 글씨 크기 비율이 다를 수 있으며, 이를 반영해야 글씨 높이 보증 됨
    // gv.setting.fontScale = Get.height / 800 / Get.textScaleFactor;
    // gv.setting.fontScale = max(gv.setting.fontScale, 0.5); //0.8보다는 크게
    // gv.setting.fontScale = min(gv.setting.fontScale, 2); //1.2보다는 작게 (추후 조절)

    //--------------------------------------------------------------------------
    // 데이터 베이스 읽기/초기화
    //--------------------------------------------------------------------------
    await hiveInitialize(); //hive 초기화
    // systemDataInitialize(); //데이타 공장 초기화
    await dbInitMuscle();
    await dbInitRecord();

    // await dbSqlTest(); //hive Db test
    // await dbHiveTest(); //sql db test (위의 hive 와 동일한 결과 나와야)

    //--------------------------------------------------------------------------
    // 공유메모리 읽기
    //--------------------------------------------------------------------------
    await sharedPreferenceInit();
    await gv.control.updateIdxMuscle(gv.control.idxMuscle.value); //관련 종속변수 갱신
    await gv.control.updateIdxRecord(gv.control.idxRecord.value); //관련 종속변수 갱신


    //--------------------------------------------------------------------------
    // 데이터 베이스와 공유메모리 읽기 실행 후 약간의 delay 를 추가 (2023.04.24)
    // - 사용자들 중에서 업데이트 후 운동 기록 데이터가 초기화 되었다는 보고가 있었는데, 그런 현상이 발생하지
    //    않는 기기도 있어서 문제의 원인을 파악하기 어려워 우선적으로 DB를 읽어올때 약간의 시간을 주도록 함
    //--------------------------------------------------------------------------
    await Future.delayed(const Duration(milliseconds: 200));

    //--------------------------------------------------------------------------
    // skin 초기화
    //--------------------------------------------------------------------------
    if (gv.setting.skinColor.value == 0) {
      SkinColorLightBlue().convertColor();
    } else if (gv.setting.skinColor.value == 1) {
      SkinColorLightDeepBlue().convertColor();
    } else if (gv.setting.skinColor.value == 2) {
      SkinColorDarkBlue().convertColor();
    } else if (gv.setting.skinColor.value == 3) {
      SkinColorDarkDeepBlue().convertColor();
    }
    //--------------------------------------------------------------------------
    // language 초기화
    //--------------------------------------------------------------------------


    //--------------------------------------------------------------------------
    // 블루투스 모듈 초기화
    //--------------------------------------------------------------------------

    await BleManager.initModule();
    // print('----------------------------------');
    // print(gv.bleManager[0].bleAdaptor.wvDevice.listenerList.length);
    // print('----------------------------------');
    //
    // await gv.bleManager[0].init();
    // print('----------------------------------');
    // print(gv.bleManager[0].bleAdaptor.wvDevice.listenerList.length);
    // print('----------------------------------');
    //
    // await gv.bleManager[0].init();
    // print('----------------------------------');
    // print(gv.bleManager[0].bleAdaptor.wvDevice.listenerList.length);
    // print('----------------------------------');

    // int hashgv.bleManager[0].bleAdaptor.wvDevice.listenerList[0];
    // gv.bleManager[0].bleAdaptor.wvDevice.removeListener(id)

    //--------------------------------------------------------------------------
    // 회원 로그인
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    // 디바이스 고유 정보 - 장비 시리얼로 활용
    //--------------------------------------------------------------------------
    gv.system.smartPhoneId = (await PlatformDeviceId.getDeviceId)!;
    if (kDebugMode) {
      print('smart phone unique ID : ${gv.system.smartPhoneId}');
    }

    //--------------------------------------------------------------------------
    // API - 서버 데이터 읽기
    //--------------------------------------------------------------------------
    await apiGetAuthKey(serial: gv.system.smartPhoneId);

    //--------------------------------------------------------------------------
    // 데모신호 생성
    //--------------------------------------------------------------------------
    if (gv.setting.isEnableDemo.value == true) {
      // gv.deviceControl[0].isEnableEachDemoSignal = true;
      DemoSignal.startDemoSignal();
    }

    //--------------------------------------------------------------------------
    // 통계 Data 초기값 생성
    //--------------------------------------------------------------------------
    // generateDbMuscleContents(startDate: DateTime(2022, 1, 1)); // 임의의 근육 통계 데이터 생성
    gvRecord.init();

    //--------------------------------------------------------------------------
    // 앱 초기화 완료
    //--------------------------------------------------------------------------
    gv.control.flagAppInitComplete = true;


    //--------------------------------------------------------------------------
    // 앱 버전 확인
    //--------------------------------------------------------------------------
    checkUpdate();
    // print('app_init :: appName=${gv.system.appName}  packageName=${gv.system.packageName} localVersion=${gv.system.localVersion}, storeVersion=${gv.system.storeVersion}');


    //--------------------------------------------------------------------------
    // 오디오 초기화
    // 음원 파일을 캐쉬에 로딩 하기 위해서, splash 에서 초기화
    //--------------------------------------------------------------------------
    await gv.audioManager.init();
  }
}

//==============================================================================
// 시스템 공장 초기화
//==============================================================================
Future<void> systemDataInitialize() async {
  await dbInitMuscle(isDeleteDb: true);
  await dbInitRecord(isDeleteDb: true);
  sharedPreferenceInit(deleteSp: true); //공유 메모리 초기화

  //Hive DB 초기화
  // gv.dbHiveManager.clearBox();
}

//==============================================================================
// 시스템 기본 정보 읽기 (
//==============================================================================
void systemBasicInfo() {
  //----------------------------------------------------------------------------
  // 시스템 기본 정보 획득 - 폰인지, 테블릿인지, 가로 방향인지 등
  // 실시간으로 읽어야 할 수도 있음
  //----------------------------------------------------------------------------
}
//==============================================================================
// 스마트폰 ID 읽기
//==============================================================================
// Future<String> readSmartPhoneId() async{
//
//   String id = '';
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//
//   if (gv.system.isAndroid == true){
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     id = '${androidInfo.androidId}';
//     if (kDebugMode) {
//       print('Android ID $id');
//     }
//   }
//   else if (gv.system.isIos == true){
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     id = '${iosInfo.identifierForVendor}';
//     if (kDebugMode) {
//       print('Ios ID $id');
//     }
//   }
//
//   return id;
// }
//
