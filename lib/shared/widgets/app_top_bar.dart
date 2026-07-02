import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

enum TopBarStyle { dashboard, standard, profile }

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    this.style = TopBarStyle.standard,
    this.greeting,
    this.showBack = false,
    this.onBack,
  });

  final TopBarStyle style;
  final String? greeting;
  final bool showBack;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            )
          else
            _NotificationButton(),
          const Spacer(),
          if (style == TopBarStyle.dashboard)
            _DashboardProfile(greeting: greeting ?? 'مرحباً علياء 👋')
          else if (style == TopBarStyle.profile)
            const _ProfileBrand()
          else
            const _StandardProfile(),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceCardBorder),
      ),
      child: const Icon(
        Icons.notifications_none_rounded,
        color: AppColors.textPrimary,
        size: 22,
      ),
    );
  }
}

class _DashboardProfile extends StatelessWidget {
  const _DashboardProfile({required this.greeting});

  final String greeting;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          greeting,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const _Avatar(imageUrl: null, radius: 22),
      ],
    );
  }
}

class _StandardProfile extends StatelessWidget {
  const _StandardProfile();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Haseef AI',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const _Avatar(imageUrl: null, radius: 20),
      ],
    );
  }
}

class _ProfileBrand extends StatelessWidget {
  const _ProfileBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Haseef AI',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primaryGreen.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.auto_awesome_rounded,
            color: AppColors.primaryGreen,
            size: 16,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const _Avatar(imageUrl: null, radius: 20),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.imageUrl, required this.radius});

  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.surfaceCardBorder,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Icon(Icons.person_rounded, size: radius, color: AppColors.textMuted)
          : null,
    );
  }
}
