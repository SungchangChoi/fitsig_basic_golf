import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 심박 표시 : 2초에 1회 정도면 충분할 듯...
//==============================================================================
class HeartRateDisplay extends StatefulWidget {
  const HeartRateDisplay({Key? key}) : super(key: key);

  @override
  State<HeartRateDisplay> createState() => _HeartRateDisplayState();
}

class _HeartRateDisplayState extends State<HeartRateDisplay> {
  //----------------------------------------------------------------------------
  // 1초단위 갱신 타이머 설정 및 해제
  //----------------------------------------------------------------------------
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //----------------------------------------------------------------------------
  // build
  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(asHeight(8)),
      onTap: (() {
        //보기 설정 변경
        gvMeasure.isViewEcg = !gvMeasure.isViewEcg;
        setState(() {});
      }),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(10), vertical: asHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 심박 보기 설정에 따라 컬러 변경
            Icon(
              Icons.favorite,
              color: gvMeasure.isViewEcg ? tm.red : tm.red.withOpacity(0.2),
              size: asHeight(20),
            ),
            asSizedBox(width: 4),
            TextN(dm[0].g.dsp.ecgHeartRateNow>30 ? (dm[0].g.dsp.ecgHeartRateNow).toStringAsFixed(0):'-',
                fontSize: tm.s16,
                fontWeight: FontWeight.bold,
                color: gvMeasure.isViewEcg ? tm.grey04 : tm.grey03),
          ],
        ),
      ),
    );
  }
}

Widget hearRate() {
  return Container(
    height: asHeight(20),
  );
}
