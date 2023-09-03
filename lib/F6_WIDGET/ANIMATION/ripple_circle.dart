import '/F0_BASIC/common_import.dart';

GlobalKey<_RipplesAnimationState> _ripplesAnimationStateSimpleKey = GlobalKey();
GlobalKey<_RipplesAnimationState> _ripplesAnimationStateDetailKey = GlobalKey();

// late AnimationController aniControllerRipple;
bool _isAnimationControllerInitialized = false;
bool _visible = false;
late Timer _opacityTimer = Timer(const Duration(milliseconds: 1000), () {});

//==============================================================================
// 리플 테스트코드
//==============================================================================

void rippleAnimationExecution() {
  // 이미 화면 상 측정 종료 된 경우 애니메이션 실행 안함 (애니메이션 에러 방지)
  // 애니메니션 컨트롤러가 초기화가 안된 경우에도 실행 안함
  if (DspManager.isMeasureOnScreen == false || _isAnimationControllerInitialized == false){
    return;
  }

  //원형 리플 애니메이션 재 시작
  if( gvMeasure.isViewMeasureSimple == true) {
    _ripplesAnimationStateSimpleKey.currentState?.aniControllerRipple.reset();
    _ripplesAnimationStateSimpleKey.currentState?.aniControllerRipple.forward();

    //최초 애니메이션 보이게
    _visible = true;
    _ripplesAnimationStateSimpleKey.currentState?.refresh(); //AnimatedOpacity 갱신
    // 특정 시간 후에 애니메이션 안보이게 할 목적의 타이머
    // 0.5초뒤에 사라짐
    _opacityTimer.cancel();
    _opacityTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // 화면에서 사라지게
      _visible = false;
      _ripplesAnimationStateSimpleKey.currentState?.refresh(); //AnimatedOpacity 갱신
      _opacityTimer.cancel();
    });

  }else{
    _ripplesAnimationStateDetailKey.currentState?.aniControllerRipple.reset();
    _ripplesAnimationStateDetailKey.currentState?.aniControllerRipple.forward();

    //최초 애니메이션 보이게
    _visible = true;
    _ripplesAnimationStateDetailKey.currentState?.refresh(); //AnimatedOpacity 갱신

    // 특정 시간 후에 애니메이션 안보이게 할 목적의 타이머
    // 0.5초뒤에 사라짐
    _opacityTimer.cancel();
    _opacityTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // 화면에서 사라지게
      _visible = false;
      _ripplesAnimationStateDetailKey.currentState?.refresh(); //AnimatedOpacity 갱신
      _opacityTimer.cancel();
    });
  }
}

Widget ripplesAnimationSimple() {
  return RipplesAnimation(
    key: _ripplesAnimationStateSimpleKey,
    size: asHeight(60),
    color: tm.mainBlue,
    durationMs: 300,
    opacityTotal: 0.08,
    //0.1도 강한 듯
    numOfCircle: 7,
  );
}

Widget ripplesAnimationDetail() {
  return RipplesAnimation(
    key: _ripplesAnimationStateDetailKey,
    size: asHeight(60),
    color: tm.mainBlue,
    durationMs: 300,
    opacityTotal: 0.08,
    //0.1도 강한 듯
    numOfCircle: 7,
  );
}

class RipplesAnimation extends StatefulWidget {
  final int durationMs;
  final Color color;
  final double size;
  final double opacityTotal;
  final int numOfCircle;

  const RipplesAnimation({
    this.durationMs = 200,
    this.color = Colors.blue,
    this.size = 40,
    this.opacityTotal = 1,
    this.numOfCircle = 4,
    Key? key,
  }) : super(key: key);

  @override
  State<RipplesAnimation> createState() => _RipplesAnimationState();
}

class _RipplesAnimationState extends State<RipplesAnimation>
    with TickerProviderStateMixin {
  late double size; // = widget.size;
  late Color color; // = Colors.indigoAccent.withOpacity(0.2);
  late AnimationController aniControllerRipple;

  @override
  void initState() {
    super.initState();
    aniControllerRipple = AnimationController(
      duration: Duration(milliseconds: widget.durationMs),
      vsync: this,
    ); //..forward();
    _isAnimationControllerInitialized = true;
  }

  //---------------------------------
  // 애니메이션 갱신
  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    aniControllerRipple.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = widget.size;
    color = widget.color;
    return Center(
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0, //점점 안보이게
        duration: Duration(milliseconds: widget.durationMs),
        child: CustomPaint(
          painter: CirclePainter(
            aniControllerRipple,
            color: color,
            opacityTotal: widget.opacityTotal,
            numOfCircle: widget.numOfCircle,
          ),
          child: SizedBox(
            width: size * widget.numOfCircle, // * 4.125,
            height: size * widget.numOfCircle, // * 4.125,
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(
    this._animation, {
    this.color = Colors.blue,
    this.opacityTotal = 1,
    this.numOfCircle = 4,
  }) : super(repaint: _animation);

  final Color color;
  final Animation<double> _animation;
  final double opacityTotal;
  final int numOfCircle;

  void circle(Canvas canvas, Rect rect, double value, double opacityTotal) {
    final double opacity =
        (1.0 - (value / numOfCircle.toDouble())).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity * opacityTotal);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = sqrt(area * value / 4);
    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = numOfCircle - 1; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value, opacityTotal);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}

// class PulsateCurve extends Curve {
//   const PulsateCurve();
//
//   @override
//   double transform(double t) {
//     if (t == 0 || t == 1) {
//       return 0.01;
//     }
//     return sin(t * pi);
//   }
// }
