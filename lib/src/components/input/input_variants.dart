import 'package:flutter/material.dart';
import 'package:unping_ui/src/components/input/input_types.dart';

/// A factory class for creating predefined input components based on the design system.
class Inputs {
  // Private constructor to prevent instantiation.
  Inputs._(); // coverage:ignore-line

  /// Returns a standard single-line text input field.
  ///
  /// Use for general text entry. Supports optional label, placeholder, helper text,
  /// prefix/suffix icons,   validation, and size configuration.
  ///
  /// [label] - Optional text displayed above the input.
  /// [placeholder] - Hint text shown when the field is empty.
  /// [controller] - Controls the text being edited.
  /// [focusNode] - Controls the focus of the input.
  /// [enabled] - Whether the input is interactive.
  /// [helperText] - Optional helper text below the input.
  /// [prefixIcon] - Optional widget before the text.
  /// [suffixIcon] - Optional widget after the text.
  /// [size] - Input size (sm, md, lg).
  /// [onChanged] - Callback when text changes.
  /// [validator] - Optional validation function.
  static Widget text({
    Key? key,
    String? label,
    String? placeholder,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool enabled = true,
    String? helperText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    InputSize size = InputSize.md,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextInput(
      key: key,
      label: label,
      placeholder: placeholder,
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      validator: validator,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      size: size,
      onChanged: onChanged,
    );
  }

  /// Returns a multi-line text area input.
  ///
  /// Use for longer text entries such as comments or descriptions.
  /// Supports optional label, placeholder, helper text, character count,
  /// min/max lines, and validation.
  ///
  /// [label] - Optional text displayed above the text area.
  /// [placeholder] - Hint text shown when the field is empty.
  /// [helperText] - Optional helper text below the input.
  /// [controller] - Controls the text being edited.
  /// [focusNode] - Controls the focus of the input.
  /// [maxLength] - Maximum allowed characters.
  /// [showCharCount] - Show character counter below the field.
  /// [enabled] - Whether the input is interactive.
  /// [minLines] - Minimum number of visible lines.
  /// [maxLines] - Maximum number of visible lines.
  /// [validator] - Optional validation function.
  static Widget textArea({
    Key? key,
    String? label,
    String? placeholder,
    String? helperText,
    TextEditingController? controller,
    FocusNode? focusNode,
    int? maxLength,
    bool showCharCount = false,
    bool enabled = true,
    int? minLines = 3,
    int? maxLines = 8,
    String? Function(String?)? validator,
  }) {
    return TextArea(
      key: key,
      label: label,
      placeholder: placeholder,
      helperText: helperText,
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      showCharCount: showCharCount,
      minLines: minLines!,
      maxLines: maxLines!,
      validator: validator,
      enabled: enabled,
    );
  }

  /// Returns a search input field with a leading search icon and trailing clear button.
  ///
  /// Use for search functionality. The clear button appears when text is entered.
  ///
  /// [placeholder] - Hint text shown when the field is empty.
  /// [controller] - Controls the text being edited.
  /// [focusNode] - Controls the focus of the input.
  /// [onSubmit] - Callback when the user submits a search.
  static Widget search({
    Key? key,
    String? placeholder = 'Search...',
    TextEditingController? controller,
    FocusNode? focusNode,
    ValueChanged<String>? onSubmit,
  }) {
    return SearchInput(
      key: key,
      placeholder: placeholder,
      controller: controller,
      focusNode: focusNode,
      onSubmit: onSubmit,
    );
  }

  /// Returns a password input field with a visibility toggle.
  ///
  /// Use for password entry. Text is obscured by default, with a button to show/hide.
  ///
  /// [label] - Optional text displayed above the password field.
  /// [placeholder] - Hint text shown when the field is empty.
  /// [controller] - Controls the text being edited.
  /// [focusNode] - Controls the focus of the input.
  /// [validator] - Optional validation function.
  /// [onChanged] - Callback when password changes.
  /// [enabled] - Whether the input is interactive.
  /// [obscureText] - Whether to hide or show password text by default
  /// [showStrengthIndicator] - Whether to show the password strength
  static Widget password({
    Key? key,
    String? label,
    String? placeholder = 'Password',
    TextEditingController? controller,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    bool enabled = true,
    bool obscureText = true,
    bool showStrengthIndicator = false,
  }) {
    return PasswordInput(
      key: key,
      label: label,
      placeholder: placeholder,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      obscureText: obscureText,
      showStrengthIndicator: showStrengthIndicator,
    );
  }
}
