import '/F0_BASIC/common_import.dart';
import 'package:permission_handler/permission_handler.dart';
import '/F6_WIDGET/POPUP/auto_connection_setting_switch.dart';
import 'package:flutter/cupertino.dart';

class DeviceConnectDialog extends StatelessWidget {
  final double aSideMargin = 16; // 다이얼로그 팝업창의 (한쪽) 옆면 Margin 값
  final int d = 0;

  const DeviceConnectDialog({
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
          const _DeviceList(),
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
          top: asHeight(10),
          bottom: asHeight(10),
          left: asWidth(8),
          right: asWidth(8)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: Alignment.center,
            child:
                //--------------------------------------------------------------
                // 제목(title)
                //--------------------------------------------------------------
                Obx(
              () => TextN(
                (gv.deviceStatus[d].isDeviceBtConnected.value == false &&
                        gv.setting.isBluetoothAutoConnect.value == true)
                    ? '장비 자동연결'
                    : '장비 검색',
                fontSize: tm.s20,
                color: tm.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //--------------------------------------------------------------------
          // 닫기 버튼
          //--------------------------------------------------------------------
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(asWidth(10)),
              onTap: (() {
                Get.back();
              }),
              child: Container(
                width: asWidth(56),
                height: asHeight(56),
                alignment: Alignment.center,
                child: Icon(
                  Icons.close,
                  size: asHeight(36),
                  color: tm.grey03,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//============================================================================
// 스캔 된 블루투스 장치 리스트 보여주는 위젯 클래스
//============================================================================
// 새로 검색된 장비들의 수 및 상태가 변경될 수 있으므로 stateful 로 작성
class _DeviceList extends StatefulWidget {
  const _DeviceList({
    Key? key,
  }) : super(key: key);

  @override
  State<_DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<_DeviceList>
    with TickerProviderStateMixin {
  // "전원" 아이콘 깜박이는데 사용되는 타이머
  late Timer _opacityChangeTimer;
  double opacityLevel = 1.0; // 초기 투명도 값
  int d = 0;

  late StreamSubscription _isConnectedRealListen;
  late StreamSubscription _isScanListUpdatedListen;

  // "전원" 아이콘에 적용되는 투명도 변경하는 메소드
  // void _changeOpacity() {
  //   setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  // }

  ///---------------------------------------------------------------------------
  /// initState()
  ///---------------------------------------------------------------------------
  @override
  void initState() {
    // bleAdaptor 에 있는 스캔 리스트 목록 초기화
    bleCommonData.scanDevices = [];
    // 스캔 결과 업데이트 변경 알림 연결
    // todo : 사라지는 현상 있음. 체크 필요 (221128)
    _isScanListUpdatedListen =
        bleCommonData.isScanListUpdated.listen((isScanListUpdated) {
      setState(() {});
    });
    // Android 12 이상일 경우 scan 을 위해 permission 받아야함
    if (gv.system.isAndroid && int.parse(gv.system.osVersion!) >= 12) {
      if (kDebugMode) {
        print('_DeviceListState :: initState :: osVersion(${int.parse(gv.system.osVersion!)}) >= 12. permission 허가 받는 프로세스 시작');
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bluetoothScanAndConnectRequestThenScan(context);
      });
    } else if(gv.system.isAndroid && int.parse(gv.system.osVersion!) < 12) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        locationPermissionRequest(context);
      });
    }else{
      BleManager.scan(true, filter: 'FITSIG');
    }

    // "전원" 아이콘 투명도 조절 타이머 초기화
    _opacityChangeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
      });
      // gv.setting.isBluetoothAutoConnect.value == true
      //     ? _changeOpacity()
      //     : () {};
    });

    //--------------------------------------------------------------------------
    // 연결 성공 시 창 닫기
    //--------------------------------------------------------------------------
    _isConnectedRealListen =
        bt[d].bleDevice.isBtConnectedReal.listen((isConnectedReal) async {
      // 장비와 연결된 경우, 타이머 및 이벤트 리스너 취소 후 팝업창 닫기
      if (isConnectedReal == true) {
        Navigator.pop(context); // 팝업창 닫기
      }
    });
    super.initState();
  }

  ///---------------------------------------------------------------------------
  /// dispose()
  ///---------------------------------------------------------------------------
  @override
  void dispose() {
    _opacityChangeTimer.cancel(); // 투명도 조절 타이머 종료
    _isConnectedRealListen.cancel(); //연결상태 감지 리스너 삭제
    _isScanListUpdatedListen.cancel(); //스캔리스트 감지 리스터 삭제

    if (bleCommonData.isScanning == true) {
      BleManager.scan(false);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          //--------------------------------------------------------------------
          // 블루투스 자동연결 설정 버튼
          // 설정의 자동 연결과 동일하게
          //----------------------------------------------------
          AutoConnectionSettingSwitch(
            onToggle: (check) {
              int d = 0;
              //----------------------------------------------
              // 기존 장비 기록이 없는 상태라면, 무조건 disable
              //----------------------------------------------
              if (gv.deviceStatus[d].btControlState.value ==
                  EmlBtControlState.idleInit) {
                gv.setting.isBluetoothAutoConnect.value = false;
                openSnackBarBasic('장비 기록 없음', '장비를 연결한 기록이 있어야 자동 설정이 가능합니다.');
              }
              //----------------------------------------------
              // 기존 장비 기록이 있다면 설정 가능
              //----------------------------------------------
              else {
                gv.setting.isBluetoothAutoConnect.value = check; //
                gv.spMemory.write('isBluetoothAutoConnect', check);
                //--------------------------------------------
                // 연결 대기 상태에 따라 조건부 연결 처리
                //--------------------------------------------
                if (gv.setting.isBluetoothAutoConnect.value == true) {
                  gv.btStateManager[d].whenAutoConnectChangeToEnable();
                } else {
                  gv.btStateManager[d].whenAutoConnectChangeToDisable();
                }
              }
              //----------------------------------
              // 자동 연결 해제 시 전원아이콘 깜빡임 타이머 생성
              // if (check) {
              //   if (opacityChangeTimer.isActive != true) {
              //     opacityChangeTimer =
              //         Timer.periodic(const Duration(seconds: 1), (timer) {
              //       _changeOpacity();
              //     });
              //   }
              // }
              // //----------------------------------
              // // 자동 연결 해제 시 전원아이콘 깜빡임 타이머 해제
              // else {
              //   // gv.bleManager[0].connectionTimer?.cancel();
              //   opacityChangeTimer.cancel();
              // }
            },
          ),
          dividerBig(),

          //-------------------------------------------------------------
          // 검색된 장비 표시리스트 또는 (이전 연결 정보 있을 경우) "전원 켜주세요"
          //-------------------------------------------------------------
          Obx(
            () => Expanded(
                child: (gv.deviceStatus[d].isDeviceBtConnected.value == false &&
                        gv.setting.isBluetoothAutoConnect.value == true)
                    ? SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     TextN(
                            //       bt[d].bleDevice.name,
                            //       fontSize: tm.s20,
                            //       color: tm.black,
                            //     ),
                            //     asSizedBox(width: 5),
                            //     AnimatedOpacity(
                            //       opacity: opacityLevel,
                            //       duration: opacityLevel == 1.0
                            //           ? const Duration(milliseconds: 100)
                            //           : const Duration(milliseconds: 400),
                            //       child: Icon(
                            //         Icons.power_settings_new_rounded,
                            //         size: tm.s30,
                            //         color: tm.blue,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Image.asset(
                              'assets/icons/ic_블루투스.png', //device_white_256.png',
                              fit: BoxFit.scaleDown,
                              height: asHeight(40),
                              color: tm.mainBlue,
                            ),
                            SizedBox(height: asHeight(10)),
                            TextN(
                              '장비의 전원을 켜주세요',
                              fontSize: tm.s12,
                              fontWeight: FontWeight.bold,
                              color: tm.mainBlue,
                            ),
                            // SizedBox(height: asHeight(30)),
                            // Padding(
                            //   padding:
                            //       EdgeInsets.symmetric(horizontal: asWidth(18)),
                            //   child: TextN(
                            //     '새로운 장비와 연결하는 경우 자동연결 설정을 끈 후에 검색을 하세요',
                            //     color: tm.grey03,
                            //     fontSize: tm.s16,
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            left: asWidth(8),
                            right: asWidth(16),
                            top: asHeight(4),
                            bottom: asHeight(4)),
                        itemCount: bleCommonData.scanDevices.length,
                        itemBuilder: (context, index) => _ScanListItem(
                          key: ValueKey(bleCommonData.scanDevices[index].name),
                            bleDevice: bleCommonData.scanDevices[index],
                            index: index),
                      )),
          ),
          // dividerSmallThin(),
          //--------------------------------------------------------------
          // "FITSIG 장비 검색중"
          //--------------------------------------------------------------
          // Obx(() {
          //   return Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       TextN(
          //         gv.setting.isBluetoothAutoConnect.value == true
          //             ? '등록된 장비 전원켜짐 대기 중...  '
          //             : 'FITSIG 장비 검색 중...  ',
          //         fontSize: tm.s16,
          //         color: tm.grey03,
          //       ),
          //       SizedBox(
          //         width: tm.s20,
          //         height: tm.s20,
          //         child: const CupertinoActivityIndicator(
          //           radius: 15.0,
          //           color: CupertinoColors.black,
          //         ),
          //
          //         // CircularProgressIndicator(
          //         //   valueColor: AlwaysStoppedAnimation<Color>(tm.blue),
          //         //   strokeWidth: 3,
          //         //   semanticsLabel: 'Circular progress indicator',
          //         // ),
          //       ),
          //     ],
          //   );
          // }),
          SizedBox(
            height: asHeight(20),
          ),
        ],
      ),
    );
  }
}

void bluetoothScanAndConnectRequestThenScan(BuildContext context) async {
  await Permission.bluetoothScan.request(); // android 버전 9
  var scanStatus = await Permission.bluetoothScan.status;
  await Permission.bluetoothConnect.request(); // android 버전 9
  var connectStatus = await Permission.bluetoothConnect.status;
  if (scanStatus.isGranted && connectStatus.isGranted) {
    BleManager.scan(true, filter: 'FITSIG');
  } else {
    // 블루투스 scan 퍼미션을 받지 않아, 스캔 팝업 창을 닫음
    Navigator.pop(context);
  }
}

void locationPermissionRequest(BuildContext context) async {
  await Permission.location.request();
  var locationStatus = await Permission.location.status;
  if (locationStatus.isGranted) {
    BleManager.scan(true, filter: 'FITSIG');
  } else {
    // 블루투스 scan 퍼미션을 받지 않아, 스캔 팝업 창을 닫음
    Navigator.pop(context);
  }
}

/// ============================================================================
/// 검색 리스트 아이템
/// - 좌측: 블루투스 아이콘
/// - 중앙: 이름 및 어드레스
/// - 우측: RSSI
/// ============================================================================
class _ScanListItem extends StatefulWidget {
  final BleDevice bleDevice; //BleDevice
  final int index;

  const _ScanListItem({required this.bleDevice, required this.index, Key? key,}): super(key:key);

  @override
  State<_ScanListItem> createState() => _ScanListItemState();
}

class _ScanListItemState extends State<_ScanListItem> {
  late int rssi;
  Timer? scannedDeviceShowTimer;
  late Timer rssiChangeTimer;
  int d = 0;
  // late StreamSubscription _rssiListen;
  int lastRssiCounter = 0;

  @override
  void initState() {
    super.initState();
    rssi = widget.bleDevice.rssi.value;
    // 검색된 장치의 RSSI 가 변경될 경우 화면을 갱신하여 새로운 RSSI 가 표시되도록 등록
    // print('새로운 인스턴스 시작 :: deviceName=${widget.bleDevice.name.split(':').last} hashCode=${widget.bleDevice.hashCode}');
    // _rssiListen = widget.bleDevice.rssi.listen(
    //   (newRssi) async {
    //     if (scannedDeviceShowTimer.isActive) {
    //       scannedDeviceShowTimer.cancel();
    //     }
    //
    //     // 제대로 동작하게 하려면 scanDevices 리스트를 업데이트하는 BLE 모듈에서 advertise 수신에 따른 scanDevice 리스트를 수정하나,
    //     // 구현이 되어있지 않아 App(의 위젯)에서 control 하다보니 RSSI event 호출 interval 이 가끔  1초 혹은 2초보다 길때가 있음.
    //     // 이로인해 아래의 타이머의 실행 지연값이 1,2초로 짧을 경우, 실행되어 scanDevice 리스트에서 해당 device 를 삭제될 때가 많아
    //     // 3초로 넉넉히 줌 (2023.02.28)
    //     scannedDeviceShowTimer = Timer(
    //       const Duration(seconds: 3),
    //       () {
    //         rssiChangeTimer.cancel();
    //         // 처음 bleCommonData.scanDevices 리스트에서 할당 되었던 index 는 다른 장비가 off 되어 리스트에서 삭제 될 경우,
    //         // 기존에 존재하던 리스트 아이템들의 index 가 변경될 수 있으므로 삭제할때 마다 index 를 찾아봐야함
    //         int currentIndex =
    //             bleCommonData.scanDevices.indexOf(widget.bleDevice);
    //         if(currentIndex == -1){
    //           print('_ScanListItemState :: Timer event :: bleCommonData.scanDevices.indexOf(widget.bleDevice) = -1  ### WARNING ###');
    //           return ;
    //         }
    //         // print('삭제할 인스턴스 :: 위젯 deviceName=${widget.bleDevice.name.split(':').last}, 검색한deviceName=${bleCommonData.scanDevices[currentIndex].name}  검색한hashCode=${bleCommonData.scanDevices[currentIndex].hashCode}');
    //         setState(() {
    //           bleCommonData.scanDevices.removeAt(currentIndex);
    //         });
    //         // print('삭제후 리스트 :: scanDevices.length=${bleCommonData.scanDevices.length}');
    //         // for(int i=0;i<bleCommonData.scanDevices.length;i++){
    //         //   print('삭제후 리스트 :: 이름=${bleCommonData.scanDevices[i].name.split(':').last} hashCode=${bleCommonData.scanDevices[i].hashCode}');
    //         // }
    //       },
    //     );
    //   },
    // );
   // rssiChangeTimer = Timer.periodic(const Duration(seconds: 2), (_) {
   //    setState(() {
   //      rssi = widget.bleDevice.rssi.value;
   //    });
   //  });

   rssiChangeTimer = Timer.periodic(const Duration(seconds: 2), (_) {
     // BleDevice 에서 advertisement 수신 때마다 증가 시키는 rssiCounter 가 변화 했다면..아직 장치(fitsig)가 켜져 있는 것으로 간주
     if( lastRssiCounter != widget.bleDevice.rssiCounter.value) {
       // RSSI가 수신되고 있으므로, 검색된 장비 표시 삭제 타이머가 켜져있다면 해제
       if(scannedDeviceShowTimer != null){
         scannedDeviceShowTimer!.cancel();
         scannedDeviceShowTimer = null;
       }
       lastRssiCounter = widget.bleDevice.rssiCounter.value;
       setState(() {
         rssi = widget.bleDevice.rssi.value;
       });
     }
     // 이전 rssiCounter 값과 동일 하면 꺼진 것으로 의심되므로, 검색된 장비 표시 삭제를 위한 Timer 시작
     else if((lastRssiCounter == widget.bleDevice.rssiCounter.value) && scannedDeviceShowTimer == null){
       scannedDeviceShowTimer = Timer(const Duration(seconds: 4), () {
         int currentIndex = bleCommonData.scanDevices.indexOf(widget.bleDevice);
         if (currentIndex == -1) {
           print(
               '_ScannedDeviceItemState :: Timer event :: bleCommonData.scanDevices.indexOf(widget.bleDevice) = -1  ### WARNING ###');
           return;
         }
         bleCommonData.scanDevices.removeAt(currentIndex);
       });
     }
   });

    // scannedDeviceShowTimer = Timer(const Duration(seconds: 3), () {
    //   int currentIndex =
    //   bleCommonData.scanDevices.indexOf(widget.bleDevice);
    //   if(currentIndex == -1){
    //     print('_ScanListItemState :: Timer event :: bleCommonData.scanDevices.indexOf(widget.bleDevice) = -1  ### WARNING ###');
    //     return ;
    //   }
    //   setState(() {
    //     bleCommonData.scanDevices.removeAt(currentIndex);
    //   });
    // });
  }

  @override
  void dispose() {
    // print('인스턴스 종료 :: deviceName=${widget.bleDevice.name.split(':').last} hashCode=${this.hashCode}');
    // _rssiListen.cancel(); //리스너 해제
    scannedDeviceShowTimer?.cancel();
    rssiChangeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.index == 0)
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
            widget.bleDevice.name,
            fontSize: tm.s16,
            fontWeight: FontWeight.bold,
            color: tm.black,
          ),
          subtitle: TextN(
            widget.bleDevice.id,
            fontSize: tm.s12,
            color: tm.grey03,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: TextN(
            '$rssi dBm',
            fontSize: tm.s14,
            color: tm.black,
          ),
          onTap: () async {
            // 스캔을 멈추고 연결 시도
            // 상태를 보고 연결 시도
            // 최초대기 혹은 auto disable 대기상태 일 때 재 연결 가능
            await BleManager.scan(false);
            await Future.delayed(const Duration(milliseconds: 100));
            await gv.btStateManager[d].connectNewDevice(widget.bleDevice);
            Navigator.pop(context); // 다이얼로그 닫기
            //----------------------------------------------------------------
            // 완전히 완료되지 않은 상황에서 다시 연결하는 것이 문제가 될 때 다음 실행 (221128)
            // if (gv.deviceStatus[d].btControlState.value ==
            //         EmlBtControlState.idleInit ||
            //     gv.deviceStatus[d].btControlState.value ==
            //         EmlBtControlState.idleDis) {
            //   await BleManager.scan(false);
            //   await Future.delayed(const Duration(milliseconds: 100));
            //   await gv.btStateManager[d].connectNewDevice(widget.bleDevice);
            //   Navigator.pop(context);// 다이얼로그 닫기
            // } else {
            //   openSnackBarBasic(
            //       '연결 대기', '기존의 블루투스 연결이 종료되지 않았습니다. 잠시 후 다시 시도하세요.');
            // }
          },
        ),
        dividerSmall2(),
      ],
    );
  }
}
