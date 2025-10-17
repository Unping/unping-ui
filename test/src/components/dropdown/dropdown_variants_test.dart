// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('Dropdowns.select', () {
    testWidgets('creates single selection dropdown', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Dropdowns.select<String>(
            label: 'Country',
            options: ['USA', 'Canada', 'Mexico'],
            placeholder: 'Choose a country',
          ),
        ),
      );

      expect(find.text('Country'), findsOneWidget);
      expect(find.text('Choose a country'), findsOneWidget);
    });

    testWidgets('handles selection', (tester) async {
      String? selected;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.select<String>(
                  options: ['USA', 'Canada'],
                  placeholder: 'Select',
                  onChanged: (value) => selected = value,
                ),
              ),
            ],
          ),
        ),
      );

      // Open and select
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Canada'));
      await tester.pumpAndSettle();

      expect(selected, equals('Canada'));
    });

    testWidgets('renders with searchable option', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.select<String>(
                  options: ['USA', 'Canada'],
                  placeholder: 'Select',
                  searchable: true,
                ),
              ),
            ],
          ),
        ),
      );

      // Open menu
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Should have search field
      expect(find.byType(EditableText), findsOneWidget);
    });

    testWidgets('uses custom optionBuilder', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.select<int>(
                  options: [1, 2, 3],
                  placeholder: 'Select',
                  optionBuilder: (num) => Text('Number: $num'),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(find.text('Number: 1'), findsOneWidget);
      expect(find.text('Number: 2'), findsOneWidget);
    });
  });

  group('Dropdowns.multiSelect', () {
    testWidgets('creates multi-selection dropdown', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Dropdowns.multiSelect<String>(
            label: 'Skills',
            options: ['Flutter', 'Dart', 'React'],
            selectedValues: ['Flutter'],
          ),
        ),
      );

      expect(find.text('Skills'), findsOneWidget);
      expect(find.text('1 selected'), findsOneWidget);
    });

    testWidgets('handles multi-selection', (tester) async {
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

      // Open menu
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Select first item
      await tester.tap(find.text('A'));
      await tester.pump();

      expect(selected, contains('A'));
    });

    testWidgets('displays multiple selected count', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Dropdowns.multiSelect<String>(
            options: ['A', 'B', 'C'],
            selectedValues: ['A', 'B', 'C'],
          ),
        ),
      );

      expect(find.text('3 selected'), findsOneWidget);
    });
  });

  group('Dropdowns.combobox', () {
    testWidgets('creates searchable combobox', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.combobox<String>(
                  options: ['Apple', 'Banana'],
                  placeholder: 'Search',
                  optionBuilder: (fruit) => Text(fruit),
                ),
              ),
            ],
          ),
        ),
      );

      // Open menu
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      // Should have search field by default
      expect(find.byType(EditableText), findsOneWidget);
    });

    testWidgets('uses custom search filter', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Align(
                  alignment: Alignment.topLeft,
                  child: BaseDropdown<String>(
                    placeholder: 'Search',
                    options: [
                      DropdownOption(value: 'apple', label: 'apple'),
                      DropdownOption(value: 'banana', label: 'banana'),
                    ],
                    config: DropdownConfig(
                      searchable: true,
                      menuMaxHeight: 300.0,
                      searchFilter: (option, query) {
                        return option.label
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      // Search for 'a'
      final editableText =
          tester.widget<EditableText>(find.byType(EditableText));
      editableText.controller.text = 'a';
      await tester.pump();

      expect(find.text('apple'), findsOneWidget);
      expect(find.text('banana'), findsNothing);
    });
  });

  group('Dropdowns.menu', () {
    testWidgets('creates action menu', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Dropdowns.menu(
            trigger: Icon(Icons.more_vert),
            items: [
              DropdownMenuAction(label: 'Edit', onTap: () {}),
              DropdownMenuAction(label: 'Delete', onTap: () {}),
            ],
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('opens menu on trigger tap', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.menu(
                  trigger: Icon(Icons.more_vert),
                  items: [
                    DropdownMenuAction(label: 'Edit', onTap: () {}),
                    DropdownMenuAction(label: 'Delete', onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('executes action onTap', (tester) async {
      bool editCalled = false;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Align(
                  alignment: Alignment.center,
                  child: Dropdowns.menu(
                    trigger: Icon(Icons.more_vert),
                    items: [
                      DropdownMenuAction(
                        label: 'Edit',
                        onTap: () => editCalled = true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      // Open menu
      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      // Verify menu opened
      expect(find.text('Edit'), findsOneWidget);

      // Tap action
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();

      expect(editCalled, isTrue);
    });

    testWidgets('renders destructive action', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.menu(
                  trigger: Icon(Icons.more_vert),
                  items: [
                    DropdownMenuAction(
                      label: 'Delete',
                      destructive: true,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('renders keyboard shortcuts', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.menu(
                  trigger: Icon(Icons.more_vert),
                  items: [
                    DropdownMenuAction(
                      label: 'Edit',
                      shortcut: '⌘E',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.text('⌘E'), findsOneWidget);
    });
  });

  group('DropdownConfig', () {
    testWidgets('applies loading configuration', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<String>(
                  placeholder: 'Select',
                  options: [],
                  config: DropdownConfig(
                    isLoading: true,
                    loadingMessage: 'Please wait...',
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      // Use pump() instead of pumpAndSettle() because loading spinner animates infinitely
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Please wait...'), findsOneWidget);
    });

    testWidgets('applies virtual scrolling configuration', (tester) async {
      final largeList = List.generate(
        200,
        (i) => DropdownOption(value: i, label: 'Item $i'),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseDropdown<int>(
                  placeholder: 'Select',
                  options: largeList,
                  config: DropdownConfig(
                    virtualScrolling: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      // Items should be rendered (virtual scrolling active)
      expect(find.text('Item 0'), findsOneWidget);
    });
  });

  group('Dropdowns.select with custom builders', () {
    testWidgets('uses custom selectedBuilder', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Dropdowns.select<String>(
            options: ['A', 'B', 'C'],
            selectedValue: 'B',
            selectedBuilder: (value) => Text('Selected: $value'),
          ),
        ),
      );

      expect(find.text('Selected: B'), findsOneWidget);
    });
  });

  group('Dropdowns.multiSelect with custom builders', () {
    testWidgets('uses custom optionBuilder in multiSelect', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.multiSelect<int>(
                  options: [1, 2, 3],
                  placeholder: 'Select',
                  optionBuilder: (num) => Text('Number: $num'),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(find.text('Number: 1'), findsOneWidget);
      expect(find.text('Number: 2'), findsOneWidget);
    });

    testWidgets('uses custom selectedBuilder in multiSelect', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Dropdowns.multiSelect<String>(
            options: ['A', 'B', 'C'],
            selectedValues: ['A', 'B'],
            selectedBuilder: (values) => Text('${values.length} items'),
          ),
        ),
      );

      expect(find.text('2 items'), findsOneWidget);
    });
  });

  group('Dropdowns.combobox with searchFilter', () {
    testWidgets('uses custom searchFilter', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Align(
                  alignment: Alignment.topLeft,
                  child: Dropdowns.combobox<String>(
                    options: ['Apple', 'Banana', 'Cherry'],
                    placeholder: 'Search',
                    optionBuilder: (fruit) => Text(fruit),
                    searchFilter: (option, query) {
                      return option.startsWith(query.toUpperCase());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      // Search with custom filter
      final editableText =
          tester.widget<EditableText>(find.byType(EditableText));
      editableText.controller.text = 'a';
      await tester.pump();

      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
    });
  });

  group('Dropdowns.menu positioning', () {
    testWidgets('menu positions above when menuPosition is above',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Align(
                  alignment: Alignment.bottomCenter,
                  child: Dropdowns.menu(
                    trigger: Icon(Icons.more_vert),
                    items: [
                      DropdownMenuAction(label: 'Edit', onTap: () {}),
                    ],
                    menuPosition: DropdownMenuPosition.above,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.text('Edit'), findsOneWidget);
    });

    testWidgets('menu positions below when menuPosition is below',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Align(
                  alignment: Alignment.topCenter,
                  child: Dropdowns.menu(
                    trigger: Icon(Icons.more_vert),
                    items: [
                      DropdownMenuAction(label: 'Edit', onTap: () {}),
                    ],
                    menuPosition: DropdownMenuPosition.below,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.text('Edit'), findsOneWidget);
    });

    testWidgets('menu auto positions based on available space', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Align(
                  alignment: Alignment.center,
                  child: Dropdowns.menu(
                    trigger: Icon(Icons.more_vert),
                    items: [
                      DropdownMenuAction(label: 'Edit', onTap: () {}),
                    ],
                    menuPosition: DropdownMenuPosition.auto,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.text('Edit'), findsOneWidget);
    });

    testWidgets('closes menu when clicking trigger again', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.menu(
                  trigger: Icon(Icons.more_vert),
                  items: [
                    DropdownMenuAction(label: 'Edit', onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      // Open menu
      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.text('Edit'), findsOneWidget);

      // Click trigger again to close
      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.text('Edit'), findsNothing);
    });

    testWidgets('disabled menu does not open', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Dropdowns.menu(
                  trigger: Icon(Icons.more_vert),
                  items: [
                    DropdownMenuAction(label: 'Edit', onTap: () {}),
                  ],
                  enabled: false,
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.text('Edit'), findsNothing);
    });
  });
}
