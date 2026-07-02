import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/decision_type_card.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/section_header.dart';
import '../providers/decision_providers.dart';

class NewDecisionScreen extends ConsumerWidget {
  const NewDecisionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = Responsive.horizontalPadding(context);
    final formState = ref.watch(decisionFormProvider);

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
                      const AppTopBar(),
                      const SectionHeader(
                        title: 'حلل قراراً جديداً',
                        subtitle:
                            'اختر نوع القرار المالي الذي تفكر فيه لنقوم بتحليله لك',
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      ...decisionTypes.map((type) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: DecisionTypeCard(
                            title: type.title,
                            subtitle: type.subtitle,
                            icon: type.icon,
                            iconColor: type.iconColor,
                            isSelected: formState.selectedTypeId == type.id,
                            onTap: () {
                              ref
                                  .read(decisionFormProvider.notifier)
                                  .selectType(type.id);
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(padding, 0, padding, AppSpacing.md),
            child: PrimaryButton(
              label: 'تحليل القرار ذكياً',
              icon: Icons.bar_chart_rounded,
              onPressed: formState.selectedTypeId != null
                  ? () => context.push(AppRoutes.analyzeDecision)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
