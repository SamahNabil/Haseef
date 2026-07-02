import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/feature_highlight_card.dart';
import '../../../shared/widgets/network_background.dart';
import '../../../shared/widgets/primary_button.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final horizontalPadding = size.width > 600 ? size.width * 0.2 : AppSpacing.screenHorizontal;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: NetworkBackground(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.12),
                  _BrandHeader(theme: theme),
                  const Spacer(flex: 2),
                  const FeatureHighlightCard(
                    icon: DecisionImpactIcon(),
                    text: 'اعرف أثر قرارك قبل أن تتخذه',
                  ),
                  const Spacer(flex: 3),
                  PrimaryButton(
                    label: 'ابدأ الآن',
                    icon: Icons.arrow_back,
                    onPressed: () {
                      // Dashboard route will be wired in the next screen.
                      context.go(AppRoutes.home);
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'مدعوم بأقوى خوارزميات الذكاء الاصطناعي المالية',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: size.height * 0.06),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Haseef AI',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Container(
                width: 1.5,
                height: 28,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              'حصيف',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'مستشارك الذكي لاتخاذ القرار المالي',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
