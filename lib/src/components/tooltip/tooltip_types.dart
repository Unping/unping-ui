// lib/components/tooltip/tooltip_types.dart
import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

/// Enums
enum UiTooltipPlacement { top, bottom, left, right, auto }
enum UiTooltipVariant { neutral, info, success, warning, error }

const kTooltipShowDuration = Duration(milliseconds: 140);
const kTooltipHideDuration = Duration(milliseconds: 120);
const kTooltipShowDelay    = Duration(milliseconds: 350);

// Token-backed padding/radius; same final values as before.
const kTooltipPadding  = EdgeInsets.symmetric(
  horizontal: UiSpacing.xs, // 8.0
  vertical: UiSpacing.sm,   // 12.0
);
const kTooltipRadius   = BorderRadius.all(Radius.circular(UiRadius.sm)); // 8.0

const kTooltipShadow   = [
  BoxShadow(color: Color(0x33000000), blurRadius: 10, offset: Offset(0, 4)),
];

// Keep gap ≈ 8.0 (token-backed) and same max width.
const kTooltipGap      = UiSpacing.xs; // 8.0
const kTooltipMaxWidth = 280.0;

/// Style container
@immutable
class UiTooltipStyle {
  const UiTooltipStyle({
    required this.background,
    required this.textStyle,
    this.padding = kTooltipPadding,
    this.radius = kTooltipRadius,
    this.shadow = kTooltipShadow,
    this.gap = kTooltipGap,
    this.maxWidth = kTooltipMaxWidth,
    this.showDuration = kTooltipShowDuration,
    this.hideDuration = kTooltipHideDuration,
    this.showDelay = kTooltipShowDelay,
  });

  final Color background;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final BorderRadius radius;
  final List<BoxShadow> shadow;
  final double gap;
  final double maxWidth;
  final Duration showDuration;
  final Duration hideDuration;
  final Duration showDelay;

  UiTooltipStyle copyWith({
    Color? background,
    TextStyle? textStyle,
    EdgeInsets? padding,
    BorderRadius? radius,
    List<BoxShadow>? shadow,
    double? gap,
    double? maxWidth,
    Duration? showDuration,
    Duration? hideDuration,
    Duration? showDelay,
  }) {
    return UiTooltipStyle(
      background: background ?? this.background,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      radius: radius ?? this.radius,
      shadow: shadow ?? this.shadow,
      gap: gap ?? this.gap,
      maxWidth: maxWidth ?? this.maxWidth,
      showDuration: showDuration ?? this.showDuration,
      hideDuration: hideDuration ?? this.hideDuration,
      showDelay: showDelay ?? this.showDelay,
    );
  }

  /// Optional factory for consumers who want to *explicitly* wire foundation tokens.
  factory UiTooltipStyle.fromFoundation({
    required Color background,
    required TextStyle textStyle,
    EdgeInsets? padding,
    BorderRadius? radius,
    List<BoxShadow>? shadow,
    double? gap,
    double? maxWidth,
    Duration? showDuration,
    Duration? hideDuration,
    Duration? showDelay,
  }) {
    return UiTooltipStyle(
      background: background,
      textStyle: textStyle,
      padding: padding ?? kTooltipPadding,
      radius: radius ?? kTooltipRadius,
      shadow: shadow ?? kTooltipShadow,
      gap: gap ?? kTooltipGap,
      maxWidth: maxWidth ?? kTooltipMaxWidth,
      showDuration: showDuration ?? kTooltipShowDuration,
      hideDuration: hideDuration ?? kTooltipHideDuration,
      showDelay: showDelay ?? kTooltipShowDelay,
    );
  }
}

/// UiTooltipStyle
UiTooltipStyle styleFor(UiTooltipVariant variant, double viewportWidth) {
  final base = UiTextStyles.textXs.fontSize ?? 12.0;
  double fontSize = base;
  if (viewportWidth <= 360) {
    fontSize = (base - 2).clamp(10, base).toDouble();
  } else if (viewportWidth <= 480) {
    fontSize = (base - 1).clamp(10, base).toDouble();
  }

  final txt = UiTextStyles.textXs.copyWith(
    fontSize: fontSize,
    height: 1.25,
    color: Colors.white,
  );

  switch (variant) {
    case UiTooltipVariant.info:
      return UiTooltipStyle(background: UiColors.primary600, textStyle: txt);
    case UiTooltipVariant.success:
      return UiTooltipStyle(background: UiColors.success600, textStyle: txt);
    case UiTooltipVariant.warning:
      return UiTooltipStyle(background: UiColors.warning600, textStyle: txt);
    case UiTooltipVariant.error:
      return UiTooltipStyle(background: UiColors.error600, textStyle: txt);
    case UiTooltipVariant.neutral:
    default:
      return UiTooltipStyle(background: UiColors.neutral900, textStyle: txt);
  }
}

/// Placement resolver
UiTooltipPlacement resolvePlacement({
  required BuildContext context,
  required UiTooltipPlacement explicit,
}) {
  if (explicit != UiTooltipPlacement.auto) return explicit;

  final rb = context.findRenderObject() as RenderBox?;
  if (rb == null || !rb.hasSize) return UiTooltipPlacement.top;

  final size = rb.size;
  final topLeft = rb.localToGlobal(Offset.zero);
  final bottomRight = rb.localToGlobal(Offset(size.width, size.height));
  final screen = MediaQuery.sizeOf(context);

  final spaceTop = topLeft.dy;
  final spaceBottom = screen.height - bottomRight.dy;
  final spaceLeft = topLeft.dx;
  final spaceRight = screen.width - bottomRight.dx;

  if (spaceTop >= 56) return UiTooltipPlacement.top;
  if (spaceBottom >= 56) return UiTooltipPlacement.bottom;
  if (spaceRight >= 120) return UiTooltipPlacement.right;
  if (spaceLeft >= 120) return UiTooltipPlacement.left;
  return UiTooltipPlacement.top;
}
