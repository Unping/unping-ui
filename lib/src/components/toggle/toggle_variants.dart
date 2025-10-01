import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

/// Central place to define toggle variants
class Toggles {
  // coverage:ignore-next-line
  Toggles._();

  /// Basic switch toggle variant
  static Widget switchToggle({
    required bool value,
    required ValueChanged<bool> onChanged,
    String? label,
    String? description,
    ToggleSize size = ToggleSize.md,
    bool isDisabled = false,
    Color activeColor = UiColors.toggleActive,
    Color inactiveColor = UiColors.neutral600,
    Color thumbColor = UiColors.neutral400,
    Duration animationDuration = const Duration(milliseconds: 200),
    Color focusRingColor = UiColors.neutral25,
    double focusRingWidth = 3.0,
    TextStyle? labelStyle,
    TextStyle? descriptionStyle,
    double spacing = UiSpacing.xs,
    double disabledOpacity = 0.4,
    final ToggleVisualState? forceVisualState,
  }) {
    return ToggleSwitch(
      value: value,
      onChanged: onChanged,
      label: label,
      description: description,
      size: size,
      isDisabled: isDisabled,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      thumbColor: thumbColor,
      animationDuration: animationDuration,
      focusRingColor: focusRingColor,
      focusRingWidth: focusRingWidth,
      labelStyle: labelStyle,
      descriptionStyle: descriptionStyle,
      spacing: spacing,
      disabledOpacity: disabledOpacity,
      forceVisualState: forceVisualState,
    );
  }
}
