// dart format width=80
import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

//   enable real golden checks after you generate baselines.
const bool kSkipGoldens = false;

/// Minimal test theme with Unping extensions so tokens resolve.
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

/// Wraps the widget in a predictable environment for tests/goldens.
Widget _wrap(Widget child, {Size size = const Size(800, 600)}) {
  return MaterialApp(
    theme: _testTheme(),
    home: MediaQuery(
      data: MediaQueryData(
        size: size,
        devicePixelRatio: 1.0,
        textScaler: const TextScaler.linear(1.0),
      ),
      child: Scaffold(body: Center(child: child)),
    ),
  );
}

Future<TestGesture> _hoverOver(
    WidgetTester tester,
    Finder target, {
      Offset? at,
    }) async {
  final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
  await gesture.addPointer();
  addTearDown(() => gesture.removePointer());
  final offset = at ?? tester.getCenter(target);
  await gesture.moveTo(offset);
  await tester.pump();
  return gesture;
}

/// 350ms delay + a bit of show animation
Future<void> _showTooltipAndSettle(
    WidgetTester tester,
    Finder trigger,
    ) async {
  await _hoverOver(tester, trigger);
  await tester.pump(const Duration(milliseconds: 360));
  await tester.pump(const Duration(milliseconds: 200));
}

Future<void> _expectGoldenOrSkip(
    WidgetTester tester,
    String path,
    ) async {
  if (kSkipGoldens) {
    // Smoke assertion so the test still asserts something meaningful.
    expect(find.byType(MaterialApp), findsOneWidget);
  } else {
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile(path),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UiTooltip golden', () {
    testWidgets('top / neutral', (tester) async {
      await tester.pumpWidget(
        _wrap(
          UiTooltip(
            placement: UiTooltipPlacement.top,
            variant: UiTooltipVariant.neutral,
            message: 'Tooltip – top / neutral',
            child: const Text('Target'),
          ),
        ),
      );

      await _showTooltipAndSettle(tester, find.text('Target'));
      await _expectGoldenOrSkip(
        tester,
        'goldens/tooltip_top_neutral.png',
      );
    });

    testWidgets('bottom / info', (tester) async {
      await tester.pumpWidget(
        _wrap(
          UiTooltip(
            placement: UiTooltipPlacement.bottom,
            variant: UiTooltipVariant.info,
            message: 'Tooltip – bottom / info',
            child: const Text('Info'),
          ),
        ),
      );

      await _showTooltipAndSettle(tester, find.text('Info'));
      await _expectGoldenOrSkip(
        tester,
        'goldens/tooltip_bottom_info.png',
      );
    });

    testWidgets('left / success', (tester) async {
      await tester.pumpWidget(
        _wrap(
          UiTooltip(
            placement: UiTooltipPlacement.left,
            variant: UiTooltipVariant.success,
            message: 'Tooltip – left / success',
            child: const Text('Success'),
          ),
        ),
      );

      await _showTooltipAndSettle(tester, find.text('Success'));
      await _expectGoldenOrSkip(
        tester,
        'goldens/tooltip_left_success.png',
      );
    });

    testWidgets('right / warning', (tester) async {
      await tester.pumpWidget(
        _wrap(
          UiTooltip(
            placement: UiTooltipPlacement.right,
            variant: UiTooltipVariant.warning,
            message: 'Tooltip – right / warning',
            child: const Text('Warning'),
          ),
        ),
      );

      await _showTooltipAndSettle(tester, find.text('Warning'));
      await _expectGoldenOrSkip(
        tester,
        'goldens/tooltip_right_warning.png',
      );
    });

    testWidgets('auto / error with long text near bottom edge', (tester) async {
      await tester.pumpWidget(
        _wrap(
          Padding(
            padding: const EdgeInsets.only(top: 520),
            child: UiTooltip(
              placement: UiTooltipPlacement.auto,
              variant: UiTooltipVariant.error,
              message:
              'Very long tooltip that wraps within a constrained max '
                  'width to stay readable across small viewports.',
              child: const Text('Auto near bottom'),
            ),
          ),
          size: const Size(800, 600),
        ),
      );

      await _showTooltipAndSettle(tester, find.text('Auto near bottom'));
      await _expectGoldenOrSkip(
        tester,
        'goldens/tooltip_auto_error_long.png',
      );
    });

    testWidgets('rich() content golden', (tester) async {
      await tester.pumpWidget(
        _wrap(
          Tooltips.rich(
            child: const Text('Rich Target'),
            message: 'Semantics label',
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.info, size: 16, color: Colors.white),
                SizedBox(width: 8),
                Text('Rich tooltip', style: TextStyle(color: Colors.white)),
              ],
            ),
            placement: UiTooltipPlacement.top,
            variant: UiTooltipVariant.info,
          ),
        ),
      );

      await _showTooltipAndSettle(tester, find.text('Rich Target'));
      await _expectGoldenOrSkip(
        tester,
        'goldens/tooltip_rich_info.png',
      );
    });

    testWidgets('popover() golden', (tester) async {
      await tester.pumpWidget(
        _wrap(
          Tooltips.popover(
            child: const Text('Click me'),
            message: 'Popover content',
            variant: UiTooltipVariant.neutral,
            placement: UiTooltipPlacement.bottom,
          ),
        ),
      );

      await tester.tap(find.text('Click me'));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 200));
      await _expectGoldenOrSkip(
        tester,
        'goldens/tooltip_popover_neutral.png',
      );
    });
  });
}

