import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AutoConnectionSettingSwitch extends StatefulWidget {
  const AutoConnectionSettingSwitch({required this.onToggle, Key? key})
      : super(key: key);
  final ValueChanged<bool> onToggle;

  @override
  State<AutoConnectionSettingSwitch> createState() =>
      _AutoConnectionSettingSwitchState();
}

class _AutoConnectionSettingSwitchState
    extends State<AutoConnectionSettingSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: asHeight(10), right: asWidth(18), left: asWidth(18)),
      width: asWidth(GvDef.widthRef),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          //-----------------------------------------------
          // 제목
          TextN(
            '등록된 장비와 자동연결'.tr,
            fontSize: tm.s16,
            fontWeight: FontWeight.bold,
            color: tm.black,
          ),
          // asSizedBox(width: 25),
          //-----------------------------------------------
          // enable 스위치
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (gv.setting.isBluetoothAutoConnect.value != true)
                Image.asset(
                  'assets/icons/spin_loading.gif',
                  width: asHeight(30),
                  height: asHeight(30),
                ),
              // const CupertinoActivityIndicator(
              //       radius: 15.0,
              //       color: CupertinoColors.black,
              //     ),
              SizedBox(width: asWidth(12)),
              Obx(() {
                return Transform.scale(
                  scale: 1.2,
                  child: CupertinoSwitch(
                    activeColor: tm.mainBlue,
                    value: gv.setting.isBluetoothAutoConnect.value,
                    onChanged: widget.onToggle,
                  ),
                );
              }),
            ],
          ),
          // Obx(() {
          //   return FlutterSwitch(
          //     width: asWidth(68),
          //     height: asHeight(40),
          //     toggleSize: asHeight(36),
          //     //45.0,
          //     value: gv.setting.isBluetoothAutoConnect.value,
          //     borderRadius: asHeight(20),
          //     // padding: padSwitch,
          //     toggleColor: tm.grey01,
          //     activeColor: tm.blue,
          //     inactiveColor: tm.grey03,
          //     onToggle: widget.onToggle,
          //     // 텍스트
          //     activeText: '켜짐',
          //     inactiveText: '꺼짐',
          //     activeTextColor: tm.white,
          //     inactiveTextColor: tm.white,
          //     valueFontSize: tm.s14 <= 15 ? tm.s14 : 15,
          //     //크기 제한
          //     showOnOff: true,
          //   );
          // }),
        ],
      ),
    );
  }
}
