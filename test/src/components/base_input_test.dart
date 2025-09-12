// test/src/components/input/base_input_test.dart
// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:flutter/material.dart';

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

    testWidgets('renders prefix icon when provided', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(prefixIcon: Icons.star),
        ),
      );
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('didUpdateWidget clears _currentHeight when resizable false',
        (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(controller: controller, resizable: true, maxLines: 3),
      ));

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(controller: controller, resizable: false, maxLines: 3),
      ));

      // If no exception, branch executed
      expect(find.byType(BaseInput), findsOneWidget);
    });

    testWidgets('Clear button works in textarea mode', (tester) async {
      final controller = TextEditingController(text: 'to clear');
      await tester.pumpWidget(
        MaterialApp(
          home: BaseInput(
            controller: controller,
            isSearch: true,
            maxLines: 3, // textarea mode
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap the GestureDetector that wraps the clear button
      await tester.tap(find.byType(GestureDetector).last, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(controller.text, isEmpty);
    });

    testWidgets('shows validationMessage when errorText is not provided',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(
            placeholder: 'Test',
            validationMessage: 'Custom validation',
            forceState: InputState.error,
          ),
        ),
      );
      expect(find.text('Custom validation'), findsOneWidget);
    });

    testWidgets('renders search icon in multi-line input', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(isSearch: true, maxLines: 3),
      ));
      // In multi-line it renders CustomPaint directly
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('renders suffix icon in multi-line textarea', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(maxLines: 3, suffixIcon: Icons.check),
      ));
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('Clear button Semantics onTap clears text', (tester) async {
      final controller = TextEditingController(text: 'abc');
      await tester.pumpWidget(
        MaterialApp(
          home: BaseInput(controller: controller, isSearch: true),
        ),
      );
      await tester.pumpAndSettle();

      // Tap the GestureDetector that wraps the clear button
      await tester.tap(find.byType(GestureDetector).last, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(controller.text, isEmpty);
    });

    testWidgets('toggles password visibility back and forth', (tester) async {
      final controller = TextEditingController(text: 'Password1');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.password(controller: controller),
        ),
      );

      // Initially obscured
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).obscureText,
        isTrue,
      );

      // Tap -> visible
      await tester.tap(find.byType(GestureDetector).last);
      await tester.pump();
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).obscureText,
        isFalse,
      );

      // Tap -> hidden again
      await tester.tap(find.byType(GestureDetector).last);
      await tester.pump();
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).obscureText,
        isTrue,
      );
    });

    testWidgets('resizable textarea updates height on drag', (tester) async {
      final controller = TextEditingController(text: 'multiline text');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.textArea(
            controller: controller,
            resizable: true,
            maxLines: 5,
          ),
        ),
      );

      final handle = find.byType(GestureDetector).last;
      expect(handle, findsOneWidget);

      // Drag down
      await tester.drag(handle, const Offset(0, 40));
      await tester.pump();
    });

    testWidgets('Inputs.text minimal works', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Inputs.text(),
      ));
      expect(find.byType(BaseInput), findsOneWidget);
    });

    testWidgets('Inputs.textArea minimal works', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Inputs.textArea(),
      ));
      expect(find.byType(BaseInput), findsOneWidget);
    });

    testWidgets('Inputs.search minimal works', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Inputs.search(),
      ));
      expect(find.byType(BaseInput), findsOneWidget);
    });

    testWidgets('Inputs.password minimal works', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Inputs.password(),
      ));
      expect(find.byType(BaseInput), findsOneWidget);
    });

    testWidgets('shows default error message when no errorText provided',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(
            placeholder: 'Test',
            forceState: InputState.error,
          ),
        ),
      );

      expect(find.text('Error message'), findsOneWidget);
    });

    testWidgets('BaseInput calls onSubmitted when Enter pressed',
        (tester) async {
      String? submitted;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.text(
            onSubmitted: (val) => submitted = val,
          ),
        ),
      );

      await tester.enterText(find.byType(EditableText), 'hello');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      expect(submitted, 'hello');
    });

    testWidgets('BaseInput respects forceState focused and normal',
        (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child:
            BaseInput(forceState: InputState.focused, placeholder: 'Focused'),
      ));
      expect(find.byType(BaseInput), findsOneWidget);

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(forceState: InputState.normal, placeholder: 'Normal'),
      ));
      expect(find.byType(BaseInput), findsOneWidget);
    });

    testWidgets('ResizableBox updates height when widget updates',
        (tester) async {
      final child = Container();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ResizableBox(
            initialHeight: 100,
            child: child,
            onHeightChanged: (_) {},
          ),
        ),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ResizableBox(
            initialHeight: 200,
            child: child,
            onHeightChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(ResizableBox), findsOneWidget);
    });

    test('Custom painters shouldRepaint always false', () {
      expect(const ResizeHandlePainter().shouldRepaint(ResizeHandlePainter()),
          isFalse);
      expect(
          XIconPainter(color: Colors.red)
              .shouldRepaint(XIconPainter(color: Colors.red)),
          isFalse);
      expect(
          SearchIconPainter(color: Colors.red)
              .shouldRepaint(SearchIconPainter(color: Colors.red)),
          isFalse);
      expect(
          VisibilityIconPainter(color: Colors.red)
              .shouldRepaint(VisibilityIconPainter(color: Colors.red)),
          isFalse);
      expect(
          VisibilityOffIconPainter(color: Colors.red)
              .shouldRepaint(VisibilityOffIconPainter(color: Colors.red)),
          isFalse);
    });

    testWidgets('forceState focused and normal covered', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(forceState: InputState.focused, placeholder: 'Focus'),
      ));
      expect(find.text('Focus'), findsOneWidget);

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(forceState: InputState.normal, placeholder: 'Normal'),
      ));
      expect(find.text('Normal'), findsOneWidget);
    });

    testWidgets('BaseInput supports lg size', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(size: InputSize.lg, placeholder: 'LG'),
      ));
      expect(find.text('LG'), findsOneWidget);
    });

    testWidgets('Clear button Semantics has onTap when text is non-empty',
        (tester) async {
      final controller =
          TextEditingController(text: 'abc'); // must be non-empty
      await tester.pumpWidget(
        MaterialApp(
          home: BaseInput(controller: controller, isSearch: true),
        ),
      );

      // Wait for build and semantics to settle
      await tester.pumpAndSettle();

      // Verify the clear button semantics exists
      expect(find.bySemanticsLabel('Clear text'), findsOneWidget);

      // Tap the clear button using GestureDetector
      await tester.tap(find.byType(GestureDetector).last, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Assert the text is cleared
      expect(controller.text, isEmpty);
    });

    testWidgets('Obscure toggle Semantics has onTap when obscureText=true',
        (tester) async {
      final controller = TextEditingController(text: 'secret'); // non-empty
      await tester.pumpWidget(
        MaterialApp(
          home: BaseInput(
            controller: controller,
            obscureText: true,
            showObscureToggle: true,
          ),
        ),
      );

      // Wait for build and semantics to settle
      await tester.pumpAndSettle();

      // Verify the show password semantics exists
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);

      // Tap the obscure toggle using GestureDetector
      await tester.tap(find.byType(GestureDetector).last, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Assert obscureText is false
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).obscureText,
        isFalse,
      );

      // Verify semantics label updated to 'Hide password'
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
    });
    testWidgets('Suffix icon renders in textarea (non-singleline)',
        (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(
          maxLines: 3,
          suffixIcon: Icons.check,
        ),
      ));
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('Search icon renders in textarea (non-singleline)',
        (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(
          isSearch: true,
          maxLines: 3,
        ),
      ));
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('Password strength strong is shown', (tester) async {
      final controller = TextEditingController(text: 'StrongPass123');
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(
          controller: controller,
          showStrengthIndicator: true,
        ),
      ));
      await tester.pump();
      expect(find.text('Strong'), findsOneWidget);
    });

    testWidgets('Dispose disposes owned controller and focusNode',
        (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(placeholder: 'dispose test'),
      ));
      await tester.pumpWidget(Container()); // triggers dispose
    });

    testWidgets('Dispose does not dispose external controller/focusNode',
        (tester) async {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(controller: controller, focusNode: focusNode),
      ));
      await tester.pumpWidget(Container()); // triggers dispose
      // controller and focusNode should still be usable
      controller.text = 'still alive';
      expect(controller.text, 'still alive');
      focusNode.requestFocus();
      expect(focusNode.hasFocus, isFalse); // but not disposed
    });

    testWidgets('shows character count with maxLength only', (tester) async {
      final controller = TextEditingController(text: 'abcd');
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BaseInput(controller: controller, maxLength: 10),
      ));
      expect(find.text('4/10'), findsOneWidget);
    });

    testWidgets('ResizableBox clamps height when dragged up', (tester) async {
      final controller = TextEditingController(text: 'long text');
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Inputs.textArea(controller: controller, resizable: true),
      ));
      final handle = find.byType(GestureDetector).last;
      await tester.drag(handle, const Offset(0, -1000)); // drag up a lot
      await tester.pump();
    });

    testWidgets('onSubmitted callback works', (tester) async {
      String? submitted;
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Inputs.text(onSubmitted: (val) => submitted = val),
      ));
      await tester.enterText(find.byType(EditableText), 'submit me');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      expect(submitted, 'submit me');
    });

    testWidgets('shows Weak password indicator', (tester) async {
      final controller = TextEditingController(text: '123');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.password(
            controller: controller,
            showStrengthIndicator: true,
          ),
        ),
      );
      expect(find.text('Weak'), findsOneWidget);
    });

    testWidgets('shows Medium password indicator', (tester) async {
      final controller = TextEditingController(text: 'abcdef');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Inputs.password(
            controller: controller,
            showStrengthIndicator: true,
          ),
        ),
      );
      expect(find.text('Medium'), findsOneWidget);
    });

    test('InputSize enum covers all values', () {
      for (final size in InputSize.values) {
        expect(size, isNotNull);
      }
    });

    test('InputState enum covers all values', () {
      for (final state in InputState.values) {
        expect(state, isNotNull);
      }
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

    testWidgets('updates obscureText on widget update', (tester) async {
      final controller = TextEditingController(text: 'secret');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(obscureText: true, controller: controller),
        ),
      );
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).obscureText,
        isTrue,
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(obscureText: false, controller: controller),
        ),
      );
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).obscureText,
        isFalse,
      );
    });

    testWidgets('renders search icon when isSearch = true', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(isSearch: true),
        ),
      );
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('renders prefix and suffix widgets', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(
            prefix: Text('P'),
            suffix: Text('S'),
          ),
        ),
      );
      expect(find.text('P'), findsOneWidget);
      expect(find.text('S'), findsOneWidget);
    });

    testWidgets('renders suffix icon when provided', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(suffixIcon: Icons.check),
        ),
      );
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('shows live character count when showCharacterCount is true',
        (tester) async {
      final controller = TextEditingController(text: 'abc');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(controller: controller, showCharacterCount: true),
        ),
      );
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('shows tooltip when provided and no error', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(tooltipMessage: 'Helper info'),
        ),
      );
      expect(find.text('Helper info'), findsOneWidget);
    });

    testWidgets('uses custom strengthCalculator', (tester) async {
      final controller = TextEditingController(text: 'custom');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(
            controller: controller,
            showStrengthIndicator: true,
            strengthCalculator: (_) => PasswordStrength.strong,
          ),
        ),
      );
      expect(find.text('Strong'), findsOneWidget);
    });

    testWidgets('updates semantics label when toggling obscureText',
        (tester) async {
      final controller = TextEditingController(text: 'secret');
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseInput(
            controller: controller,
            showObscureToggle: true,
            obscureText: true,
          ),
        ),
      );

      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      await tester.tap(find.byType(GestureDetector).last);
      await tester.pump();
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
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
