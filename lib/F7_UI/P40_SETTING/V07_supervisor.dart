import '/F0_BASIC/common_import.dart';

//==============================================================================
// 관리자 페이지
//==============================================================================

class SuperVisorPage extends StatefulWidget {
  const SuperVisorPage({Key? key}) : super(key: key);

  @override
  State<SuperVisorPage> createState() => _SuperVisorPageState();
}

class _SuperVisorPageState extends State<SuperVisorPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
            child: Column(
          children: [
            //----------------------------------------------------------------
            // 상단 바
            topBarBack(context, title: '개발자 페이지'),
            asSizedBox(height: 26),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextN(
                        '이곳은 제품 검증을 위한 개발자 페이지 입니다.',
                        fontSize: tm.s18,
                        color: tm.black,
                      ),
                      asSizedBox(height: 10),
                      //--------------------------------------------------------
                      // 데모신호 생성 및 디버그 설정
                      //--------------------------------------------------------
                      _setDemoSignal(),
                      asSizedBox(height: 30),
                      _setMeasureQualityDebug(),
                      //--------------------------------------------------------
                      // 측정결과 디버그 데이터 표시
                      //--------------------------------------------------------
                      asSizedBox(height: 20),
                      dividerSmall(),
                      asSizedBox(height: 10),
                      //--------------------------------------------------------------
                      // 디바이스 상태 정보
                      //--------------------------------------------------------------
                      const DeviceStateDetail(),
                      asSizedBox(height: 10),
                      dividerSmall(),

                      //----------------------------------------------------------------
                      // 배터리 측정 페이지 (시험에 필요할 경우 활성화)
                      // asSizedBox(height: 20),
                      // ElevatedButtonN(
                      //   onPressed: (() {
                      //     Get.to(() => const BatterCapacityTestPage());
                      //   }),
                      //   child: const TextN('배터리 측정 페이지로가기'),
                      // ),

                      asSizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}

//==============================================================================
// 데모 신호 생성 (실제 제품 적용 여부 논의)
//==============================================================================
Widget _setDemoSignal() {
  RxInt _refresh = 0.obs;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      settingSwitchBox(
          onChanged: ((check) {
            gv.setting.isEnableDemo.value = check;
            // 공유 메모리 저장 안함
            //gv.spMemory.write('isEnableDemo', check); //공유 메모리 저장
            if (check == true) {
              DemoSignal.startDemoSignal();
            } else {
              DemoSignal.stopDemoSignal();
            }
          }),
          title: '데모신호 생성',
          subText: '장비 연결이 없는 경우에 데모 신호를 생성합니다.'
              ' 개발 검증 목적으로 사용되는 기능입니다.',
          switchValue: gv.setting.isEnableDemo),
      asSizedBox(height: 10),
      //------------------------------------------------------------------------
      // 크기 조절 : 실제 제품에서는 빠질 수 있음
      //------------------------------------------------------------------------
      Obx(() {
        int refresh = _refresh.value;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
          child: Column(
            children: [
              //----------------------------------------------------------------
              // 크기 조절
              //----------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextN(
                    '크기 : ${gv.deviceControl[0].signalMagnitude.toStringAsFixed(1)} mV',
                    fontSize: tm.s16,
                    color: tm.grey05,
                  ),
                  Row(
                    children: [
                      ElevatedButtonN(
                        width: asWidth(40),
                        height: asHeight(30),
                        radius: asHeight(10),
                        primaryColor: tm.mainBlue,
                        onPressed: (() {
                          gv.deviceControl[0].signalMagnitude += 0.1;
                          _refresh.value++;
                        }),
                        child: TextN(
                          '+',
                          fontSize: tm.s20,
                        ),
                      ),
                      asSizedBox(width: 10),
                      ElevatedButtonN(
                        width: asWidth(40),
                        height: asHeight(30),
                        radius: asHeight(10),
                        primaryColor: tm.mainBlue,
                        onPressed: (() {
                          gv.deviceControl[0].signalMagnitude -= 0.1;
                          _refresh.value++;
                        }),
                        child: TextN(
                          '-',
                          fontSize: tm.s20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              asSizedBox(height: 10),
              //----------------------------------------------------------------
              // 주기 조절
              //----------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextN(
                    '주기 : ${gv.deviceControl[0].signalPeriod.toStringAsFixed(1)} 초',
                    fontSize: tm.s16,
                    color: tm.grey05,
                  ),
                  Row(
                    children: [
                      ElevatedButtonN(
                        width: asWidth(40),
                        height: asHeight(30),
                        radius: asHeight(10),
                        primaryColor: tm.mainBlue,
                        onPressed: (() {
                          gv.deviceControl[0].signalPeriod += 0.1;
                          _refresh.value++;
                        }),
                        child: TextN(
                          '+',
                          fontSize: tm.s20,
                        ),
                      ),
                      asSizedBox(width: 10),
                      ElevatedButtonN(
                        width: asWidth(40),
                        height: asHeight(30),
                        radius: asHeight(10),
                        primaryColor: tm.mainBlue,
                        onPressed: (() {
                          gv.deviceControl[0].signalPeriod -= 0.1;
                          _refresh.value++;
                        }),
                        child: TextN(
                          '-',
                          fontSize: tm.s20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              asSizedBox(height: 10),
              //----------------------------------------------------------------
              // 옵셋 조절
              //----------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextN(
                    '옵셋  : ${gv.deviceControl[0].signalOffset.toStringAsFixed(1)} mV',
                    fontSize: tm.s16,
                    color: tm.grey05,
                  ),
                  Row(
                    children: [
                      ElevatedButtonN(
                        width: asWidth(40),
                        height: asHeight(30),
                        radius: asHeight(10),
                        primaryColor: tm.mainBlue,
                        onPressed: (() {
                          gv.deviceControl[0].signalOffset += 0.1;
                          _refresh.value++;
                        }),
                        child: TextN(
                          '+',
                          fontSize: tm.s20,
                        ),
                      ),
                      asSizedBox(width: 10),
                      ElevatedButtonN(
                        width: asWidth(40),
                        height: asHeight(30),
                        radius: asHeight(10),
                        primaryColor: tm.mainBlue,
                        onPressed: (() {
                          gv.deviceControl[0].signalOffset -= 0.1;
                          _refresh.value++;
                        }),
                        child: TextN(
                          '-',
                          fontSize: tm.s20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    ],
  );
}

//==============================================================================
// 측정 품질 디버그 데이터 표시 여부
//==============================================================================
Widget _setMeasureQualityDebug() {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      settingSwitchBox(
          onChanged: ((check) {
            gv.setting.isViewMeasureQualityDebug.value = check;
          }),
          title: '측정품질 디버그 데이터 생성',
          subText: '측정 종료 후 전극 접촉 품질 및 예외상황 발생을 파악할 수 있는 디버그 데이터를 생성합니다.',
          switchValue: gv.setting.isViewMeasureQualityDebug),
      asSizedBox(height: 10),
    ],
  );
}

//==============================================================================
// 장비 정보
//==============================================================================
class DeviceStateDetail extends StatefulWidget {
  const DeviceStateDetail({Key? key}) : super(key: key);

  @override
  State<DeviceStateDetail> createState() => _DeviceStateDetailState();
}

class _DeviceStateDetailState extends State<DeviceStateDetail> {
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

  @override
  Widget build(BuildContext context) {
    return _infoDeviceDetail(context);
  }

//============================================================================
// 장비 정보 내용
//============================================================================
  Widget _infoDeviceDetail(BuildContext context) {
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
          //------------------------------------------------------------------
          // 수신 상태
          //------------------------------------------------------------------
          TextN('수신 상태', fontSize: tm.s20, color: tm.black),
          _infoText(
              'bps(13600)',
              isConnected == true
                  ? (gv.deviceStatus[d].bpsAverage).toStringAsFixed(1)
                  : '-'),
          _infoText(
              '초당 샘플 수(500)',
              isConnected == true
                  ? (gv.deviceStatus[d].samplePerSec).toStringAsFixed(1)
                  : '-'),
          _infoText(
              '평균 에러패킷/초',
              isConnected == true
                  ? gv.deviceStatus[d].packetErrorAverage.toStringAsFixed(4)
                  : '-'),
          asSizedBox(height: 10),
          dividerSmall(),
          asSizedBox(height: 10),
          //------------------------------------------------------------------
          // 디바이스 상태
          //------------------------------------------------------------------
          TextN('디바이스 상태', fontSize: tm.s20, color: tm.black),
          _infoText(
              '부팅 횟수',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].bootCount.toString() + '회'
                  : '-'),
          _infoText(
              '디바이스 전송속도',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].bps.toString() + 'bps'
                  : '-'),

          _infoText(
              '보낸 패킷 수/초',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].sentPackets.toString()
                  : '-'),

          _infoText(
              '실패 패킷 수/초',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].failPackets.toString()
                  : '-'),

          _infoText(
              '스킵 패킷 수/초`',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].skipPackets.toString()
                  : '-'),

          _infoText(
              '제조일',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].productYear.toString() +
                      '-' +
                      BleManager.fitsigDeviceAck[d].productMonth.toString() +
                      '-' +
                      BleManager.fitsigDeviceAck[d].productDay.toString()
                  : '-'),

          _infoText(
              '배터리 용량',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].batteryCapacity.toString() +
                      '%'
                  : '-'),
          //10단계 표시
          _infoText(
              '배터리 전압',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].batteryVoltage
                      .toStringAsFixed(2)
                  : '-'),

          _infoText(
              '디바이스 온도',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].temperature} ℃'
                  : '-'),
          //10단계 표시
          _infoText(
              '디바이스 수신감도 ',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].rssi} dB'
                  : '-'),
          _infoText('스마트기기 수신감도 ',
              isConnected == true ? '${bt[d].bleDevice.rssi} dB' : '-'),
          _infoText('USB 연결 ', isConnected == true ? usbDetect : '-'),
          _infoText(
              'USB 포트 전압',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].usbVoltage.toStringAsFixed(2)
                  : '-'),
          _infoText(
              '물기 전압',
              isConnected == true
                  ? BleManager.fitsigDeviceAck[d].waterVoltage
                      .toStringAsFixed(2)
                  : '-'),
          _infoText('USB 포트 물기', isConnected == true ? waterDetect : '-'),
          asSizedBox(height: 10),
          dividerSmall(),
          asSizedBox(height: 10),
          _infoText(
              '측정 상태 커맨드',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].commandFeedBackMeasurement}'
                  : '-'),
          _infoText(
              '스크린 상태 커맨드',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].commandFeedBackScreen}'
                  : '-'),
          _infoText(
              '착용 상태 커맨드',
              isConnected == true
                  ? '${BleManager.fitsigDeviceAck[d].commandFeedBackAttach}'
                  : '-'),
          asSizedBox(height: 10),
          dividerSmall(),
          asSizedBox(height: 10),
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
        asSizedBox(height: 5),
        Row(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: asWidth(140),
                child: FittedBoxN(
                    child: TextN(title, fontSize: tm.s16, color: tm.grey05))),
            asSizedBox(width: 10),
            Container(
                alignment: Alignment.centerLeft,
                width: asWidth(160),
                child: FittedBoxN(
                    child:
                        TextN(contents, fontSize: tm.s16, color: tm.grey04))),
          ],
        ),
        asSizedBox(height: 5),
      ],
    );
  }
}
