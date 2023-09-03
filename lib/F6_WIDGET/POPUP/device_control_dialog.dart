import '/F0_BASIC/common_import.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '/F6_WIDGET/POPUP/auto_connection_setting_switch.dart';

class DeviceControlDialog extends StatelessWidget {
  final double aSideMargin = 16; // 다이얼로그 팝업창의 (한쪽) 옆면 Margin 값
  const DeviceControlDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _head(),
          const DeviceControlMain(),
        ],
      ),
    );
  }

  //============================================================================
  // head
  //============================================================================
  Widget _head() {
    return Container(
      // 여유공간
      margin: EdgeInsets.only(
          top: asHeight(20),
          bottom: asHeight(20),
          left: asWidth(18),
          right: asWidth(18)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: TextN(
              '장비 연결 관리',
              fontSize: tm.s20,
              color: tm.grey04,
              fontWeight: FontWeight.w600,
            ),
          ),
          //----------------------------------------------------------------------
          // 닫기 버튼
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: (() {
                Get.back();
              }),
              child: Icon(
                Icons.close,
                size: asHeight(36),
                color: tm.grey03,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//============================================================================
// 연결된 장치의 제어 버튼 위젯 클래스
//============================================================================
class DeviceControlMain extends StatelessWidget {
  const DeviceControlMain({Key? key}) : super(key: key);
  final int d = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          //----------------------------------------------------
          // 블루투스 자동연결 설정 버튼
          //----------------------------------------------------
          AutoConnectionSettingSwitch(
            onToggle: (check) {
              gv.setting.isBluetoothAutoConnect.value = check; //!test1.value;
              gv.spMemory.write('isBluetoothAutoConnect',
                  gv.setting.isBluetoothAutoConnect.value);
            },
          ),
          dividerSmallThin(),
          SizedBox(height: asHeight(20)),
          //----------------------------------------------------
          // 연결된 장비명
          //----------------------------------------------------
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: asWidth(18),
                ),
                child: TextN(
                  '나의 기기',
                  fontSize: tm.s14,
                  fontWeight: FontWeight.bold,
                  color: tm.grey03,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                leading: Image.asset(
                  'assets/icons/ic_device.png',
                  fit: BoxFit.scaleDown,
                  color: tm.black,
                  height: asHeight(36),
                ),
                // leading: Icon(Icons.bluetooth, color: tm.blue),
                title: TextN(
                  bt[d].bleDevice.name,
                  fontSize: tm.s16,
                  fontWeight: FontWeight.bold,
                  color: tm.black,
                ),
                subtitle: TextN(
                  bt[d].bleDevice.id,
                  fontSize: tm.s12,
                  color: tm.grey03,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Obx (() => TextN(
                  '${BleManager.fitsigDeviceAck[d].rssi.value} dBm',
                  fontSize: tm.s14,
                  color: tm.black,
                )),
                onTap: () {},
              ),
              dividerSmall2(),
            ],
          ),
          Expanded(child: SizedBox(height: asHeight(20))),
          Obx(() {
            int d = 0;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //----------------------------------------------------
                // 장비 끄기 버튼
                //----------------------------------------------------
                textButtonI(
                  width: gv.setting.isBluetoothAutoConnect.value == true
                      ? asWidth(324)
                      : asWidth(158),
                  height: asHeight(52),
                  radius: asHeight(8),
                  backgroundColor: tm.white,
                  onTap: () async {
                    int d = 0;
                    await BleManager.devicePowerOff(deviceIndex: d); //디바이스 전원끄기
                    await Future.delayed(
                        const Duration(milliseconds: 200)); //명령전달 시간 잠시 대기
                    await gv.btStateManager[d].disconnectCommand(); //연결 해제
                    Future.delayed(const Duration(milliseconds: 100),
                        () {}); // 블루투스 해제 프로세스를 위해 임의로 설정한 delay
                    Navigator.pop(context);
                  },
                  title: '장비 끄기'.tr,
                  textColor: tm.grey04,
                  fontSize: tm.s14,
                  fontWeight: FontWeight.bold,
                  borderColor: tm.grey02,
                  borderLineWidth: asWidth(1),
                ),
                if (gv.setting.isBluetoothAutoConnect.value != true)
                  asSizedBox(width: 8),
                //----------------------------------------------------
                // 장비 연결 해제 버튼 (자동연결 설정이 true 가 이닐때만 보임)
                //----------------------------------------------------
                if (gv.setting.isBluetoothAutoConnect.value != true)
                  textButtonI(
                    width: asWidth(158),
                    height: asHeight(52),
                    radius: asHeight(8),
                    backgroundColor: tm.white,
                    onTap: () async {
                      // 연결 끊기
                      await gv.btStateManager[d].disconnectCommand(); //연결 해제
                      Navigator.pop(context);
                    },
                    title: '연결 해제'.tr,
                    textColor: tm.grey04,
                    fontSize: tm.s14,
                    fontWeight: FontWeight.bold,
                    borderColor: tm.grey02,
                    borderLineWidth: asWidth(1),
                  ),
              ],
            );
          }),
          // return (gv.setting.isBluetoothAutoConnect.value != true)
          //     ?
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     textButtonG(
          //       width: asWidth(280),
          //       height: asHeight(40),
          //       title: '연결 해제',
          //       onTap: (() async {
          //         // 연결 끊기
          //         await gv.btStateManager[d].disconnectCommand(); //연결 해제
          //         // BleManager.disconnect(deviceIndex: d);
          //         // //연결 해제가 성공했다면, 전역 변수의 연결 상태 update
          //         // Future.delayed(const Duration(milliseconds: 100),
          //         //     () {}); // 블루투스 해제 프로세스를 위해 임의로 설정한 delay
          //         Navigator.pop(context);
          //       }),
          //     ),
          //     asSizedBox(height: 20)
          //   ],
          // )
          //     : Container();
          asSizedBox(height: 8),
          //----------------------------------------------------
          // 연결 장비 LED 깜박이기 버튼
          //----------------------------------------------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: asHeight(18)),
            child: textButtonI(
              width: asWidth(324),
              height: asHeight(52),
              radius: asHeight(8),
              backgroundColor: tm.white,
              onTap: () {
                int d = 0;
                BleManager.blinkDeviceLED(deviceIndex: d);
              },
              title: '장비 LED 깜박이기'.tr,
              textColor: tm.grey04,
              fontSize: tm.s14,
              fontWeight: FontWeight.bold,
              borderColor: tm.grey02,
              borderLineWidth: asWidth(1),
            ),
          ),
          SizedBox(height: asHeight(40))
          // //----------------------------------------------------
          // // 자동 연결 라디오 버튼
          // //----------------------------------------------------
          // SizedBox(
          //   width: asWidth(280),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       //-----------------------------------------------
          //       // 제목
          //       TextN(
          //         '블루투스 자동연결'.tr,
          //         fontSize: tm.s16,
          //         fontWeight: FontWeight.w400,
          //         color: tm.grey05,
          //       ),
          //       //-----------------------------------------------
          //       // enable 스위치
          //       Obx(() {
          //         return FlutterSwitch(
          //           width: asWidth(48),
          //           height: asHeight(30),
          //           toggleSize: asHeight(27),
          //           //45.0,
          //           value: gv.setting.isBluetoothAutoConnect.value,
          //           borderRadius: asHeight(20),
          //           // padding: padSwitch,
          //           toggleColor: tm.grey01,
          //           activeColor: tm.blue,
          //           inactiveColor: tm.grey03,
          //           onToggle: (check) {
          //             gv.setting.isBluetoothAutoConnect.value =
          //                 check; //!test1.value;
          //             gv.spMemory.write('isBluetoothAutoConnect',
          //                 gv.setting.isBluetoothAutoConnect.value);
          //           },
          //           // 텍스트
          //           activeText: '켜짐',
          //           inactiveText: '꺼짐',
          //           activeTextColor: tm.white,
          //           inactiveTextColor: tm.white,
          //           valueFontSize: tm.s14 <= 15 ? tm.s14 : 15, //크기 제한
          //           showOnOff: true,
          //         );
          //       }),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
