// test/src/components/input/base_input_test.dart
// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:flutter/semantics.dart';

void main() {
  group('BaseInput', () {
    testWidgets('renders text input correctly', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.text(
            placeholder: 'Enter text',
          ),
        ),
      );

      expect(find.text('Enter text'), findsOneWidget);
    });

    testWidgets('renders text area correctly', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.textArea(
            placeholder: 'Enter description',
          ),
        ),
      );

      expect(find.text('Enter description'), findsOneWidget);
    });

    testWidgets('renders search input with clear button', (tester) async {
      final controller = TextEditingController(text: 'Search me');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.search(
            controller: controller,
          ),
        ),
      );

      expect(find.text('Search me'), findsOneWidget);

// Tap the clear button (✕)
      await tester.tap(find.byType(GestureDetector).last);
      await tester.pump();

      expect(controller.text, isEmpty);
    });

    testWidgets('renders password input with toggle', (tester) async {
      final controller = TextEditingController(text: 'secret123');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.password(
            controller: controller,
          ),
        ),
      );

// Initially obscured
      final editable = tester.widget<EditableText>(find.byType(EditableText));
      expect(editable.obscureText, isTrue);

// Tap the visibility toggle
      await tester.tap(find.byType(GestureDetector).last);
      await tester.pump();

      final updated = tester.widget<EditableText>(find.byType(EditableText));
      expect(updated.obscureText, isFalse);
    });

    testWidgets('responds to typing and onChanged callback', (tester) async {
      String? typedValue;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.text(
            placeholder: 'Email',
            onChanged: (val) => typedValue = val,
          ),
        ),
      );

      await tester.enterText(find.byType(EditableText), 'hello@test.com');
      expect(typedValue, equals('hello@test.com'));
    });

    testWidgets('shows error state when errorText is provided', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.text(
            placeholder: 'Username',
            errorText: 'Required field',
          ),
        ),
      );

      expect(find.text('Required field'), findsOneWidget);
    });

    testWidgets('disables input when enabled is false', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.text(
            placeholder: 'Disabled',
            enabled: false,
          ),
        ),
      );

      final editable = tester.widget<EditableText>(find.byType(EditableText));
      expect(editable.readOnly, isTrue);
    });

    testWidgets('supports character count', (tester) async {
      final controller = TextEditingController(text: 'abc');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.textArea(
            controller: controller,
            maxLength: 10,
            showCharacterCount: true,
          ),
        ),
      );

      expect(find.text('3/10'), findsOneWidget);
    });

    testWidgets('applies semantics label', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(
            placeholder: 'Email',
            semanticsLabel: 'Email input field',
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(BaseInput));
      expect(semantics.label, contains('Email input field'));
      expect(
          semantics.getSemanticsData().flags &
                  SemanticsFlag.isTextField.index !=
              0,
          isTrue);
    });

    testWidgets('shows password strength indicator when enabled',
        (tester) async {
      final controller = TextEditingController(text: 'StrongPass123');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.password(
            controller: controller,
            showStrengthIndicator: true,
          ),
        ),
      );

// Find the strength indicator text specifically
      final strengthText = find.descendant(
        of: find.byType(BaseInput),
        matching: find.text('Strong'),
      );

      expect(strengthText, findsOneWidget);
    });
  });
}
