import 'package:flutter/material.dart';


//------------------------------------------------------------------------------
// Bounce Circle 애니메니션 클래스
// - linear gradient 된 색상을 가진 원이  fade out, fade in  하면서 깜박거리는 애니메이션
//------------------------------------------------------------------------------
class BounceCircle extends StatefulWidget {
  final Color color;        // 원의 색
  final double radius;      // 원의 반지름
  final Alignment center;

  const BounceCircle({
    Key? key,
    this.color = Colors.blue,
    this.radius = 10,
    this.center  = Alignment.center,
  }) : super(key: key);


  @override
  State<BounceCircle> createState() => _BounceCircleState();
}

class _BounceCircleState extends State<BounceCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // 1초 길이로 반복하는 애니메이션 컨트롤러 설정 초기화
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
    // animation value(여기서는 투명도에 적용)가 변화할때마다 화면 갱신을 위한 설정
    _animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BounceCircle oldWidget){
    animationController.reset();
    animationController.forward().then((value) => animationController.reverse());
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.radius*2,
      height: widget.radius*2,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: widget.center,
          radius: 1,
          colors: [
            widget.color.withOpacity(_animation.value * 0.6),
            Colors.white.withOpacity(0),
          ],
        ),
      ),
    );
  }
}