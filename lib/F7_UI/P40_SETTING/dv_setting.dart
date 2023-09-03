import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

DvSetting dvSetting = DvSetting()..init();

class DvSetting {
  // Rx<bool> isUpdatingFirmware = false.obs;
  int d = 0;
  // Rx<bool> isUpdatable = false.obs;
  String otaFilePath = '';
  Rx<EmaFirmwareStatus> firmwareStatus =
      EmaFirmwareStatus.noDevice.obs; //펌웨어 상태정보
  Rx<int> touchTime = gv.deviceControl[0].touchTime.obs;

  Rx<String?> exportDbDirectoryString = ''.obs;
  Rx<String?> exportExcelDirectoryString = ''.obs;

  bool isExportingExcel = false;
  bool isExportingDb = false;
  bool isImportingDb = false;

  // 파일 내보내기시 진행 상태(progress indicator)용 변수
  Rx<double> exportProgressStatus = 0.0.obs;

  //----------------------------------------------------
  // 가이드 방식
  //----------------------------------------------------
  // bool isOptionGuide = true; //가이드 선택, 좌/우 선택 두가지
  EmaGuideContents guideContents = EmaGuideContents.attachPosition;
  bool isViewLeft = false;
  // bool isViewExercise = false;
  // bool isModeGuideMethod = true;

  // 운동 영상을 다운로드 중임을 표시하는 flag. 영상 다운로드 시간이 몇분 걸리기도해서 페이지를 이동할 수 도 있으므로 여기다 변수만듬
  bool isVideoDownloading = false;

  //----------------------------------------------------
  // 초기화
  //----------------------------------------------------
  void init() {
    findOtaFileAndOpen();
  }

  //----------------------------------------------------
  // 펌웨어 업데이트가 필요한지 확인하는 메소드
  //----------------------------------------------------
  // Future<void> checkFwUpdatable() async {
  //   // 연결된 장비가 없다면 업데이트가 가능한지 확인할 수 없음
  //   if (bt[d].bleDevice.isBtConnectedReal.value == false) {
  //     // if (gv.bleManager[d].bleAdaptor.reactiveDevice == null) {
  //     //   print('dv_setting.dart :: checkFwUpdatable() : 연결된 장치가 없으므로 check 종료 (현재 firmwareStatus=${firmwareStatus.value})');
  //     if (firmwareStatus.value != EmaFirmwareStatus.noDevice) {
  //       firmwareStatus.value = EmaFirmwareStatus.noDevice;
  //     }
  //     return;
  //   }
  //   // await findFirmwareFileAndOpen();
  //   compareFwVersion();
  // }

  //----------------------------------------------------
  // 장비와 ota 파일의 펌웨어 버전을 비교. (Todo:현재 장비에서 컨트롤 메시지를 받을 때마다 수행....수정 필요)
  //----------------------------------------------------
  compareFwVersion() {
    // device 의 FW version 은 4 bytes 이며 첫번째 byte 에 hex 값으로 01 이 왜 들어가는데 이유를 아직 모름,
    // OTA file version 의 buildVersion (3 bytes)와 형식부터 다름. 두 값의 하위 2 byte 만 뽑아서 사용
    String fwVersionMask = '0000ffff';
    int fwVersionMaskAsInt = int.parse(fwVersionMask, radix: 16);

    // 현재 장치의 firmware 버전
    // int deviceFwVersion = fitsigDeviceAck[0].qnFwVersion & fwVersionMaskAsInt;
    int deviceFwVersion = BleManager.fitsigDeviceAck[d].qnFwVersion;
    int deviceHwVersion = BleManager.fitsigDeviceAck[d].hwVersion;

    // 선택한 OTA 파일에 있는 firmware 버전과 hardware 버전
    int otaFileFwVersion =
        bleCommonData.otaFileVersion!.buildVersion & fwVersionMaskAsInt;
    int otaFileHwVersion = bleCommonData.otaFileVersion!.hardwareVersion;

    // Todo: HW version 도 고려해야함
    if (otaFileFwVersion > deviceFwVersion) {
      // print(
      //     'dv_setting.dart :: otaFileFwVersion = ${otaFileFwVersion.toRadixString(16)}, deviceFwVersion = ${deviceFwVersion.toRadixString(16)}');
      // isUpdatable.value = true;
      firmwareStatus.value = EmaFirmwareStatus.needUpdate;
    } else {
      // isUpdatable.value = false;
      firmwareStatus.value = EmaFirmwareStatus.upToDate;
    }
  }

  Future<void> findOtaFileAndOpen() async {
    // asset 에 있는 file list(json 형식) 를 가져오기

    var assets = await rootBundle.loadString('AssetManifest.json');

    // json 형식을 Map 으로 변환
    Map filesMap = json.decode(assets);

    // '.ota' 로 끝나는 리스트를 찾기
    List otaFileKeys =
        filesMap.keys.where((element) => element.endsWith('.ota')).toList();

    // 리스트 길이가 1개, 즉 .ota 로 끝나는 파일 이 1개 뿐일 경우, 이 파일의 path 를 가져오기
    if (otaFileKeys.length == 1) {
      String anOtaFileKey = otaFileKeys[d];
      otaFilePath = filesMap[anOtaFileKey][d];
      bleCommonData.otaFile = OtaFile(dvSetting.otaFilePath);
      await bleCommonData.otaFile!.init();
      bleCommonData.otaFileVersion = bleCommonData.otaFile!.version;

      // await bt[d].openOTAFile(dvSetting.otaFilePath);
      // print('dv_setting.dart :: otaFileVersion 이 메모리에 로딩 되었습니다.');
    } else {
      print('dv_setting.dart :: otaFile 이 1개가 아닙니다.');
    }
  }
}
