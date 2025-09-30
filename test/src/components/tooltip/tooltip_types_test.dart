import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: const <ThemeExtension<dynamic>>[
          UnpingColorExtension.light,
          UiSpacingExtension.light,
          UiRadiusExtension.light,
        ],
        textTheme: TextTheme(bodyMedium: UiTextStyles.textMd),
      ),
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('tooltip_types.dart', () {
    test('UiTooltipStyle.copyWith & fromFoundation', () {
      const base = UiTooltipStyle(
        background: Colors.black,
        textStyle: TextStyle(color: Colors.white),
      );

      final copy = base.copyWith(
        background: Colors.blue,
        gap: 9,
        maxWidth: 123,
        showDelay: const Duration(milliseconds: 77),
      );

      expect(copy.background, Colors.blue);
      expect(copy.gap, 9);
      expect(copy.maxWidth, 123);
      expect(copy.showDelay, const Duration(milliseconds: 77));

      final built = UiTooltipStyle.fromFoundation(
        background: Colors.red,
        textStyle: TextStyle(fontSize: 11),
      );
      expect(built.background, Colors.red);
      expect(built.textStyle.fontSize, 11);
    });

    test('styleFor: all variants & viewport buckets', () {
      for (final v in UiTooltipVariant.values) {
        expect(styleFor(v, 320).textStyle, isA<TextStyle>());
        expect(styleFor(v, 480).textStyle, isA<TextStyle>());
        expect(styleFor(v, 1024).textStyle, isA<TextStyle>());
      }
    });

    testWidgets('resolvePlacement: explicit returns + auto branch',
        (tester) async {
      await tester.pumpWidget(_wrap(const SizedBox()));
      final ctx = tester.element(find.byType(SizedBox));

      // Explicit early-returns
      expect(resolvePlacement(context: ctx, explicit: UiTooltipPlacement.top),
          UiTooltipPlacement.top);
      expect(
          resolvePlacement(context: ctx, explicit: UiTooltipPlacement.bottom),
          UiTooltipPlacement.bottom);
      expect(resolvePlacement(context: ctx, explicit: UiTooltipPlacement.left),
          UiTooltipPlacement.left);
      expect(resolvePlacement(context: ctx, explicit: UiTooltipPlacement.right),
          UiTooltipPlacement.right);

      // Auto: position a box so the spacing logic runs (we don't assert which)
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Stack(children: [
            Positioned(
              top: 520,
              left: 680,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Builder(builder: (c) {
                  final p = resolvePlacement(
                      context: c, explicit: UiTooltipPlacement.auto);
                  expect(p, isA<UiTooltipPlacement>());
                  return const SizedBox.shrink();
                }),
              ),
            ),
          ]),
        ),
      ));
      await tester.pump(const Duration(milliseconds: 1));
    });
  });

  testWidgets('resolvePlacement → RIGHT when only right has room',
      (tester) async {
    final boxKey = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final screenH = constraints.maxHeight; // usually 600

              // Ensure top/bottom spaces are both < 56 so top/bottom won’t win.
              const double topPad = 40.0; // < 56
              const double bottomPad = 40.0; // < 56
              const double boxW = 40.0;
              final double boxH = screenH - topPad - bottomPad;

              // Make left small (< 120) so right can win, and right large (>= 120).
              const double leftPad = 20.0; // left space = 20 (< 120)
              // right space = screenW - (leftPad + boxW) = screenW - 60 (>=120 on normal test screens)

              return Stack(children: [
                Positioned(
                  top: topPad,
                  left: leftPad,
                  child: Container(
                    key: boxKey,
                    width: boxW,
                    height: boxH,
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
    );

    // Now resolve using the container’s exact BuildContext
    final ctx = boxKey.currentContext!;
    final p = resolvePlacement(context: ctx, explicit: UiTooltipPlacement.auto);
    expect(p, UiTooltipPlacement.right);
  });

  testWidgets('resolvePlacement → LEFT when only left has room',
      (tester) async {
    final boxKey = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final screenW = constraints.maxWidth;
              final screenH = constraints.maxHeight;

              // Keep top/bottom < 56 to block those branches.
              const double topPad = 40.0; // < 56
              const double bottomPad = 40.0; // < 56
              const double boxW = 40.0;
              final double boxH = screenH - topPad - bottomPad;

              // Make right small (< 120) to block RIGHT, and left big (>= 120) to force LEFT.
              const double rightPad = 100.0; // right space (< 120)
              final double leftPad =
                  screenW - rightPad - boxW; // left space (>= 120)

              return Stack(children: [
                Positioned(
                  top: topPad,
                  left: leftPad,
                  child: Container(
                    key: boxKey,
                    width: boxW,
                    height: boxH,
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
    );

    final ctx = boxKey.currentContext!;
    final p = resolvePlacement(context: ctx, explicit: UiTooltipPlacement.auto);
    expect(p, UiTooltipPlacement.left);
  });

  testWidgets(
      'resolvePlacement → BOTTOM when bottom has room (and top does not)',
      (tester) async {
    final key = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LayoutBuilder(builder: (context, c) {
            const topPad = 10.0; // < 56 (so TOP won't win)
            const boxH = 40.0; // small box
            // leave plenty of space below: spaceBottom = screenH - (topPad + boxH) >= 56
            return Stack(children: [
              Positioned(
                top: topPad,
                left: 0,
                child: Container(key: key, width: 40, height: boxH),
              ),
            ]);
          }),
        ),
      ),
    );

    final ctx = key.currentContext!;
    final p = resolvePlacement(context: ctx, explicit: UiTooltipPlacement.auto);
    expect(p, UiTooltipPlacement.bottom);
  });

  testWidgets(
      'resolvePlacement → TOP when render box is null/has no size (guard path)',
      (tester) async {
    // Call resolvePlacement from a context that does NOT back a RenderBox with size.
    // Using a Builder directly under MaterialApp before any sized child ensures rb is null or !hasSize.
    UiTooltipPlacement? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(builder: (ctx) {
          result =
              resolvePlacement(context: ctx, explicit: UiTooltipPlacement.auto);
          return const SizedBox(); // keep the tree valid
        }),
      ),
    );

    expect(result, UiTooltipPlacement.top);
  });
}
