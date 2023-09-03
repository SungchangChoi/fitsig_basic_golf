// import '/F0_BASIC/common_import.dart';
// import 'package:numberpicker/numberpicker.dart';
//
// //==============================================================================
// // Bluetooth Test
// //==============================================================================
//
// class BluetoothTest extends StatelessWidget {
//   const BluetoothTest({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         color: tm.white,
//         child: SafeArea(
//           child: WillPopScope(
//             child: DefaultTabController(
//               length: 2,
//               child: Scaffold(
//                 appBar: AppBar(
//                   title: const Text('QC'),
//                   bottom: const TabBar(
//                     tabs: [
//                       Text('상태'),
//                       Text('제어'),
//                     ],
//                   ),
//                 ),
//                 body: const TabBarView(
//                   children: [
//                     QcStatus(),
//                     QcControl(),
//                   ],
//                 ),
//               ),
//             ),
//             onWillPop: () async {
//               //gv.bleManager[0].bleAdaptor.wvDevice1.value?.disconnect();
//               return true;
//             },
//           ),
//         ));
//   }
// }
//
//
//
// class QcStatus extends StatefulWidget {
//   const QcStatus({Key? key}) : super(key: key);
//   @override
//   _QcStatusState createState() => _QcStatusState();
// }
//
// class _QcStatusState extends State<QcStatus> with HexMixin {
//   // late BleDevice? device;
//   late ReactiveDevice? device;
//
//   int d = 0;
//
//   @override
//   void initState() {
//     device = gv.bleManager[0].bleAdaptor.reactiveDevice;
//     if (gv.bleManager[0].bleAdaptor.reactiveDevice != null){
//       device = gv.bleManager[0].bleAdaptor.reactiveDevice;
//       device!.wvNotifyData.addListener(hashCode, () {
//         setState((){});
//       });
//     }
//     // 신규 디바이스 연결시
//     // gv.bleManager[0].bleAdaptor.wvDevice1.addListener(hashCode, () {
//     //   // 기존 연결 삭제
//     //   // device?.wvDeviceInfo.removeListener(hashCode);
//     //   // 신규 연결
//     //   if (gv.bleManager[0].bleAdaptor.wvDevice1.value != null){
//     //     device = gv.bleManager[0].bleAdaptor.wvDevice1.value;
//     //     device!.wvNotifyData.addListener(hashCode, () {
//     //       setState((){});
//     //     });
//     //   }
//     //   else{
//     //     device!.wvNotifyData.removeListener(hashCode);
//     //     device = null;
//     //   }
//
//       // device?.wvDeviceInfo.addListener(hashCode, () {
//       //   setState(() {});
//       // });
//     // });
//     // device!.wvNotifyData.addListener(hashCode, () {setState((){});});
//     // device?.wvDeviceInfo.addListener(hashCode, () {
//     //   setState(() {});
//     // });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     device?.wvNotifyData.removeListener(hashCode);
//     // gv.bleManager[0].bleAdaptor.wvDevice1.removeListener(hashCode);
//     // device?.wvDeviceInfo.removeListener(hashCode);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (device == null) {
//       return const Center(child: Text('디바이스 연결이 없습니다.'));
//     } else {
//       return Scrollbar(
//         child: ListView(
//           children: ListTile.divideTiles(
//             context: context,
//             tiles: [
//               ListTile(
//                 leading: const Text('제품 아이디:'),
//                 // title: Text(
//                 //     _valueConverter(device?.wvDeviceInfo.value?.productId, 4)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.productId.toRadixString(16)),
//               ),
//               ListTile(
//                 leading: const Text('펌웨어 버전:'),
//                 // title: Text(_valueConverter(
//                 //     device?.wvDeviceInfo.value?.qnFwVersion, 8)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.qnFwVersion.toRadixString(16)),
//               ),
//               ListTile(
//                 leading: const Text('하드웨어 버전:'),
//                 // title: Text(
//                 //     _valueConverter(device?.wvDeviceInfo.value?.hwVersion, 6)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.hwVersion.toRadixString(16)),
//
//               ),
//               ListTile(
//                 leading: const Text('MSP 버전:'),
//                 // title: Text(_valueConverter(
//                 //     device?.wvDeviceInfo.value?.mspFwVersion, 4)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.mspVersion.toRadixString(16)),
//               ),
//               // ListTile(
//               //   leading: const Text('블루투스 주소:'),
//               //   title: Text(
//               //       _valueConverter(device?.wvDeviceInfo.value?.macAddress, 0)),
//               // ),
//               ListTile(
//                 leading: const Text('배터리 충전량:'),
//                 // title: Text(_valueConverter(
//                 //     device?.wvDeviceInfo.value?.batteryCapacity, 0)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.batteryCapacity.toString()),
//               ),
//               ListTile(
//                 leading: const Text('USB 전압:'),
//                 // title: Text(
//                 //     _valueConverter(device?.wvDeviceInfo.value?.usbVoltage, 0)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.usbVoltage.toStringAsFixed(3)),
//
//               ),
//               ListTile(
//                 leading: const Text('Water 전압:'),
//                 // title: Text(_valueConverter(
//                 //     device?.wvDeviceInfo.value?.waterVoltage, 0)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.waterVoltage.toStringAsFixed(3)),
//               ),
//               ListTile(
//                 leading: const Text('온도:'),
//                 // title: Text(_valueConverter(
//                 //     device?.wvDeviceInfo.value?.temperature, 0)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.temperature.toString()),
//               ),
//               ListTile(
//                 leading: const Text('배터리 상태:'),
//                 // title: Text(
//                 //     _toBatteryStatus(device?.wvDeviceInfo.value?.batteryCode)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.batteryState.toString()),
//               ),
//               ListTile(
//                 leading: const Text('RSSI:'),
//                 // title:
//                 // Text(_valueConverter(device?.wvDeviceInfo.value?.rssi, 0)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.rssi.toString()),
//               ),
//               ListTile(
//                 leading: const Text('전송 패킷 수:'),
//                 // title: Text(_valueConverter(
//                 //     device?.wvDeviceInfo.value?.sentPackets, 0)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.sentPackets.toString()),
//
//               ),
//               ListTile(
//                 leading: const Text('실패 패킷 수:'),
//                 // title: Text(_valueConverter(
//                 //     device?.wvDeviceInfo.value?.failPackets, 0)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.failPackets.toString()),
//               ),
//               ListTile(
//                 leading: const Text('스킵 패킷 수:'),
//                 // title: Text(_valueConverter(
//                 //     device?.wvDeviceInfo.value?.skipPackets, 0)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.skipPackets.toString()),
//               ),
//               ListTile(
//                 leading: const Text('부팅 횟수:'),
//                 // title: Text(
//                 //     _valueConverter(device?.wvDeviceInfo.value?.bootCount, 0)),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.bootCount.toString()),
//               ),
//               ListTile(
//                 leading: const Text('시리얼 번호:'),
//                 title: Text(gv.bleManager[d].fitsigDeviceAck.serialNumber.toString()),
//               ),
//               ListTile(
//                 leading: const Text('제조 년, 월, 일:'),
//                 title: Text('${gv.bleManager[d].fitsigDeviceAck.productYear
//                     .toString()}.${gv.bleManager[d].fitsigDeviceAck.productMonth
//                     .toString()}.${gv.bleManager[d].fitsigDeviceAck.productDay.toString()}'),
//               ),
//             ],
//           ).toList(),
//         ),
//       );
//     }
//   }
// }
//
// class QcControl extends StatefulWidget {
//   const QcControl({Key? key}) : super(key: key);
//
//   @override
//   _QcControlState createState() => _QcControlState();
// }
//
// class _QcControlState extends State<QcControl> {
//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//       child: ListView(
//         children: ListTile.divideTiles(
//           context: context,
//           tiles: [
//             ListTile(
//               title: IntegerInputSpinner(
//                 '링크 번호:',
//                 _cd.linkIndex,
//                     (value) {
//                   _cd.linkIndex = value;
//                   setState(() {});
//                 },
//                 maxValue: 4,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 '착용 상태:',
//                 _cd.wearIndex,
//                     (value) {
//                   _cd.wearIndex = value;
//                   setState(() {});
//                 },
//                 maxValue: 2,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 '스크린 상태:',
//                 _cd.screenIndex,
//                     (value) {
//                   _cd.screenIndex = value;
//                   setState(() {});
//                 },
//                 maxValue: 10,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 '절약 모드:',
//                 _cd.savingMode,
//                     (value) {
//                   _cd.savingMode = value;
//                   setState(() {});
//                 },
//                 maxValue: 1,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 '동작 중:',
//                 _cd.isWorking,
//                     (value) {
//                   _cd.isWorking = value;
//                   setState(() {});
//                 },
//                 maxValue: 1,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 '가속도/자이로:',
//                 _cd.accGyro,
//                     (value) {
//                   _cd.accGyro = value;
//                   setState(() {});
//                 },
//                 maxValue: 1,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 '터치 버튼 보정:',
//                 _cd.touchWeightFactor,
//                     (value) {
//                   _cd.touchWeightFactor = value;
//                   setState(() {});
//                 },
//                 maxValue: 120,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 'BOR:',
//                 _cd.bor,
//                     (value) {
//                   _cd.bor = value;
//                   setState(() {});
//                 },
//                 maxValue: 1,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 '디버그:',
//                 _cd.debug,
//                     (value) {
//                   _cd.debug = value;
//                   setState(() {});
//                 },
//                 maxValue: 1,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 'I2C 부팅 제어:',
//                 _cd.i2cBooting,
//                     (value) {
//                   _cd.i2cBooting = value;
//                   setState(() {});
//                 },
//                 maxValue: 1,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 '롬 쓰기 활성화:',
//                 _cd.isEnableRomWrite,
//                     (value) {
//                   _cd.isEnableRomWrite = value;
//                   setState(() {});
//                 },
//                 maxValue: 1,
//               ),
//             ),
//             ListTile(
//               title: IntegerInputSpinner(
//                 '롬 읽기 활성화:',
//                 _cd.isEnableRomRead,
//                     (value) {
//                   _cd.isEnableRomRead = value;
//                   setState(() {});
//                 },
//                 maxValue: 1,
//               ),
//             ),
//             ListTile(
//               title: TextInput(
//                 '시리얼 넘버:',
//                     (value) {
//                   int? v = int.tryParse(value);
//                   if (v != null) {
//                     _cd.serialNumber = v;
//                     setState(() {});
//                   }
//                 },
//               ),
//             ),
//             ListTile(
//               title: InputDate(
//                 '제조 년월일:',
//                 _cd.date,
//                     (value) {
//                   _cd.date = value;
//                   setState(() {});
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   List<int> data = List.filled(20, 0);
//                   data[0] = 0xD0;
//                   data[1] = _cd.linkIndex;
//                   data[2] = _cd.wearIndex;
//                   data[3] = _cd.screenIndex;
//                   data[4] = _cd.savingMode;
//                   data[5] = _cd.isWorking;
//                   data[6] = _cd.accGyro;
//                   data[7] = _cd.touchWeightFactor; // 0을 쓰면 반영 안 됨
//                   data[8] = _cd.bor == 1 ? 0xEF : 0x00;
//                   data[9] = _cd.debug == 1 ? 0xE1 : 0xE0;
//                   data[10] = _cd.i2cBooting == 1 ? 0xFA : 0x00;
//                   data[11] = _cd.isEnableRomWrite + (_cd.isEnableRomRead<<1);
//                   print('read enable =${_cd.isEnableRomRead}');
//                   data[12] = (_cd.serialNumber ~/ 0x1000000) & 0xFF;
//                   data[13] = (_cd.serialNumber ~/ 0x10000) & 0xFF;
//                   data[14] = (_cd.serialNumber ~/ 0x100) & 0xFF;
//                   data[15] = _cd.serialNumber % 0x100;
//                   data[16] = _cd.date.year % 100;
//                   data[17] = _cd.date.month;
//                   data[18] = _cd.date.day;
//                   print('V04_bluetooth_test :: data[11] =  ${data[11]}');
//                   gv.bleManager[0].bleAdaptor.reactiveDevice.sendQcCommand(data);
//                 },
//                 child: const SizedBox(
//                   child: Center(child: Text('명령 전송')),
//                   height: 40,
//                 ),
//               ),
//             ),
//           ],
//         ).toList(),
//       ),
//     );
//   }
// }
//
// ControlData _cd = ControlData();
//
// class ControlData {
//   int linkIndex = 0;
//   int wearIndex = 0;
//   int screenIndex = 0;
//   int savingMode = 0;
//   int isWorking = 0;
//   int accGyro = 0;
//   int touchWeightFactor = 0;
//   int bor = 0;
//   int debug = 0;
//   int i2cBooting = 0;
//   int isEnableRomWrite = 0;
//   int isEnableRomRead = 0;
//   int serialNumber = 0;
//   DateTime date = DateTime.now();
// }
//
// class IntegerInputSpinner extends StatelessWidget {
//   final String label;
//   final int iniValue;
//   final int minValue;
//   final int maxValue;
//   final Function(int) onChanged;
//   const IntegerInputSpinner(this.label, this.iniValue, this.onChanged,
//       {Key? key, this.minValue = 0, this.maxValue = 10}):super(key:key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 150,
//       child: Row(
//         textBaseline: TextBaseline.ideographic,
//         children: [
//           Text(label),
//           Expanded(
//             child: InkWell(
//               child: Text(
//                 iniValue.toString(),
//                 style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
//                 textAlign: TextAlign.end,
//               ),
//               onTap: () => NumberPickerDialog.show(
//                 context,
//                 iniValue,
//                 minValue: minValue,
//                 maxValue: maxValue,
//                 onChanged: onChanged,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class TextInput extends StatelessWidget {
//   final String label;
//   final Function(String)? onChanged;
//   const TextInput(this.label, this.onChanged,{Key? key}):super(key:key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 150,
//       child: Row(
//         textBaseline: TextBaseline.ideographic,
//         children: [
//           Text(label),
//           const SizedBox(width: 20),
//           Expanded(
//             child: TextField(
//               keyboardType: TextInputType.number,
//               style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
//               onChanged: onChanged,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class InputDate extends StatelessWidget {
//   final String label;
//   final DateTime date;
//   final Function(DateTime) onChanged;
//   const InputDate(
//       this.label,
//       this.date,
//       this.onChanged,
//       {Key? key}):super(key:key);
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 150,
//       child: Row(
//         textBaseline: TextBaseline.ideographic,
//         children: [
//           Text(label),
//           const SizedBox(width: 20),
//           Expanded(
//             child: InkWell(
//               child: Text(
//                 date.year.toString(),
//                 style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
//                 textAlign: TextAlign.end,
//               ),
//               onTap: () async {
//                 DateTime? dt = await showDatePicker(
//                   context: context,
//                   initialDate: date,
//                   firstDate: date.subtract(const Duration(days: 300)),
//                   lastDate: date.add(const Duration(days: 300)),
//                 );
//                 if (dt != null) {
//                   onChanged(dt);
//                 }
//               },
//             ),
//           ),
//           Expanded(
//             child: InkWell(
//               child: Text(
//                 date.month.toString(),
//                 style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
//                 textAlign: TextAlign.end,
//               ),
//               onTap: () async {
//                 DateTime? dt = await showDatePicker(
//                   context: context,
//                   initialDate: date,
//                   firstDate: date.subtract(const Duration(days: 300)),
//                   lastDate: date.add(const Duration(days: 300)),
//                 );
//                 if (dt != null) {
//                   onChanged(dt);
//                 }
//               },
//             ),
//           ),
//           Expanded(
//             child: InkWell(
//               child: Text(
//                 date.day.toString(),
//                 style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
//                 textAlign: TextAlign.end,
//               ),
//               onTap: () async {
//                 DateTime? dt = await showDatePicker(
//                   context: context,
//                   initialDate: date,
//                   firstDate: date.subtract(const Duration(days: 300)),
//                   lastDate: date.add(const Duration(days: 300)),
//                 );
//                 if (dt != null) {
//                   onChanged(dt);
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class NumberPickerDialog {
//   static Future<void> show(
//       BuildContext context,
//       int iniValue, {
//         int minValue = 0,
//         int maxValue = 10,
//         Function(int)? onChanged,
//       }) async {
//     int _value = iniValue;
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: NPD(
//             iniValue: _value,
//             minValue: minValue,
//             maxValue: maxValue,
//             onChanged: onChanged,
//           ),
//         );
//       },
//     );
//   }
// }
//
// class NPD extends StatefulWidget {
//   final int iniValue;
//   final int minValue;
//   final int maxValue;
//   final Function(int)? onChanged;
//   const NPD({
//     Key? key,
//     required this.iniValue,
//     this.minValue = 0,
//     this.maxValue = 10,
//     this.onChanged,
//   }) : super(key: key);
//
//   @override
//   _NPDState createState() => _NPDState();
// }
//
// class _NPDState extends State<NPD> {
//   late int _value;
//   @override
//   void initState() {
//     _value = widget.iniValue;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return NumberPicker(
//       value: _value,
//       minValue: widget.minValue,
//       maxValue: widget.maxValue,
//       onChanged: (int value) {
//         _value = value;
//         widget.onChanged?.call(value);
//         setState(() {});
//       },
//     );
//   }
// }
