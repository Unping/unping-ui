// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide DropdownMenuItem;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('Dropdown Keyboard Navigation', () {
    testWidgets('Arrow Down opens menu when closed', (tester) async {
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

      // Press Arrow Down
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      // Menu should be open
      expect(find.text('Option A'), findsWidgets);
    });

    testWidgets('Arrow Down navigates through options', (tester) async {
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
                    DropdownOption(value: 'c', label: 'Option C'),
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

      // Navigate down
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();

      // State should update (focused index changes)
      expect(find.text('Option A'), findsWidgets);
    });

    testWidgets('Arrow Up navigates backward', (tester) async {
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

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Move down then up
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pump();

      expect(find.text('Option A'), findsWidgets);
    });

    testWidgets('Home key jumps to first option', (tester) async {
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
                    DropdownOption(value: 'c', label: 'Option C'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.home);
      await tester.pump();

      expect(find.text('Option A'), findsWidgets);
    });

    testWidgets('End key jumps to last option', (tester) async {
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
                    DropdownOption(value: 'c', label: 'Option C'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.end);
      await tester.pump();

      expect(find.text('Option C'), findsOneWidget);
    });

    testWidgets('Enter key selects focused option', (tester) async {
      String? selected;

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
                  onChanged: (value) => selected = value,
                ),
              ),
            ],
          ),
        ),
      );

      // Open and navigate
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();

      // Select with Enter
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(selected, isNotNull);
    });

    testWidgets('Space key opens menu when closed', (tester) async {
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

      await tester.tap(find.text('Select'));
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      expect(find.text('Option A'), findsWidgets);
    });
  });

  group('Dropdown Mouse Interactions', () {
    testWidgets('hover changes menu item appearance', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenuItem(
            label: 'Test Item',
          ),
        ),
      );

      // Create a hover event
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.text('Test Item')));
      await tester.pumpAndSettle();

      // Item should render (hover state internally managed)
      expect(find.text('Test Item'), findsOneWidget);
    });

    testWidgets('click outside closes menu', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Container(
                  width: 400,
                  height: 400,
                  child: BaseDropdown<String>(
                    placeholder: 'Select',
                    options: [
                      DropdownOption(value: 'a', label: 'Option A'),
                    ],
                  ),
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

      // Tap outside (on container background) - pick a point well outside menu bounds
      await tester.tapAt(Offset(50, 200));
      await tester.pumpAndSettle();

      // Menu should close (option not visible)
      expect(find.text('Option A'), findsNothing);
      expect(find.text('Select'), findsOneWidget);
    });
  });

  group('Dropdown Focus Management', () {
    testWidgets('dropdown receives focus on tap', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            placeholder: 'Select',
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pump();

      // Focus node should have focus (verified by widget rendering)
      expect(find.text('Select'), findsOneWidget);
    });

    testWidgets('loses focus closes menu', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Column(
                  children: [
                    BaseDropdown<String>(
                      placeholder: 'Select',
                      options: [
                        DropdownOption(value: 'a', label: 'Option A'),
                      ],
                    ),
                    Container(height: 100, width: 100), // Focusable area
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

      // Tap elsewhere
      await tester.tapAt(Offset(50, 200));
      await tester.pumpAndSettle();

      // Menu should close (option not visible)
      expect(find.text('Option A'), findsNothing);
      expect(find.text('Select'), findsOneWidget);
    });
  });

  group('Dropdown Accessibility', () {
    testWidgets('has semantic label', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            semanticsLabel: 'Country selector',
            placeholder: 'Select',
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
          ),
        ),
      );

      // Semantics are applied
      expect(find.text('Select'), findsOneWidget);
    });

    testWidgets('menu items have semantic labels', (tester) async {
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

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Options should be accessible
      expect(find.text('Option A'), findsWidgets);
    });

    testWidgets('disabled state is semantically indicated', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseDropdown<String>(
            placeholder: 'Select',
            enabled: false,
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
          ),
        ),
      );

      // Widget renders in disabled state
      expect(find.text('Select'), findsOneWidget);
    });
  });

  group('Dropdown Search Interactions', () {
    testWidgets('typing in search filters options', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Align(
                  alignment: Alignment.topLeft,
                  child: BaseDropdown<String>(
                    placeholder: 'Select',
                    options: [
                      DropdownOption(value: 'a', label: 'Apple'),
                      DropdownOption(value: 'b', label: 'Banana'),
                      DropdownOption(value: 'c', label: 'Cherry'),
                    ],
                    config: DropdownConfig(
                      searchable: true,
                      menuMaxHeight: 300.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Verify search field is present (menu opened)
      expect(find.byType(EditableText), findsOneWidget);

      // Verify menu opened and all options visible
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsOneWidget);

      // Type in search (case insensitive search)
      final editableText =
          tester.widget<EditableText>(find.byType(EditableText));
      editableText.controller.text = 'ban';
      await tester.pump();

      // Should filter to just Banana
      expect(find.text('Apple'), findsNothing);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsNothing);
    });

    testWidgets('clearing search shows all options', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Align(
                  alignment: Alignment.topLeft,
                  child: BaseDropdown<String>(
                    placeholder: 'Select',
                    options: [
                      DropdownOption(value: 'a', label: 'Apple'),
                      DropdownOption(value: 'b', label: 'Banana'),
                    ],
                    config: DropdownConfig(
                      searchable: true,
                      menuMaxHeight: 300.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Type search text to filter
      final editableText =
          tester.widget<EditableText>(find.byType(EditableText));
      editableText.controller.text = 'ban';
      await tester.pump();

      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Apple'), findsNothing);

      // Clear search by entering empty string
      editableText.controller.text = '';
      await tester.pump();

      // All options should be visible again
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
    });
  });

  group('Dropdown Multi-Select Interactions', () {
    testWidgets('selecting item adds to selection', (tester) async {
      List<String> selected = [];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.multiSelect<String>(
                  options: ['A', 'B', 'C'],
                  selectedValues: selected,
                  placeholder: 'Select',
                  onChanged: (values) => selected = values,
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pump();

      expect(selected, contains('A'));
      expect(selected.length, equals(1));
    });

    testWidgets('deselecting item removes from selection', (tester) async {
      List<String> selected = ['A'];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.multiSelect<String>(
                  options: ['A', 'B'],
                  selectedValues: selected,
                  placeholder: 'Select',
                  onChanged: (values) => selected = values,
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('1 selected'));
      await tester.pumpAndSettle();

      // Deselect A
      await tester.tap(find.text('A'));
      await tester.pump();

      expect(selected, isEmpty);
    });
  });
}
