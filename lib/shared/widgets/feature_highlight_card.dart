import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'glass_card.dart';

class FeatureHighlightCard extends StatelessWidget {
  const FeatureHighlightCard({
    super.key,
    required this.icon,
    required this.text,
  });

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: AppSpacing.lg),
          Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.6,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class DecisionImpactIcon extends StatelessWidget {
  const DecisionImpactIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 56,
      child: CustomPaint(
        painter: _DecisionImpactIconPainter(),
      ),
    );
  }
}

class _DecisionImpactIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const color = AppColors.primaryGreen;

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final sparklePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.08, size.height * 0.75)
      ..lineTo(size.width * 0.35, size.height * 0.55)
      ..lineTo(size.width * 0.55, size.height * 0.65)
      ..lineTo(size.width * 0.92, size.height * 0.15);

    canvas.drawPath(path, linePaint);

    final dots = [
      Offset(size.width * 0.08, size.height * 0.75),
      Offset(size.width * 0.35, size.height * 0.55),
      Offset(size.width * 0.55, size.height * 0.65),
      Offset(size.width * 0.92, size.height * 0.15),
    ];

    for (final dot in dots) {
      canvas.drawCircle(dot, 4, dotPaint);
    }

    _drawSparkle(canvas, Offset(size.width * 0.78, size.height * 0.22), sparklePaint);
    _drawSparkle(canvas, Offset(size.width * 0.88, size.height * 0.08), sparklePaint, size: 6);
  }

  void _drawSparkle(Canvas canvas, Offset center, Paint paint, {double size = 8}) {
    final path = Path();
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2;
      path.moveTo(center.dx, center.dy);
      path.lineTo(
        center.dx + math.cos(angle) * size,
        center.dy + math.sin(angle) * size,
      );
    }
    canvas.drawPath(path, paint..strokeWidth = 1.5..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
