import 'package:flutter/material.dart';

/// Unping-UI spacing system
/// Provides consistent spacing values throughout the design system
class UiSpacing {
  /// Spacing values from Figma design system
  /// Following the scale: 0, 0.5, 1, 2, 3, 4, 5, 6, 8, 10, 12, 16, 20, 24, 32, 40, 48, 56, 64, 80, 96, 120, 140, 160, 180, 192, 256, 320, 360, 400, 480

  /// Zero spacing - 0px
  static const double spacing0 = 0.0;

  /// 0.5 spacing - 2px
  static const double spacing0_5 = 2.0;

  /// 1 spacing - 4px
  static const double spacing1 = 4.0;

  /// 2 spacing - 8px
  static const double spacing2 = 8.0;

  /// 3 spacing - 12px
  static const double spacing3 = 12.0;

  /// 4 spacing - 16px
  static const double spacing4 = 16.0;

  /// 5 spacing - 20px
  static const double spacing5 = 20.0;

  /// 6 spacing - 24px
  static const double spacing6 = 24.0;

  /// 8 spacing - 32px
  static const double spacing8 = 32.0;

  /// 10 spacing - 40px
  static const double spacing10 = 40.0;

  /// 12 spacing - 48px
  static const double spacing12 = 48.0;

  /// 16 spacing - 64px
  static const double spacing16 = 64.0;

  /// 20 spacing - 80px
  static const double spacing20 = 80.0;

  /// 24 spacing - 96px
  static const double spacing24 = 96.0;

  /// 32 spacing - 128px
  static const double spacing32 = 128.0;

  /// 40 spacing - 160px
  static const double spacing40 = 160.0;

  /// 48 spacing - 192px
  static const double spacing48 = 192.0;

  /// 56 spacing - 224px
  static const double spacing56 = 224.0;

  /// 64 spacing - 256px
  static const double spacing64 = 256.0;

  /// 80 spacing - 320px
  static const double spacing80 = 320.0;

  /// 96 spacing - 384px
  static const double spacing96 = 384.0;

  /// 120 spacing - 480px
  static const double spacing120 = 480.0;

  /// 140 spacing - 560px
  static const double spacing140 = 560.0;

  /// 160 spacing - 640px
  static const double spacing160 = 640.0;

  /// 180 spacing - 720px
  static const double spacing180 = 720.0;

  /// 192 spacing - 768px
  static const double spacing192 = 768.0;

  /// 256 spacing - 1024px
  static const double spacing256 = 1024.0;

  /// 320 spacing - 1280px
  static const double spacing320 = 1280.0;

  /// 360 spacing - 1440px
  static const double spacing360 = 1440.0;

  /// 400 spacing - 1600px
  static const double spacing400 = 1600.0;

  /// 480 spacing - 1920px
  static const double spacing480 = 1920.0;

  // Legacy aliases for backward compatibility
  /// Zero spacing - 0px
  static const double zero = spacing0;

  /// Extra extra small spacing - 4px
  static const double xxs = spacing1;

  /// Extra small spacing - 8px
  static const double xs = spacing2;

  /// Small spacing - 12px
  static const double sm = spacing3;

  /// Medium spacing - 16px
  static const double m = spacing4;

  /// Large spacing - 24px
  static const double l = spacing6;

  /// Extra large spacing - 32px
  static const double xl = spacing8;

  /// 2x large spacing - 48px
  static const double xxl = spacing12;

  /// 3x large spacing - 64px
  static const double xxxl = spacing16;

  /// Common edge insets
  static const EdgeInsets allZero = EdgeInsets.all(zero);
  static const EdgeInsets allXxs = EdgeInsets.all(xxs);
  static const EdgeInsets allXs = EdgeInsets.all(xs);
  static const EdgeInsets allSm = EdgeInsets.all(sm);
  static const EdgeInsets allM = EdgeInsets.all(m);
  static const EdgeInsets allL = EdgeInsets.all(l);
  static const EdgeInsets allXl = EdgeInsets.all(xl);
  static const EdgeInsets allXxl = EdgeInsets.all(xxl);
  static const EdgeInsets allXxxl = EdgeInsets.all(xxxl);

  /// Horizontal edge insets
  static const EdgeInsets horizontalZero = EdgeInsets.symmetric(
    horizontal: zero,
  );
  static const EdgeInsets horizontalXxs = EdgeInsets.symmetric(horizontal: xxs);
  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalM = EdgeInsets.symmetric(horizontal: m);
  static const EdgeInsets horizontalL = EdgeInsets.symmetric(horizontal: l);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);
  static const EdgeInsets horizontalXxl = EdgeInsets.symmetric(horizontal: xxl);
  static const EdgeInsets horizontalXxxl = EdgeInsets.symmetric(
    horizontal: xxxl,
  );

  /// Vertical edge insets
  static const EdgeInsets verticalZero = EdgeInsets.symmetric(vertical: zero);
  static const EdgeInsets verticalXxs = EdgeInsets.symmetric(vertical: xxs);
  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalM = EdgeInsets.symmetric(vertical: m);
  static const EdgeInsets verticalL = EdgeInsets.symmetric(vertical: l);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);
  static const EdgeInsets verticalXxl = EdgeInsets.symmetric(vertical: xxl);
  static const EdgeInsets verticalXxxl = EdgeInsets.symmetric(vertical: xxxl);

  /// Only edge insets
  static const EdgeInsets onlyTopZero = EdgeInsets.only(top: zero);
  static const EdgeInsets onlyTopXxs = EdgeInsets.only(top: xxs);
  static const EdgeInsets onlyTopXs = EdgeInsets.only(top: xs);
  static const EdgeInsets onlyTopSm = EdgeInsets.only(top: sm);
  static const EdgeInsets onlyTopM = EdgeInsets.only(top: m);
  static const EdgeInsets onlyTopL = EdgeInsets.only(top: l);
  static const EdgeInsets onlyTopXl = EdgeInsets.only(top: xl);
  static const EdgeInsets onlyTopXxl = EdgeInsets.only(top: xxl);
  static const EdgeInsets onlyTopXxxl = EdgeInsets.only(top: xxxl);

  static const EdgeInsets onlyBottomZero = EdgeInsets.only(bottom: zero);
  static const EdgeInsets onlyBottomXxs = EdgeInsets.only(bottom: xxs);
  static const EdgeInsets onlyBottomXs = EdgeInsets.only(bottom: xs);
  static const EdgeInsets onlyBottomSm = EdgeInsets.only(bottom: sm);
  static const EdgeInsets onlyBottomM = EdgeInsets.only(bottom: m);
  static const EdgeInsets onlyBottomL = EdgeInsets.only(bottom: l);
  static const EdgeInsets onlyBottomXl = EdgeInsets.only(bottom: xl);
  static const EdgeInsets onlyBottomXxl = EdgeInsets.only(bottom: xxl);
  static const EdgeInsets onlyBottomXxxl = EdgeInsets.only(bottom: xxxl);

  static const EdgeInsets onlyLeftZero = EdgeInsets.only(left: zero);
  static const EdgeInsets onlyLeftXxs = EdgeInsets.only(left: xxs);
  static const EdgeInsets onlyLeftXs = EdgeInsets.only(left: xs);
  static const EdgeInsets onlyLeftSm = EdgeInsets.only(left: sm);
  static const EdgeInsets onlyLeftM = EdgeInsets.only(left: m);
  static const EdgeInsets onlyLeftL = EdgeInsets.only(left: l);
  static const EdgeInsets onlyLeftXl = EdgeInsets.only(left: xl);
  static const EdgeInsets onlyLeftXxl = EdgeInsets.only(left: xxl);
  static const EdgeInsets onlyLeftXxxl = EdgeInsets.only(left: xxxl);

  static const EdgeInsets onlyRightZero = EdgeInsets.only(right: zero);
  static const EdgeInsets onlyRightXxs = EdgeInsets.only(right: xxs);
  static const EdgeInsets onlyRightXs = EdgeInsets.only(right: xs);
  static const EdgeInsets onlyRightSm = EdgeInsets.only(right: sm);
  static const EdgeInsets onlyRightM = EdgeInsets.only(right: m);
  static const EdgeInsets onlyRightL = EdgeInsets.only(right: l);
  static const EdgeInsets onlyRightXl = EdgeInsets.only(right: xl);
  static const EdgeInsets onlyRightXxl = EdgeInsets.only(right: xxl);
  static const EdgeInsets onlyRightXxxxl = EdgeInsets.only(right: xxxl);

  /// SizedBox spacing helpers
  static const SizedBox gapZero = SizedBox(height: zero, width: zero);
  static const SizedBox gapXxs = SizedBox(height: xxs, width: xxs);
  static const SizedBox gapXs = SizedBox(height: xs, width: xs);
  static const SizedBox gapSm = SizedBox(height: sm, width: sm);
  static const SizedBox gapM = SizedBox(height: m, width: m);
  static const SizedBox gapL = SizedBox(height: l, width: l);
  static const SizedBox gapXl = SizedBox(height: xl, width: xl);
  static const SizedBox gapXxl = SizedBox(height: xxl, width: xxl);
  static const SizedBox gapXxxl = SizedBox(height: xxxl, width: xxxl);

  /// Vertical gaps
  static const SizedBox verticalGapZero = SizedBox(height: zero);
  static const SizedBox verticalGapXxs = SizedBox(height: xxs);
  static const SizedBox verticalGapXs = SizedBox(height: xs);
  static const SizedBox verticalGapSm = SizedBox(height: sm);
  static const SizedBox verticalGapM = SizedBox(height: m);
  static const SizedBox verticalGapL = SizedBox(height: l);
  static const SizedBox verticalGapXl = SizedBox(height: xl);
  static const SizedBox verticalGapXxl = SizedBox(height: xxl);
  static const SizedBox verticalGapXxxl = SizedBox(height: xxxl);

  /// Horizontal gaps
  static const SizedBox horizontalGapZero = SizedBox(width: zero);
  static const SizedBox horizontalGapXxs = SizedBox(width: xxs);
  static const SizedBox horizontalGapXs = SizedBox(width: xs);
  static const SizedBox horizontalGapSm = SizedBox(width: sm);
  static const SizedBox horizontalGapM = SizedBox(width: m);
  static const SizedBox horizontalGapL = SizedBox(width: l);
  static const SizedBox horizontalGapXl = SizedBox(width: xl);
  static const SizedBox horizontalGapXxl = SizedBox(width: xxl);
  static const SizedBox horizontalGapXxxl = SizedBox(width: xxxl);
}

/// Theme extension for spacing system
/// Provides access to spacing values through the theme system
class UiSpacingExtension extends ThemeExtension<UiSpacingExtension> {
  const UiSpacingExtension();

  static const light = UiSpacingExtension();
  static const dark = UiSpacingExtension();

  @override
  ThemeExtension<UiSpacingExtension> copyWith() {
    return const UiSpacingExtension();
  }

  @override
  ThemeExtension<UiSpacingExtension> lerp(
    ThemeExtension<UiSpacingExtension>? other,
    double t,
  ) {
    return const UiSpacingExtension();
  }
}

/// Extension on BuildContext to easily access spacing values
extension UiSpacingContext on BuildContext {
  UiSpacingExtension get UiSpacing =>
      Theme.of(this).extension<UiSpacingExtension>() ??
      UiSpacingExtension.light;
}
