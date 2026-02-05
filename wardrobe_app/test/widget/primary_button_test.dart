import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wardrobe_app/shared/widgets/primary_button.dart';

void main() {
  group('PrimaryButton', () {
    testWidgets('displays text correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Test Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Test Button',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PrimaryButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Test Button',
              onPressed: null,
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('is disabled when isEnabled is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Test Button',
              onPressed: () {},
              isEnabled: false,
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('shows loading indicator when isLoading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Test Button',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });

    testWidgets('displays icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Test Button',
              onPressed: () {},
              icon: Icons.check,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });

  group('SecondaryButton', () {
    testWidgets('displays text correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: 'Secondary Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Secondary Button'), findsOneWidget);
    });

    testWidgets('has outlined style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: 'Secondary Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });

  group('TertiaryButton', () {
    testWidgets('displays text correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TertiaryButton(
              text: 'Tertiary Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Tertiary Button'), findsOneWidget);
    });

    testWidgets('has text button style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TertiaryButton(
              text: 'Tertiary Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(TextButton), findsOneWidget);
    });
  });
}
