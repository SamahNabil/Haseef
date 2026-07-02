import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/financial_score_ring.dart';
import '../../../shared/widgets/metric_tile.dart';
import '../../../shared/widgets/quick_action_tile.dart';
import '../../../shared/widgets/smart_recommendation_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(padding, AppSpacing.md, padding, AppSpacing.lg),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.contentMaxWidth(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppTopBar(style: TopBarStyle.dashboard),
                const Center(
                  child: FinancialScoreRing(
                    score: 92,
                    maxScore: 100,
                    statusLabel: 'وضعك المالي ممتاز',
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: AppSpacing.sm,
                  crossAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 1.5,
                  children: const [
                    MetricTile(
                      label: 'الدخل',
                      value: '24,500 ر.س',
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                    MetricTile(
                      label: 'الادخار',
                      value: '8,200 ر.س',
                      icon: Icons.savings_outlined,
                    ),
                    MetricTile(
                      label: 'الالتزامات',
                      value: '4,100 ر.س',
                      icon: Icons.credit_card_outlined,
                    ),
                    MetricTile(
                      label: 'المصروفات',
                      value: '12,200 ر.س',
                      icon: Icons.shopping_cart_outlined,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                SmartRecommendationCard(
                  title: 'توصية حصيف الذكية',
                  body:
                      'يمكنك زيادة ادخارك بنسبة 18% إذا قمت بتعديل بعض قراراتك المالية في الترفيه.',
                  onViewDetails: () {},
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'إجراءات سريعة',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 220,
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: AppSpacing.sm,
                    crossAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 1.35,
                    children: [
                      QuickActionTile(
                        label: 'تحليل قرار جديد',
                        icon: Icons.add_circle_outline_rounded,
                        iconColor: AppColors.primaryGreen,
                        onTap: () => context.go(AppRoutes.decisions),
                      ),
                      QuickActionTile(
                        label: 'اسأل حصيف',
                        icon: Icons.smart_toy_outlined,
                        onTap: () => context.go(AppRoutes.assistant),
                      ),
                      QuickActionTile(
                        label: 'محاكاة المستقبل',
                        icon: Icons.show_chart_rounded,
                        iconColor: AppColors.accentOrange,
                        onTap: () => context.go(AppRoutes.futureSimulation),
                      ),
                      QuickActionTile(
                        label: 'تحليل عقد',
                        icon: Icons.description_outlined,
                        iconColor: AppColors.accentBlue,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
