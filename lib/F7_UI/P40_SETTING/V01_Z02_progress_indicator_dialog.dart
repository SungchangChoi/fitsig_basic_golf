import '/F0_BASIC/common_import.dart';

//==============================================================================
// class : 진행 프로세스 보여주는 dialog 의 child 로 사용할 수 있는 위젯
//==============================================================================
class ProgressIndicatorDialog extends StatefulWidget {
  const ProgressIndicatorDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgressIndicatorDialog> createState() =>
      _ProgressIndicatorDialogState();
}

class _ProgressIndicatorDialogState extends State<ProgressIndicatorDialog> {
  bool _isCompleted = false; //  진행 완료시 한번만 실행되도록 하는 Flag 변수
  double progressValue = 0.0; //
  late StreamSubscription _progressListen;

  @override
  void initState() {
    _isCompleted = false;
    _progressListen = dvSetting.exportProgressStatus.listen((value) {
      if (progressValue >= 1 && _isCompleted == false) {
        setState(() {
          progressValue = value;
          _isCompleted = true;
        });
        Get.back();
      } else {
        setState(() {
          progressValue = value;
        });
      }
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
    super.initState();
  }

  @override
  void dispose() {
    _progressListen.cancel(); //리스너 제거
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: asHeight(20), horizontal: asWidth(20)),
      width: asWidth(220),
      height: asHeight(200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //------------------------------------------------------------------
          // 제목
          //------------------------------------------------------------------
          TextN(
            '운동기록 내보내기 진행 중',
            fontSize: tm.s18,
            color: tm.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: asHeight(20)),
          //-------------------------------------------------------------------
          // 진행 바
          //-------------------------------------------------------------------
          // const Expanded(child: Center(child: CircularProgressIndicator())),
          Expanded(child: Center(child: UpdateProgressBar(value: progressValue))),
        ],
      ),
    );
    // Expanded(
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: asWidth(16)),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Column(
    //           children: [
    //             TextN(
    //               '근전도 장비의 펌웨어를'
    //                       ' ${(bleCommonData.otaFileVersion!.buildVersion & 0xffffff).toRadixString(16)} 버전으로 업데이트 합니다.'
    //                   .tr,
    //               fontSize: tm.s16,
    //               color: tm.black,
    //             ),
    //             asSizedBox(height: 8),
    //             TextN(
    //               '업데이트 중에는 장비의 전원을 끄지 마세요. 예상 소요 시간은 약 1분 30초 입니다.'.tr,
    //               fontSize: tm.s16,
    //               color: tm.black,
    //             ),
    //           ],
    //         ),
    //         UpdateProgressBar(
    //           value: progressValue,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
