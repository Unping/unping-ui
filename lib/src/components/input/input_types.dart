import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// Input size variants
enum InputSize {
  /// Small Input - compact size
  sm,

  /// Medium Input - default size
  md,

  /// Large Input - expanded size
  lg,
}

/// Input visual states (can be forced for showcasing)
enum InputState {
  /// Normal state - default appearance
  normal,

  /// Focused state - when input interaction began
  focused,

  /// Disabled state - when input is not interactive
  disabled,

  /// Error state - when input has error message
  error,
}

/// Password strength buckets
enum PasswordStrength {
  /// Weak password - weak password message
  weak,

  /// Medium password - medium password message
  medium,

  /// Strong password - strong password message
  strong,
}

/// Signature for validating input values.
/// Return a **string** to show an error message, or **null** when valid.

/// Compact spec describing paddings and text style derived from [InputSize].
class InputSizeSpec {
  final EdgeInsets padding; // content padding inside the field
  final TextStyle textStyle; // text style for input value
  final double minHeight; // suggested min height for single-line fields

  const InputSizeSpec({
    required this.padding,
    required this.textStyle,
    required this.minHeight,
  });
}

/// Maps [InputSize] to concrete paddings, min heights and typography.
/// Uses design tokens from UiTextStyles where possible, with sensible fallbacks.
class InputSizeTokens {
  static InputSizeSpec of(BuildContext context, InputSize size) {
    switch (size) {
      case InputSize.sm:
        return InputSizeSpec(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle:
              UiTextStyles.textXs.copyWith(fontWeight: UiTextStyles.medium),
          minHeight: 36,
        );
      case InputSize.md:
        return InputSizeSpec(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          textStyle:
              UiTextStyles.textSm.copyWith(fontWeight: UiTextStyles.medium),
          minHeight: 40,
        );
      case InputSize.lg:
        return InputSizeSpec(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle:
              UiTextStyles.textMd.copyWith(fontWeight: UiTextStyles.medium),
          minHeight: 48,
        );
    }
  }
}

/// Configuration for password strength calculation.
class PasswordStrengthColors {
  final Color weak;
  final Color medium;
  final Color strong;

  const PasswordStrengthColors({
    required this.weak,
    required this.medium,
    required this.strong,
  });
}
