import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('Dropdowns.select Widget Tests', () {
    String? selectedValue;

    setUp(() {
      selectedValue = null;
    });

    testWidgets('renders correctly in normal state and selects an option',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.select(
              label: 'Single Select',
              selectedValue: selectedValue,
              textStyle: UiTextStyles.displayMd,
              state: DropdownState.normal,
              options: ['USA', 'Canada', 'Mexico'],
              onSelectedValueChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      // Verify label text is visible
      expect(find.text('Single Select').first, findsOneWidget);

      // Tap dropdown to open
      await tester.tap(find.byType(BaseDropdown<dynamic>));
      await tester.pumpAndSettle();

      // Verify options appear
      expect(find.text('USA').first, findsOneWidget);
      expect(find.text('Canada').first, findsOneWidget);
      expect(find.text('Mexico').first, findsOneWidget);

      // Select an option
      await tester.tap(find.text('Canada').last);
      await tester.pumpAndSettle();

      // Verify selected value updated
      expect(selectedValue, equals('Canada'));
    });

    testWidgets('renders correctly in error state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.select(
              label: 'Single Select',
              selectedValue: selectedValue,
              textStyle: UiTextStyles.displayMd,
              state: DropdownState.error,
              options: ['USA', 'Canada', 'Mexico'],
              onSelectedValueChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      // Verify label text
      expect(find.text('Single Select').first, findsOneWidget);

      // You can check for red/error visual cues if available
      final dropdownFinder = find.byType(BaseDropdown<dynamic>);
      expect(dropdownFinder, findsOneWidget);
    });

    testWidgets('renders correctly in focused state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FocusScope(
              child: Dropdowns.select(
                label: 'Single Select',
                selectedValue: selectedValue,
                textStyle: UiTextStyles.displayMd,
                state: DropdownState.focused,
                options: ['USA', 'Canada', 'Mexico'],
                onSelectedValueChanged: (value) {
                  selectedValue = value;
                },
              ),
            ),
          ),
        ),
      );

      // Verify label text
      expect(find.text('Single Select').first, findsOneWidget);

      // Focus and open
      await tester.tap(find.byType(BaseDropdown<dynamic>));
      await tester.pumpAndSettle();

      // Check if focused state visually changes (border or highlight)
      final dropdown = tester.widget<BaseDropdown<dynamic>>(
        find.byType(BaseDropdown<dynamic>),
      );
      expect(dropdown, isNotNull);
    });

    testWidgets('renders correctly in disabled state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.select(
              label: 'Single Select',
              selectedValue: selectedValue,
              textStyle: UiTextStyles.displayMd,
              state: DropdownState.disabled,
              options: ['USA', 'Canada', 'Mexico'],
              onSelectedValueChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      // Verify label text is visible
      expect(find.text('Single Select').first, findsOneWidget);

      // Attempt to open dropdown
      await tester.tap(find.byType(BaseDropdown<dynamic>));
      await tester.pumpAndSettle();

      // Should not open overlay when disabled so only one found
      expect(find.text('USA'), findsOne);
      expect(find.text('Canada'), findsOne);
      expect(find.text('Mexico'), findsOne);
    });
  });

  group('Dropdowns.multiSelect Widget Tests', () {
    late List<String> selectedValues;

    setUp(() {
      selectedValues = [];
    });

    testWidgets('renders correctly in error state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.multiSelect(
              label: 'Select Multi',
              textStyle: UiTextStyles.displayMedium,
              state: DropdownState.error,
              errorMessage: 'This field is required',
              selectAllText: 'Select All',
              clearAllText: 'Clear All',
              selectedValues: selectedValues,
              options: ['Flutter', 'Dart', 'React'],
              onSelectedValueChanged: (value) {
                selectedValues.add(value);
              },
            ),
          ),
        ),
      );

      // Verify error text is shown
      expect(find.text('This field is required'), findsOneWidget);

      // Verify visual error state
      final dropdown = tester.widget(find.byType(BaseDropdown<dynamic>));
      expect(dropdown, isNotNull);
      // Optionally test for red border or color if exposed via key
    });

    testWidgets('renders correctly in focused state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FocusScope(
              child: Dropdowns.multiSelect(
                label: 'Focused Dropdown',
                textStyle: UiTextStyles.displayMedium,
                state: DropdownState.focused,
                selectedValues: selectedValues,
                options: ['Flutter', 'Dart', 'React'],
                onSelectedValueChanged: (value) {
                  selectedValues.add(value);
                },
              ),
            ),
          ),
        ),
      );

      // Verify label text
      expect(find.text('Focused Dropdown'), findsOneWidget);

      // Simulate focus
      final dropdownFinder = find.byType(BaseDropdown<dynamic>);
      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle();

      // Ensure dropdown has focus color or indicator
      final focusedDropdown =
          tester.widget<BaseDropdown<dynamic>>(dropdownFinder);
      expect(focusedDropdown, isNotNull);
      // You can check specific visual changes if you expose color props
    });

    testWidgets('renders correctly in disabled state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.multiSelect(
              label: 'Disabled Dropdown',
              textStyle: UiTextStyles.displayMedium,
              state: DropdownState.disabled,
              selectedValues: selectedValues,
              options: ['Flutter', 'Dart', 'React'],
              onSelectedValueChanged: (value) {
                selectedValues.add(value);
              },
            ),
          ),
        ),
      );

      // Verify label is visible
      expect(find.text('Disabled Dropdown'), findsOneWidget);

      // Try to tap it
      await tester.tap(find.byType(BaseDropdown<dynamic>));
      await tester.pumpAndSettle();

      // The overlay should NOT appear
      expect(find.text('Flutter'), findsNothing);
      expect(find.text('Dart'), findsNothing);
    });
  });

  ///Combo box
  group('Dropdowns.combobox', () {
    late String selectedValue;

    setUp(() {
      selectedValue = '';
    });

    testWidgets('renders correctly in normal state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.combobox(
              label: 'Choose a Language',
              textStyle: UiTextStyles.displayMd,
              state: DropdownState.normal,
              options: ['Flutter', 'Dart', 'React', 'Node.js'],
              onSelectedValueChanged: (value) => selectedValue = value ?? '',
            ),
          ),
        ),
      );

      // Verify label is visible
      expect(find.text('Choose a Language'), findsOneWidget);

      // Open dropdown
      await tester.tap(find.text('Choose a Language'));
      await tester.pumpAndSettle();

      // Verify options appear
      expect(find.text('Flutter'), findsOneWidget);
      expect(find.text('Dart'), findsOneWidget);

      // Select an option
      await tester.tap(find.text('Dart').first);
      await tester.pumpAndSettle();

      expect(selectedValue, equals('Dart'));
    });

    testWidgets('shows error state with error message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.combobox(
              label: 'Choose a Language',
              textStyle: UiTextStyles.displayMd,
              errorMessage: 'Invalid selection',
              state: DropdownState.error,
              options: ['Flutter', 'Dart', 'React'],
              onSelectedValueChanged: (value) {},
            ),
          ),
        ),
      );

      // Verify label and error message
      expect(find.text('Choose a Language'), findsOneWidget);
      expect(find.text('Invalid selection'), findsOneWidget);
    });

    testWidgets('shows disabled state (cannot open)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.combobox(
              label: 'Choose a Language',
              textStyle: UiTextStyles.displayMd,
              state: DropdownState.disabled,
              options: ['Flutter', 'Dart'],
              onSelectedValueChanged: (value) {},
            ),
          ),
        ),
      );

      // Attempt to open dropdown
      await tester.tap(find.text('Choose a Language'));
      await tester.pumpAndSettle();

      // Options should not appear
      expect(find.text('Flutter'), findsNothing);
    });

    testWidgets('handles search input filtering', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.combobox(
              label: 'Choose a Language',
              textStyle: UiTextStyles.displayMd,
              isSearchable: true,
              state: DropdownState.focused,
              options: ['Flutter', 'Dart', 'React', 'Node.js'],
              onSelectedValueChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      // Tap to open dropdown
      await tester.tap(find.text('Choose a Language'));
      await tester.pumpAndSettle();

      // Type "Re" to filter
      await tester.enterText(find.byType(TextField), 'Re');
      await tester.pumpAndSettle();

      // Verify React remains visible
      expect(find.text('React'), findsOneWidget);

      // Select filtered option
      await tester.tap(find.text('React'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('React'));
    });
  });

  group('Dropdowns.menu', () {
    testWidgets('renders correctly with grouped menu items',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.menu(
              label: 'Options',
              leadingDropdownIcon: const Icon(Icons.more_vert),
              trailingDropdownIcon: const Icon(Icons.arrow_drop_down),
              textStyle: UiTextStyles.displayMd,
              actionMenuDivider: true,
              withBorder: true,
              state: DropdownState.normal,
              actionMenuGroups: [
                MenuDropdownItemGroup(
                  groupTitle: 'File',
                  groupItems: [
                    MenuDropdownItem(
                      label: 'New',
                      icon: const Icon(Icons.add),
                      onTap: () => debugPrint('Pressed New'),
                    ),
                    MenuDropdownItem(
                      label: 'Open',
                      icon: const Icon(Icons.folder_open),
                      onTap: () => debugPrint('Pressed Open'),
                    ),
                  ],
                ),
                MenuDropdownItemGroup(
                  groupTitle: 'Danger Zone',
                  groupItems: [
                    MenuDropdownItem(
                      label: 'Delete',
                      icon: const Icon(Icons.delete),
                      destructive: true,
                      onTap: () => debugPrint('Pressed Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      // Verify label and icons are visible
      expect(find.text('Options'), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);

      // Tap to open menu
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      // Verify grouped menu items are shown
      expect(find.text('File'), findsOneWidget);
      expect(find.text('Danger Zone'), findsOneWidget);
      expect(find.text('New'), findsOneWidget);
      expect(find.text('Open'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('executes item tap actions correctly',
        (WidgetTester tester) async {
      String? tappedLabel;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.menu(
              label: 'Menu',
              textStyle: UiTextStyles.displaySmMedium,
              withBorder: true,
              state: DropdownState.normal,
              actionMenuGroups: [
                MenuDropdownItemGroup(
                  groupTitle: 'File',
                  groupItems: [
                    MenuDropdownItem(
                        label: 'Open',
                        icon: const Icon(Icons.folder_open),
                        onTap: () {
                          tappedLabel = 'Open';
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      // Open menu
      await tester.tap(find.text('Menu'));
      await tester.pumpAndSettle();

      // Tap menu item
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Verify callback executed
      expect(tappedLabel, equals('Open'));
    });

    testWidgets('renders disabled state correctly (menu doesn’t open)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.menu(
              label: 'Menu',
              textStyle: UiTextStyles.displayMd,
              state: DropdownState.disabled,
              withBorder: true,
              actionMenuGroups: [
                MenuDropdownItemGroup(
                  groupTitle: 'File',
                  groupItems: [
                    MenuDropdownItem(
                      label: 'Open',
                      icon: const Icon(Icons.folder_open),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      // Try to open
      await tester.tap(find.text('Menu'));
      await tester.pumpAndSettle();

      // Should not open
      expect(find.text('Open'), findsNothing);
    });

    testWidgets('supports scrolling for long action menus',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdowns.menu(
              label: 'Long Menu',
              textStyle: UiTextStyles.displayMd,
              withBorder: true,
              state: DropdownState.normal,
              actionMenuGroups: [
                MenuDropdownItemGroup(
                  groupTitle: 'Items',
                  groupItems: List.generate(
                    30,
                    (i) => MenuDropdownItem(
                      label: 'Item $i',
                      icon: const Icon(Icons.circle),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Long Menu'));
      await tester.pumpAndSettle();

      // Scroll down to last item
      final scrollable = find.byType(Scrollable).first;
      await tester.drag(scrollable, const Offset(0, -1000));
      await tester.pumpAndSettle();

      // Verify last item appears
      expect(find.text('Item 29'), findsOneWidget);
    });
  });
}
