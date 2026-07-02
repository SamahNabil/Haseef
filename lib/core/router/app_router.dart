import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/assistant/presentation/ask_haseef_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/decisions/presentation/analysis_result_screen.dart';
import '../../features/decisions/presentation/analyze_decision_screen.dart';
import '../../features/decisions/presentation/future_simulation_screen.dart';
import '../../features/decisions/presentation/new_decision_screen.dart';
import '../../features/profile/presentation/financial_profile_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../shared/widgets/main_shell.dart';
import 'app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorDecisionsKey =
    GlobalKey<NavigatorState>(debugLabel: 'decisions');
final _shellNavigatorAssistantKey =
    GlobalKey<NavigatorState>(debugLabel: 'assistant');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDecisionsKey,
            routes: [
              GoRoute(
                path: AppRoutes.decisions,
                builder: (context, state) => const NewDecisionScreen(),
                routes: [
                  GoRoute(
                    path: 'analyze',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) =>
                        const AnalyzeDecisionScreen(),
                  ),
                  GoRoute(
                    path: 'result',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) =>
                        const AnalysisResultScreen(),
                  ),
                  GoRoute(
                    path: 'simulation',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) =>
                        const FutureSimulationScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAssistantKey,
            routes: [
              GoRoute(
                path: AppRoutes.assistant,
                builder: (context, state) => const AskHaseefScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const FinancialProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('الصفحة غير موجودة: ${state.uri}'),
      ),
    ),
  );
});
