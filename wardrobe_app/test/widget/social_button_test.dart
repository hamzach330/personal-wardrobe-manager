import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wardrobe_app/shared/widgets/social_button.dart';

void main() {
  group('SocialButton', () {
    testWidgets('google button displays correct text and icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialButton(
              text: 'Continue with Google',
              provider: SocialProvider.google,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('facebook button displays correct text and icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialButton(
              text: 'Continue with Facebook',
              provider: SocialProvider.facebook,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Continue with Facebook'), findsOneWidget);
      expect(find.byIcon(Icons.facebook), findsOneWidget);
    });

    testWidgets('apple button displays correct text and icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialButton(
              text: 'Continue with Apple',
              provider: SocialProvider.apple,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Continue with Apple'), findsOneWidget);
      expect(find.byIcon(Icons.apple), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialButton(
              text: 'Continue with Google',
              provider: SocialProvider.google,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SocialButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('shows loading indicator when isLoading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialButton(
              text: 'Continue with Google',
              provider: SocialProvider.google,
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SocialButton(
              text: 'Continue with Google',
              provider: SocialProvider.google,
              onPressed: null,
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });
}
