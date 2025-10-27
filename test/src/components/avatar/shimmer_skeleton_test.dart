import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/src/components/avatar/shimmer_skeleton.dart';

// Import your ShimmerSkeleton widget file here
// import 'package:your_app/shimmer_skeleton.dart';

void main() {
  group('ShimmerSkeleton Widget Tests', () {
    testWidgets('should render without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ShimmerSkeleton(
            baseColor: Color(0xFFE0E0E0),
            highlightColor: Color(0xFFF5F5F5),
          ),
        ),
      );

      expect(find.byType(ShimmerSkeleton), findsOneWidget);
      expect(find.byType(AnimatedBuilder), findsOneWidget);
      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should accept custom colors', (WidgetTester tester) async {
      const customBaseColor = Color(0xFF123456);
      const customHighlightColor = Color(0xFF789ABC);

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ShimmerSkeleton(
            baseColor: customBaseColor,
            highlightColor: customHighlightColor,
          ),
        ),
      );

      final shimmerWidget = tester.widget<ShimmerSkeleton>(
        find.byType(ShimmerSkeleton),
      );

      expect(shimmerWidget.baseColor, customBaseColor);
      expect(shimmerWidget.highlightColor, customHighlightColor);
    });

    testWidgets('should animate over time', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ShimmerSkeleton(
            baseColor: Color(0xFFE0E0E0),
            highlightColor: Color(0xFFF5F5F5),
          ),
        ),
      );

      // Verify AnimatedBuilder is present and rebuilding
      expect(find.byType(AnimatedBuilder), findsOneWidget);

      // Pump frames to verify animation is running without errors
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 500));

      // No exceptions should have been thrown
      expect(tester.takeException(), isNull);
    });

    testWidgets('should complete animation cycle without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ShimmerSkeleton(
            baseColor: Color(0xFFE0E0E0),
            highlightColor: Color(0xFFF5F5F5),
          ),
        ),
      );

      // Complete one full animation cycle (1400ms)
      await tester.pump(const Duration(milliseconds: 1400));
      expect(tester.takeException(), isNull);

      // Continue to next cycle
      await tester.pump(const Duration(milliseconds: 1400));
      expect(tester.takeException(), isNull);
    });

    testWidgets('should dispose cleanly without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ShimmerSkeleton(
            baseColor: Color(0xFFE0E0E0),
            highlightColor: Color(0xFFF5F5F5),
          ),
        ),
      );

      expect(find.byType(ShimmerSkeleton), findsOneWidget);

      // Remove widget to trigger dispose
      await tester.pumpWidget(const SizedBox.shrink());

      // Controller should be disposed without errors
      expect(tester.takeException(), isNull);
      expect(find.byType(ShimmerSkeleton), findsNothing);
    });

    testWidgets('should rebuild with different colors',
        (WidgetTester tester) async {
      const initialBaseColor = Color(0xFFE0E0E0);
      const initialHighlightColor = Color(0xFFF5F5F5);

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ShimmerSkeleton(
            baseColor: initialBaseColor,
            highlightColor: initialHighlightColor,
          ),
        ),
      );

      var shimmerWidget = tester.widget<ShimmerSkeleton>(
        find.byType(ShimmerSkeleton),
      );

      expect(shimmerWidget.baseColor, initialBaseColor);
      expect(shimmerWidget.highlightColor, initialHighlightColor);

      // Rebuild with new colors
      const newBaseColor = Color(0xFF000000);
      const newHighlightColor = Color(0xFFFFFFFF);

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ShimmerSkeleton(
            baseColor: newBaseColor,
            highlightColor: newHighlightColor,
          ),
        ),
      );

      shimmerWidget = tester.widget<ShimmerSkeleton>(
        find.byType(ShimmerSkeleton),
      );

      expect(shimmerWidget.baseColor, newBaseColor);
      expect(shimmerWidget.highlightColor, newHighlightColor);
    });

    testWidgets('should use BlendMode.srcATop for ShaderMask',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ShimmerSkeleton(
            baseColor: Color(0xFFE0E0E0),
            highlightColor: Color(0xFFF5F5F5),
          ),
        ),
      );

      final shaderMask = tester.widget<ShaderMask>(
        find.byType(ShaderMask),
      );

      expect(shaderMask.blendMode, BlendMode.srcATop);
    });
  });

  group('GradientTranslation Tests', () {
    test('should create Matrix4 with correct translation', () {
      const translation = GradientTranslation(100.0, 50.0);
      final rect = const Rect.fromLTWH(0, 0, 200, 100);

      final matrix = translation.transform(rect);

      expect(matrix, isNotNull);
      expect(matrix!.getTranslation().x, 100.0);
      expect(matrix.getTranslation().y, 50.0);
    });

    test('should handle negative translation values', () {
      const translation = GradientTranslation(-50.0, -25.0);
      final rect = const Rect.fromLTWH(0, 0, 200, 100);

      final matrix = translation.transform(rect);

      expect(matrix, isNotNull);
      expect(matrix!.getTranslation().x, -50.0);
      expect(matrix.getTranslation().y, -25.0);
    });

    test('should handle zero translation', () {
      const translation = GradientTranslation(0.0, 0.0);
      final rect = const Rect.fromLTWH(0, 0, 200, 100);

      final matrix = translation.transform(rect);

      expect(matrix, isNotNull);
      expect(matrix!.getTranslation().x, 0.0);
      expect(matrix.getTranslation().y, 0.0);
    });
  });
}
