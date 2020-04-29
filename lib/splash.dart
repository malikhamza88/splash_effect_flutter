import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onTap;

  Splash({
    Key key,
    @required this.child,
    @required this.onTap,
  });

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  static const double maxRadius = 120;
  static const double minRadius = 50;

  AnimationController controller;
  Tween<double> radiusTween;
  Tween<double> borderTween;
  Animation radiusAnimation;
  Animation borderAnimation;
  AnimationStatus status;
  Offset _tapPosition;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((listener) {
            status = listener;
          });
    radiusTween = Tween<double>(begin: 0, end: 50);
    borderTween = Tween<double>(begin: 25, end: 1);
    radiusAnimation = radiusTween
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    borderAnimation = borderTween.animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleTap(TapUpDetails tapUpDetails) {
    RenderBox renderBox = context.findRenderObject();
    _tapPosition = renderBox.globalToLocal(tapUpDetails.globalPosition);

    double radius = (renderBox.size.width > renderBox.size.height)
        ? renderBox.size.width
        : renderBox.size.height;

    double constraintRadius;
    if (radius > maxRadius) {
      constraintRadius = maxRadius;
    } else if (radius < minRadius) {
      constraintRadius = minRadius;
    } else {
      constraintRadius = radius;
    }

    radiusTween.end = constraintRadius * 0.6;
    borderTween.begin = radiusTween.end / 2;
    borderTween.end = radiusTween.end * 0.01;
    _animate();
    widget.onTap();
  }

  void _animate() {
    controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: SplashPaint(
        radius: radiusAnimation.value,
        borderWidth: borderAnimation.value,
        animationStatus: status,
        tapPosition: _tapPosition,
      ),
      child: GestureDetector(
        child: widget.child,
        onTapUp: _handleTap,
      ),
    );
  }
}

class SplashPaint extends CustomPainter {
  final double radius;

  final Paint blackPaint;
  final double borderWidth;
  final Offset tapPosition;
  final AnimationStatus animationStatus;

  SplashPaint({
    Key key,
    @required this.radius,
    @required this.borderWidth,
    @required this.animationStatus,
    @required this.tapPosition,
  }) : blackPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (animationStatus == AnimationStatus.forward) {
      canvas.drawCircle(tapPosition, radius, blackPaint);
    }
  }

  @override
  bool shouldRepaint(SplashPaint oldDelegate) {
    if (radius != oldDelegate.radius)
      return true;
    else
      return false;
  }
}
