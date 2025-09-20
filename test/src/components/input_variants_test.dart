import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  /// Helper function to pump a widget with MaterialApp
  Future<void> pumpWidget(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: child,
          ),
        ),
      ),
    );
    // await pumpWidget(tester, child);
  }

  // This predicate finds the Text widget that is actually visible to the user.
  // Used to avoid false positives from invisible error/helper texts.
  Finder findVisibleText(String text) {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          widget.data == text &&
          // Check that the text color is not transparent
          (widget.style?.color?.a ?? 255) > 0,
    );
  }

  group('TextInput', () {
    testWidgets('renders label, placeholder, and helper text', (tester) async {
      await pumpWidget(
        tester,
        const TextInput(
          label: 'Username',
          placeholder: 'Enter username',
          helperText: 'This is a hint',
        ),
      );

      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Enter username'), findsOneWidget);
      expect(findVisibleText('This is a hint'), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered', (tester) async {
      String? changedValue;
      await pumpWidget(
        tester,
        TextInput(onChanged: (value) => changedValue = value),
      );

      await tester.enterText(find.byType(TextInput), 'hello');
      await tester.pump();

      expect(changedValue, 'hello');
    });

    testWidgets('handles user typing and focus', (tester) async {
      String? changedValue;
      final focusNode = FocusNode();

      await pumpWidget(
        tester,
        TextInput(
            onChanged: (value) => changedValue = value, focusNode: focusNode),
      );

      // Check focus
      expect(focusNode.hasFocus, isFalse);
      await tester.tap(find.byType(TextInput));
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      // Check typing
      await tester.enterText(find.byType(TextInput), 'hello');
      await tester.pump();
      expect(changedValue, 'hello');
    });

    testWidgets('displays error text from validator', (tester) async {
      final formKey = GlobalKey<FormState>();
      final errorMessage = 'Cannot be empty';
      await pumpWidget(
        tester,
        Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: TextInput(
            validator: (value) => errorMessage,
          ),
        ),
      );

      // Trigger validation
      formKey.currentState!.validate();
      await tester.pump();

      expect(findVisibleText(errorMessage), findsOneWidget);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await pumpWidget(tester, const TextInput(enabled: false));
      final textFormField =
          tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textFormField.enabled, isFalse);
    });

    testWidgets('applies correct styles for each InputSize', (tester) async {
      for (final size in InputSize.values) {
        await pumpWidget(
          tester,
          Inputs.text(size: size, placeholder: 'Test'),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        final inputDecoration = textField.decoration!;
        final textStyle = textField.style!;

        late double expectedVerticalPadding;
        late TextStyle expectedTextStyle;

        switch (size) {
          case InputSize.sm:
            expectedVerticalPadding = 10.0; // from _getVerticalPadding
            expectedTextStyle = UiTextStyles.textSm;
            break;
          case InputSize.md:
            expectedVerticalPadding = 12.0; // from _getVerticalPadding
            expectedTextStyle = UiTextStyles.textMd;
            break;
          case InputSize.lg:
            expectedVerticalPadding = 14.0;
            expectedTextStyle = UiTextStyles.textMd;
            break;
        }

        expect((inputDecoration.contentPadding as EdgeInsets).top,
            expectedVerticalPadding,
            reason: 'Failed for size $size');
        expect(textStyle.fontSize, expectedTextStyle.fontSize,
            reason: 'Failed for size $size');
      }
    });

    testWidgets('focuses input when label is tapped', (tester) async {
      await pumpWidget(tester, Inputs.text(label: 'My Label'));
      await tester.tap(find.text('My Label'));
      await tester.pump();
      final textFormField =
          tester.widget<EditableText>(find.byType(EditableText));
      expect(textFormField.focusNode.hasFocus, isTrue);
    });
  });

  group('TextArea', () {
    testWidgets('shows character count when showCharCount is true',
        (tester) async {
      await pumpWidget(tester, const TextArea(showCharCount: true));
      expect(findVisibleText('0'), findsOneWidget);

      await tester.enterText(find.byType(TextArea), 'hello');
      await tester.pump();

      expect(findVisibleText('5'), findsOneWidget);
    });

    testWidgets('shows character count with maxLength', (tester) async {
      await pumpWidget(
        tester,
        const TextArea(showCharCount: true, maxLength: 100),
      );
      expect(findVisibleText('0 / 100'), findsOneWidget);

      await tester.enterText(find.byType(TextArea), 'hello world');
      await tester.pump();

      expect(findVisibleText('11 / 100'), findsOneWidget);
    });

    testWidgets('does not show character count when showCharCount is false',
        (tester) async {
      await pumpWidget(tester, const TextArea(showCharCount: false));
      expect(find.textContaining(RegExp(r'\d+ / \d+')), findsNothing);
      expect(find.text('0'), findsNothing);
    });
  });

  group('SearchInput', () {
    testWidgets('shows clear button only when text is present', (tester) async {
      await pumpWidget(tester, const SearchInput());

      // Initially, no clear button
      expect(find.byIcon(Icons.close_rounded), findsNothing);

      // Enter text, clear button should appear
      await tester.enterText(find.byType(SearchInput), 'search query');
      await tester.pump();
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);

      // Clear text, button should disappear
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump();
      expect(find.byIcon(Icons.close_rounded), findsNothing);
    });

    testWidgets('clears text when clear button is tapped', (tester) async {
      await pumpWidget(tester, const SearchInput());
      await tester.enterText(find.byType(SearchInput), 'search query');
      await tester.pump();

      expect(find.text('search query'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump();

      expect(find.text('search query'), findsNothing);
    });

    testWidgets('calls onSubmit when text changes or is cleared',
        (tester) async {
      String? submittedValue;
      await pumpWidget(
        tester,
        SearchInput(onSubmit: (value) => submittedValue = value),
      );

      await tester.enterText(find.byType(SearchInput), 'test');
      await tester.pump();
      expect(submittedValue, 'test');

      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump();
      expect(submittedValue, '');
    });
  });

  group('PasswordInput', () {
    testWidgets('is obscured by default', (tester) async {
      await pumpWidget(tester, const PasswordInput());
      final textFormField =
          tester.widget<EditableText>(find.byType(EditableText));
      expect(textFormField.obscureText, isTrue);
    });

    testWidgets('toggles obscureText when visibility icon is tapped',
        (tester) async {
      await pumpWidget(tester, const PasswordInput());

      // Starts obscured with visibility_off icon
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);
      expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText,
          isTrue);

      // Tap to reveal
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      // Is now visible with visibility icon
      expect(find.byIcon(Icons.visibility_off), findsNothing);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText,
          isFalse);

      // Tap to obscure again
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      // Is obscured again
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);
      expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText,
          isTrue);
    });
  });

  group('PasswordInput with Strength Indicator', () {
    testWidgets('does NOT show strength indicator by default', (tester) async {
      await pumpWidget(tester, const PasswordInput());

      await tester.enterText(find.byType(PasswordInput), 'weakpassword');
      await tester.pump();

      // Assert that no helper text related to strength is shown.
      expect(find.textContaining('Strength:'), findsNothing);
    });

    testWidgets('shows strength indicator when showStrengthIndicator is true',
        (tester) async {
      await pumpWidget(
          tester, const PasswordInput(showStrengthIndicator: true));

      // As soon as the user types, the indicator should appear.
      await tester.enterText(find.byType(PasswordInput), 'w');
      await tester.pump();

      expect(findVisibleText('Strength: Weak'), findsOneWidget);
    });

    testWidgets('updates strength from Weak to Medium to Strong as user types',
        (tester) async {
      await pumpWidget(
          tester, const PasswordInput(showStrengthIndicator: true));
      // --- Test for No Password ---
      await tester.enterText(find.byType(PasswordInput), '');
      await tester.pump();
      expect(findVisibleText('Strength: Weak'), findsNothing);
      expect(findVisibleText('Strength: Medium'), findsNothing);
      expect(findVisibleText('Strength: Strong'), findsNothing);

      // --- Test for WEAK strength ---
      // (e.g., short password)
      await tester.enterText(find.byType(PasswordInput), 'pass');
      await tester.pump();
      expect(findVisibleText('Strength: Weak'), findsOneWidget);
      expect(findVisibleText('Strength: Medium'), findsNothing);
      expect(findVisibleText('Strength: Strong'), findsNothing);

      // --- Test for MEDIUM strength ---
      // (e.g., long password with mixed case)
      await tester.enterText(find.byType(PasswordInput), 'Password123');
      await tester.pump();
      expect(findVisibleText('Strength: Weak'), findsNothing);
      expect(findVisibleText('Strength: Medium'), findsOneWidget);
      expect(findVisibleText('Strength: Strong'), findsNothing);

      // --- Test for STRONG strength ---
      // (e.g., long password with mixed case, numbers, and special characters)
      await tester.enterText(find.byType(PasswordInput), 'Password123!');
      await tester.pump();
      expect(findVisibleText('Strength: Weak'), findsNothing);
      expect(findVisibleText('Strength: Medium'), findsNothing);
      expect(findVisibleText('Strength: Strong'), findsOneWidget);
    });

    testWidgets('hides strength indicator when input is cleared',
        (tester) async {
      await pumpWidget(
          tester, const PasswordInput(showStrengthIndicator: true));

      await tester.enterText(find.byType(PasswordInput), 'StrongPass123!');
      await tester.pump();
      expect(findVisibleText('Strength: Strong'), findsOneWidget);

      // Clear the text
      await tester.enterText(find.byType(PasswordInput), '');
      await tester.pump();

      // The indicator should disappear
      expect(find.textContaining('Strength:'), findsNothing);
    });

    testWidgets('validation error takes precedence over strength indicator',
        (tester) async {
      final formKey = GlobalKey<FormState>();
      await pumpWidget(
        tester,
        Form(
          key: formKey,
          child: PasswordInput(
            showStrengthIndicator: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
        ),
      );

      // Enter a strong password, indicator should be visible
      await tester.enterText(find.byType(PasswordInput), 'StrongPass123!');
      await tester.pump();
      expect(findVisibleText('Strength: Strong'), findsOneWidget);
      expect(findVisibleText('Password is required'), findsNothing);

      // Clear the text and trigger validation
      await tester.enterText(find.byType(PasswordInput), '');
      formKey.currentState!.validate();
      await tester.pump();

      // Assert that the error message is shown and the strength indicator is hidden.
      expect(findVisibleText('Password is required'), findsOneWidget);
      expect(findVisibleText('Strength:'), findsNothing);
    });
  });
  group('Inputs Factory', () {
    testWidgets('Inputs.text() creates a TextInput with correct parameters',
        (tester) async {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      const label = 'Test Label';
      const placeholder = 'Test Placeholder';
      const helperText = 'Test Helper';
      const prefixIcon = Icon(Icons.person);
      const suffixIcon = Icon(Icons.info);
      String? changedValue;
      String? validator(String? v) => v == null ? 'Error' : null;

      final widget = Inputs.text(
        controller: controller,
        focusNode: focusNode,
        label: label,
        placeholder: placeholder,
        helperText: helperText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabled: false,
        size: InputSize.lg,
        onChanged: (value) => changedValue = value,
        validator: validator,
      );

      expect(widget, isA<TextInput>());

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      final textInput = tester.widget<TextInput>(find.byType(TextInput));
      expect(textInput.controller, controller);
      expect(textInput.focusNode, focusNode);
      expect(textInput.label, label);
      expect(textInput.placeholder, placeholder);
      expect(textInput.helperText, helperText);
      expect(textInput.prefixIcon, prefixIcon);
      expect(textInput.suffixIcon, suffixIcon);
      expect(textInput.enabled, isFalse);
      expect(textInput.size, InputSize.lg);
      expect(textInput.validator, validator);

      // Test callback
      textInput.onChanged?.call('test');
      expect(changedValue, 'test');

      // Clean up
      controller.dispose();
      focusNode.dispose();
    });

    testWidgets('Inputs.textArea() creates a TextArea with correct parameters',
        (tester) async {
      const maxLength = 200;

      final widget = Inputs.textArea(
        label: 'Bio',
        placeholder: 'Enter your bio',
        maxLength: maxLength,
        showCharCount: true,
        minLines: 4,
        maxLines: 10,
      );

      expect(widget, isA<TextArea>());

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      final textArea = tester.widget<TextArea>(find.byType(TextArea));
      expect(textArea.label, 'Bio');
      expect(textArea.placeholder, 'Enter your bio');
      expect(textArea.maxLength, maxLength);
      expect(textArea.showCharCount, isTrue);
      expect(textArea.minLines, 4);
      expect(textArea.maxLines, 10);
    });

    testWidgets('Inputs.search() creates a SearchInput with correct parameters',
        (tester) async {
      String? submittedValue;

      final widget = Inputs.search(
        placeholder: 'Find something...',
        onSubmit: (value) => submittedValue = value,
      );

      expect(widget, isA<SearchInput>());

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      final searchInput = tester.widget<SearchInput>(find.byType(SearchInput));
      expect(searchInput.placeholder, 'Find something...');

      // Test callback
      searchInput.onSubmit?.call('query');
      expect(submittedValue, 'query');
    });

    testWidgets(
        'Inputs.password() creates a PasswordInput with correct parameters',
        (tester) async {
      final widget = Inputs.password(
        label: 'Create Password',
        placeholder: 'Your new password',
        showStrengthIndicator: true,
        obscureText: false, // Non-default value
      );

      expect(widget, isA<PasswordInput>());

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      final passwordInput =
          tester.widget<PasswordInput>(find.byType(PasswordInput));
      expect(passwordInput.label, 'Create Password');
      expect(passwordInput.placeholder, 'Your new password');
      expect(passwordInput.showStrengthIndicator, isTrue);
      expect(passwordInput.obscureText, isFalse);
    });
  });
}
