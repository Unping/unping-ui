// lib/components/tooltip/tooltip_variants.dart
import 'package:flutter/material.dart';

import 'base_tooltip.dart';
import 'popover_tooltip.dart';
import 'tooltip_types.dart';

class Tooltips {
  /// Simple text tooltip (string message)
  static UiTooltip text({
    Key? key,
    required Widget child,
    required String message,
    UiTooltipVariant variant = UiTooltipVariant.neutral,
    UiTooltipPlacement placement = UiTooltipPlacement.auto,
    UiTooltipStyle? style,
    bool enabled = true,
    bool triggerOnHover = true,
    bool triggerOnLongPress = true,
    bool enableSemantics = true,
  }) {
    return UiTooltip(
      key: key,
      child: child,
      message: message,
      variant: variant,
      placement: placement,
      style: style,
      enabled: enabled,
      triggerOnHover: triggerOnHover,
      triggerOnLongPress: triggerOnLongPress,
      enableSemantics: enableSemantics,
    );
  }

  /// Rich content tooltip (any widget content)
  static UiTooltip rich({
    Key? key,
    required Widget child,
    required Widget content,
    String message = '', // used for Semantics
    UiTooltipVariant variant = UiTooltipVariant.neutral,
    UiTooltipPlacement placement = UiTooltipPlacement.auto,
    UiTooltipStyle? style,
    bool enabled = true,
    bool triggerOnHover = true,
    bool triggerOnLongPress = true,
    bool enableSemantics = true,
  }) {
    return UiTooltip(
      key: key,
      child: child,
      message: message,
      content: content,
      variant: variant,
      placement: placement,
      style: style,
      enabled: enabled,
      triggerOnHover: triggerOnHover,
      triggerOnLongPress: triggerOnLongPress,
      enableSemantics: enableSemantics,
    );
  }

  /// Click-to-open popover (supports either text via `message` or rich `content`)
  static PopoverTooltip popover({
    Key? key,
    required Widget child,
    String message = '',
    Widget? content,
    UiTooltipVariant variant = UiTooltipVariant.neutral,
    UiTooltipPlacement placement = UiTooltipPlacement.auto,
    UiTooltipStyle? style,
    bool enabled = true,
    bool enableSemantics = true,
  }) {
    return PopoverTooltip(
      key: key,
      child: child,
      message: message,
      content: content,
      variant: variant,
      placement: placement,
      style: style,
      enabled: enabled,
      enableSemantics: enableSemantics,
    );
  }

  /// Wrapper convenience (alias of `text`)
  static UiTooltip wrapper({
    Key? key,
    required Widget child,
    required String message,
    UiTooltipVariant variant = UiTooltipVariant.neutral,
    UiTooltipPlacement placement = UiTooltipPlacement.auto,
    UiTooltipStyle? style,
    bool enabled = true,
    bool triggerOnHover = true,
    bool triggerOnLongPress = true,
    bool enableSemantics = true,
  }) {
    return text(
      key: key,
      child: child,
      message: message,
      variant: variant,
      placement: placement,
      style: style,
      enabled: enabled,
      triggerOnHover: triggerOnHover,
      triggerOnLongPress: triggerOnLongPress,
      enableSemantics: enableSemantics,
    );
  }

  // Keep your predefined variant factories for convenience
  static UiTooltip neutral({
    Key? key,
    required Widget child,
    required String message,
    UiTooltipPlacement placement = UiTooltipPlacement.auto,
    bool enabled = true,
    UiTooltipStyle? style,
  }) =>
      text(
        key: key,
        child: child,
        message: message,
        placement: placement,
        enabled: enabled,
        style: style,
        variant: UiTooltipVariant.neutral,
      );

  static UiTooltip info({
    Key? key,
    required Widget child,
    required String message,
    UiTooltipPlacement placement = UiTooltipPlacement.auto,
    bool enabled = true,
    UiTooltipStyle? style,
  }) =>
      text(
        key: key,
        child: child,
        message: message,
        placement: placement,
        enabled: enabled,
        style: style,
        variant: UiTooltipVariant.info,
      );

  static UiTooltip success({
    Key? key,
    required Widget child,
    required String message,
    UiTooltipPlacement placement = UiTooltipPlacement.auto,
    bool enabled = true,
    UiTooltipStyle? style,
  }) =>
      text(
        key: key,
        child: child,
        message: message,
        placement: placement,
        enabled: enabled,
        style: style,
        variant: UiTooltipVariant.success,
      );

  static UiTooltip warning({
    Key? key,
    required Widget child,
    required String message,
    UiTooltipPlacement placement = UiTooltipPlacement.auto,
    bool enabled = true,
    UiTooltipStyle? style,
  }) =>
      text(
        key: key,
        child: child,
        message: message,
        placement: placement,
        enabled: enabled,
        style: style,
        variant: UiTooltipVariant.warning,
      );

  static UiTooltip error({
    Key? key,
    required Widget child,
    required String message,
    UiTooltipPlacement placement = UiTooltipPlacement.auto,
    bool enabled = true,
    UiTooltipStyle? style,
  }) =>
      text(
        key: key,
        child: child,
        message: message,
        placement: placement,
        enabled: enabled,
        style: style,
        variant: UiTooltipVariant.error,
      );
}
