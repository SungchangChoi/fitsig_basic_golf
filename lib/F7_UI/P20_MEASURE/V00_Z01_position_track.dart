import '/F0_BASIC/common_import.dart';


final GlobalKey<_PositionTrackState> keyPositionTrack = GlobalKey();
//==============================================================================
// record main
//==============================================================================
Widget musclePositionTrack()
{
  return _PositionTrack(key: keyPositionTrack);

}

//==============================================================================
// position track : 클릭하면 나타나고 이후에 사라짐
//==============================================================================
class _PositionTrack extends StatefulWidget {
  const _PositionTrack({Key? key}) : super(key: key);

  @override
  State<_PositionTrack> createState() => _PositionTrackState();
}

class _PositionTrackState extends State<_PositionTrack> {
  bool _visible = false;
  Timer timer = Timer(const Duration(milliseconds: 1000), () {});

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void refresh() {
    setState(() {
      _visible = true;

      // 근육 변화가 감지되면 1초 정도 유지
      timer.cancel();
      timer = Timer(const Duration(milliseconds: 1000), () {
        _visible = false;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double markSize = asHeight(8);
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: asWidth(260),
        alignment: Alignment.center,
        child: FittedBoxN(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                gv.dbmMuscle.numberOfData,
                    (index) => Container(
                  height: markSize,
                  width: markSize,
                  margin: EdgeInsets.symmetric(horizontal: asWidth(2)),
                  decoration: BoxDecoration(
                      color: index == gv.control.idxMuscle.value
                          ? tm.mainBlue
                          : tm.grey02,
                      borderRadius: BorderRadius.circular(markSize / 2)),
                )),
          ),
        ),
      ),
    );
  }
}

//==============================================================================
// 화면 갱신용
//==============================================================================
class RefreshMeasureIdle {
  //----------------------------------------------------------------------------
  // track 관련 갱신
  //----------------------------------------------------------------------------
  static void muscleTrack() {
    keyPositionTrack.currentState?.refresh(); //사라지는 트랙은 stateful
  }
}
