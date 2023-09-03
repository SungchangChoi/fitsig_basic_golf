import 'package:flutter/material.dart';

class BlinkingCircle extends StatefulWidget {
  final Offset offset;
  final Color pointColor;
  final double radius;

  const BlinkingCircle({
    Key? key,
    required this.offset,
    this.pointColor = Colors.blue,
    this.radius = 50,
  }):super(key: key);

  @override
  State<BlinkingCircle> createState() => BlinkingCircleState();
}

class BlinkingCircleState extends State<BlinkingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CirclePainter(
        animationController,
        dx: widget.offset.dx,
        dy: widget.offset.dx,
        color: widget.pointColor,
        radius: widget.radius,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dx;
  final double dy;
  final Animation<double>? _animation;

  CirclePainter(
    this._animation, {
    required this.dx,
    required this.dy,
    this.color = Colors.blue,
    required this.radius,
  }) : super(repaint: _animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintStyle = Paint();
    double opacity = (1 - _animation!.value).clamp(0.0, 1.0);
    Offset offset = Offset(dx, dy);

    paintStyle.color = color.withOpacity(opacity);
    paintStyle.style = PaintingStyle.fill;
    canvas.drawCircle(offset, radius * _animation!.value, paintStyle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
