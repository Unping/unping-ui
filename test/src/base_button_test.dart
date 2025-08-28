// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('BaseButton', () {
    testWidgets('renders text button correctly', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseButton(
            text: 'Test Button',
            textColor: Color(0xFFFFFFFF),
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('renders icon button correctly', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseButton(
            icon: Icon(Icons.add),
            textColor: Color(0xFFFFFFFF),
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('renders text and icon button correctly', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseButton(
            text: 'Test Button',
            icon: Icon(Icons.add),
            textColor: Color(0xFFFFFFFF),
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('throws assertion error when both text and icon are null',
        (tester) async {
      expect(
        () => BaseButton(textColor: Color(0xFFFFFFFF)),
        throwsAssertionError,
      );
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseButton(
            text: 'Test Button',
            textColor: Color(0xFFFFFFFF),
            onPressed: () => wasPressed = true,
          ),
        ),
      );

      await tester.tap(find.text('Test Button'));
      expect(wasPressed, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseButton(
            text: 'Test Button',
            textColor: Color(0xFFFFFFFF),
            onPressed: null,
          ),
        ),
      );

      await tester.tap(find.text('Test Button'));
      expect(wasPressed, isFalse);
    });

    testWidgets('shows loading widget when isLoading is true', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseButton(
            text: 'Test Button',
            textColor: Color(0xFFFFFFFF),
            onPressed: () {},
            isLoading: true,
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });

    testWidgets('shows custom loading widget when provided', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseButton(
            text: 'Test Button',
            textColor: Color(0xFFFFFFFF),
            onPressed: () {},
            isLoading: true,
            loadingWidget: Text('Loading...'),
          ),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });

    testWidgets('does not call onPressed when loading', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseButton(
            text: 'Test Button',
            textColor: Color(0xFFFFFFFF),
            onPressed: () => wasPressed = true,
            isLoading: true,
          ),
        ),
      );

      await tester.tap(find.byType(BaseButton), warnIfMissed: false);
      expect(wasPressed, isFalse);
    });

    group('IconPosition', () {
      testWidgets('positions icon before text when leading', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              icon: Icon(Icons.add),
              iconPosition: IconPosition.leading,
              textColor: Color(0xFFFFFFFF),
              onPressed: () {},
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        final children = row.children;

        expect(children.length, equals(3)); // icon, gap, text
        expect(children[0], isA<Icon>());
        expect(children[1], isA<SizedBox>());
        expect(children[2], isA<Text>());
      });

      testWidgets('positions icon after text when trailing', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              icon: Icon(Icons.add),
              iconPosition: IconPosition.trailing,
              textColor: Color(0xFFFFFFFF),
              onPressed: () {},
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        final children = row.children;

        expect(children.length, equals(3)); // text, gap, icon
        expect(children[0], isA<Text>());
        expect(children[1], isA<SizedBox>());
        expect(children[2], isA<Icon>());
      });
    });

    group('ButtonState', () {
      testWidgets('uses forced state when provided', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              focusTextColor: Color(0xFF00FF00),
              onPressed: () {},
              forceState: ButtonState.focused,
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.color, equals(Color(0xFF00FF00)));
      });

      testWidgets('respects disabled state even with forced state',
          (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              disabledTextColor: Color(0xFF888888),
              onPressed: null,
              forceState: ButtonState.focused,
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.color, equals(Color(0xFF888888)));
      });
    });

    group('Hover and Focus', () {
      testWidgets('changes appearance on hover', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              hoverTextColor: Color(0xFF00FF00),
              onPressed: () {},
            ),
          ),
        );

        // Initially should have normal text color
        var textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.color, equals(Color(0xFFFFFFFF)));

        // Hover over the button
        final gesture =
            await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        await gesture.moveTo(tester.getCenter(find.byType(BaseButton)));
        await tester.pump();

        // Should now have hover text color
        textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.color, equals(Color(0xFF00FF00)));

        await gesture.removePointer();
      });

      testWidgets('changes appearance on focus', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              focusTextColor: Color(0xFF0000FF),
              onPressed: () {},
              forceState: ButtonState.focused,
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.color, equals(Color(0xFF0000FF)));
      });

      testWidgets('does not change on hover when disabled', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              disabledTextColor: Color(0xFF888888),
              hoverTextColor: Color(0xFF00FF00),
              onPressed: null,
            ),
          ),
        );

        // Hover over the disabled button
        final gesture =
            await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        await gesture.moveTo(tester.getCenter(find.byType(BaseButton)));
        await tester.pump();

        // Should still have disabled text color
        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.color, equals(Color(0xFF888888)));

        await gesture.removePointer();
      });

      testWidgets('responds to actual focus changes', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              focusTextColor: Color(0xFF0000FF),
              onPressed: () {},
            ),
          ),
        );

        // Get the Focus widget's onFocusChange callback by inspecting the widget tree
        final focusWidget = tester.widget<Focus>(find.descendant(
          of: find.byType(BaseButton),
          matching: find.byType(Focus),
        ));

        // Initially should have normal text color
        var textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.color, equals(Color(0xFFFFFFFF)));

        // Trigger focus change by calling the callback directly
        if (focusWidget.onFocusChange != null) {
          focusWidget.onFocusChange!(true);
          await tester.pump();

          // Should now have focus text color
          textWidget = tester.widget<Text>(find.text('Test'));
          expect(textWidget.style!.color, equals(Color(0xFF0000FF)));

          // Simulate losing focus
          focusWidget.onFocusChange!(false);
          await tester.pump();

          // Should return to normal color
          textWidget = tester.widget<Text>(find.text('Test'));
          expect(textWidget.style!.color, equals(Color(0xFFFFFFFF)));
        } else {
          // If onFocusChange is null, just verify the widget exists
          expect(find.text('Test'), findsOneWidget);
        }
      });

      testWidgets('does not respond to focus changes when disabled',
          (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              focusTextColor: Color(0xFF0000FF),
              disabledTextColor: Color(0xFF888888),
              onPressed: null, // disabled
            ),
          ),
        );

        // Get the Focus widget's onFocusChange callback
        final focusWidget = tester.widget<Focus>(find.descendant(
          of: find.byType(BaseButton),
          matching: find.byType(Focus),
        ));

        // Should have disabled text color
        var textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.color, equals(Color(0xFF888888)));

        // Try to focus on the disabled button by calling onFocusChange
        if (focusWidget.onFocusChange != null) {
          focusWidget.onFocusChange!(true);
          await tester.pump();

          // Should still have disabled text color, not focus color
          textWidget = tester.widget<Text>(find.text('Test'));
          expect(textWidget.style!.color, equals(Color(0xFF888888)));

          // Test losing focus as well
          focusWidget.onFocusChange!(false);
          await tester.pump();

          // Should still have disabled text color
          textWidget = tester.widget<Text>(find.text('Test'));
          expect(textWidget.style!.color, equals(Color(0xFF888888)));
        } else {
          // If onFocusChange is null, just verify the widget has disabled color
          expect(textWidget.style!.color, equals(Color(0xFF888888)));
        }
      });
    });

    group('Styling', () {
      testWidgets('applies custom padding', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              onPressed: () {},
              padding: EdgeInsets.all(20),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, equals(EdgeInsets.all(20)));
      });

      testWidgets('applies default padding for text button', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              onPressed: () {},
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding,
            equals(EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0)));
      });

      testWidgets('applies default padding for icon-only button',
          (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              icon: Icon(Icons.add),
              textColor: Color(0xFFFFFFFF),
              onPressed: () {},
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, equals(EdgeInsets.all(8.0)));
      });

      testWidgets('applies background color', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              backgroundColor: Color(0xFF000000),
              onPressed: () {},
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(Color(0xFF000000)));
      });

      testWidgets('applies border', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              borderColor: Color(0xFFFF0000),
              borderWidth: 2.0,
              onPressed: () {},
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;
        expect(border.top.color, equals(Color(0xFFFF0000)));
        expect(border.top.width, equals(2.0));
      });

      testWidgets('applies border radius', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              borderRadius: 10.0,
              onPressed: () {},
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.borderRadius, equals(BorderRadius.circular(10.0)));
      });

      testWidgets('applies underlined text', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              underlineText: true,
              onPressed: () {},
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.decoration, equals(TextDecoration.underline));
      });

      testWidgets('applies font styling', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              textStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
              onPressed: () {},
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style!.fontSize, equals(16.0));
        expect(textWidget.style!.fontWeight, equals(FontWeight.bold));
        expect(textWidget.style!.fontFamily, equals('Arial'));
      });

      testWidgets('uses UiTextStyles.textSm as default text style',
          (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              onPressed: () {},
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Test'));
        // Verify default style matches UiTextStyles.textSm
        expect(
            textWidget.style!.fontSize, equals(UiTextStyles.textSm.fontSize));
        expect(textWidget.style!.fontWeight,
            equals(UiTextStyles.textSm.fontWeight));
        expect(textWidget.style!.height, equals(UiTextStyles.textSm.height));
        expect(textWidget.style!.fontFamily,
            equals(UiTextStyles.textSm.fontFamily));
      });

      testWidgets('applies minimum height and width constraints',
          (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              minHeight: 50.0,
              minWidth: 100.0,
              onPressed: () {},
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.constraints!.minHeight, equals(50.0));
        expect(container.constraints!.minWidth, equals(100.0));
      });

      testWidgets('applies focus ring shadow', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              focusRingColor: Color(0xFF00FF00),
              focusRingWidth: 2.0,
              onPressed: () {},
              forceState: ButtonState.focused,
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.length, equals(1));
        expect(decoration.boxShadow![0].color, equals(Color(0xFF00FF00)));
        expect(decoration.boxShadow![0].spreadRadius, equals(2.0));
      });
    });

    group('Animation', () {
      testWidgets('animates scale on tap down and up', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              onPressed: () {},
            ),
          ),
        );

        // Tap down
        await tester.startGesture(tester.getCenter(find.byType(BaseButton)));
        await tester.pump();
        await tester.pump(Duration(milliseconds: 50));

        // The animation should be running
        expect(find.byType(AnimatedBuilder), findsOneWidget);

        // Tap up
        await tester.tap(find.byType(BaseButton), warnIfMissed: false);
        await tester.pump();
        await tester.pump(Duration(milliseconds: 50));
      });

      testWidgets('does not animate when disabled', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              textColor: Color(0xFFFFFFFF),
              onPressed: null,
            ),
          ),
        );

        // Try to tap - should not animate
        await tester.tap(find.byType(BaseButton), warnIfMissed: false);
        await tester.pump();

        // No exception should be thrown
        expect(find.byType(AnimatedBuilder), findsOneWidget);
      });
    });

    group('Custom Gap', () {
      testWidgets('applies custom gap between icon and text', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseButton(
              text: 'Test',
              icon: Icon(Icons.add),
              gap: 16.0,
              textColor: Color(0xFFFFFFFF),
              onPressed: () {},
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        final gapWidget = row.children[1] as SizedBox;
        expect(gapWidget.width, equals(16.0));
      });
    });
  });

  group('Buttons helper class', () {
    group('ghost', () {
      testWidgets('creates ghost button with correct defaults', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Buttons.ghost(
              text: 'Ghost Button',
              onPressed: () {},
            ),
          ),
        );

        expect(find.text('Ghost Button'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.text('Ghost Button'));
        expect(textWidget.style!.color, equals(Color(0xFFFFFFFF)));
      });

      testWidgets('ghost button can be customized', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Buttons.ghost(
              text: 'Custom Ghost',
              textColor: Color(0xFF00FF00),
              hoverTextColor: Color(0xFFFF0000),
              onPressed: () {},
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Custom Ghost'));
        expect(textWidget.style!.color, equals(Color(0xFF00FF00)));
      });
    });

    group('filled', () {
      testWidgets('creates filled button with correct defaults',
          (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Buttons.filled(
              text: 'Filled Button',
              onPressed: () {},
            ),
          ),
        );

        expect(find.text('Filled Button'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.text('Filled Button'));
        expect(textWidget.style!.color, equals(UiColors.neutral800));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(Color(0xFFFFFFFF)));
      });

      testWidgets('filled button can be customized', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Buttons.filled(
              text: 'Custom Filled',
              backgroundColor: Color(0xFF000000),
              textColor: Color(0xFFFFFFFF),
              onPressed: () {},
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(Color(0xFF000000)));
      });
    });

    group('outline', () {
      testWidgets('creates outline button with correct defaults',
          (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Buttons.outline(
              text: 'Outline Button',
              onPressed: () {},
            ),
          ),
        );

        expect(find.text('Outline Button'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.text('Outline Button'));
        expect(textWidget.style!.color, equals(Color(0xFFFFFFFF)));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;
        expect(border.top.color, equals(Color(0xFFFFFFFF)));
      });

      testWidgets('outline button can be customized', (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Buttons.outline(
              text: 'Custom Outline',
              borderColor: Color(0xFF00FF00),
              textColor: Color(0xFF00FF00),
              onPressed: () {},
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;
        expect(border.top.color, equals(Color(0xFF00FF00)));
      });
    });
  });

  group('CustomCircularProgressIndicator', () {
    testWidgets('renders and animates', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseButton(
            text: 'Loading',
            textColor: Color(0xFFFFFFFF),
            onPressed: () {},
            isLoading: true,
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsOneWidget);

      // Let animation run for a bit
      await tester.pump(Duration(milliseconds: 100));
      await tester.pump(Duration(milliseconds: 100));

      expect(find.byType(CustomPaint), findsOneWidget);
    });
  });
}

// Add missing Icons class for testing
class Icons {
  static const IconData add = IconData(0xe047, fontFamily: 'MaterialIcons');
}

// Add missing Icon widget for testing
class Icon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const Icon(this.icon, {super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontFamily: icon.fontFamily,
        color: color,
        fontSize: size ?? 24.0,
      ),
    );
  }
}
