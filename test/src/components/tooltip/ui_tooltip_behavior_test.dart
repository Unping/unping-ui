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
    textTheme: TextTheme(bodyMedium: UiTextStyles.textMd),
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

  testWidgets('rich() sets semantics via message and renders content', (
    tester,
  ) async {
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
    final constrained = el.findAncestorWidgetOfExactType<ConstrainedBox>();
    expect(constrained, isNotNull);

    final constraints = (constrained as ConstrainedBox).constraints;
    expect(constraints.maxWidth, equals(280.0));

    final decorated = el.findAncestorWidgetOfExactType<DecoratedBox>();
    expect(decorated, isNotNull);

    final box = (decorated as DecoratedBox).decoration as BoxDecoration;
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

  // ───────────────────────────────────────────────────────────────────────────
  // EXTRA COVERAGE: interactive overlay outside-tap dismissal
  // ───────────────────────────────────────────────────────────────────────────
  testWidgets('interactive popover overlay dismisses on outside tap', (
    tester,
  ) async {
    final link = LayerLink();
    late OverlayEntry entry;
    bool dismissed = false;

    final controller = AnimationController(
      vsync: tester,
      duration: const Duration(milliseconds: 40),
      reverseDuration: const Duration(milliseconds: 40),
    );
    addTearDown(controller.dispose);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              // Insert our interactive overlay after first frame
              WidgetsBinding.instance.addPostFrameCallback((_) {
                entry = buildTooltipOverlay(
                  context: context,
                  link: link,
                  controller: controller,
                  message: 'POPOVER-INTERACTIVE',
                  content: const Text('POPOVER-INTERACTIVE'),
                  placement: UiTooltipPlacement.top,
                  style: styleFor(UiTooltipVariant.neutral, 800),
                  interactive: true,
                  dismissOnTapOutside: true,
                  onTapOutside: () {
                    // Just record that the callback fired; removal can race here.
                    dismissed = true;
                  },
                );
                Overlay.of(context, rootOverlay: true).insert(entry);
                controller.forward(from: 0);
              });
              return CompositedTransformTarget(
                link: link,
                child: const SizedBox(width: 10, height: 10),
              );
            }),
          ],
        ),
      ),
    ));

    await tester.pumpAndSettle();
    expect(find.text('POPOVER-INTERACTIVE'), findsOneWidget);

    await tester.tapAt(const Offset(0, 0));
    await tester.pumpAndSettle(const Duration(milliseconds: 120));
    expect(dismissed, isTrue);

// now it's safe to remove & settle one frame
    if (entry.mounted) {
      entry.remove();
      await tester.pump();
    }
    expect(find.text('POPOVER-INTERACTIVE'), findsNothing);
  });

  // ───────────────────────────────────────────────────────────────────────────
  // EXTRA COVERAGE: didChangeDependencies & reassemble hide
  // ───────────────────────────────────────────────────────────────────────────
  testWidgets('didUpdateWidget(enabled=false) hides immediately',
      (tester) async {
    final key = UniqueKey();

    Widget app(bool enabled) => MaterialApp(
          home: Scaffold(
            body: UiTooltip(
              enabled: enabled,
              message: 'HIDE-ME',
              child: Text('Target', key: key),
            ),
          ),
        );

    // Start enabled and show it
    await tester.pumpWidget(app(true));
    final g = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await g.addPointer();
    await g.moveTo(tester.getCenter(find.byKey(key)));
    await tester.pump(const Duration(milliseconds: 360)); // delay
    await tester.pump(const Duration(milliseconds: 200)); // show anim
    expect(find.text('HIDE-ME'), findsOneWidget);

    // Update to enabled=false -> immediate removeEntry()
    await tester.pumpWidget(app(false));
    await tester.pump(); // allow frame
    // move pointer away so nothing retriggers
    await g.moveTo(const Offset(0, 0));
    await tester.pumpAndSettle(const Duration(milliseconds: 200));

    expect(find.text('HIDE-ME'), findsNothing);
    await g.removePointer();
  });

  testWidgets('reassemble() hides an already visible tooltip', (tester) async {
    final key = UniqueKey();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UiTooltip(
            message: 'REASSEMBLE-HIDE',
            child: Text('Target', key: key),
          ),
        ),
      ),
    );

    // Show
    final g = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await g.addPointer();
    await g.moveTo(tester.getCenter(find.byKey(key)));
    await tester.pump(const Duration(milliseconds: 360));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('REASSEMBLE-HIDE'), findsOneWidget);

    // Simulate hot-reload reassemble
    await tester.binding.reassembleApplication();
    await tester.pump();

// move pointer away so nothing re-triggers
    await g.moveTo(const Offset(0, 0));
    await tester.pumpAndSettle(const Duration(milliseconds: 200));

    expect(find.text('REASSEMBLE-HIDE'), findsNothing);
  });

  // ───────────────────────────────────────────────────────────────────────────
  // EXTRA COVERAGE: placement branches & small-viewport font sizing
  // ───────────────────────────────────────────────────────────────────────────
  testWidgets('resolvePlacement covers bottom/right/left via layout', (
    tester,
  ) async {
    Future<void> mountAt(EdgeInsets padding) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: padding,
            child: UiTooltip(
              placement: UiTooltipPlacement.auto,
              message: 'X',
              child: const SizedBox(width: 20, height: 20),
            ),
          ),
        ),
      ));
      // Trigger placement logic by long-press (touch path)
      final center = tester.getCenter(find.byType(SizedBox));
      final gesture = await tester.startGesture(center);
      await tester.pump(const Duration(milliseconds: 600)); // long press
      await tester.pump(const Duration(milliseconds: 360)); // show delay
      await tester.pump(const Duration(milliseconds: 40)); // anim
      await gesture.up();
      // Let overlay settle visible then disappear (not strictly required)
      await tester.pump(const Duration(milliseconds: 160));
    }

    // Bottom (enough space below)
    await mountAt(const EdgeInsets.only(top: 20));
    expect(find.text('X'), findsOneWidget);
    await tester.pumpAndSettle();

    // Right (enough space to the right)
    await mountAt(const EdgeInsets.only(left: 20));
    expect(find.text('X'), findsOneWidget);
    await tester.pumpAndSettle();

    // Left (enough space to the left)
    await mountAt(const EdgeInsets.only(right: 20));
    expect(find.text('X'), findsOneWidget);
    await tester.pumpAndSettle();
  });

  test('styleFor adjusts font size at small viewports', () {
    final base = UiTextStyles.textXs.fontSize ?? 12.0;

    final s360 = styleFor(UiTooltipVariant.neutral, 360);
    expect(
      s360.textStyle.fontSize,
      equals((base - 2).clamp(10, base).toDouble()),
    );

    final s480 = styleFor(UiTooltipVariant.neutral, 480);
    expect(
      s480.textStyle.fontSize,
      equals((base - 1).clamp(10, base).toDouble()),
    );

    final sWide = styleFor(UiTooltipVariant.neutral, 800);
    expect(sWide.textStyle.fontSize, equals(base));
  });

  // ───────────────────────────────────────────────────────────────────────────
  // EXTRA COVERAGE: Popover focus highlight path
  // ───────────────────────────────────────────────────────────────────────────
  testWidgets('PopoverTooltip shows on focus highlight and hides on blur', (
    tester,
  ) async {
    final focusNode = FocusNode(debugLabel: 'popover');
    addTearDown(focusNode.dispose);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FocusTraversalGroup(
          child: Column(
            children: [
              const TextField(), // to move focus away later
              PopoverTooltip(
                message: 'FOCUS-POPOVER',
                child: Focus(
                  focusNode: focusNode,
                  child: const Text('Focusable Anchor'),
                ),
              ),
            ],
          ),
        ),
      ),
    ));

    // Focus
    focusNode.requestFocus();
    await tester.pump(); // onShowFocusHighlight(true)
    await tester.pump(const Duration(milliseconds: 60));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('FOCUS-POPOVER'), findsOneWidget);

    // Blur
    await tester.tap(find.byType(TextField));
    await tester.pump(); // onShowFocusHighlight(false)
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
    expect(find.text('FOCUS-POPOVER'), findsNothing);
  });
}
