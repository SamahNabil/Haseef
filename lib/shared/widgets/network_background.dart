import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class NetworkBackground extends StatelessWidget {
  const NetworkBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.2),
              radius: 1.2,
              colors: [
                AppColors.backgroundLight,
                AppColors.backgroundMid,
                AppColors.backgroundDark,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        const CustomPaint(painter: _NetworkPatternPainter()),
        child,
      ],
    );
  }
}

class _NetworkPatternPainter extends CustomPainter {
  const _NetworkPatternPainter();

  static const _nodes = <Offset>[
    Offset(0.08, 0.12),
    Offset(0.22, 0.08),
    Offset(0.38, 0.15),
    Offset(0.55, 0.06),
    Offset(0.72, 0.14),
    Offset(0.90, 0.10),
    Offset(0.15, 0.28),
    Offset(0.30, 0.32),
    Offset(0.48, 0.25),
    Offset(0.65, 0.30),
    Offset(0.82, 0.26),
    Offset(0.05, 0.45),
    Offset(0.20, 0.50),
    Offset(0.40, 0.42),
    Offset(0.58, 0.48),
    Offset(0.75, 0.44),
    Offset(0.92, 0.50),
    Offset(0.12, 0.65),
    Offset(0.28, 0.70),
    Offset(0.45, 0.62),
    Offset(0.62, 0.68),
    Offset(0.80, 0.64),
    Offset(0.95, 0.72),
    Offset(0.18, 0.85),
    Offset(0.35, 0.88),
    Offset(0.52, 0.82),
    Offset(0.68, 0.90),
    Offset(0.85, 0.86),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.patternLine
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = AppColors.patternDot
      ..style = PaintingStyle.fill;

    final points = _nodes
        .map((node) => Offset(node.dx * size.width, node.dy * size.height))
        .toList();

    for (var i = 0; i < points.length; i++) {
      for (var j = i + 1; j < points.length; j++) {
        final distance = (points[i] - points[j]).distance;
        if (distance < size.width * 0.22) {
          canvas.drawLine(points[i], points[j], linePaint);
        }
      }
    }

    for (final point in points) {
      canvas.drawCircle(point, 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
