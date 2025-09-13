// dart format width=80
import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

ThemeData _testTheme() {
  return ThemeData.light().copyWith(
    extensions: const <ThemeExtension<dynamic>>[
      UnpingColorExtension.light,
      UiSpacingExtension.light,
      UiRadiusExtension.light,
    ],
    textTheme: TextTheme(
      bodyMedium: UiTextStyles.textMd,
    ),
  );
}

Widget _wrap(Widget child, {Size size = const Size(800, 600)}) {
  return MaterialApp(
    theme: _testTheme(),
    home: MediaQuery(
      data: MediaQueryData(size: size, devicePixelRatio: 1.0),
      child: Scaffold(body: Center(child: child)),
    ),
  );
}

Future<TestGesture> _hoverOver(
  WidgetTester tester,
  Finder target, {
  Offset? at,
}) async {
  final g = await tester.createGesture(kind: PointerDeviceKind.mouse);
  await g.addPointer();
  addTearDown(() => g.removePointer());
  final offset = at ?? tester.getCenter(target);
  await g.moveTo(offset);
  await tester.pump();
  return g;
}

void main() {
  const tipText = 'Hello tooltip!';

  testWidgets('renders child and has Semantics tooltip', (tester) async {
    final childKey = UniqueKey();

    await tester.pumpWidget(
      _wrap(
        UiTooltip(
          message: tipText,
          child: Text('Target', key: childKey),
        ),
      ),
    );

    expect(find.byKey(childKey), findsOneWidget);

    final hasTooltipSemantics = find.byWidgetPredicate((w) {
      if (w is Semantics) return w.properties.tooltip == tipText;
      return false;
    });
    expect(hasTooltipSemantics, findsOneWidget);
  });

  testWidgets('rich() sets semantics via message and renders content',
      (tester) async {
    const semanticsText = 'Semantics-only label';

    await tester.pumpWidget(
      _wrap(
        Tooltips.rich(
          child: const Text('Rich'),
          message: semanticsText,
          content: const Text(
            'RICH-CONTENT',
            style: TextStyle(color: Colors.white),
          ),
          placement: UiTooltipPlacement.top,
        ),
      ),
    );

    await _hoverOver(tester, find.text('Rich'));
    await tester.pump(const Duration(milliseconds: 360));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('RICH-CONTENT'), findsOneWidget);

    final hasTooltipSemantics = find.byWidgetPredicate((w) {
      if (w is Semantics) return w.properties.tooltip == semanticsText;
      return false;
    });
    expect(hasTooltipSemantics, findsOneWidget);
  });

  testWidgets('shows on hover after delay, hides on exit', (tester) async {
    final k = UniqueKey();

    await tester.pumpWidget(
      _wrap(
        UiTooltip(
          message: tipText,
          child: FilledButton(
            key: k,
            onPressed: () {},
            child: const Text('Hover me'),
          ),
        ),
      ),
    );

    expect(find.text(tipText), findsNothing);

    final g = await _hoverOver(tester, find.byKey(k));

    // < 350ms delay -> nothing yet
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(tipText), findsNothing);

    // pass delay + a bit of show animation
    await tester.pump(const Duration(milliseconds: 80));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text(tipText), findsOneWidget);

    // move away -> hides (reverseDuration ~120ms)
    await g.moveTo(const Offset(0, 0));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 140));
    expect(find.text(tipText), findsNothing);
  });

  testWidgets('variant colors are applied (success)', (tester) async {
    final k = UniqueKey();

    await tester.pumpWidget(
      _wrap(
        UiTooltip(
          message: tipText,
          variant: UiTooltipVariant.success,
          child: FilledButton(
            key: k,
            onPressed: () {},
            child: const Text('Success'),
          ),
        ),
      ),
    );

    await _hoverOver(tester, find.byKey(k));
    await tester.pump(const Duration(milliseconds: 360));
    await tester.pump(const Duration(milliseconds: 200));

    final el = tester.element(find.text(tipText));
    final decorated = el.findAncestorWidgetOfExactType<DecoratedBox>();
    expect(decorated, isNotNull);

    final box = decorated!.decoration as BoxDecoration;
    expect(box.color, equals(UiColors.success600));
  });

  testWidgets('disabled tooltip never shows', (tester) async {
    final k = UniqueKey();

    await tester.pumpWidget(
      _wrap(
        UiTooltip(
          enabled: false,
          message: tipText,
          child: FilledButton(
            key: k,
            onPressed: () {},
            child: const Text('Disabled'),
          ),
        ),
      ),
    );

    await _hoverOver(tester, find.byKey(k));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text(tipText), findsNothing);
  });

  testWidgets('auto placement near bottom still shows', (tester) async {
    await tester.pumpWidget(
      _wrap(
        Padding(
          padding: const EdgeInsets.only(top: 520),
          child: UiTooltip(
            placement: UiTooltipPlacement.auto,
            message: tipText,
            child: const Text('Near bottom'),
          ),
        ),
        size: const Size(800, 600),
      ),
    );

    await _hoverOver(tester, find.text('Near bottom'));
    await tester.pump(const Duration(milliseconds: 360));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text(tipText), findsOneWidget);
  });

  testWidgets('viewport constraint: maxWidth applied', (tester) async {
    await tester.pumpWidget(
      _wrap(
        UiTooltip(
          placement: UiTooltipPlacement.top,
          message: 'x' * 400,
          child: const Text('Long'),
        ),
      ),
    );

    await _hoverOver(tester, find.text('Long'));
    await tester.pump(const Duration(milliseconds: 360));
    await tester.pump(const Duration(milliseconds: 200));

    final el = tester.element(find.textContaining('x'));
    final constrained = el.findAncestorWidgetOfExactType<ConstrainedBox>();
    expect(constrained, isNotNull);
    expect(constrained!.constraints.maxWidth, equals(280.0));
  });

  testWidgets('keyboard: focus highlight shows tooltip', (tester) async {
    await tester.pumpWidget(
      _wrap(
        FocusTraversalGroup(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TextField(), // focusable before
              UiTooltip(message: 'A', child: TextField()),
              TextField(), // focusable after
            ],
          ),
        ),
      ),
    );

    // Focus first TextField, TAB to move forward twice
    await tester.tap(find.byType(TextField).first);
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump(const Duration(milliseconds: 360));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('A'), findsOneWidget);
  });

  testWidgets('mobile long-press shows then hides on release', (tester) async {
    const tipText = 'Hello tooltip!';
    final k = UniqueKey();

    await tester.pumpWidget(
      _wrap(
        UiTooltip(
          message: tipText,
          child: Text('Press', key: k),
        ),
      ),
    );

    // Press and HOLD long enough: system long-press (~500ms) + showDelay (350ms)
    final center = tester.getCenter(find.byKey(k));
    final gesture = await tester.startGesture(center); // finger down
    await tester.pump(const Duration(milliseconds: 600)); // long-press fired
    await tester.pump(const Duration(milliseconds: 360)); // showDelay
    await tester.pump(const Duration(milliseconds: 200)); // show anim
    expect(find.text(tipText), findsOneWidget);

    // Release and fully settle reverse animation + overlay removal.
    await gesture.up();
    await tester.tapAt(const Offset(0, 0));
    await tester.pump(); // schedule frame
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(tipText), findsNothing);
  });

  testWidgets('Tooltips.wrapper aliases text()', (tester) async {
    await tester.pumpWidget(
      _wrap(
        Tooltips.wrapper(
          child: const Text('Wrap'),
          message: tipText,
          placement: UiTooltipPlacement.top,
        ),
      ),
    );

    await _hoverOver(tester, find.text('Wrap'));
    await tester.pump(const Duration(milliseconds: 360));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text(tipText), findsOneWidget);
  });

  testWidgets('Tooltips.popover toggles on tap (text)', (tester) async {
    await tester.pumpWidget(
      _wrap(
        Tooltips.popover(
          child: const Text('Tap me'),
          message: 'POPOVER!',
          placement: UiTooltipPlacement.bottom,
        ),
      ),
    );

    expect(find.text('POPOVER!'), findsNothing);

    // Open
    await tester.tap(find.text('Tap me'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('POPOVER!'), findsOneWidget);

    // Close (use settle for robustness)
    await tester.tap(find.text('Tap me'));
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('POPOVER!'), findsNothing);
  });
}
     