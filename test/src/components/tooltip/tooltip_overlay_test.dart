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
      home: Scaffold(
        body: Overlay(initialEntries: [
          OverlayEntry(builder: (_) => Center(child: child))
        ]),
      ),
    );

const _fast = UiTooltipStyle(
  background: Colors.black,
  textStyle: TextStyle(color: Colors.white, fontSize: 12),
  showDelay: Duration(milliseconds: 1),
  showDuration: Duration(milliseconds: 1),
  hideDuration: Duration(milliseconds: 1),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<(BuildContext, LayerLink, OverlayState)> _host(WidgetTester t) async {
    final link = LayerLink();
    await t.pumpWidget(_wrap(CompositedTransformTarget(
      link: link,
      child: const SizedBox(width: 24, height: 24),
    )));
    final ctx = t.element(find.byType(SizedBox));
    final overlay = Overlay.of(ctx, rootOverlay: true);
    return (ctx, link, overlay);
  }

  group('tooltip_overlay.dart', () {
    testWidgets('non-interactive overlay inserts/removes', (tester) async {
      final (ctx, link, overlay) = await _host(tester);

      final controller = AnimationController(
        vsync: tester,
        duration: const Duration(milliseconds: 1),
        reverseDuration: const Duration(milliseconds: 1),
      );

      final entry = buildTooltipOverlay(
        context: ctx,
        link: link,
        controller: controller,
        message: 'MSG',
        placement: UiTooltipPlacement.top,
        style: _fast,
        interactive: false,
      );

      overlay.insert(entry);
      await tester.pump(const Duration(milliseconds: 2));
      expect(entry.mounted, isTrue);

      entry.remove();
      await tester.pump(const Duration(milliseconds: 1));
      expect(entry.mounted, isFalse);
      controller.dispose();
    });

    testWidgets('interactive overlay: dismissOnTapOutside triggers callback',
        (tester) async {
      final (ctx, link, overlay) = await _host(tester);

      var dismissed = false;
      final controller = AnimationController(
        vsync: tester,
        duration: const Duration(milliseconds: 1),
        reverseDuration: const Duration(milliseconds: 1),
      );

      final entry = buildTooltipOverlay(
        context: ctx,
        link: link,
        controller: controller,
        message: 'IO',
        placement: UiTooltipPlacement.bottom,
        style: _fast,
        interactive: true,
        dismissOnTapOutside: true,
        onTapOutside: () => dismissed = true,
      );

      overlay.insert(entry);
      await tester.pump(const Duration(milliseconds: 2));

      // Tap near (1,1) to hit the translucent GestureDetector surface
      await tester.tapAt(const Offset(1, 1));
      await tester.pump(const Duration(milliseconds: 1));
      expect(dismissed, isTrue);

      entry.remove();
      await tester.pump(const Duration(milliseconds: 1));
      controller.dispose();
    });

    testWidgets('overlay builds for all placements', (tester) async {
      final (ctx, link, overlay) = await _host(tester);

      final controller = AnimationController(
        vsync: tester,
        duration: const Duration(milliseconds: 1),
        reverseDuration: const Duration(milliseconds: 1),
      );

      for (final p in UiTooltipPlacement.values) {
        final entry = buildTooltipOverlay(
          context: ctx,
          link: link,
          controller: controller,
          message: 'PLACED',
          placement: p,
          style: _fast,
          interactive: false,
        );
        overlay.insert(entry);
        await tester.pump(const Duration(milliseconds: 1));
        expect(entry.mounted, isTrue);
        entry.remove();
        await tester.pump(const Duration(milliseconds: 1));
      }

      controller.dispose();
    });
  });
}
