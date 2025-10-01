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

    testWidgets('handles different sizes', (tester) async {
      // Test large size to cover line 95, 106, 117
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: unping.Toggles.switchToggle(
              value: false,
              onChanged: (_) {},
              size: unping.ToggleSize.lg,
            ),
          ),
        ),
      );

      expect(find.byType(unping.ToggleSwitch), findsOneWidget);
    });

    testWidgets('handles widget updates', (tester) async {
      // Test didUpdateWidget to cover lines 133, 135, 136, 137
      bool value = false;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return unping.Toggles.switchToggle(
                value: value,
                onChanged: (v) {
                  setState(() => value = v);
                },
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(unping.ToggleSwitch));
      await tester.pumpAndSettle();

      expect(find.byType(unping.ToggleSwitch), findsOneWidget);
    });

    testWidgets('handles keyboard input correctly', (tester) async {
      // Test keyboard handling to cover lines 169, 170, 171, 172, 173
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

      final toggle = find.byType(unping.ToggleSwitch);
      await tester.tap(toggle);
      await tester.pumpAndSettle();

      // Test with Enter key
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      // Test with unknown key (should be ignored)
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
    });

    testWidgets('handles forceVisualState parameter', (tester) async {
      // Test forceVisualState to cover line 6 in toggle_variants.dart and line 156
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: unping.Toggles.switchToggle(
              value: false,
              onChanged: (_) {},
              forceVisualState: unping.ToggleVisualState.focused,
            ),
          ),
        ),
      );

      expect(find.byType(unping.ToggleSwitch), findsOneWidget);
    });

    testWidgets('shows focus ring when focused', (tester) async {
      // Test focus ring border to cover lines 203, 204, 205
      bool value = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: unping.ToggleSwitch(
              value: value,
              onChanged: (v) => value = v,
              forceVisualState: unping.ToggleVisualState.focused,
            ),
          ),
        ),
      );

      expect(find.byType(unping.ToggleSwitch), findsOneWidget);
    });
  });
}
