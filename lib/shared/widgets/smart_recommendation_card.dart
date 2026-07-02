import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'surface_card.dart';

class SmartRecommendationCard extends StatelessWidget {
  const SmartRecommendationCard({
    super.key,
    required this.title,
    required this.body,
    this.onViewDetails,
  });

  final String title;
  final String body;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.accentBlue.withValues(alpha: 0.15),
              size: 80,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.psychology_alt_rounded,
                      color: AppColors.accentBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
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
              const SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: onViewDetails,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.accentBlue,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text('عرض التفاصيل >'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
