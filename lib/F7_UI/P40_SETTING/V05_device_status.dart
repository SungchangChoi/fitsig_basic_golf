import '/F0_BASIC/common_import.dart';
import '/F7_UI/P40_SETTING/V05_Z01_device_update_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

//==============================================================================
// 장비 상태, 버전 등 주요 값에 대해서 표시 (충전여부 등)
//==============================================================================

class DeviceStatus extends StatefulWidget {
  const DeviceStatus({Key? key}) : super(key: key);

  @override
  State<DeviceStatus> createState() => _DeviceStatusState();
}

class _DeviceStatusState extends State<DeviceStatus> {
  late Timer _timer;

  // 장비연결 상태
  bool isConnected = gv.deviceStatus[0].isDeviceBtConnected.value;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      // 1초 단위 화면 갱신하며 상태 보여주기 (전압 등)
      isConnected = gv.deviceStatus[0].isDeviceBtConnected.value;
      setState(() {});
    });

    // dvSetting.checkFwUpdatable(); // FW 업데이트가 가능한지 확인
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int _keyLeft = 0;
  int _keyRight = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
            child: Column(
          children: [
            topBarBack(context, title: '장비정보'),
            asSizedBox(height: 26),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //-------------------------------------------------------
                      // SW 갱신 여부 (firestore 등에서 version 확인 구현 검토)
                      asSizedBox(height: 10),
                      _infoSw(context),
                      dividerBig(),
                      //-------------------------------------------------------
                      // 연결이 없는 경우
                      if (isConnected == false) _noDevice(context),
                      //-------------------------------------------------------
                      // HW FW 버전 (중요), OTA 업그레이드 여부
                      if (isConnected) _infoOta(context),
                      dividerBig(),
                      //-------------------------------------------------------
                      // 장비 이름, ID, 제조번호, 시리얼,
                      // 내부 온도, 배터리 잔량 (10단계), USB 전압, 물기 감지 여부 및 주의문
                      if (isConnected) _infoDevice(context),
                      //-------------------------------------------------------
                      dividerBig(),
                      // 오픈소스 라이선스
                      _infoElse(context),
                      asSizedBox(height: 20),
                      //--------------------------------------------------------
                      // 왼쪽 버튼 2회, 오른쪽 버튼 2회 클릭하면 관리자 페이지로 이동
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textButtonBasic(
                              width: asWidth(100),
                              height: asHeight(40),
                              borderColor: Colors.transparent,
                              title: ' ',
                              onTap: (() {
                                // print(_keyLeft);
                                // print(_keyRight);
                                if (_keyRight == 0 || _keyRight == 2) {
                                  _keyLeft++;
                                }
                              })),
                          textButtonBasic(
                              width: asWidth(100),
                              height: asHeight(40),
                              borderColor: Colors.transparent,
                              title: ' ',
                              onTap: (() {
                                if (_keyLeft == 2 || _keyLeft == 4) {
                                  _keyRight++;
                                  if (_keyRight == 4) {
                                    _keyLeft = 0;
                                    _keyRight = 0;
                                    Get.to(() => const SuperVisorPage());
                                  }
                                } else {
                                  _keyLeft = 0;
                                  _keyRight = 0;
                                }
                              })),
                        ],
                      ),
                      asSizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }

  //==============================================================================
// SW 정보
// 최신 SW 정보를 앱스토어, 구글 파이어 스토어나 API 서버를 통해 확인
//==============================================================================
  Widget _infoSw(BuildContext context) {
    int d = 0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: asWidth(10), vertical: asHeight(12)),
            width: asWidth(324),
            height: asHeight(88),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(asHeight(8)),
              color: tm.grey01,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/app_icon.png',
                  fit: BoxFit.scaleDown,
                  height: asHeight(64),
                ),
                SizedBox(width: asWidth(12)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextN(
                      '핏시그 베이직',
                      fontSize: tm.s14,
                      color: tm.grey04,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: asHeight(13)),
                    TextN(
                      '소프트웨어 버전:${gv.system.localVersion}(최신버전 ${gv.system.storeVersion})',
                      fontSize: tm.s12,
                      color: tm.grey03,
                    ),
                    SizedBox(height: asHeight(6)),
                    TextN(
                      '빌드 버전:${gv.system.appBuildNumber}',
                      fontSize: tm.s12,
                      color: tm.grey03,
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: asHeight(12)),
          IgnorePointer(
            ignoring: gv.system.isNeedUpdate.value == false,
            child: textButtonI(
              width: asWidth(324),
              height: asHeight(52),
              radius: asHeight(8),
              backgroundColor:
                  gv.system.isNeedUpdate.value == true ? tm.mainBlue : tm.grey03,
              onTap: () {
                openPopupBasicButton(
                  width: asWidth(300),
                  height: asHeight(220),
                  title: '최신버전 업그레이드',
                  text:
                      '업데이트 페이지로 이동합니다. 업데이트 전 운동 데이터를 백업 하는 것을 권장합니다. 데이터 백업은  메뉴 > 일반설정 > 운동기록 에서 \'내보내기\'를 하시면 됩니다.',
                  buttonNumber: 2,
                  buttonTitleList: ['확인', '취소'],
                  buttonTitleColorList: [tm.white, tm.mainBlue],
                  buttonBackgroundColorList: [tm.mainBlue, tm.softBlue],
                  callbackList: [
                    () async {
                      Get.back();
                      launchUrl(
                        Uri.parse(gv.system.versionStatus.appStoreLink),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    () async {
                      Get.back();
                    },
                  ],
                );
              },
              title: '최신버전 업그레이드'.tr,
              fontSize: tm.s18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: asHeight(20)),
        ],
      ),

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     TextN('SW 정보', fontSize: tm.s20, color: tm.black),
      //     asSizedBox(height: 10),
      //     _infoText('App 이름', gv.system.appName.toUpperCase()),
      //     // _infoText('패키지 이름', gv.system.packageName),
      //     _infoText('소프트웨어 버전', gv.system.localVersion),
      //     // _infoText('소프트웨어 버전', '${gv.system.localVersion} (${gv.system.appBuildNumber})'),
      //     // _infoText('빌드 버전', gv.system.appBuildNumber),
      //     _infoText('최신 소프트웨어 버전', gv.system.storeVersion.substring(0, 5)),
      //     // iOS 에서 x.x.x 뒤에 build number 까지 표시되는것을 막기위해 substring 사용
      //     // _scriptText('최신 소프트웨어가 설치되어 있습니다.'),
      //     // _scriptText('소프트웨어 업그레이드가 필요합니다. 앱스토어에 가서 업그레이드 하세요.'),
      //     asSizedBox(height: 10),
      //     // iOS, 애플 앱스토어 가는 방법 연구 필요
      //
      //     Obx(
      //       () => Center(
      //         child: textButtonG(
      //           isUpdateInfo: gv.system.isNeedUpdate.value == true,
      //           onTap: () =>
      //               launchUrl(Uri.parse(gv.system.versionStatus.appStoreLink),
      //               mode: LaunchMode.externalApplication),
      //
      //           // onTap: () => launchUrl(gv.system.storeDownloadUri,
      //           //     mode: LaunchMode.externalApplication),
      //
      //           // onTap: () {
      //           //   gv.system.appVersion.showUpdateDialog(
      //           //     context: context,
      //           //     versionStatus: gv.system.versionStatus,
      //           //     dialogTitle: '업데이트 확인',
      //           //     dialogText: '업데이트 페이지로 이동합니다.',
      //           //     updateButtonText: '확인',
      //           //     dismissButtonText: '다음에 하기',
      //           //     launchMode: LaunchMode.externalApplication,
      //           //   );
      //           // },
      //           width: asWidth(280),
      //           height: asHeight(40),
      //           title: '앱 업그레이드 하기',
      //         ),
      //       ),
      //     ),
      //     asSizedBox(height: 20),
      //     dividerSmall(),
      //     asSizedBox(height: 10),
      //   ],
      // ),
    );
  }

  //============================================================================
  // 장비 버전 및 OTA 업그레이드
  //============================================================================
  Widget _infoOta(BuildContext context) {
    int d = 0;
    // 제조년월 적절하게 숨겨서 표시
    // 0 = A ~ J = 9, 2022년 2월 1일 = 2B-0C-01, 일자는 그대로
    // String productDay = '${_numberToAbc(20)}'
    //     '-${_numberToAbc(12)}'
    //     '-${31}';
    String productDay =
        '${_numberToAbc(BleManager.fitsigDeviceAck[d].productYear)}'
        '-${_numberToAbc(BleManager.fitsigDeviceAck[d].productMonth)}'
        '${BleManager.fitsigDeviceAck[d].productDay.toString()}';
    String packageName = convertPackageName();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          asSizedBox(height: 30),
          TextN(
            '근전도 장비 버전',
            fontSize: tm.s14,
            color: tm.black,
            fontWeight: FontWeight.bold,
          ),
          asSizedBox(height: 20),
          _infoText(
              '모델명',
              isConnected == true
                  ? 'FS-${BleManager.fitsigDeviceAck[d].productId.toRadixString(16)}'
                  : '-'),
          dividerSmallThin(),
          _infoText('추가 옵션', isConnected == true ? packageName : '-'),
          dividerSmallThin(),
          _infoText('블루투스 주소', isConnected == true ? bt[d].bleDevice.id : '-'),
          dividerSmallThin(),
          // _infoText('제조번호', '${fitsigDeviceAck[0].productYear}-${fitsigDeviceAck[0].productMonth}-${fitsigDeviceAck[0].productDay}' ),
          _infoText('제조번호', isConnected == true ? productDay : '-'),
          dividerSmallThin(),
          _infoText(
              '일련번호',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].serialNumber.toString()
                  : '-'),
          dividerSmallThin(),
          _infoText(
              '하드웨어 버전',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].hwVersion.toRadixString(16)
                  : '-'),
          dividerSmallThin(),
          _infoText(
              '장비 펌웨어 버전',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].qnFwVersion.toRadixString(16)} (최신버전 ${(bleCommonData.otaFileVersion!.buildVersion & 0x0000ffff).toRadixString(16)})'
                  : '-'),
          // Obx(
          //   () =>
          _scriptText(dvSetting.firmwareStatus.value ==
                  EmaFirmwareStatus.noDevice
              ? '연결된 근전도 장비가 없습니다.'
              : dvSetting.firmwareStatus.value == EmaFirmwareStatus.needUpdate
                  ? '펌웨어 업데이트가 필요합니다.'
                      ' (최신버전: ${(bleCommonData.otaFileVersion!.buildVersion & 0x0000ffff).toRadixString(16)})'
                  : dvSetting.firmwareStatus.value == EmaFirmwareStatus.upToDate
                      ? '최신 펌웨어가 설치되어 있습니다.'
                      : '펌웨어 업데이트 중 입니다.'),
          // ),
          asSizedBox(height: 10),
          Obx(
            () => Visibility(
              // visible: dvSetting.firmwareStatus.value ==
              //     EmaFirmwareStatus.needUpdate,
              visible: true,
              //-------------------------------------------------------------
              // OTA 시행 버튼
              child: Center(
                child: textButtonI(
                  width: asWidth(324),
                  height: asHeight(52),
                  radius: asHeight(8),
                  backgroundColor: dvSetting.firmwareStatus.value ==
                          EmaFirmwareStatus.needUpdate
                      ? tm.mainBlue
                      : tm.grey03,
                  onTap: (() {
                    //Get.back; //이것이 왜 필요한가?
                    openBottomSheetBasic(
                        isHeadView: true,
                        headTitle: '펌웨어 업데이트 확인',
                        height: asHeight(300),
                        child: _firmwareUpdateConfirm(context));
                  }),
                  title: dvSetting.firmwareStatus.value ==
                          EmaFirmwareStatus.isUpdating
                      ? '펌웨어 업데이트 중'
                      : '펌웨어 업데이트 하기',
                  fontSize: tm.s18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          asSizedBox(height: 20),
        ],
      ),
    );
  }

  String convertPackageName() {
    String result;
    Map packageType = {
      '없음': '0', //LV0-BASIC,  기존에 출하(?)된 장비에 입력되어 있는 값
      'LV1-PRO': '77', // Pro-package (피트니스 시설)
      'LV2-ULTRA': '99', // Ultra-package (기업용)
    };
    int packageNumber = BleManager.fitsigDeviceAck[0].packageNumber;
    print('_DeviceStatusState :: convertPackageName :: packageNumber=$packageNumber');
    if (packageNumber == 0) {
      result = packageType.keys.elementAt(1).toString();
    }
    else if (packageNumber == 2){
      result = packageType.keys.elementAt(0).toString();
    }
    else {
      int matchedIndex = packageType.values
          .toList()
          .indexWhere((element) => element == packageNumber.toString());
      result = packageType.keys.elementAt(matchedIndex);
      // print('_DeviceStatusState :: packageName :: index=$matchedIndex, packageName=${result}');
    }
    return result;
  }

  //============================================================================
  // 숫자 -> 숫자+영어로 (제조년월 약간숨기기)
  //============================================================================
  String _numberToAbc(int num) {
    int remainder = num % 10;
    int quotient = num ~/ 10;
    List<String> abc = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
    return '$quotient${abc[remainder]}';
  }

  //============================================================================
  // 장비 정보
  //============================================================================
  Widget _infoDevice(BuildContext context) {
    int d = 0;
    //0.3V를 넘으면 물기 간주로
    String waterDetect = '감지 못함'.tr;
    String usbDetect = '연결 안됨'.tr;
    if (BleManager.fitsigDeviceAck[d].waterVoltage >= 0.3) {
      waterDetect = '감지됨'.tr;
    }
    if (BleManager.fitsigDeviceAck[d].usbVoltage >= 3.8) {
      usbDetect = '연결됨'.tr;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          asSizedBox(height: 30),
          TextN(
            '디바이스 상태',
            fontSize: tm.s14,
            color: tm.black,
            fontWeight: FontWeight.bold,
          ),
          asSizedBox(height: 10),
          _infoText(
              '배터리 용량',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].batteryCapacity.toString() +
                      '%'
                  : '-'),
          // _subText('배터리 용량은 추정 값으로 실제와 차이가 날 수 있습니다.'),
          // asSizedBox(height: 5),
          dividerSmallThin(),
          //10단계 표시
          _infoText(
              '배터리 전압',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].batteryVoltage.toStringAsFixed(2)} V'
                  : '-'),
          dividerSmallThin(),

          _infoText(
              '디바이스 온도',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].temperature} ℃'
                  : '-'),
          dividerSmallThin(),
          //10단계 표시
          _infoText(
              '디바이스 수신감도 ',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].rssi} dB'
                  : '-'),
          dividerSmallThin(),
          _infoText('스마트기기 수신감도 ',
              isConnected == true ? '${bt[d].bleDevice.rssi} dB' : '-'),
          dividerSmallThin(),
          _infoText('USB 연결 ', isConnected == true ? usbDetect : '-'),
          dividerSmallThin(),
          _infoText(
              'USB 포트 전압',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].usbVoltage.toStringAsFixed(2)} V'
                  : '-'),
          dividerSmallThin(),
          _infoText('USB 포트 물기', isConnected == true ? waterDetect : '-'),
          _subText('USB 포트 물기감지 기능은 오류가 날 수 있으므로 참조정보로만 활용하세요.'
              ' USB 포트에 물기가 있거나 의심되는 경우 완전히 제거 후 충전하시기 바랍니다.'),
          asSizedBox(height: 30),
        ],
      ),
    );
  }

  //============================================================================
  // 장비 정보
  //============================================================================
  Widget _noDevice(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          asSizedBox(height: 30),
          TextN(
            '근전도 장비 정보',
            fontSize: tm.s14,
            color: tm.black,
            fontWeight: FontWeight.bold,
          ),
          asSizedBox(height: 10),
          TextN(
            '근정도 장비가 연결되면 상태를 확인할 수 있습니다.',
            fontSize: tm.s12,
            color: tm.grey03,
            fontWeight: FontWeight.normal,
          ),
          // _scriptText('근정도 장비가 연결되면 상태를 확인할 수 있습니다.'),
          asSizedBox(height: 20),
          dividerSmall(),
        ],
      ),
    );
  }

  //============================================================================
  // 장비 정보
  //============================================================================
  Widget _infoElse(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          asSizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextN(
                '기타 정보',
                fontSize: tm.s14,
                color: tm.black,
                fontWeight: FontWeight.bold,
              ),
              textButtonG(
                onTap: (() {
                  // Get.to(() => const OpenSourceLicensePage());
                  Get.to(() => const LicensePage(
                        applicationName: 'FITSIG-BASIC',
                      ));
                }),
                width: asWidth(130),
                height: asHeight(34),
                title: '오픈소스 라이선스',
                fontSize: tm.s14,
                fontWeight: FontWeight.bold,
                textColor: tm.mainBlue,
                borderColor: tm.softBlue,
              ),
            ],
          ),
          // Center(
          //   child: textButtonG(
          //     onTap: (() {
          //       // Get.to(() => const OpenSourceLicensePage());
          //       Get.to(() => const LicensePage(
          //             applicationName: 'FITSIG-BASIC',
          //           ));
          //     }),
          //     width: asWidth(280),
          //     height: asHeight(40),
          //     title: '오픈소스 라이선스',
          //   ),
          // ),
        ],
      ),
    );
  }

  //============================================================================
  // 텍스트
  //============================================================================
  Widget _infoText(String title, String contents) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        asSizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: asWidth(140),
                child: FittedBoxN(
                    child: TextN(title, fontSize: tm.s14, color: tm.grey04))),
            // asSizedBox(width: 10),
            Container(
                alignment: Alignment.centerRight,
                width: asWidth(160),
                child: FittedBoxN(
                    child:
                        TextN(contents, fontSize: tm.s14, color: tm.grey04))),
          ],
        ),
        asSizedBox(height: 14),
      ],
    );
  }

  Widget _scriptText(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          asSizedBox(height: 5),
          TextN(text, fontSize: tm.s14, color: tm.mainBlue),
          asSizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _subText(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        asSizedBox(height: 5),
        TextN(
          text,
          fontSize: tm.s14,
          color: tm.grey03,
          height: 1.5,
        ),
        asSizedBox(height: 5),
      ],
    );
  }
}

Widget _firmwareUpdateConfirm(BuildContext context) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextN(
              '근전도 장비 펌웨어를 업데이트 하시겠습니까?',
              color: tm.grey04,
              fontSize: tm.s16,
            ),
            asSizedBox(height: 12),
            TextN(
              '업데이트에는 약 1분 30초 정도의 시간이 소요됩니다.',
              color: tm.grey04,
              fontSize: tm.s16,
            ),
          ],
        ),

        // asSizedBox(height: 20),
        textButtonG(
          title: '확인',
          width: asWidth(300),
          height: asHeight(40),
          onTap: (() {
            // gv.deviceStatus[0].isDeviceOTAUpdating.value = true;
            Get.back();
            openBottomSheetBasic(
              isHeadView: true,
              headTitle: '근전도 장비 펌웨어 업데이트',
              isDismissible: false,
              child: DeviceUpdateDialog(context: context),
              height: asHeight(300),
            );
          }),
        ),
        // asSizedBox(height: 10),
        // textButtonBasic(
        //   title: '확인',
        //   width: asWidth(300),
        //   height: asHeight(40),
        //   textColor: tm.blue,
        //   borderColor: tm.blue.withOpacity(0.3),
        //   onTap: (() {
        //     gv.deviceStatus[0].isDeviceOTAUpdating.value = true;
        //     Get.back();
        //     openBottomSheetBasic(
        //       isDismissible: false,
        //       child: DeviceUpdateDialog(context: context),
        //       height: asHeight(240),
        //     );
        //   }),
        // ),
        // asSizedBox(height: 20),
      ],
    ),
  );
}
