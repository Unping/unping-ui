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
}
