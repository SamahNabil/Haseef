import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/profile_widgets.dart';
import '../../../shared/widgets/section_header.dart';
import '../../decisions/providers/decision_providers.dart';

class FinancialProfileScreen extends ConsumerWidget {
  const FinancialProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = Responsive.horizontalPadding(context);
    final profile = ref.watch(financialProfileProvider);
    final notifier = ref.read(financialProfileProvider.notifier);

    return SafeArea(
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
                      const AppTopBar(style: TopBarStyle.profile),
                      const SectionHeader(
                        title: 'أنشئ ملفك المالي',
                        subtitle:
                            'أدخل بياناتك المالية لتمكين حصيف من تقديم توصيات دقيقة ومخصصة لك.',
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      FinancialInputRow(
                        label: 'الراتب الشهري',
                        value: profile.monthlySalary,
                        icon: Icons.payments_outlined,
                        onTap: () => _showEditDialog(
                          context,
                          'الراتب الشهري',
                          profile.monthlySalary,
                          (v) => notifier.updateField('salary', v),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      FinancialInputRow(
                        label: 'دخل إضافي',
                        value: profile.additionalIncome,
                        icon: Icons.add_card_outlined,
                        onTap: () => _showEditDialog(
                          context,
                          'دخل إضافي',
                          profile.additionalIncome,
                          (v) => notifier.updateField('income', v),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      FinancialInputRow(
                        label: 'المصروفات الشهرية',
                        value: profile.monthlyExpenses,
                        icon: Icons.shopping_bag_outlined,
                        suffix: '',
                        onTap: () => _showEditDialog(
                          context,
                          'المصروفات الشهرية',
                          profile.monthlyExpenses,
                          (v) => notifier.updateField('expenses', v),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      FinancialInputRow(
                        label: 'الالتزامات الشهرية',
                        value: profile.monthlyObligations,
                        icon: Icons.receipt_long_outlined,
                        suffix: '',
                        onTap: () => _showEditDialog(
                          context,
                          'الالتزامات الشهرية',
                          profile.monthlyObligations,
                          (v) => notifier.updateField('obligations', v),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      FinancialInputRow(
                        label: 'المدخرات',
                        value: profile.savings,
                        icon: Icons.savings_outlined,
                        suffix: '',
                        onTap: () => _showEditDialog(
                          context,
                          'المدخرات',
                          profile.savings,
                          (v) => notifier.updateField('savings', v),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      FinancialInputRow(
                        label: 'العمر',
                        value: profile.age,
                        icon: Icons.calendar_today_outlined,
                        suffix: 'سنة',
                        onTap: () => _showEditDialog(
                          context,
                          'العمر',
                          profile.age,
                          (v) => notifier.updateField('age', v),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        'الهدف المالي',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      GoalSelectorGrid(
                        goals: financialGoals,
                        selectedIndex: profile.selectedGoalIndex,
                        onSelected: notifier.selectGoal,
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
              label: 'إنشاء الملف',
              icon: Icons.check_circle_outline_rounded,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم إنشاء ملفك المالي بنجاح'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(
    BuildContext context,
    String title,
    String initialValue,
    ValueChanged<String> onSaved,
  ) async {
    final controller = TextEditingController(text: initialValue);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceCard,
        title: Text(title),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );

    if (result != null) onSaved(result);
  }
}
