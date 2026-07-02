import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/haseef_text_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/section_header.dart';
import '../providers/decision_providers.dart';

class AnalyzeDecisionScreen extends ConsumerStatefulWidget {
  const AnalyzeDecisionScreen({super.key});

  @override
  ConsumerState<AnalyzeDecisionScreen> createState() =>
      _AnalyzeDecisionScreenState();
}

class _AnalyzeDecisionScreenState extends ConsumerState<AnalyzeDecisionScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _totalController;
  late final TextEditingController _downPaymentController;
  late final TextEditingController _installmentController;
  late final TextEditingController _resultsController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _totalController = TextEditingController();
    _downPaymentController = TextEditingController();
    _installmentController = TextEditingController();
    _resultsController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _totalController.dispose();
    _downPaymentController.dispose();
    _installmentController.dispose();
    _resultsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);
    final notifier = ref.read(decisionFormProvider.notifier);

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
                            title: 'تحليل القرار',
                            subtitle:
                                'دع الذكاء الاصطناعي يساعدك في تقييم جدوى قرارك المالي.',
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          FormSectionCard(
                            title: 'عنوان القرار',
                            child: HaseefTextField(
                              controller: _titleController,
                              hint: 'مثال: شراء سيارة جديدة',
                              icon: Icons.edit_outlined,
                              onChanged: notifier.updateTitle,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          FormSectionCard(
                            title: 'المعطيات المالية',
                            child: Column(
                              children: [
                                HaseefTextField(
                                  controller: _totalController,
                                  label: 'المبلغ الإجمالي',
                                  hint: '0.00',
                                  icon: Icons.payments_outlined,
                                  keyboardType: TextInputType.number,
                                  onChanged: notifier.updateTotalAmount,
                                  suffix: const Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Text(
                                      'ر.س',
                                      style: TextStyle(
                                        color: AppColors.textMuted,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Row(
                                  children: [
                                    Expanded(
                                      child: HaseefTextField(
                                        controller: _downPaymentController,
                                        label: 'الدفعة الأولى',
                                        hint: 'اختياري',
                                        icon: Icons.account_balance_wallet_outlined,
                                        keyboardType: TextInputType.number,
                                        onChanged: notifier.updateDownPayment,
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: HaseefTextField(
                                        controller: _installmentController,
                                        label: 'القسط الشهري',
                                        hint: 'اختياري',
                                        icon: Icons.calendar_today_outlined,
                                        keyboardType: TextInputType.number,
                                        onChanged:
                                            notifier.updateMonthlyInstallment,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          FormSectionCard(
                            title: 'النتائج المرجوة',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HaseefTextArea(
                                  controller: _resultsController,
                                  hint:
                                      'ما الذي تأمل تحقيقه؟ (مثال: التنقل اليومي للعمل براحة وتوفير صيانة)',
                                  onChanged: notifier.updateDesiredResults,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      size: 16,
                                      color: AppColors.primaryGreen,
                                    ),
                                    const SizedBox(width: AppSpacing.xs),
                                    Expanded(
                                      child: Text(
                                        'سيقوم Haseef بمقارنة هذه الأهداف مع وضعك المالي الحالي.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColors.primaryGreen,
                                              height: 1.4,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                  label: 'ابدأ التحليل',
                  icon: Icons.bar_chart_rounded,
                  onPressed: () => context.push(AppRoutes.analysisResult),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
