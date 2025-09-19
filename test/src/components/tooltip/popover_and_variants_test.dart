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

const _fast = UiTooltipStyle(
  background: Colors.black,
  textStyle: TextStyle(color: Colors.white, fontSize: 12),
  showDelay: Duration(milliseconds: 1),
  showDuration: Duration(milliseconds: 1),
  hideDuration: Duration(milliseconds: 1),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('popover_tooltip.dart | PopoverTooltip', () {
    testWidgets('focus highlight path (show/hide)', (tester) async {
      final node = FocusNode();
      await tester.pumpWidget(_wrap(PopoverTooltip(
        message: 'POP',
        style: _fast,
        child: Focus(
            focusNode: node, child: const SizedBox(width: 48, height: 24)),
      )));

      // Triggers onShowFocusHighlight(true) -> show
      node.requestFocus();
      await tester.pump(const Duration(milliseconds: 2));

      // Triggers onShowFocusHighlight(false) -> hide
      node.unfocus();
      await tester.pump(const Duration(milliseconds: 2));
      node.dispose();
    });
  });

  group('tooltip_variants.dart | Tooltips factories', () {
    testWidgets('constructors build', (tester) async {
      await tester.pumpWidget(_wrap(Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltips.text(child: const Text('t1'), message: 'm', style: _fast),
          Tooltips.rich(
              child: const Text('t2'),
              message: 'm2',
              content: const Text('rich'),
              style: _fast),
          Tooltips.wrapper(
              child: const Text('t3'), message: 'm3', style: _fast),
          Tooltips.neutral(child: const Text('n'), message: 'mn', style: _fast),
          Tooltips.info(child: const Text('i'), message: 'mi', style: _fast),
          Tooltips.success(child: const Text('s'), message: 'ms', style: _fast),
          Tooltips.warning(child: const Text('w'), message: 'mw', style: _fast),
          Tooltips.error(child: const Text('e'), message: 'me', style: _fast),
          Tooltips.popover(child: const Text('p'), message: 'mp', style: _fast),
        ],
      )));
      await tester.pump(const Duration(milliseconds: 2));

      expect(find.text('t1'), findsOneWidget);
      expect(find.text('p'), findsOneWidget);
    });
  });
}
