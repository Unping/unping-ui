// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('BaseDropdown', () {
    testWidgets('renders dropdown with placeholder', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            placeholder: 'Select option',
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
              DropdownOption(value: 'b', label: 'Option B'),
            ],
          ),
        ),
      );

      expect(find.text('Select option'), findsOneWidget);
    });

    testWidgets('renders dropdown with label', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            label: 'Choose:',
            placeholder: 'Select',
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
          ),
        ),
      );

      expect(find.text('Choose:'), findsOneWidget);
    });

    testWidgets('displays selected value', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            selectedValue: 'a',
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
              DropdownOption(value: 'b', label: 'Option B'),
            ],
          ),
        ),
      );

      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('opens menu on tap', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<String>(
                  placeholder: 'Select',
                  options: [
                    DropdownOption(value: 'a', label: 'Option A'),
                    DropdownOption(value: 'b', label: 'Option B'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      // Tap to open menu
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Menu items should be visible
      expect(find.text('Option A'), findsWidgets);
      expect(find.text('Option B'), findsOneWidget);
    });

    testWidgets('selects option on tap', (tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<String>(
                  placeholder: 'Select',
                  options: [
                    DropdownOption(value: 'a', label: 'Option A'),
                    DropdownOption(value: 'b', label: 'Option B'),
                  ],
                  onChanged: (value) => selectedValue = value,
                ),
              ),
            ],
          ),
        ),
      );

      // Open menu
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Select option
      await tester.tap(find.text('Option B'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('b'));
    });

    testWidgets('closes menu on selection', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<String>(
                  placeholder: 'Select',
                  options: [
                    DropdownOption(value: 'a', label: 'Option A'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      // Open menu
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(find.text('Option A'), findsWidgets);

      // Select option
      await tester.tap(find.text('Option A').last);
      await tester.pumpAndSettle();

      // Menu should be closed (only one instance in trigger)
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('displays helper text', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            placeholder: 'Select',
            helperText: 'Choose wisely',
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
          ),
        ),
      );

      expect(find.text('Choose wisely'), findsOneWidget);
    });

    testWidgets('displays error text', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            placeholder: 'Select',
            errorText: 'Required field',
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
          ),
        ),
      );

      expect(find.text('Required field'), findsOneWidget);
    });

    testWidgets('multi-select displays count', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            multiSelect: true,
            selectedValues: ['a', 'b'],
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
              DropdownOption(value: 'b', label: 'Option B'),
              DropdownOption(value: 'c', label: 'Option C'),
            ],
          ),
        ),
      );

      expect(find.text('2 selected'), findsOneWidget);
    });

    testWidgets('keyboard navigation opens menu with Enter', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<String>(
                  placeholder: 'Select',
                  options: [
                    DropdownOption(value: 'a', label: 'Option A'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      // Focus the dropdown
      await tester.tap(find.text('Select'));
      await tester.pump();

      // Press Enter
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      // Menu should be open
      expect(find.text('Option A'), findsWidgets);
    });

    testWidgets('keyboard navigation with Arrow Down', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<String>(
                  placeholder: 'Select',
                  options: [
                    DropdownOption(value: 'a', label: 'Option A'),
                    DropdownOption(value: 'b', label: 'Option B'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      // Focus and open
      await tester.tap(find.text('Select'));
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      // Menu should be open
      expect(find.text('Option A'), findsWidgets);
    });

    testWidgets('Escape key closes menu', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<String>(
                  placeholder: 'Select',
                  options: [
                    DropdownOption(value: 'a', label: 'Option A'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      // Open menu
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(find.text('Option A'), findsWidgets);

      // Press Escape
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      // Menu should be closed (option not visible, placeholder visible)
      expect(find.text('Option A'), findsNothing);
      expect(find.text('Select'), findsOneWidget);
    });

    testWidgets('disabled dropdown does not open', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<String>(
                  placeholder: 'Select',
                  enabled: false,
                  options: [
                    DropdownOption(value: 'a', label: 'Option A'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      // Try to open menu
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Menu should not open (only trigger visible)
      expect(find.text('Option A'), findsNothing);
    });

    testWidgets('renders with custom selectedBuilder', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            selectedValue: 'a',
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
            selectedBuilder: (value) => Text('Custom: $value'),
          ),
        ),
      );

      expect(find.text('Custom: a'), findsOneWidget);
    });

    testWidgets('renders prefix widget', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            placeholder: 'Select',
            prefix: Icon(Icons.star),
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('renders suffix widget', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            placeholder: 'Select',
            suffix: Icon(Icons.info),
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('handles empty options list', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<String>(
                  placeholder: 'Select',
                  options: [],
                ),
              ),
            ],
          ),
        ),
      );

      // Open menu
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Should show empty state
      expect(find.text('No options available'), findsOneWidget);
    });

    testWidgets('different sizes render correctly', (tester) async {
      for (final size in DropdownSize.values) {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseDropdown<String>(
              size: size,
              placeholder: 'Select',
              options: [
                DropdownOption(value: 'a', label: 'Option A'),
              ],
            ),
          ),
        );

        expect(find.text('Select'), findsOneWidget);
        await tester.pumpWidget(Container()); // Clear
      }
    });

    testWidgets('forceState overrides automatic state', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            placeholder: 'Select',
            forceState: DropdownState.error,
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
          ),
        ),
      );

      // Widget should render with forced state
      expect(find.text('Select'), findsOneWidget);
    });
  });
}
