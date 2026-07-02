import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/analysis_widgets.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/surface_card.dart';

class AnalysisResultScreen extends StatelessWidget {
  const AnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.surfaceDark,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    padding,
                    AppSpacing.md,
                    padding,
                    AppSpacing.lg,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Responsive.contentMaxWidth(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppTopBar(
                            showBack: true,
                            onBack: () => context.pop(),
                          ),
                          const SectionHeader(title: 'نتيجة التحليل'),
                          const SizedBox(height: AppSpacing.lg),
                          SurfaceCard(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                  child: CustomPaint(
                                    painter: _RiskGaugePainter(),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'متوسط',
                                            style: theme.textTheme.titleLarge
                                                ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.accentOrange,
                                            ),
                                          ),
                                          const SizedBox(height: AppSpacing.sm),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'درجة المخاطرة مبنية على الالتزامات الشهرية والأهداف طويلة الأمد...',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppColors.textMuted,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          const AiSummaryCard(
                            title: 'ملخص الذكاء الاصطناعي',
                            body:
                                'بناءً على بياناتك الحالية، سيؤثر هذا القرار على معدل الادخار وسيؤخر تحقيق هدف شراء المنزل.',
                          ),
                          const SizedBox(height: AppSpacing.md),
                          const AnalysisMetricGrid(
                            metrics: [
                              AnalysisMetricData(
                                label: 'التدفق الشهري',
                                value: '٢,٤٠٠ ر.س',
                                icon: Icons.account_balance_wallet_outlined,
                              ),
                              AnalysisMetricData(
                                label: 'معدل الادخار',
                                value: '١٢٪-',
                                icon: Icons.savings_outlined,
                                valueColor: AppColors.accentRed,
                                trendIcon: Icons.arrow_downward_rounded,
                              ),
                              AnalysisMetricData(
                                label: 'تحقيق الهدف',
                                value: '٥+ أشهر',
                                icon: Icons.flag_outlined,
                              ),
                              AnalysisMetricData(
                                label: 'نسبة الدين',
                                value: '٣٥٪',
                                icon: Icons.account_balance_outlined,
                                valueColor: AppColors.accentOrange,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          const ProsConsSection(
                            title: 'الإيجابيات',
                            isPositive: true,
                            items: [
                              'تلبية احتياج حالي ضروري',
                              'زيادة القيمة الصافية للأصول',
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          const ProsConsSection(
                            title: 'المخاطر',
                            isPositive: false,
                            items: [
                              'انخفاض السيولة الطارئة',
                              'ارتفاع نسبة الاستقطاع',
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            'توصيات حصيف',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: AppColors.accentBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const RecommendationTile(
                            label: 'زيادة الدفعة الأولى بنسبة ١٠٪',
                            icon: Icons.credit_card_outlined,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const RecommendationTile(
                            label: 'تأجيل الشراء ٣ أشهر',
                            icon: Icons.schedule_outlined,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const RecommendationTile(
                            label: 'اختيار خيار أقل تكلفة',
                            icon: Icons.bar_chart_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(padding, 0, padding, AppSpacing.md),
                child: PrimaryButton(
                  label: 'عرض المحاكاة',
                  onPressed: () => context.go(AppRoutes.futureSimulation),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RiskGaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.85);
    final radius = size.width * 0.35;

    final backgroundPaint = Paint()
      ..color = AppColors.surfaceCardBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14,
      3.14,
      false,
      backgroundPaint,
    );

    final gradientPaint = Paint()
      ..shader = const SweepGradient(
        colors: [
          AppColors.primaryGreen,
          AppColors.accentOrange,
          AppColors.accentRed,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14,
      3.14 * 0.55,
      false,
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
