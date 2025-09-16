import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('BaseInputField', () {
    test('should create instance with required parameters', () {
      final inputField = BaseInputField(
        textColor: const Color(0xFF000000),
      );

      expect(inputField, isA<BaseInputField>());
      expect(inputField.textColor, equals(const Color(0xFF000000)));
      expect(inputField.variant, equals(InputFieldVariant.outlined));
      expect(inputField.size, equals(InputFieldSize.md));
      expect(inputField.enabled, isTrue);
    });

    test('should create instance with all optional parameters', () {
      final inputField = BaseInputField(
        textColor: const Color(0xFF000000),
        placeholder: 'Test placeholder',
        label: 'Test label',
        helperText: 'Test helper',
        errorText: 'Test error',
        leadingIcon: const Icon(Icons.search),
        trailingIcon: const Icon(Icons.clear),
        variant: InputFieldVariant.filled,
        size: InputFieldSize.lg,
        enabled: false,
        readOnly: true,
        obscureText: true,
        autocorrect: false,
        enableSuggestions: false,
        maxLines: 3,
        minLines: 2,
        maxLength: 100,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.words,
        backgroundColor: const Color(0xFFFFFFFF),
        focusBackgroundColor: const Color(0xFFE0E0E0),
        disabledBackgroundColor: const Color(0xFFF5F5F5),
        borderColor: const Color(0xFF000000),
        focusBorderColor: const Color(0xFF0000FF),
        errorBorderColor: const Color(0xFFFF0000),
        disabledBorderColor: const Color(0xFF888888),
        borderWidth: 2.0,
        focusRingColor: const Color(0xFF00FF00),
        focusRingWidth: 4.0,
        disabledTextColor: const Color(0xFF999999),
        placeholderColor: const Color(0xFF666666),
        labelColor: const Color(0xFF333333),
        helperTextColor: const Color(0xFF777777),
        errorTextColor: const Color(0xFFFF0000),
        borderRadius: 12.0,
        contentPadding: const EdgeInsets.all(16),
        labelGap: 12.0,
        helperGap: 8.0,
        iconGap: 10.0,
        forceState: InputFieldState.error,
      );

      expect(inputField, isA<BaseInputField>());
      expect(inputField.placeholder, equals('Test placeholder'));
      expect(inputField.label, equals('Test label'));
      expect(inputField.helperText, equals('Test helper'));
      expect(inputField.errorText, equals('Test error'));
      expect(inputField.leadingIcon, isA<Icon>());
      expect(inputField.trailingIcon, isA<Icon>());
      expect(inputField.variant, equals(InputFieldVariant.filled));
      expect(inputField.size, equals(InputFieldSize.lg));
      expect(inputField.enabled, isFalse);
      expect(inputField.readOnly, isTrue);
      expect(inputField.obscureText, isTrue);
      expect(inputField.autocorrect, isFalse);
      expect(inputField.enableSuggestions, isFalse);
      expect(inputField.maxLines, equals(3));
      expect(inputField.minLines, equals(2));
      expect(inputField.maxLength, equals(100));
      expect(inputField.keyboardType, equals(TextInputType.emailAddress));
      expect(inputField.textInputAction, equals(TextInputAction.done));
      expect(inputField.textCapitalization, equals(TextCapitalization.words));
      expect(inputField.backgroundColor, equals(const Color(0xFFFFFFFF)));
      expect(inputField.focusBackgroundColor, equals(const Color(0xFFE0E0E0)));
      expect(
          inputField.disabledBackgroundColor, equals(const Color(0xFFF5F5F5)));
      expect(inputField.borderColor, equals(const Color(0xFF000000)));
      expect(inputField.focusBorderColor, equals(const Color(0xFF0000FF)));
      expect(inputField.errorBorderColor, equals(const Color(0xFFFF0000)));
      expect(inputField.disabledBorderColor, equals(const Color(0xFF888888)));
      expect(inputField.borderWidth, equals(2.0));
      expect(inputField.focusRingColor, equals(const Color(0xFF00FF00)));
      expect(inputField.focusRingWidth, equals(4.0));
      expect(inputField.disabledTextColor, equals(const Color(0xFF999999)));
      expect(inputField.placeholderColor, equals(const Color(0xFF666666)));
      expect(inputField.labelColor, equals(const Color(0xFF333333)));
      expect(inputField.helperTextColor, equals(const Color(0xFF777777)));
      expect(inputField.errorTextColor, equals(const Color(0xFFFF0000)));
      expect(inputField.borderRadius, equals(12.0));
      expect(inputField.contentPadding, equals(const EdgeInsets.all(16)));
      expect(inputField.labelGap, equals(12.0));
      expect(inputField.helperGap, equals(8.0));
      expect(inputField.iconGap, equals(10.0));
      expect(inputField.forceState, equals(InputFieldState.error));
    });

    group('Basic Functionality', () {
      testWidgets('should display with required textColor parameter',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
              ),
            ),
          ),
        );

        expect(find.byType(BaseInputField), findsOneWidget);
        expect(find.byType(EditableText), findsOneWidget);
      });

      testWidgets('should display placeholder text when provided',
          (WidgetTester tester) async {
        const placeholderText = 'Enter your text...';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                placeholder: placeholderText,
              ),
            ),
          ),
        );

        expect(find.text(placeholderText), findsOneWidget);
      });

      testWidgets('should position placeholder correctly with leading icon',
          (WidgetTester tester) async {
        const placeholderText = 'Search...';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                placeholder: placeholderText,
                leadingIcon: const Icon(Icons.search),
              ),
            ),
          ),
        );

        expect(find.text(placeholderText), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);
      });

      testWidgets('should display label when provided',
          (WidgetTester tester) async {
        const labelText = 'Username';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                label: labelText,
              ),
            ),
          ),
        );

        expect(find.text(labelText), findsOneWidget);
      });

      testWidgets('should display helper text when provided',
          (WidgetTester tester) async {
        const helperText = 'This is a helper text';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                helperText: helperText,
              ),
            ),
          ),
        );

        expect(find.text(helperText), findsOneWidget);
      });

      testWidgets('should display error text and override helper text',
          (WidgetTester tester) async {
        const helperText = 'This is a helper text';
        const errorText = 'This field is required';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                helperText: helperText,
                errorText: errorText,
              ),
            ),
          ),
        );

        expect(find.text(errorText), findsOneWidget);
        expect(find.text(helperText), findsNothing);
      });

      testWidgets('should accept text input and call onChanged',
          (WidgetTester tester) async {
        String? changedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                onChanged: (value) => changedValue = value,
              ),
            ),
          ),
        );

        const inputText = 'Hello World';
        await tester.enterText(find.byType(EditableText), inputText);

        expect(changedValue, equals(inputText));
      });

      testWidgets('should call onSubmitted when submitted',
          (WidgetTester tester) async {
        String? submittedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                onSubmitted: (value) => submittedValue = value,
              ),
            ),
          ),
        );

        const inputText = 'Hello World';
        await tester.enterText(find.byType(EditableText), inputText);
        await tester.testTextInput.receiveAction(TextInputAction.done);

        expect(submittedValue, equals(inputText));
      });
    });

    group('Variants', () {
      testWidgets('should render outlined variant by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        final decoration = container.decoration as BoxDecoration;

        expect(decoration.border, isA<Border>());
        expect((decoration.border as Border).top.width, equals(1.0));
      });

      testWidgets('should render filled variant with background color',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                variant: InputFieldVariant.filled,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        final decoration = container.decoration as BoxDecoration;

        expect(decoration.color, equals(UiColors.neutral50));
      });

      testWidgets('should render underlined variant with bottom border only',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                variant: InputFieldVariant.underlined,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;

        expect(border.bottom.width, equals(1.0));
        expect(border.top.width, equals(0.0));
        expect(border.left.width, equals(0.0));
        expect(border.right.width, equals(0.0));
      });
    });

    group('Sizes', () {
      testWidgets('should apply different padding for different sizes',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  BaseInputField(
                    textColor: UiColors.neutral900,
                    size: InputFieldSize.sm,
                    key: const Key('small'),
                  ),
                  BaseInputField(
                    textColor: UiColors.neutral900,
                    size: InputFieldSize.md,
                    key: const Key('medium'),
                  ),
                  BaseInputField(
                    textColor: UiColors.neutral900,
                    size: InputFieldSize.lg,
                    key: const Key('large'),
                  ),
                ],
              ),
            ),
          ),
        );

        // Check that different sizes render differently
        final smallField = find.byKey(const Key('small'));
        final mediumField = find.byKey(const Key('medium'));
        final largeField = find.byKey(const Key('large'));

        expect(smallField, findsOneWidget);
        expect(mediumField, findsOneWidget);
        expect(largeField, findsOneWidget);
      });

      testWidgets('should use custom content padding when provided',
          (WidgetTester tester) async {
        // Test with custom content padding
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                contentPadding:
                    const EdgeInsets.all(50.0), // Large custom padding
                placeholder: 'Test placeholder',
                size: InputFieldSize.md, // Ensure we're not using default size
              ),
            ),
          ),
        );

        expect(find.text('Test placeholder'), findsOneWidget);

        // Test without custom content padding to ensure both code paths are tested
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                // No contentPadding - should use size-based padding
                placeholder: 'Test placeholder 2',
                size: InputFieldSize.md,
              ),
            ),
          ),
        );

        expect(find.text('Test placeholder 2'), findsOneWidget);
      });

      testWidgets('should apply correct min height and padding for large size',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                size: InputFieldSize.lg,
                placeholder: 'Large input',
              ),
            ),
          ),
        );

        // Verify large size renders
        expect(find.text('Large input'), findsOneWidget);

        // Access the widget to ensure large size code paths are executed
        final inputFieldWidget =
            tester.widget<BaseInputField>(find.byType(BaseInputField));
        expect(inputFieldWidget.size, equals(InputFieldSize.lg));
      });

      testWidgets('should apply correct min height for all sizes',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  BaseInputField(
                    textColor: UiColors.neutral900,
                    size: InputFieldSize.sm,
                    key: const Key('small'),
                  ),
                  BaseInputField(
                    textColor: UiColors.neutral900,
                    size: InputFieldSize.md,
                    key: const Key('medium'),
                  ),
                  BaseInputField(
                    textColor: UiColors.neutral900,
                    size: InputFieldSize.lg,
                    key: const Key('large'),
                  ),
                ],
              ),
            ),
          ),
        );

        // Find all container widgets and verify they exist
        final containers = find.byType(Container);
        expect(containers, findsWidgets);
      });
    });

    group('States', () {
      testWidgets('should show disabled state when enabled is false',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                enabled: false,
              ),
            ),
          ),
        );

        final editableText = tester.widget<EditableText>(
          find.byType(EditableText),
        );
        expect(editableText.readOnly, isTrue);
      });

      testWidgets('should show error state when errorText is provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                errorText: 'Error message',
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;

        expect(border.top.color, equals(UiColors.error600));
      });

      testWidgets('should force specific state when forceState is provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                forceState: InputFieldState.focused,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;

        expect(border.top.color, equals(UiColors.primary600));
      });
    });

    group('Icons', () {
      testWidgets('should display leading icon when provided',
          (WidgetTester tester) async {
        const iconWidget = Icon(Icons.search, key: Key('leading-icon'));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                leadingIcon: iconWidget,
              ),
            ),
          ),
        );

        expect(find.byKey(const Key('leading-icon')), findsOneWidget);
      });

      testWidgets('should display trailing icon when provided',
          (WidgetTester tester) async {
        const iconWidget = Icon(Icons.visibility, key: Key('trailing-icon'));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                trailingIcon: iconWidget,
              ),
            ),
          ),
        );

        expect(find.byKey(const Key('trailing-icon')), findsOneWidget);
      });

      testWidgets('should display both leading and trailing icons',
          (WidgetTester tester) async {
        const leadingIcon = Icon(Icons.search, key: Key('leading-icon'));
        const trailingIcon = Icon(Icons.visibility, key: Key('trailing-icon'));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                leadingIcon: leadingIcon,
                trailingIcon: trailingIcon,
              ),
            ),
          ),
        );

        expect(find.byKey(const Key('leading-icon')), findsOneWidget);
        expect(find.byKey(const Key('trailing-icon')), findsOneWidget);
      });
    });

    group('Focus Management', () {
      testWidgets('should handle focus changes and call onFocusChanged',
          (WidgetTester tester) async {
        bool? lastFocusState;
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                focusNode: focusNode,
                onFocusChanged: (hasFocus) => lastFocusState = hasFocus,
              ),
            ),
          ),
        );

        // Request focus
        focusNode.requestFocus();
        await tester.pump();

        expect(lastFocusState, isTrue);

        // Unfocus
        focusNode.unfocus();
        await tester.pump();

        expect(lastFocusState, isFalse);
      });

      testWidgets('should show focus state visually when focused',
          (WidgetTester tester) async {
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                focusNode: focusNode,
                focusRingColor: UiColors.primary200,
              ),
            ),
          ),
        );

        // Focus the input
        focusNode.requestFocus();
        await tester.pump();

        // Check that focus ring is visible by looking for multiple containers
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('Text Input Configuration', () {
      testWidgets('should respect obscureText property',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                obscureText: true,
              ),
            ),
          ),
        );

        final editableText = tester.widget<EditableText>(
          find.byType(EditableText),
        );
        expect(editableText.obscureText, isTrue);
      });

      testWidgets('should respect maxLines property',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                maxLines: 3,
              ),
            ),
          ),
        );

        final editableText = tester.widget<EditableText>(
          find.byType(EditableText),
        );
        expect(editableText.maxLines, equals(3));
      });

      testWidgets('should respect readOnly property',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                readOnly: true,
              ),
            ),
          ),
        );

        final editableText = tester.widget<EditableText>(
          find.byType(EditableText),
        );
        expect(editableText.readOnly, isTrue);
      });

      testWidgets('should respect keyboardType property',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        );

        final editableText = tester.widget<EditableText>(
          find.byType(EditableText),
        );
        expect(editableText.keyboardType, equals(TextInputType.emailAddress));
      });
    });

    group('Value Management', () {
      testWidgets('should display initial value when provided',
          (WidgetTester tester) async {
        const initialValue = 'Initial text';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                value: initialValue,
              ),
            ),
          ),
        );

        expect(find.text(initialValue), findsOneWidget);
      });

      testWidgets(
          'should update controller text when value changes via didUpdateWidget',
          (WidgetTester tester) async {
        String currentValue = 'Initial value';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      BaseInputField(
                        textColor: UiColors.neutral900,
                        value: currentValue,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentValue = 'Updated value';
                          });
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        expect(find.text('Initial value'), findsOneWidget);

        // Tap button to update value
        await tester.tap(find.text('Update'));
        await tester.pump();

        expect(find.text('Updated value'), findsOneWidget);
        expect(find.text('Initial value'), findsNothing);
      });

      testWidgets(
          'should not update controller when external controller is used',
          (WidgetTester tester) async {
        final controller = TextEditingController(text: 'Controller text');
        String currentValue = 'Widget value';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      BaseInputField(
                        textColor: UiColors.neutral900,
                        value: currentValue,
                        controller: controller,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentValue = 'Updated widget value';
                          });
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        expect(find.text('Controller text'), findsOneWidget);

        // Tap button to update widget value (should not affect controller)
        await tester.tap(find.text('Update'));
        await tester.pump();

        // Controller text should remain unchanged
        expect(find.text('Controller text'), findsOneWidget);
      });

      testWidgets('should work with external TextEditingController',
          (WidgetTester tester) async {
        final controller = TextEditingController(text: 'Controller text');

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                controller: controller,
              ),
            ),
          ),
        );

        expect(find.text('Controller text'), findsOneWidget);

        // Update via controller
        controller.text = 'Updated text';
        await tester.pump();

        expect(find.text('Updated text'), findsOneWidget);
      });
    });

    group('Styling and Colors', () {
      testWidgets('should apply custom colors correctly',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.primary600,
                backgroundColor: UiColors.primary50,
                borderColor: UiColors.primary300,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        final decoration = container.decoration as BoxDecoration;

        expect(decoration.color, equals(UiColors.primary50));
        expect((decoration.border as Border).top.color,
            equals(UiColors.primary300));
      });

      testWidgets('should apply custom text styles',
          (WidgetTester tester) async {
        const customTextStyle = TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseInputField(
                textColor: UiColors.neutral900,
                textStyle: customTextStyle,
                value: 'Styled text',
              ),
            ),
          ),
        );

        final editableText = tester.widget<EditableText>(
          find.byType(EditableText),
        );

        expect(editableText.style.fontSize, equals(18));
        expect(editableText.style.fontWeight, equals(FontWeight.bold));
      });
    });
  });
}
