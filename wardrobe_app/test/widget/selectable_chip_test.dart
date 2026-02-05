import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wardrobe_app/shared/widgets/selectable_chip.dart';

void main() {
  group('SelectableChip', () {
    testWidgets('displays label text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SelectableChip(
              label: 'Test Chip',
              isSelected: false,
            ),
          ),
        ),
      );

      expect(find.text('Test Chip'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectableChip(
              label: 'Test Chip',
              isSelected: false,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SelectableChip));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('has different style when selected', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                SelectableChip(
                  label: 'Unselected',
                  isSelected: false,
                ),
                SelectableChip(
                  label: 'Selected',
                  isSelected: true,
                ),
              ],
            ),
          ),
        ),
      );

      final unselectedChip = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.widgetWithText(GestureDetector, 'Unselected'),
          matching: find.byType(AnimatedContainer),
        ),
      );

      final selectedChip = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.widgetWithText(GestureDetector, 'Selected'),
          matching: find.byType(AnimatedContainer),
        ),
      );

      // Verify they have different decorations
      expect(
        unselectedChip.decoration,
        isNot(equals(selectedChip.decoration)),
      );
    });
  });

  group('SelectableChipGroup', () {
    testWidgets('displays title and all options', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectableChipGroup(
              title: 'Style Vibes',
              options: const ['Minimal', 'Casual', 'Bold'],
              selectedOptions: const [],
              onOptionToggle: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Style Vibes'), findsOneWidget);
      expect(find.text('Minimal'), findsOneWidget);
      expect(find.text('Casual'), findsOneWidget);
      expect(find.text('Bold'), findsOneWidget);
    });

    testWidgets('calls onOptionToggle when chip tapped', (tester) async {
      String? toggledOption;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectableChipGroup(
              title: 'Style Vibes',
              options: const ['Minimal', 'Casual', 'Bold'],
              selectedOptions: const [],
              onOptionToggle: (option) => toggledOption = option,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Casual'));
      await tester.pump();

      expect(toggledOption, 'Casual');
    });

    testWidgets('shows selected state for selected options', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectableChipGroup(
              title: 'Style Vibes',
              options: const ['Minimal', 'Casual', 'Bold'],
              selectedOptions: const ['Casual'],
              onOptionToggle: (_) {},
            ),
          ),
        ),
      );

      // Verify Casual is selected (has different style)
      final chips = tester.widgetList<SelectableChip>(
        find.byType(SelectableChip),
      ).toList();

      expect(chips[0].isSelected, isFalse); // Minimal
      expect(chips[1].isSelected, isTrue);  // Casual
      expect(chips[2].isSelected, isFalse); // Bold
    });
  });
}
