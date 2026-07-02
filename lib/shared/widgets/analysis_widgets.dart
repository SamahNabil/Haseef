import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'surface_card.dart';

class ProsConsSection extends StatelessWidget {
  const ProsConsSection({
    super.key,
    required this.title,
    required this.items,
    required this.isPositive,
  });

  final String title;
  final List<String> items;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isPositive ? AppColors.primaryGreen : AppColors.accentRed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SurfaceCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            children: items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ),
                        Icon(
                          isPositive
                              ? Icons.check_circle_rounded
                              : Icons.warning_amber_rounded,
                          color: color,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class RecommendationTile extends StatelessWidget {
  const RecommendationTile({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SurfaceCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md + 2,
      ),
      child: Row(
        children: [
          Icon(
            Icons.chevron_left_rounded,
            color: AppColors.textMuted,
          ),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.accentBlue, size: 18),
          ),
        ],
      ),
    );
  }
}

class AiSummaryCard extends StatelessWidget {
  const AiSummaryCard({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: AppColors.accentBlue,
                  size: 18,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class AnalysisMetricGrid extends StatelessWidget {
  const AnalysisMetricGrid({
    super.key,
    required this.metrics,
  });

  final List<AnalysisMetricData> metrics;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.35,
      children: metrics.map((m) => _MetricCard(data: m)).toList(),
    );
  }
}

class AnalysisMetricData {
  const AnalysisMetricData({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
    this.trendIcon,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;
  final IconData? trendIcon;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.data});

  final AnalysisMetricData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data.icon, color: AppColors.textMuted, size: 18),
          const Spacer(),
          Text(
            data.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                data.value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: data.valueColor ?? AppColors.textPrimary,
                ),
              ),
              if (data.trendIcon != null) ...[
                const SizedBox(width: 4),
                Icon(data.trendIcon, color: data.valueColor, size: 16),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
