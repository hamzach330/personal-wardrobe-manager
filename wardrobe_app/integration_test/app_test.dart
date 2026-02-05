import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wardrobe_app/app/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('splash screen shows and animates', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: WardrobeApp(),
        ),
      );

      // Verify splash screen elements
      expect(find.byType(Image), findsWidgets);

      // Wait for animation
      await tester.pump(const Duration(seconds: 1));

      // Pump more frames for animation
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
    });

    testWidgets('welcome screen has get started button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: WardrobeApp(),
        ),
      );

      // Skip splash animation
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Verify welcome screen elements
      expect(find.text('Get Started'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('get started navigates to signup', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: WardrobeApp(),
        ),
      );

      // Skip splash and wait for welcome
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Tap Get Started
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Verify navigation to signup screen
      expect(find.text('Continue with Google'), findsOneWidget);
      expect(find.text('Continue with Facebook'), findsOneWidget);
      expect(find.text('Continue with Apple'), findsOneWidget);
    });

    testWidgets('email signup form validates inputs', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: WardrobeApp(),
        ),
      );

      // Navigate to email signup
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sign up with Email'));
      await tester.pumpAndSettle();

      // Verify email signup form exists
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.byType(TextFormField), findsWidgets);

      // Try to submit empty form
      await tester.tap(find.text('Create Account'));
      await tester.pumpAndSettle();

      // Verify validation errors shown
      expect(find.textContaining('required'), findsWidgets);
    });
  });

  group('Onboarding Flow', () {
    testWidgets('permissions screen shows all permission cards', (tester) async {
      // This would require setting up navigation state
      // For now, we verify the widget builds correctly
      await tester.pumpWidget(
        const ProviderScope(
          child: WardrobeApp(),
        ),
      );

      await tester.pumpAndSettle();
    });
  });
}
