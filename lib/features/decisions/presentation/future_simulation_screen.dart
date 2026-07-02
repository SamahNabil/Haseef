import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/simulation_widgets.dart';

class FutureSimulationScreen extends StatelessWidget {
  const FutureSimulationScreen({super.key});

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
                          const SectionHeader(
                            title: 'محاكاة المستقبل',
                            subtitle:
                                'قارن بين السيناريوهات لاتخاذ القرار الأمثل لمستقبلك المالي.',
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          ScenarioComparisonCard(
                            optionLabel: 'الخيار (أ)',
                            title: 'الوضع الحالي',
                            icon: Icons.history_rounded,
                            accentColor: AppColors.accentBlue,
                            rows: const [
                              ScenarioRowData(
                                label: 'المدخرات المتوقعة',
                                value: '45,000 ر.س',
                              ),
                              ScenarioRowData(
                                label: 'مستوى المخاطرة',
                                value: 'عالي',
                                valueColor: AppColors.accentRed,
                              ),
                              ScenarioRowData(
                                label: 'تحقيق الهدف',
                                value: '62%',
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ScenarioComparisonCard(
                            optionLabel: 'الخيار (ب)',
                            title: 'قرار مؤجل',
                            icon: Icons.star_outline_rounded,
                            accentColor: AppColors.accentOrange,
                            isRecommended: true,
                            rows: const [
                              ScenarioRowData(
                                label: 'المدخرات المتوقعة',
                                value: '78,200 ر.س',
                                valueColor: AppColors.accentOrange,
                              ),
                              ScenarioRowData(
                                label: 'مستوى المخاطرة',
                                value: 'منخفض جداً',
                                valueColor: AppColors.accentOrange,
                              ),
                              ScenarioRowData(
                                label: 'تحقيق الهدف',
                                value: '94%',
                                valueColor: AppColors.accentOrange,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          const TimelineChartCard(),
                          const SizedBox(height: AppSpacing.md),
                          const SmartAdviceCard(
                            title: 'نصيحة Haseef الذكية',
                            body:
                                'نوصي بالسيناريو الثاني لأنه يقلل المخاطر بنسبة 37% ويحافظ على استقرارك المالي.',
                            chips: ['+18% نمو', 'ثبات مالي'],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          PrimaryButton(
                            label: 'اعتمد هذا القرار',
                            icon: Icons.check_rounded,
                            onPressed: () => context.pop(),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'تحميل التقرير الكامل كملف PDF',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textMuted,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.textMuted,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
