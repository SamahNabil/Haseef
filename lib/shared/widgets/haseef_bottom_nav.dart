import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class HaseefBottomNav extends StatelessWidget {
  const HaseefBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItem(
      label: 'الرئيسية',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      route: AppRoutes.home,
    ),
    _NavItem(
      label: 'القرارات',
      icon: Icons.show_chart_outlined,
      activeIcon: Icons.show_chart_rounded,
      route: AppRoutes.decisions,
    ),
    _NavItem(
      label: 'المساعد',
      icon: Icons.smart_toy_outlined,
      activeIcon: Icons.smart_toy_rounded,
      route: AppRoutes.assistant,
    ),
    _NavItem(
      label: 'الملف',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      route: AppRoutes.profile,
    ),
  ];

  static int indexForLocation(String location) {
    if (location.startsWith(AppRoutes.decisions)) return 1;
    if (location.startsWith(AppRoutes.assistant)) return 2;
    if (location.startsWith(AppRoutes.profile)) return 3;
    return 0;
  }

  static void goToTab(BuildContext context, int index) {
    context.go(_items[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border(
          top: BorderSide(color: AppColors.surfaceCardBorder, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isActive = currentIndex == index;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isActive ? item.activeIcon : item.icon,
                          color: isActive
                              ? AppColors.navActive
                              : AppColors.navInactive,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                isActive ? FontWeight.w700 : FontWeight.w500,
                            color: isActive
                                ? AppColors.navActive
                                : AppColors.navInactive,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
}
