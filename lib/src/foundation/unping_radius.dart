import 'package:flutter/material.dart';

/// Unping-UI border radius system
/// Provides consistent border radius values throughout the design system
class UnpingRadius {
  /// No radius
  static const double none = 0.0;

  /// Extra small radius - 4px
  static const double xs = 4.0;

  /// Small radius - 8px
  static const double sm = 8.0;

  /// Medium radius - 12px
  static const double md = 12.0;

  /// Large radius - 16px
  static const double lg = 16.0;

  /// Extra large radius - 28px
  static const double xl = 28.0;

  /// 2x large radius - 32px
  static const double xxl = 32.0;

  /// Full radius - creates circular/pill shape
  static const double full = 999.0;

  /// Common border radius values
  static const BorderRadius allNone = BorderRadius.all(Radius.circular(none));
  static const BorderRadius allXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius allSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius allMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius allLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius allXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius allXxl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius allFull = BorderRadius.all(Radius.circular(full));

  /// Top border radius values
  static const BorderRadius topNone = BorderRadius.only(
    topLeft: Radius.circular(none),
    topRight: Radius.circular(none),
  );
  static const BorderRadius topXs = BorderRadius.only(
    topLeft: Radius.circular(xs),
    topRight: Radius.circular(xs),
  );
  static const BorderRadius topSm = BorderRadius.only(
    topLeft: Radius.circular(sm),
    topRight: Radius.circular(sm),
  );
  static const BorderRadius topMd = BorderRadius.only(
    topLeft: Radius.circular(md),
    topRight: Radius.circular(md),
  );
  static const BorderRadius topLg = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );
  static const BorderRadius topXl = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );
  static const BorderRadius topXxl = BorderRadius.only(
    topLeft: Radius.circular(xxl),
    topRight: Radius.circular(xxl),
  );

  /// Bottom border radius values
  static const BorderRadius bottomNone = BorderRadius.only(
    bottomLeft: Radius.circular(none),
    bottomRight: Radius.circular(none),
  );
  static const BorderRadius bottomXs = BorderRadius.only(
    bottomLeft: Radius.circular(xs),
    bottomRight: Radius.circular(xs),
  );
  static const BorderRadius bottomSm = BorderRadius.only(
    bottomLeft: Radius.circular(sm),
    bottomRight: Radius.circular(sm),
  );
  static const BorderRadius bottomMd = BorderRadius.only(
    bottomLeft: Radius.circular(md),
    bottomRight: Radius.circular(md),
  );
  static const BorderRadius bottomLg = BorderRadius.only(
    bottomLeft: Radius.circular(lg),
    bottomRight: Radius.circular(lg),
  );
  static const BorderRadius bottomXl = BorderRadius.only(
    bottomLeft: Radius.circular(xl),
    bottomRight: Radius.circular(xl),
  );
  static const BorderRadius bottomXxl = BorderRadius.only(
    bottomLeft: Radius.circular(xxl),
    bottomRight: Radius.circular(xxl),
  );

  /// Left border radius values
  static const BorderRadius leftNone = BorderRadius.only(
    topLeft: Radius.circular(none),
    bottomLeft: Radius.circular(none),
  );
  static const BorderRadius leftXs = BorderRadius.only(
    topLeft: Radius.circular(xs),
    bottomLeft: Radius.circular(xs),
  );
  static const BorderRadius leftSm = BorderRadius.only(
    topLeft: Radius.circular(sm),
    bottomLeft: Radius.circular(sm),
  );
  static const BorderRadius leftMd = BorderRadius.only(
    topLeft: Radius.circular(md),
    bottomLeft: Radius.circular(md),
  );
  static const BorderRadius leftLg = BorderRadius.only(
    topLeft: Radius.circular(lg),
    bottomLeft: Radius.circular(lg),
  );
  static const BorderRadius leftXl = BorderRadius.only(
    topLeft: Radius.circular(xl),
    bottomLeft: Radius.circular(xl),
  );
  static const BorderRadius leftXxl = BorderRadius.only(
    topLeft: Radius.circular(xxl),
    bottomLeft: Radius.circular(xxl),
  );

  /// Right border radius values
  static const BorderRadius rightNone = BorderRadius.only(
    topRight: Radius.circular(none),
    bottomRight: Radius.circular(none),
  );
  static const BorderRadius rightXs = BorderRadius.only(
    topRight: Radius.circular(xs),
    bottomRight: Radius.circular(xs),
  );
  static const BorderRadius rightSm = BorderRadius.only(
    topRight: Radius.circular(sm),
    bottomRight: Radius.circular(sm),
  );
  static const BorderRadius rightMd = BorderRadius.only(
    topRight: Radius.circular(md),
    bottomRight: Radius.circular(md),
  );
  static const BorderRadius rightLg = BorderRadius.only(
    topRight: Radius.circular(lg),
    bottomRight: Radius.circular(lg),
  );
  static const BorderRadius rightXl = BorderRadius.only(
    topRight: Radius.circular(xl),
    bottomRight: Radius.circular(xl),
  );
  static const BorderRadius rightXxl = BorderRadius.only(
    topRight: Radius.circular(xxl),
    bottomRight: Radius.circular(xxl),
  );
}

/// Theme extension for radius system
/// Provides access to radius values through the theme system
class UnpingRadiusExtension extends ThemeExtension<UnpingRadiusExtension> {
  const UnpingRadiusExtension({
    this.none = UnpingRadius.none,
    this.xs = UnpingRadius.xs,
    this.sm = UnpingRadius.sm,
    this.md = UnpingRadius.md,
    this.lg = UnpingRadius.lg,
    this.xl = UnpingRadius.xl,
    this.xxl = UnpingRadius.xxl,
    this.full = UnpingRadius.full,
  });

  final double none;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double full;

  static const light = UnpingRadiusExtension();
  static const dark = UnpingRadiusExtension();

  @override
  ThemeExtension<UnpingRadiusExtension> copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? full,
  }) {
    return UnpingRadiusExtension(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      full: full ?? this.full,
    );
  }

  @override
  ThemeExtension<UnpingRadiusExtension> lerp(
    ThemeExtension<UnpingRadiusExtension>? other,
    double t,
  ) {
    if (other is! UnpingRadiusExtension) return this;
    return UnpingRadiusExtension(
      none: none,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      full: full,
    );
  }
}

/// Extension on BuildContext to easily access radius values
extension UnpingRadiusContext on BuildContext {
  UnpingRadiusExtension get unpingRadius =>
      Theme.of(this).extension<UnpingRadiusExtension>() ??
      UnpingRadiusExtension.light;
}
