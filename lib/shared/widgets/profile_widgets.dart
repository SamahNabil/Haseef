import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'surface_card.dart';

class FinancialInputRow extends StatelessWidget {
  const FinancialInputRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.suffix = 'ريال',
    this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final String suffix;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SurfaceCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.accentBlue, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  suffix.isEmpty ? value : '$value $suffix',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GoalSelectorGrid extends StatelessWidget {
  const GoalSelectorGrid({
    super.key,
    required this.goals,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<FinancialGoal> goals;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.1,
      ),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];
        final isSelected = selectedIndex == index;

        return SurfaceCard(
          onTap: () => onSelected(index),
          backgroundColor: isSelected
              ? AppColors.primaryGreen.withValues(alpha: 0.1)
              : AppColors.surfaceCard,
          borderColor:
              isSelected ? AppColors.primaryGreen : AppColors.surfaceCardBorder,
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                goal.icon,
                color: isSelected ? AppColors.primaryGreen : AppColors.textMuted,
                size: 28,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                goal.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryGreen
                          : AppColors.textPrimary,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FinancialGoal {
  const FinancialGoal({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
