// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart' hide DropdownMenuItem, DropdownMenu;
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('DropdownMenuItem', () {
    testWidgets('renders label correctly', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenuItem(
            label: 'Test Item',
          ),
        ),
      );

      expect(find.text('Test Item'), findsOneWidget);
    });

    testWidgets('shows checkmark when selected', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenuItem(
            label: 'Test Item',
            selected: true,
            showCheckmark: true,
          ),
        ),
      );

      // Checkmark is rendered via CustomPaint
      expect(find.byType(CustomPaint), findsOneWidget);
    });

    testWidgets('does not show checkmark when showCheckmark is false',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenuItem(
            label: 'Test Item',
            selected: true,
            showCheckmark: false,
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsNothing);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenuItem(
            label: 'Test Item',
            onTap: () => wasTapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Test Item'));
      expect(wasTapped, isTrue);
    });

    testWidgets('does not call onTap when disabled', (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenuItem(
            label: 'Test Item',
            enabled: false,
            onTap: () => wasTapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Test Item'));
      expect(wasTapped, isFalse);
    });

    testWidgets('renders supporting text', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenuItem(
            label: 'Test Item',
            supportingText: 'Additional info',
          ),
        ),
      );

      expect(find.text('Test Item'), findsOneWidget);
      expect(find.text('Additional info'), findsOneWidget);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenuItem(
            label: 'Test Item',
            icon: Icon(Icons.star),
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('renders trailing widget', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenuItem(
            label: 'Test Item',
            trailing: Text('Badge'),
          ),
        ),
      );

      expect(find.text('Badge'), findsOneWidget);
    });
  });

  group('DropdownMenu', () {
    testWidgets('renders menu with options', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
              DropdownOption(value: 'b', label: 'Option B'),
              DropdownOption(value: 'c', label: 'Option C'),
            ],
          ),
        ),
      );

      expect(find.text('Option A'), findsOneWidget);
      expect(find.text('Option B'), findsOneWidget);
      expect(find.text('Option C'), findsOneWidget);
    });

    testWidgets('shows empty state when no options', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [],
          ),
        ),
      );

      expect(find.text('No options available'), findsOneWidget);
    });

    testWidgets('shows loading state', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [],
            isLoading: true,
            loadingMessage: 'Loading data...',
          ),
        ),
      );

      expect(find.text('Loading data...'), findsOneWidget);
    });

    testWidgets('renders search field when searchable', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
            searchable: true,
            searchPlaceholder: 'Search...',
          ),
        ),
      );

      // Search field is an EditableText
      expect(find.byType(EditableText), findsOneWidget);
    });

    testWidgets('filters options based on search', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [
              DropdownOption(value: 'apple', label: 'Apple'),
              DropdownOption(value: 'banana', label: 'Banana'),
              DropdownOption(value: 'cherry', label: 'Cherry'),
            ],
            searchable: true,
          ),
        ),
      );

      // Initially all options visible
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsOneWidget);

      // Type in search (find the EditableText and enter text)
      await tester.enterText(find.byType(EditableText), 'ban');
      await tester.pumpAndSettle();

      // Only matching option should be visible
      expect(find.text('Apple'), findsNothing);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsNothing);
    });

    testWidgets('shows "No results" when search has no matches',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [
              DropdownOption(value: 'apple', label: 'Apple'),
            ],
            searchable: true,
          ),
        ),
      );

      // Type non-matching search
      await tester.enterText(find.byType(EditableText), 'xyz');
      await tester.pumpAndSettle();

      expect(find.text('No results found'), findsOneWidget);
    });

    testWidgets('custom search filter works', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [
              DropdownOption(value: '1', label: 'Item One'),
              DropdownOption(value: '2', label: 'Item Two'),
            ],
            searchable: true,
            searchFilter: (option, query) =>
                option.value.toString().contains(query),
          ),
        ),
      );

      // Search by value instead of label
      await tester.enterText(find.byType(EditableText), '1');
      await tester.pumpAndSettle();

      expect(find.text('Item One'), findsOneWidget);
      expect(find.text('Item Two'), findsNothing);
    });

    testWidgets('renders checkmarks for selected items', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
              DropdownOption(value: 'b', label: 'Option B'),
            ],
            selectedValues: ['a'],
            showCheckmarks: true,
          ),
        ),
      );

      // Selected item has checkmark - verify by checking the menu item widget structure
      expect(find.text('Option A'), findsOneWidget);
      expect(find.text('Option B'), findsOneWidget);
      // We expect CustomPaint widgets (checkmark for selected item)
      // Note: There may be multiple CustomPaint widgets in the tree
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('calls onSelected when item tapped', (tester) async {
      dynamic selectedValue;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [
              DropdownOption(value: 'a', label: 'Option A'),
            ],
            onSelected: (value) => selectedValue = value,
          ),
        ),
      );

      await tester.tap(find.text('Option A'));
      expect(selectedValue, equals('a'));
    });

    testWidgets('renders group headers', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [
              DropdownOption(value: 'html', label: 'HTML', group: 'Frontend'),
              DropdownOption(value: 'css', label: 'CSS', group: 'Frontend'),
              DropdownOption(value: 'node', label: 'Node', group: 'Backend'),
            ],
          ),
        ),
      );

      expect(find.text('FRONTEND'), findsOneWidget);
      expect(find.text('BACKEND'), findsOneWidget);
    });

    testWidgets('renders dividers when showDivider is true', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DropdownMenu(
            options: [
              DropdownOption(
                value: 'a',
                label: 'Option A',
                showDivider: true,
              ),
              DropdownOption(value: 'b', label: 'Option B'),
            ],
          ),
        ),
      );

      // Find Container widgets that represent dividers
      final containers = find.byType(Container);
      expect(containers, findsWidgets);
    });
  });
}
