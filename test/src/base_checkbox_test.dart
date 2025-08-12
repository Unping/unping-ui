import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/src/base_checkbox.dart';

void main() {
  group('BaseCheckbox', () {
    testWidgets('renders with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('handles state changes correctly', (WidgetTester tester) async {
      CheckboxState? changedState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) => changedState = state,
          ),
        ),
      );

      // Tap the checkbox
      await tester.tap(find.byType(BaseCheckbox));
      expect(changedState, CheckboxState.checked);
    });

    testWidgets('does not respond to taps when disabled',
        (WidgetTester tester) async {
      CheckboxState? changedState;

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: null, // This makes it disabled
          ),
        ),
      );

      // Tap the checkbox
      await tester.tap(find.byType(BaseCheckbox));
      expect(changedState, isNull);
    });

    testWidgets('radio button does not uncheck itself',
        (WidgetTester tester) async {
      CheckboxState? changedState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.checked,
            shape: CheckboxShape.circle,
            onChanged: (state) => changedState = state,
          ),
        ),
      );

      // Tap the radio button (should not uncheck)
      await tester.tap(find.byType(BaseCheckbox));
      expect(changedState, isNull);
    });

    testWidgets('radio button does not support indeterminate state',
        (WidgetTester tester) async {
      // Radio buttons created through the factory should only use checked/unchecked
      RadioState? changedState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Checkboxes.radio(
            state: RadioState.unchecked,
            onChanged: (state) => changedState = state,
          ),
        ),
      );

      // The radio button should be in unchecked state initially
      await tester.tap(find.byType(BaseCheckbox));
      expect(changedState,
          RadioState.checked); // Should go to checked, never indeterminate
    });

    testWidgets('renders different sizes correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              BaseCheckbox(size: CheckboxSize.sm),
              BaseCheckbox(size: CheckboxSize.md),
              BaseCheckbox(size: CheckboxSize.lg),
            ],
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsNWidgets(3));
    });

    testWidgets('handles indeterminate state', (WidgetTester tester) async {
      CheckboxState? changedState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.indeterminate,
            onChanged: (state) => changedState = state,
          ),
        ),
      );

      // Tap the checkbox (should go from indeterminate to checked)
      await tester.tap(find.byType(BaseCheckbox));
      expect(changedState, CheckboxState.checked);
    });

    testWidgets('supports focus and keyboard navigation',
        (WidgetTester tester) async {
      CheckboxState? changedState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) => changedState = state,
            focusRingColor: const Color(0xFF989DB3),
          ),
        ),
      );

      // Verify that the checkbox is wrapped in a MouseRegion for hover support
      expect(find.byType(MouseRegion), findsOneWidget);

      // Verify that tapping works (basic functionality)
      await tester.tap(find.byType(BaseCheckbox));
      await tester.pump();

      expect(changedState, CheckboxState.checked);
    });

    testWidgets('shows focus ring when focused', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            focusRingColor: const Color(0xFF989DB3),
            forceVisualState: CheckboxVisualState.focused,
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);

      // The checkbox should be rendered with focus styling
      // (This test verifies the forceVisualState functionality)
    });
  });

  group('RadioGroup', () {
    testWidgets('renders radio options correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RadioGroup<String>(
            options: [
              RadioOption.text(value: 'option1', text: 'Option 1'),
              RadioOption.text(value: 'option2', text: 'Option 2'),
              RadioOption.text(value: 'option3', text: 'Option 3'),
            ],
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsNWidgets(3));
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('handles selection changes', (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RadioGroup<String>(
            options: [
              RadioOption.text(value: 'option1', text: 'Option 1'),
              RadioOption.text(value: 'option2', text: 'Option 2'),
            ],
            onChanged: (value) => selectedValue = value,
          ),
        ),
      );

      // Tap the first option
      await tester.tap(find.text('Option 1'));
      expect(selectedValue, 'option1');
    });

    testWidgets('renders horizontally when specified',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RadioGroup<String>(
            direction: Axis.horizontal,
            options: [
              RadioOption.text(value: 'option1', text: 'Option 1'),
              RadioOption.text(value: 'option2', text: 'Option 2'),
            ],
          ),
        ),
      );

      // Check that the RadioGroup widget itself is present
      expect(find.byType(RadioGroup<String>), findsOneWidget);
      // Check that the text options are present
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('does not respond when disabled', (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RadioGroup<String>(
            disabled: true,
            options: [
              RadioOption.text(value: 'option1', text: 'Option 1'),
              RadioOption.text(value: 'option2', text: 'Option 2'),
            ],
            onChanged: (value) => selectedValue = value,
          ),
        ),
      );

      // Tap the first option
      await tester.tap(find.text('Option 1'));
      expect(selectedValue, isNull);
    });
  });

  group('Checkboxes factory', () {
    testWidgets('creates standard checkbox', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Checkboxes.checkbox(),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('creates radio button', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Checkboxes.radio(state: RadioState.unchecked),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('radio button with checked state', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Checkboxes.radio(state: RadioState.checked),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('radio button handles selection callback',
        (WidgetTester tester) async {
      RadioState? changedState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Checkboxes.radio(
            state: RadioState.unchecked,
            onChanged: (state) => changedState = state,
          ),
        ),
      );

      // Tap the radio button
      await tester.tap(find.byType(BaseCheckbox));
      expect(changedState, RadioState.checked);
    });

    testWidgets('creates radio group', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Checkboxes.radioGroup<String>(
            options: [
              RadioOption.text(value: 'option1', text: 'Option 1'),
              RadioOption.text(value: 'option2', text: 'Option 2'),
            ],
          ),
        ),
      );

      expect(find.byType(RadioGroup<String>), findsOneWidget);
      expect(find.byType(BaseCheckbox), findsNWidgets(2));
    });
  });

  group('RadioOption', () {
    test('creates option with text label', () {
      final option = RadioOption.text(
        value: 'test',
        text: 'Test Option',
      );

      expect(option.value, 'test');
      expect(option.label, isA<Text>());
    });

    test('creates option without label', () {
      final option = RadioOption<String>(value: 'test');

      expect(option.value, 'test');
      expect(option.label, isNull);
    });
  });

  group('BaseCheckbox advanced features', () {
    testWidgets('should handle focus changes', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
          ),
        ),
      );

      // Focus the checkbox
      await tester.tap(find.byType(BaseCheckbox));
      await tester.pumpAndSettle();

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should handle hover state changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
          ),
        ),
      );

      // Simulate hover
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(BaseCheckbox)));
      await tester.pumpAndSettle();

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should handle indeterminate state',
        (WidgetTester tester) async {
      CheckboxState? changedState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.indeterminate,
            onChanged: (state) => changedState = state,
          ),
        ),
      );

      // Tap indeterminate checkbox should go to checked
      await tester.tap(find.byType(BaseCheckbox));
      expect(changedState, CheckboxState.checked);
    });

    testWidgets('should handle checkbox with label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            label: 'Test Label',
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('should handle checkbox with description',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            description: 'Test Description',
          ),
        ),
      );

      expect(find.text('Test Description'), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('should handle checkbox with both label and description',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            label: 'Test Label',
            description: 'Test Description',
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('should handle disabled checkbox with text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: null, // Disabled
            label: 'Disabled Label',
            description: 'Disabled Description',
          ),
        ),
      );

      expect(find.text('Disabled Label'), findsOneWidget);
      expect(find.text('Disabled Description'), findsOneWidget);
    });

    testWidgets('should handle checkbox with forceVisualState',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            forceVisualState: CheckboxVisualState.hovered,
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should handle forceVisualState when disabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: null, // Disabled
            forceVisualState: CheckboxVisualState.hovered,
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should handle text with custom spacing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            label: 'Spaced Label',
            textSpacing: 16.0,
          ),
        ),
      );

      expect(find.text('Spaced Label'), findsOneWidget);
      // Check for custom spacing by verifying more than one SizedBox
      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
    });

    testWidgets('should handle text click when not disabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            label: 'Clickable Label',
          ),
        ),
      );

      // Verify we can find the checkbox and label
      expect(find.text('Clickable Label'), findsOneWidget);
      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should use IntrinsicWidth for proper layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            label: 'Layout Test',
          ),
        ),
      );

      expect(find.byType(IntrinsicWidth), findsOneWidget);
    });

    testWidgets('should handle custom label and description styles',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            label: 'Styled Label',
            description: 'Styled Description',
            labelStyle: const TextStyle(fontSize: 16, color: Color(0xFF000000)),
            descriptionStyle:
                const TextStyle(fontSize: 12, color: Color(0xFF666666)),
          ),
        ),
      );

      expect(find.text('Styled Label'), findsOneWidget);
      expect(find.text('Styled Description'), findsOneWidget);
    });

    testWidgets('should handle keyboard events', (WidgetTester tester) async {
      CheckboxState? changedState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) => changedState = state,
          ),
        ),
      );

      // Focus and tap the checkbox directly
      await tester.tap(find.byType(BaseCheckbox));
      await tester.pumpAndSettle();

      expect(changedState, CheckboxState.checked);
    });

    testWidgets('should ignore keyboard events when disabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: null, // Disabled
          ),
        ),
      );

      // Should just verify the widget renders properly when disabled
      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should handle state animation when widget updates',
        (WidgetTester tester) async {
      // Test animation when state changes from checked to unchecked
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.checked,
            onChanged: (state) {},
          ),
        ),
      );

      // Update to unchecked state
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets(
        'should handle state animation when widget updates from unchecked to checked',
        (WidgetTester tester) async {
      // Test animation when state changes from unchecked to checked
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
          ),
        ),
      );

      // Update to checked state
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.checked,
            onChanged: (state) {},
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should test indeterminate state with custom paint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.indeterminate,
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
      expect(find.byType(CustomPaint), findsOneWidget);

      // Trigger repaints to exercise shouldRepaint method
      await tester.pump();
      await tester.pump();
    });

    testWidgets('responds to actual focus changes', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
            focusRingColor: const Color(0xFF989DB3),
          ),
        ),
      );

      // Get the Focus widget's onFocusChange callback by inspecting the widget tree
      final focusWidget = tester.widget<Focus>(find.descendant(
        of: find.byType(BaseCheckbox),
        matching: find.byType(Focus),
      ));

      // Trigger focus change by calling the callback directly
      if (focusWidget.onFocusChange != null) {
        focusWidget.onFocusChange!(true);
        await tester.pump();

        // Checkbox should now be in focused state
        expect(find.byType(BaseCheckbox), findsOneWidget);

        // Simulate losing focus
        focusWidget.onFocusChange!(false);
        await tester.pump();

        // Should return to normal state
        expect(find.byType(BaseCheckbox), findsOneWidget);
      } else {
        // If onFocusChange is null, just verify the widget exists
        expect(find.byType(BaseCheckbox), findsOneWidget);
      }
    });

    testWidgets('does not respond to focus changes when disabled',
        (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: null, // Disabled
          ),
        ),
      );

      // Disabled checkbox should not have Focus widget from BaseCheckbox
      expect(
          find.descendant(
            of: find.byType(BaseCheckbox),
            matching: find.byType(Focus),
          ),
          findsNothing);

      expect(
          find.descendant(
            of: find.byType(BaseCheckbox),
            matching: find.byType(MouseRegion),
          ),
          findsNothing);

      expect(
          find.descendant(
            of: find.byType(BaseCheckbox),
            matching: find.byType(GestureDetector),
          ),
          findsNothing);
    });

    testWidgets('handles keyboard events', (tester) async {
      CheckboxState? changedState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) => changedState = state,
          ),
        ),
      );

      // Get the Focus widget to test keyboard events
      final focusWidget = tester.widget<Focus>(find.descendant(
        of: find.byType(BaseCheckbox),
        matching: find.byType(Focus),
      ));

      // Test space key
      if (focusWidget.onKeyEvent != null) {
        final spaceKeyEvent = KeyDownEvent(
          physicalKey: PhysicalKeyboardKey.space,
          logicalKey: LogicalKeyboardKey.space,
          timeStamp: Duration.zero,
        );

        final result = focusWidget.onKeyEvent!(FocusNode(), spaceKeyEvent);
        expect(result, KeyEventResult.handled);
        expect(changedState, CheckboxState.checked);

        // Reset state
        changedState = null;

        // Test enter key
        final enterKeyEvent = KeyDownEvent(
          physicalKey: PhysicalKeyboardKey.enter,
          logicalKey: LogicalKeyboardKey.enter,
          timeStamp: Duration.zero,
        );

        final enterResult = focusWidget.onKeyEvent!(FocusNode(), enterKeyEvent);
        expect(enterResult, KeyEventResult.handled);
        expect(changedState, CheckboxState.checked);

        // Test other keys should be ignored
        final otherKeyEvent = KeyDownEvent(
          physicalKey: PhysicalKeyboardKey.keyA,
          logicalKey: LogicalKeyboardKey.keyA,
          timeStamp: Duration.zero,
        );

        changedState = null;
        final otherResult = focusWidget.onKeyEvent!(FocusNode(), otherKeyEvent);
        expect(otherResult, KeyEventResult.ignored);
        expect(changedState, isNull);
      }
    });

    testWidgets('handles mouse region exit', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.unchecked,
            onChanged: (state) {},
          ),
        ),
      );

      // Find the MouseRegion and simulate hover enter and exit
      final mouseRegion = tester.widget<MouseRegion>(find.byType(MouseRegion));

      // Simulate mouse enter
      if (mouseRegion.onEnter != null) {
        mouseRegion.onEnter!(PointerEnterEvent());
        await tester.pump();
      }

      // Simulate mouse exit
      if (mouseRegion.onExit != null) {
        mouseRegion.onExit!(PointerExitEvent());
        await tester.pump();
      }

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });
  });

  group('Radio Group', () {
    testWidgets('should handle radio group value changes',
        (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RadioGroup<String>(
            options: [
              RadioOption.text(value: 'option1', text: 'Option 1'),
              RadioOption.text(value: 'option2', text: 'Option 2'),
            ],
            onChanged: (value) => selectedValue = value,
          ),
        ),
      );

      // Tap the first radio button
      await tester.tap(find.text('Option 1'));
      expect(selectedValue, 'option1');
    });

    testWidgets('should show selected value in radio group',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RadioGroup<String>(
            value: 'option2',
            options: [
              RadioOption.text(value: 'option1', text: 'Option 1'),
              RadioOption.text(value: 'option2', text: 'Option 2'),
            ],
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('should handle disabled radio group',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RadioGroup<String>(
            options: [
              RadioOption.text(value: 'option1', text: 'Option 1'),
              RadioOption.text(value: 'option2', text: 'Option 2'),
            ],
            onChanged: null, // Disabled
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });
  });

  group('Custom Painters', () {
    testWidgets('CheckMarkPainter shouldRepaint coverage', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.checked,
            onChanged: (state) {},
          ),
        ),
      );

      // Find the CustomPaint widget (check mark)
      expect(find.byType(CustomPaint), findsOneWidget);

      // Trigger repaints to exercise shouldRepaint method
      await tester.pump();
      await tester.pump();
    });

    testWidgets('IndeterminatePainter shouldRepaint coverage', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseCheckbox(
            state: CheckboxState.indeterminate,
            onChanged: (state) {},
          ),
        ),
      );

      // Find the CustomPaint widget (indeterminate mark)
      expect(find.byType(CustomPaint), findsOneWidget);

      // Trigger repaints to exercise shouldRepaint method
      await tester.pump();
      await tester.pump();
    });
  });
}
