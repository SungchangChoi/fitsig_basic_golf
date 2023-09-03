import '/F0_BASIC/common_import.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cp949_dart/cp949_dart.dart'
    as cp949; //  Microsoft Windows 의 한글 인코딩 방식으로, EUC-KR의 확장임

//==============================================================================
// battery capacity test
//==============================================================================

class BatterCapacityTestPage extends StatefulWidget {
  const BatterCapacityTestPage({Key? key}) : super(key: key);

  @override
  State<BatterCapacityTestPage> createState() => _BatterCapacityTestPageState();
}

class _BatterCapacityTestPageState extends State<BatterCapacityTestPage> {
  int measureSec = 0;
  bool flagMeasureEnable = false;
  int d = 0;

  List<int> timeMin = [];
  List<double> batteryVolt = [];
  List<bool> chargeState = [];

  late Timer timer;
  late Directory dir;
  late String filePath;
  late File file;
  late String fileName;

  _prepareLogFile() async {
    dir = await getApplicationDocumentsDirectory();
    int today = todayInt8();
    fileName = '${today}_batteryLog.csv';
    filePath = '${dir.path}/$fileName';
    if (await File(filePath).exists()) {
      File(filePath).deleteSync();
      file = await File(filePath).create();
    } else {
      file = await File(filePath).create();
    }
  }

  @override
  void initState() {
    Wakelock.enable(); //화면 켜짐 유지 - 배터리 시험 중에 켜짐 유지
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (flagMeasureEnable) {
        // 매 1분마다 기록
        // 1차 시험 후 5분으로 변경 검토
        // print(measureSec % 60);
        if (measureSec % 60 == 0) {
          timeMin.add(measureSec ~/ 60);
          batteryVolt.add(BleManager.fitsigDeviceAck[d].batteryVoltage);
          chargeState.add(BleManager.fitsigDeviceAck[d].mspState.isCharging);
          String stringData =
              '${measureSec ~/ 60}분,${BleManager.fitsigDeviceAck[d].batteryVoltage.toStringAsFixed(4)}V,'
              '${(BleManager.fitsigDeviceAck[d].mspState.isCharging).toString()}\n';
          List<int> byteData = cp949.encode(stringData);
          file.writeAsBytesSync(byteData, mode: FileMode.append);
        }
        measureSec++;
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
            child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //--------------------------------------------------------------
                // 상단 바
                topBarBack(context),
                //--------------------------------------------------------------
                // 설명 글
                asSizedBox(height: 20),
                const TextN(
                  '배터리 전압 연속적 관찰',
                ),
                asSizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButtonN(
                      onPressed: (() async {
                        await _prepareLogFile();
                        measureSec = 0;
                        timeMin = [];
                        batteryVolt = [];
                        chargeState = [];
                        flagMeasureEnable = true;
                      }),
                      child: const TextN('측정 시작'),
                    ),
                    ElevatedButtonN(
                      onPressed: (() async {
                        flagMeasureEnable = false;
                        dir = await getApplicationDocumentsDirectory();
                        filePath = '${dir.path}/$fileName';
                        bool existFile = File(filePath).existsSync();
                        if (existFile) {
                          await saveFileAtVisibleDirectory(
                              newFileNames: [fileName],
                              files: [File(filePath)]);
                        }
                      }),
                      child: const TextN('측정 종료'),
                    ),
                  ],
                ),

                asSizedBox(height: 20),
                TextN(
                  '측정 시간 : ${timeToStringBasic(timeSec: measureSec)}',
                ),
                TextN(
                  '데이터 수 : ${timeMin.length}',
                  // measureSec ~/ 60
                ),
                asSizedBox(height: 20),
                Column(
                  children: List.generate(
                      timeMin.length,
                      (index) => Row(
                            children: [
                              SizedBox(
                                  width: asWidth(100),
                                  child: TextN('시간 : ${timeMin[index]}분')),
                              SizedBox(
                                width: asWidth(100),
                                child: TextN(
                                    '전압 :  ${batteryVolt[index].toStringAsFixed(4)}V'),
                              ),
                              SizedBox(
                                width: asWidth(100),
                                child: TextN(
                                    '충전여부 :  ${chargeState[index].toString()}'),
                              ),
                            ],
                          )),
                ),
                asSizedBox(height: 50),
                Container(
                  color: Colors.greenAccent,
                  height: 50,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        )));
  }
}
