import '/F0_BASIC/common_import.dart';
import 'package:intl/intl.dart';

//==============================================================================
// 부착상태 표시 하는 바 혹은 아이콘 (디자인 따라)
//==============================================================================
class ElectrodeContactStatus extends StatefulWidget {
  const ElectrodeContactStatus({Key? key}) : super(key: key);

  @override
  State<ElectrodeContactStatus> createState() => _ElectrodeContactStatusState();
}

class _ElectrodeContactStatusState extends State<ElectrodeContactStatus> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {

      });
    });

    // DspCommonParameter.exGoertzelCnEn = true;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextN(
         '접촉레벨 (양호: 1.5 이하?) '+ (dm[0].g.dsp.exGoertzelAv).toStringAsFixed(3),
          fontSize: tm.s20,
          fontWeight: FontWeight.w400,
          color: tm.white,
        ),

        TextN(
          '${dm[0].g.dsp.exceptionType}',
          fontSize: tm.s20,
          fontWeight: FontWeight.w400,
          color: tm.white,
        ),

        TextN(
          '${dm[0].g.dsp.exFakeType}',
          fontSize: tm.s20,
          fontWeight: FontWeight.w400,
          color: tm.white,
        ),

        // DspCommonParameter.exGoertzelCnEn = true
        // 위 설정 후 아래 코드 실행하여 60Hz 잡음 수준 측정 가능
        // TextN(
        // '  60Hz '+  (dm[0].g.dsp.exGoertzelCnAv).toStringAsFixed(3),
        //   fontSize: tm.s20,
        //   fontWeight: FontWeight.w400,
        //   color: tm.white,
        // ),
      ],
    );
  }
}
