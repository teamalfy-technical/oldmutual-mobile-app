import 'dart:math';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// An animated success checkmark that draws a circle and then a check stroke.
class PAnimatedCheckmark extends StatefulWidget {
  final double size;
  final Duration duration;
  final Color? circleColor;
  final Color? checkColor;

  const PAnimatedCheckmark({
    super.key,
    this.size = 120,
    this.duration = const Duration(milliseconds: 1400),
    this.circleColor,
    this.checkColor,
  });

  @override
  State<PAnimatedCheckmark> createState() => _PAnimatedCheckmarkState();
}

class _PAnimatedCheckmarkState extends State<PAnimatedCheckmark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;
  late Animation<double> _checkAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _circleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );

    _checkAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.85, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final circleColor = widget.circleColor ?? PAppColor.successMedium;
    final checkColor = widget.checkColor ?? PAppColor.whiteColor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _CheckmarkPainter(
              circleProgress: _circleAnimation.value,
              checkProgress: _checkAnimation.value,
              circleColor: circleColor,
              checkColor: checkColor,
            ),
          ),
        );
      },
    );
  }
}

class _CheckmarkPainter extends CustomPainter {
  final double circleProgress;
  final double checkProgress;
  final Color circleColor;
  final Color checkColor;

  _CheckmarkPainter({
    required this.circleProgress,
    required this.checkProgress,
    required this.circleColor,
    required this.checkColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Draw filled circle with opacity based on progress
    final circlePaint = Paint()
      ..color = circleColor.withValues(alpha: circleProgress)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * circleProgress, circlePaint);

    // Draw circle stroke
    final strokePaint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepAngle = 2 * pi * circleProgress;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, strokePaint);

    // Draw checkmark
    if (checkProgress > 0) {
      final checkPaint = Paint()
        ..color = checkColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      // Checkmark points (relative to center)
      final p1 = Offset(size.width * 0.28, size.height * 0.52);
      final p2 = Offset(size.width * 0.44, size.height * 0.66);
      final p3 = Offset(size.width * 0.72, size.height * 0.36);

      final path = Path();
      if (checkProgress <= 0.5) {
        // First stroke of check (down-right)
        final t = checkProgress / 0.5;
        path.moveTo(p1.dx, p1.dy);
        path.lineTo(
          p1.dx + (p2.dx - p1.dx) * t,
          p1.dy + (p2.dy - p1.dy) * t,
        );
      } else {
        // Full first stroke + partial second stroke (up-right)
        final t = (checkProgress - 0.5) / 0.5;
        path.moveTo(p1.dx, p1.dy);
        path.lineTo(p2.dx, p2.dy);
        path.lineTo(
          p2.dx + (p3.dx - p2.dx) * t,
          p2.dy + (p3.dy - p2.dy) * t,
        );
      }

      canvas.drawPath(path, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CheckmarkPainter oldDelegate) {
    return circleProgress != oldDelegate.circleProgress ||
        checkProgress != oldDelegate.checkProgress;
  }
}
