import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haseef_ai/core/theme/app_theme.dart';
import 'package:haseef_ai/features/splash/presentation/splash_screen.dart';

void main() {
  testWidgets('Splash screen renders key Arabic content', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const SplashScreen(),
        ),
      ),
    );

    expect(find.text('Haseef AI'), findsOneWidget);
    expect(find.text('حصيف'), findsOneWidget);
    expect(find.text('مستشارك الذكي لاتخاذ القرار المالي'), findsOneWidget);
    expect(find.text('اعرف أثر قرارك قبل أن تتخذه'), findsOneWidget);
    expect(find.text('ابدأ الآن'), findsOneWidget);
  });
}
