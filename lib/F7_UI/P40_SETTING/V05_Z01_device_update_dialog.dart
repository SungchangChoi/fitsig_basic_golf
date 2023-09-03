import '/F0_BASIC/common_import.dart';

//==============================================================================
// class : 장비 업데이트
//==============================================================================

class DeviceUpdateDialog extends StatefulWidget {
  const DeviceUpdateDialog({
    Key? key,
    required this.context,
  }) : super(key: key);
  final BuildContext context;

  @override
  State<DeviceUpdateDialog> createState() => _DeviceUpdateDialogState();
}

class _DeviceUpdateDialogState extends State<DeviceUpdateDialog> {
  bool _isCompleted = false;
  int d = 0;

  late StreamSubscription _otaUpdateProgressListen;

  @override
  void initState() {
    _isCompleted = false;
    bt[d].bleDevice.otaUpdateProgress.value = 0;
    _otaUpdateProgressListen =
        bt[d].bleDevice.otaUpdateProgress.listen((otaUpdateProgress) {
      setState(() {});

      if (otaUpdateProgress >= 1 && _isCompleted == false) {
        // dvSetting.firmwareStatus.value = EmaFirmwareStatus.upToDate;
        _isCompleted =
            true; // 아래에 Get.back() 이 2번 호출될때가 있어서, 한번만 실행되도록 하는 Flag 변수

        Future.delayed(const Duration(seconds: 2), () {
          // firmwareStatus.value 를 updating 에서 다른 것으로 바꾸는 순간 monitoring 이 시작되기 때문에 아래 명령은 주석처리
          dvSetting.firmwareStatus.value = EmaFirmwareStatus.upToDate;
          Get.back();
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateDevice();
    });
    super.initState();
  }

  @override
  void dispose() {
    _otaUpdateProgressListen.cancel(); //리스너 제거
    if (_isCompleted == false) {
      stopUpdatingFirmware();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: asWidth(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                TextN(
                  '근전도 장비의 펌웨어를'
                          ' ${(bleCommonData.otaFileVersion!.buildVersion & 0xffffff).toRadixString(16)} 버전으로 업데이트 합니다.'
                      .tr,
                  fontSize: tm.s16,
                  color: tm.black,
                ),
                asSizedBox(height: 8),
                TextN(
                  '업데이트 중에는 장비의 전원을 끄지 마세요. 예상 소요 시간은 약 1분 30초 입니다.'.tr,
                  fontSize: tm.s16,
                  color: tm.black,
                ),
              ],
            ),
            UpdateProgressBar(
              value: bt[d].bleDevice.otaUpdateProgress.value,
            ),
          ],
        ),
      ),
    );
    // return Expanded(
    //   child: Column(
    //     children: [
    //       // _head(),
    //       // dividerBig(),
    //       _main(),
    //       asSizedBox(height: 20),
    //     ],
    //   ),
    // );
  }

  //----------------------------------------------------------------------------
  //다이얼로그 제목
  //----------------------------------------------------------------------------
  Widget _head() {
    return Container(
      // 여유공간
      margin: EdgeInsets.only(
        top: asHeight(20),
        left: asWidth(18),
        right: asWidth(18),
        bottom: asHeight(20),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: TextN(
              '근전도 장비 펌웨어 업데이트',
              fontSize: tm.s20,
              color: tm.grey04,
              fontWeight: FontWeight.w600,
            ),
          ),
          //----------------------------------------------------------------------
          // 닫기 버튼
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: InkWell(
          //     onTap: (() {
          //       // Todo: 업데이트 중에 누르면 어떻게 행동할지 조건걸어서 분기
          //       if(_isCompleted == false){
          //         stopUpdatingFirmware();
          //       }
          //       Get.back();
          //     }),
          //     child: Icon(
          //       Icons.close,
          //       size: asHeight(36),
          //       color: tm.grey03,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  // 다이얼로그 메인내용
  //----------------------------------------------------------------------------
  Widget _main() {
    int d = 0;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextN(
            '근전도 측정 장치의 펌웨어를 ${(bleCommonData.otaFileVersion!.buildVersion & 0xffffff).toRadixString(16)} 버전으로 업데이트 합니다'
                    ' 업데이트 중에는 장비의 전원을 끄지 마세요.\n업데이트에는 약 1분 30초 정도가 소요됩니다'
                .tr,
            fontSize: tm.s16,
            color: tm.black,
          ),
          // asSizedBox(height: 20),
          UpdateProgressBar(
            value: bt[d].bleDevice.otaUpdateProgress.value,
          ),
        ],
      ),
    );
  }

  void updateDevice() async {
    if (dvSetting.firmwareStatus.value != EmaFirmwareStatus.isUpdating) {
      await updateFirmware(); // updateFirmware 에서 addListener( ) 실행을 위해 hashCode 전달
    }
  }
}
