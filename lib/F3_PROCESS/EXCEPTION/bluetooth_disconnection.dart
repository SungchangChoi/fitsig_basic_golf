import '/F0_BASIC/common_import.dart';

//==============================================================================
// BLE manager
//==============================================================================
// List<int> previousBluetoothToDspCnt = List.generate(GvDef.maxDeviceNum,
//     (_) => 0); // 장비가 사용자의 의도치 않게 꺼지는 것을 체크하기 위한 callback count

// checkBluetoothDisconnectionOld() {
//   int d = 0;
//
//   //--------------------------------------------------------------------------
//   // 장치 전원 꺼짐을 확인하기 위한 프로세스
//   //--------------------------------------------------------------------------
//   // 500ms 마다 한번씩 실행,
//   Timer _disconnectionCheckTimer =
//       Timer.periodic(const Duration(milliseconds: 500), (timer) async {
//
//     for (int index = 0; index < GvDef.maxDeviceNum; index++) {
//
//       if (gv.deviceStatus[index].isDeviceBtConnected.value == true &&
//           gv.deviceStatus[index].isDeviceOTAUpdating.value == false) {
//         // 연결이 되어있다면 DspManager 로부터 해장 장비(index)의 bluetoothToDspCnt 값 가져옴
//         int bluetoothToDspCnt = gv.bleManager[d].bluetoothToDspCnt;
//
//         // if (kDebugMode) {
//         //   print(
//         //       'bluetooth_disconnection.dart :: checkBluetoothDisconnection() : 이전값=${previousBluetoothToDspCnt[index]}  현재값=$bluetoothToDspCnt  차이=${bluetoothToDspCnt - previousBluetoothToDspCnt[index]}');
//         // }
//
//         // 이전 bluetoothToDspCnt 값과 차이 비교하여 장비 꺼짐을 판단
//         if (bluetoothToDspCnt - gv.bleManager[d].previousBluetoothToDspCnt < 1 &&
//             gv.bleManager[d].previousBluetoothToDspCnt != 0) {
//
//           print(
//               'bluetooth_disconnection.dart :: checkBluetoothDisconnection() : 장비와 disconnect 된것을 인지 하였습니다. ');
//
//           // 장비가 꺼졌으므로, 현재 측정중 상태라면 측정 종료
//           if(DspManager.stateMeasure.value ==
//               EmlStateMeasure.onMeasure){
//
//             DspManager.commandMeasureComplete();
//
//             // 장비가 꺼져서 측정을 종료하는 것이므로, 원래 값으로 복귀
//             gv.deviceData[0].mvcLevel.value =
//                 gv.dbMuscleIndexes[gv.control.idxMuscle.value].mvcMv * GvDef.convLv;
//             print(
//                 'bluetooth_disconnection.dart :: 측정 중 장비의 연결이 해제되어 측정을 취소합니다.');
//             await Future.delayed(const Duration(seconds: 3));
//             //--------------------------------------------------
//             // 다이올로그 닫기
//             Get.back();
//           }
//
//           // 장비가 꺼졌으므로, counter 초기화
//           gv.bleManager[d].previousBluetoothToDspCnt = 0;
//           gv.bleManager[d].bluetoothToDspCnt = 0;
//           whenBluetoothDisconnected(0);
//
//         } else {
//           gv.bleManager[d].previousBluetoothToDspCnt = bluetoothToDspCnt;
//         }
//       }
//     }
//   });
// }
