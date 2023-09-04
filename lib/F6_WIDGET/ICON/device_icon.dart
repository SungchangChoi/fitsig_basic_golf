import '/F0_BASIC/common_import.dart';
import 'package:fitsig_basic_golf/F6_WIDGET/POPUP/ble_dialog.dart'; //bleAdaptor 연결 다이얼로그. 다른곳에서는 필요 없으므로 common_import 에 입력 안함
import 'package:fitsig_basic_golf/F6_WIDGET/POPUP/device_control_dialog.dart';

//==============================================================================
// device icon
//==============================================================================
int _batteryCapacityState = 0;

class DeviceIcon extends StatefulWidget {
  const DeviceIcon({Key? key}) : super(key: key);

  @override
  State<DeviceIcon> createState() => _DeviceIconState();
}

class _DeviceIconState extends State<DeviceIcon> {
  late Timer _timer;
  bool isView = true;

  //----------------------------------------------------------------------------
  // 시작단계
  //----------------------------------------------------------------------------
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // 배터리 상태가 낮을 때에만 애니메이션 깜빡이기
      if (_batteryCapacityState == 0 &&
          gv.deviceStatus[0].isAppConnected.value == true) {
        isView = !isView;
        setState(() {});
      }
      // 다른 경우에는 화면 갱신 없음 (상태 변하면 getX가 화면 갱신~)
      // 접촉품질 표시를 위해 0.5초마다 갱신하는 것 추가
      else {
        isView = true;
        setState(() {});
      }
    });
    super.initState();
  }

  //----------------------------------------------------------------------------
  // 종료단계
  //----------------------------------------------------------------------------
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //----------------------------------------------------------------------------
  // 빌드
  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // double icHeight = Get.height * 14 / 800;
    // 배터리 용량, 블루투스, 부착상태 변화될 때 마다 아이콘 갱신
    return Obx(() {
      // int hist = 2; //히스테리시스 값
      // // 히스테리시스를 반영 한 상태 변경
      // //-------------------- >=90
      // if (_batteryCapacityState == 8 &&
      //     gv.deviceStatus[0].batteryCapacity.value >= 90 + hist) {
      //   _batteryCapacityState = 9;
      // } else if (gv.deviceStatus[0].batteryCapacity.value >= 90) {
      //   _batteryCapacityState = 9;
      // }
      // //-------------------- >=80
      // else if (_batteryCapacityState == 7 &&
      //     gv.deviceStatus[0].batteryCapacity.value >= 80 + hist) {
      //   _batteryCapacityState = 8;
      // } else if (gv.deviceStatus[0].batteryCapacity.value >= 80) {
      //   _batteryCapacityState = 8;
      // }
      // //-------------------- >=70
      // else if (_batteryCapacityState == 6 &&
      //     gv.deviceStatus[0].batteryCapacity.value >= 70 + hist) {
      //   _batteryCapacityState = 7;
      // } else if (gv.deviceStatus[0].batteryCapacity.value >= 70) {
      //   _batteryCapacityState = 7;
      // }
      // //-------------------- >=60
      // else if (_batteryCapacityState == 5 &&
      //     gv.deviceStatus[0].batteryCapacity.value >= 60 + hist) {
      //   _batteryCapacityState = 6;
      // } else if (gv.deviceStatus[0].batteryCapacity.value >= 60) {
      //   _batteryCapacityState = 6;
      // }
      // //-------------------- >=50
      // else if (_batteryCapacityState == 4 &&
      //     gv.deviceStatus[0].batteryCapacity.value >= 50 + hist) {
      //   _batteryCapacityState = 5;
      // } else if (gv.deviceStatus[0].batteryCapacity.value >= 50) {
      //   _batteryCapacityState = 5;
      // }
      // //-------------------- >=40
      // else if (_batteryCapacityState == 3 &&
      //     gv.deviceStatus[0].batteryCapacity.value >= 40 + hist) {
      //   _batteryCapacityState = 4;
      // } else if (gv.deviceStatus[0].batteryCapacity.value >= 40) {
      //   _batteryCapacityState = 4;
      // }
      // //-------------------- >=30
      // else if (_batteryCapacityState == 2 &&
      //     gv.deviceStatus[0].batteryCapacity.value >= 30 + hist) {
      //   _batteryCapacityState = 3;
      // } else if (gv.deviceStatus[0].batteryCapacity.value >= 30) {
      //   _batteryCapacityState = 3;
      // }
      // //-------------------- >=20
      // else if (_batteryCapacityState == 1 &&
      //     gv.deviceStatus[0].batteryCapacity.value >= 20 + hist) {
      //   _batteryCapacityState = 2;
      // } else if (gv.deviceStatus[0].batteryCapacity.value >= 20) {
      //   _batteryCapacityState = 2;
      // }
      // //-------------------- >=10
      // else if (_batteryCapacityState == 0 &&
      //     gv.deviceStatus[0].batteryCapacity.value >= 10 + hist) {
      //   _batteryCapacityState = 1;
      // } else if (gv.deviceStatus[0].batteryCapacity.value >= 10) {
      //   _batteryCapacityState = 1;
      // }
      // //-------------------- < 10
      // else {
      //   _batteryCapacityState = 0;
      // }

      return TextN(
        gv.deviceStatus[0].isAppConnected.value == true
            ? '연결중'
            : '연결하기',
        color: gv.deviceStatus[0].isAppConnected.value == true
            ? tm.mainBlue
            : tm.red,
      );
    });
  }

  //==============================================================================
  // 접찹 강도 표시 위젯
  // 입력 파라미터 value 를 이용해서 control
  // 등급
  //==============================================================================
  Widget adhesionStrengthDisplay() {
    int qualityBarNum = 4;
    int d = 0;
    return Obx(() {
      return Row(
        children: [
          //----------------------------------------------------------------
          // 접촉 불량 시 경우 느낌 표
          if (gv.deviceStatus[0].isAppConnected.value == true &&
              gv.deviceData[d].electrodeQualityGrade.value == 4)
            Container(
              width: asHeight(16),
              height: asHeight(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: tm.red,
                  borderRadius: BorderRadius.circular(asHeight(8))),
              child: TextN(
                'i',
                color: tm.white,
                fontSize: tm.s12,
              ),
            ),
          if (gv.deviceStatus[0].isAppConnected.value == true &&
              gv.deviceData[d].electrodeQualityGrade.value == 4)
            asSizedBox(width: 4),
          //----------------------------------------------------------------
          // 전극 품질 상태 바
          SizedBox(
            height: asHeight(14),
            width: asHeight(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var index = 0; index < qualityBarNum; index++)
                  Container(
                    width: asHeight(3),
                    height: asHeight(14) *
                        ((qualityBarNum - index) / qualityBarNum),
                    decoration: BoxDecoration(
                      // 레벨에 부합하거나, 초기 튜토리얼 설명 중이라면 파란색
                      color: (gv.deviceStatus[0].isAppConnected.value == true &&
                                  index >=
                                      gv.deviceData[d].electrodeQualityGrade
                                          .value) ||
                              dvIntro.cntIsViewTutorial.value == 3
                          ? tm.mainBlue
                          : tm.grey03,
                      borderRadius: BorderRadius.circular(asHeight(1)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

//==============================================================================
// device icon button
// 디바이스 크기 보존을 위해 inkwell 로 교체
//==============================================================================
Widget deviceIconButton(BuildContext context) {
  return InkWell(
    onTap: (() async {
      // 블루투스가 사용 가능한 상태인지 체크 후 불가능할 때 스낵 바
      if (BleManager.flagIsBleReady == false) {
        bluetoothStatusErrorMessage();
        return;
      }
      int d = 0;
      EmlBtControlState presentState = gv.deviceStatus[d].btControlState.value;
      // 연결 상태에 따라 다른 화면
      if (gv.deviceStatus[d].isDeviceBtConnected.value == true) {
        openBottomSheetBasic(
            child: const DeviceControlDialog(),
            height: Get.height - asHeight(400));
      } else if (presentState == EmlBtControlState.disconnectingDis ||
          presentState == EmlBtControlState.disconnectingEn) {
        openSnackBarBasic('장비 해제 중', '장비를 해제 중입니다. 잠시만 기다려 주세요.');
      } else if (isDeviceIconOn.value) {
        openSnackBarBasic('장비 재연결 진행 중',
            '정전기가 감지되었습니다. 데이터 손상을 막기위해 장비와 재연결을 진행 중입니다. 잠시만 기다려 주세요.',
            duration: const Duration(seconds: 4));
      } else {
        // 연결을 위한 Dialog 팝업
        openBottomSheetBasic(
            child: const DeviceConnectDialog(),
            height: Get.height - asHeight(430));
      }
    }),
    borderRadius: BorderRadius.circular(asHeight(10)),
    child: Container(
        // height: asHeight(54),
        // width: asWidth(66), //30 + 18 + 18
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(18), vertical: asHeight(18)),
        // child: Container(
        //     height: asHeight(30), //클릭 범위를 조금 넓혀 줌 (높이 30)
        //     alignment: Alignment.center,
        child: const DeviceIcon()),
    // ),
  );
}

// ElevatedButtonN(
//   height: deviceButtonHeight,
//   // width: 70,
//   child: const DeviceIcon(),
//   primaryColor: tm.white,
//   onPressed: () async {
//     if (gv.deviceStatus[0].isDeviceBtConnected.value) {
//       // 연결 끊기
//       //Todo: 1개 이상의 device 와 연결 될수 있다면 어떤 device 를 disconnect 할 것인지 버튼에 입력된 정보가 있어야 함
//       gv.bleManager[0].disconnect(deviceNumber: EmlDeviceNumber.device1);
//       //연결 해제가 성공했다면, 전역 변수의 연결 상태 update
//       Future.delayed(const Duration(milliseconds: 100),
//           () {}); // 블루투스 해제 프로세스를 위해 임의로 설정한 delay
//     } else {
//       // 연결을 위한 Dialog 팝업
//       await showBleConnectDialog(
//           context: context, deviceNumber: EmlDeviceNumber.device1);
//     }
//   },
// ),
