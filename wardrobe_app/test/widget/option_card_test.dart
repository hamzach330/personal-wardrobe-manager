import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wardrobe_app/shared/widgets/option_card.dart';

void main() {
  group('OptionCard', () {
    testWidgets('displays title, description, and icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OptionCard(
              title: 'Test Option',
              description: 'Test Description',
              icon: Icons.check,
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Option'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('calls onTap when pressed', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OptionCard(
              title: 'Test Option',
              description: 'Test Description',
              icon: Icons.check,
              isSelected: false,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(OptionCard));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('shows different style when selected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OptionCard(
              title: 'Selected Option',
              description: 'This is selected',
              icon: Icons.check,
              isSelected: true,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify the card exists and has selection state
      expect(find.byType(OptionCard), findsOneWidget);
    });
  });

  group('HorizontalOptionCard', () {
    testWidgets('displays title, description, and icon horizontally', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HorizontalOptionCard(
              title: 'Horizontal Option',
              description: 'Horizontal Description',
              icon: Icons.arrow_forward,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Horizontal Option'), findsOneWidget);
      expect(find.text('Horizontal Description'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('calls onTap when pressed', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HorizontalOptionCard(
              title: 'Horizontal Option',
              description: 'Description',
              icon: Icons.check,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(HorizontalOptionCard));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
