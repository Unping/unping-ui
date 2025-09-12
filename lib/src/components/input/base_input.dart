import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';



/// A base class for input components that matches the Figma design.
/// This will be extended to have variants such as text fields, text areas,
/// and other input controls that provide users with ways to enter and edit data.
class BaseInput extends StatelessWidget {
  /// The label text displayed above the input field. (optional)
  final String? label;

  /// The placeholder text shown within the input field when it is empty. (optional)
  final String? placeholder;

  /// Controls the text being edited in the input field. (required)
  final TextEditingController controller;

  /// Manages the focus state of the input field. (required)
  final FocusNode focusNode;

  /// Determines whether the input field is enabled or disabled. Defaults to `true`. (optional)
  final bool enabled;

  /// Helper text displayed below the input field. (optional)
  final String? helperText;

  /// A widget to display before the input field (e.g., an icon). (optional)
  final Widget? prefixIcon;

  /// A widget to display after the input field (e.g., an icon). (optional)
  final Widget? suffixIcon;

  /// The size of the input field, defined by the [InputSize] enum. Defaults to [InputSize.md]. (optional)
  final InputSize size;

  /// Whether to obscure the text being entered, typically used for passwords. Defaults to `false`. (optional)
  final bool obscureText;

  /// The minimum number of lines to display in the input field. (optional)
  final int? minLines;

  /// The maximum number of lines to display in the input field. Defaults to `1`. (optional)
  final int? maxLines;

  /// Callback function called when the input value changes. (optional)
  final ValueChanged<String>? onChanged;

  /// The type of keyboard to use for editing the text. (optional)
  final TextInputType? keyboardType;

  /// A function to validate the input field's value. (optional)
  final String? Function(String?)? validator;

  const BaseInput({
    super.key,
    required this.controller,
    required this.focusNode,
    this.label,
    this.placeholder,
    this.enabled = true,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.size = InputSize.md,
    this.obscureText = false,
    this.minLines,
    this.maxLines = 1,
    this.onChanged,
    this.keyboardType,
    this.validator,
  });

  /// Returns the vertical padding based on the input size.
  double _getVerticalPadding() {
    switch (size) {
      case InputSize.sm:
        return 10.0;
      case InputSize.md:
        return 12.0;
      case InputSize.lg:
        return 14.0;
    }
  }

  /// Returns the text style based on the input size.
  TextStyle _getTextStyle() {
    switch (size) {
      case InputSize.sm:
        return UiTextStyles.textSm;
      case InputSize.md:
        return UiTextStyles.textMd;
      case InputSize.lg:
        return UiTextStyles.textMd;
    }
  }

  /// Returns the label color depending on the enabled state and validation.
  Color _getLabelColor() {
    if (!enabled) return UiColors.neutral500;
    final errorText = validator?.call(controller.text);
    if (errorText != null) return UiColors.error;
    return UiColors.neutral500;
  }

  @override
  Widget build(BuildContext context) {
    final String? errorText = validator?.call(controller.text);
    final bool hasError = errorText != null;
    final textStyle = _getTextStyle();

    // Define the border style for all states
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiRadius.sm),
      borderSide: BorderSide(color: UiColors.neutral500, width: 1.5),
    );

    // --- DEFINE THE FOCUS SHADOW ---
    final focusShadow = [
      BoxShadow(
        color: UiColors.neutral500,
        spreadRadius: 4.0,
      ),
    ];

    final semanticLabels = [
      label,
      // Use controller.text for the current value, which is crucial.
      controller.text,
      // Use the visible error text if it exists, otherwise use the helper text.
      hasError ? errorText : helperText,
    ];

    // Join them into a single, clean string. This handles nulls and empty strings gracefully.
    final fullSemanticLabel =
        semanticLabels.where((s) => s != null && s.isNotEmpty).join(', ');

    // --- 2. CREATE THE SEMANTIC CONTAINER ---
    // This single Semantics widget will represent the entire component to the screen reader.
    return Semantics(
      // `container: true` groups all descendant semantics into this single node.
      container: true,
      // Provide the perfectly constructed label.
      label: fullSemanticLabel,
      // Explicitly declare its role and state.
      textField: true,
      enabled: enabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null)
            GestureDetector(
              onTap: () => enabled ? focusNode.requestFocus() : null,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(bottom: UiSpacing.xs),
                child: Text(
                  label!,
                  style: UiTextStyles.textSm.copyWith(
                    fontWeight: UiTextStyles.medium,
                    color: _getLabelColor(),
                  ),
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiRadius.md),
              boxShadow: focusNode.hasFocus ? focusShadow : null,
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              onChanged: onChanged,
              minLines: minLines,
              maxLines: maxLines,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: textStyle,
              cursorColor: UiColors.divider,
              validator: validator,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: textStyle.copyWith(color: UiColors.neutral400),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: UiSpacing.m,
                  vertical: _getVerticalPadding(),
                ),
                isDense: true,
                filled: true,
                fillColor: UiColors.neutral600,
                prefixIcon: prefixIcon != null
                    ? IconTheme(
                        data:
                            IconThemeData(color: UiColors.neutral500, size: 20),
                        child: prefixIcon!,
                      )
                    : null,
                suffixIcon: suffixIcon != null
                    ? IconTheme(
                        data:
                            IconThemeData(color: UiColors.neutral500, size: 20),
                        child: suffixIcon!,
                      )
                    : null,
                border: borderStyle,
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
                disabledBorder: borderStyle.copyWith(
                  borderSide: BorderSide.none,
                ),
                errorBorder: borderStyle.copyWith(
                  borderSide:
                      const BorderSide(color: UiColors.error, width: 1.5),
                ),
                focusedErrorBorder: borderStyle.copyWith(
                  borderSide:
                      const BorderSide(color: UiColors.error, width: 1.5),
                ),
                helperText: helperText,
                helperStyle: UiTextStyles.textSm
                    .copyWith(height: 0.01, color: Colors.transparent),
                // We set errorText to a transparent space to reserve height,
                // but display the actual text in our custom widget below.
                // This prevents the field from jumping when an error appears.
                errorMaxLines: 1,
                errorStyle:
                    const TextStyle(height: 0.01, color: Colors.transparent),
              ),
            ),
          ),
          if (helperText != null || hasError)
            Padding(
              padding: const EdgeInsets.only(top: UiSpacing.xs, left: 0),
              child: Text(
                hasError ? errorText : helperText!,
                style: UiTextStyles.textSm.copyWith(
                  color: hasError ? UiColors.error : UiColors.neutral500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
