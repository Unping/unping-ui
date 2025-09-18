import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart' as unping;

void main() {
  group('ToggleSwitch Widget Tests', () {
    testWidgets('renders correctly with default values', (tester) async {
      bool value = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: unping.Toggles.switchToggle(
              value: value,
              onChanged: (v) => value = v,
            ),
          ),
        ),
      );

      expect(find.byType(unping.ToggleSwitch), findsOneWidget);
    });

    testWidgets('toggles on tap', (tester) async {
      bool value = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: unping.Toggles.switchToggle(
              value: value,
              onChanged: (v) => value = v,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(unping.ToggleSwitch));
      await tester.pumpAndSettle();

      expect(value, true);
    });

    testWidgets('toggles with keyboard (Enter/Space) when focused',
        (tester) async {
      bool value = false;

      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Focus(
              focusNode: focusNode,
              child: unping.Toggles.switchToggle(
                value: value,
                onChanged: (v) => value = v,
              ),
            ),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();
      expect(value, false);
    });

    testWidgets('does not toggle when disabled', (tester) async {
      bool value = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: unping.Toggles.switchToggle(
              value: value,
              isDisabled: true,
              onChanged: (v) => value = v,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(unping.ToggleSwitch));
      await tester.pumpAndSettle();

      expect(value, false);
    });

    testWidgets('renders label and description', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: unping.Toggles.switchToggle(
              value: false,
              onChanged: (_) {},
              label: 'Test Label',
              description: 'Test Description',
            ),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });
  });
}
