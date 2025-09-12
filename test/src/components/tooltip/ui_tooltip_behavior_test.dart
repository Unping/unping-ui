// dart format width=80
import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

Widget _wrap(Widget child, {Size size = const Size(800, 600)}) {
  return MaterialApp(
    theme: UiTheme.lightTheme(),
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

    // move away -> hides
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

  testWidgets('auto placement shows overlay near screen edge', (tester) async {
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
}
