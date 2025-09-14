import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// Input field variants
enum InputFieldVariant {
  /// Outlined variant with border
  outlined,

  /// Filled variant with background
  filled,

  /// Underlined variant with bottom border
  underlined,
}

/// Input field size variants
enum InputFieldSize {
  /// Small input field
  sm,

  /// Medium input field - default size
  md,

  /// Large input field
  lg,
}

/// Input field visual states
enum InputFieldState {
  /// Normal state - default appearance
  normal,

  /// Focused state - when input has focus
  focused,

  /// Error state - when validation fails
  error,

  /// Disabled state - when input is not interactive
  disabled,
}

/// A base input field widget that matches the Figma design pattern.
/// Supports customizable variants, icons, validation states, and full theming.
class BaseInputField extends StatefulWidget {
  /// The current text value of the input field
  final String? value;

  /// Callback when the text value changes
  final ValueChanged<String>? onChanged;

  /// Callback when the input field is submitted
  final ValueChanged<String>? onSubmitted;

  /// Callback when the input field gains or loses focus
  final ValueChanged<bool>? onFocusChanged;

  /// Placeholder text when input is empty
  final String? placeholder;

  /// Label text displayed above the input
  final String? label;

  /// Helper text displayed below the input
  final String? helperText;

  /// Error text displayed below the input (overrides helperText)
  final String? errorText;

  /// Leading icon widget
  final Widget? leadingIcon;

  /// Trailing icon widget
  final Widget? trailingIcon;

  /// Visual variant of the input field
  final InputFieldVariant variant;

  /// Size of the input field
  final InputFieldSize size;

  /// Whether the input field is enabled
  final bool enabled;

  /// Whether the input field is read-only
  final bool readOnly;

  /// Whether to obscure text (for passwords)
  final bool obscureText;

  /// Whether to autocorrect text
  final bool autocorrect;

  /// Whether to enable suggestions
  final bool enableSuggestions;

  /// Maximum number of lines (null for unlimited)
  final int? maxLines;

  /// Minimum number of lines
  final int? minLines;

  /// Maximum length of text
  final int? maxLength;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Text capitalization
  final TextCapitalization textCapitalization;

  /// Background color for filled variant
  final Color? backgroundColor;

  /// Background color when focused
  final Color? focusBackgroundColor;

  /// Background color when disabled
  final Color? disabledBackgroundColor;

  /// Border color
  final Color? borderColor;

  /// Border color when focused
  final Color? focusBorderColor;

  /// Border color when error
  final Color? errorBorderColor;

  /// Border color when disabled
  final Color? disabledBorderColor;

  /// Border width
  final double borderWidth;

  /// Focus ring color
  final Color? focusRingColor;

  /// Focus ring width
  final double focusRingWidth;

  /// Text color
  final Color textColor;

  /// Text color when disabled
  final Color? disabledTextColor;

  /// Placeholder text color
  final Color? placeholderColor;

  /// Label text color
  final Color? labelColor;

  /// Helper text color
  final Color? helperTextColor;

  /// Error text color
  final Color? errorTextColor;

  /// Text style for input text
  final TextStyle? textStyle;

  /// Text style for placeholder
  final TextStyle? placeholderStyle;

  /// Text style for label
  final TextStyle? labelStyle;

  /// Text style for helper text
  final TextStyle? helperStyle;

  /// Text style for error text
  final TextStyle? errorStyle;

  /// Border radius
  final double borderRadius;

  /// Content padding
  final EdgeInsetsGeometry? contentPadding;

  /// Gap between label and input
  final double labelGap;

  /// Gap between input and helper/error text
  final double helperGap;

  /// Gap between icons and text
  final double iconGap;

  /// Force a specific input state (overrides automatic state detection)
  /// Useful for showcasing different states in Widgetbook or design systems
  final InputFieldState? forceState;

  /// Focus node for controlling focus
  final FocusNode? focusNode;

  /// Text editing controller
  final TextEditingController? controller;

  BaseInputField({
    super.key,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.onFocusChanged,
    this.placeholder,
    this.label,
    this.helperText,
    this.errorText,
    this.leadingIcon,
    this.trailingIcon,
    this.variant = InputFieldVariant.outlined,
    this.size = InputFieldSize.md,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.backgroundColor,
    this.focusBackgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.borderWidth = 1.0,
    this.focusRingColor,
    this.focusRingWidth = 3.0,
    required this.textColor,
    this.disabledTextColor,
    this.placeholderColor,
    this.labelColor,
    this.helperTextColor,
    this.errorTextColor,
    TextStyle? textStyle,
    this.placeholderStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.borderRadius = UiRadius.xs,
    this.contentPadding,
    this.labelGap = 8.0, // UiSpacing.xs
    this.helperGap = 8.0, // UiSpacing.xs
    this.iconGap = 8.0, // UiSpacing.xs
    this.forceState,
    this.focusNode,
    this.controller,
  }) : textStyle = textStyle;

  @override
  State<BaseInputField> createState() => _BaseInputFieldState();
}

class _BaseInputFieldState extends State<BaseInputField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller =
        widget.controller ?? TextEditingController(text: widget.value);

    _focusNode.addListener(_handleFocusChange);

    // If we don't have a controller and value is provided, set it
    if (widget.controller == null && widget.value != null) {
      _controller.text = widget.value!;
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(BaseInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update controller text if value changed and we're managing the controller
    if (widget.controller == null && widget.value != oldWidget.value) {
      _controller.text = widget.value ?? '';
    }
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    widget.onFocusChanged?.call(_focusNode.hasFocus);
  }

  /// Get the effective text style
  TextStyle get _effectiveTextStyle => widget.textStyle ?? UiTextStyles.textSm;

  /// Priority: forceState > disabled > error > focused > normal
  InputFieldState get _currentState {
    if (widget.forceState != null) {
      // Still respect disabled state when not enabled
      if (!widget.enabled) return InputFieldState.disabled;
      return widget.forceState!;
    }

    if (!widget.enabled) return InputFieldState.disabled;
    if (widget.errorText != null) return InputFieldState.error;
    if (_isFocused) return InputFieldState.focused;
    return InputFieldState.normal;
  }

  /// Get size-specific dimensions
  EdgeInsetsGeometry get _sizedContentPadding {
    if (widget.contentPadding != null) return widget.contentPadding!;

    switch (widget.size) {
      case InputFieldSize.sm:
        return EdgeInsets.symmetric(
            horizontal: UiSpacing.sm, vertical: UiSpacing.xs);
      case InputFieldSize.md:
        return EdgeInsets.symmetric(
            horizontal: UiSpacing.m, vertical: UiSpacing.sm);
      case InputFieldSize.lg:
        return EdgeInsets.symmetric(
            horizontal: UiSpacing.l, vertical: UiSpacing.m);
    }
  }

  double get _sizedMinHeight {
    switch (widget.size) {
      case InputFieldSize.sm:
        return 32.0;
      case InputFieldSize.md:
        return 40.0;
      case InputFieldSize.lg:
        return 48.0;
    }
  }

  /// Get colors for current state
  Color get _backgroundColor {
    final state = _currentState;
    switch (state) {
      case InputFieldState.disabled:
        return widget.disabledBackgroundColor ??
            (widget.variant == InputFieldVariant.filled
                ? UiColors.neutral100
                : const Color(0x00000000)); // Transparent
      case InputFieldState.focused:
        return widget.focusBackgroundColor ??
            (widget.variant == InputFieldVariant.filled
                ? UiColors.neutral50
                : const Color(0x00000000)); // Transparent
      case InputFieldState.error:
      case InputFieldState.normal:
        return widget.backgroundColor ??
            (widget.variant == InputFieldVariant.filled
                ? UiColors.neutral50
                : const Color(0x00000000)); // Transparent
    }
  }

  Color get _borderColor {
    final state = _currentState;
    switch (state) {
      case InputFieldState.disabled:
        return widget.disabledBorderColor ?? UiColors.neutral300;
      case InputFieldState.error:
        return widget.errorBorderColor ?? UiColors.error600;
      case InputFieldState.focused:
        return widget.focusBorderColor ?? UiColors.primary600;
      case InputFieldState.normal:
        return widget.borderColor ?? UiColors.neutral300;
    }
  }

  Color get _textColor {
    final state = _currentState;
    switch (state) {
      case InputFieldState.disabled:
        return widget.disabledTextColor ?? UiColors.neutral400;
      case InputFieldState.error:
      case InputFieldState.focused:
      case InputFieldState.normal:
        return widget.textColor;
    }
  }

  /// Build border based on variant
  Border? get _border {
    switch (widget.variant) {
      case InputFieldVariant.outlined:
        return Border.all(
          color: _borderColor,
          width: widget.borderWidth,
        );
      case InputFieldVariant.underlined:
        return Border(
          bottom: BorderSide(
            color: _borderColor,
            width: widget.borderWidth,
          ),
        );
      case InputFieldVariant.filled:
        return null;
    }
  }

  /// Build focus ring decoration
  BoxDecoration? get _focusRingDecoration {
    if (_currentState != InputFieldState.focused ||
        widget.focusRingColor == null) {
      return null;
    }

    return BoxDecoration(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      boxShadow: [
        BoxShadow(
          color: widget.focusRingColor!,
          blurRadius: 0,
          spreadRadius: widget.focusRingWidth,
          offset: Offset.zero,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: widget.labelStyle ??
                UiTextStyles.textSm.copyWith(
                  color: widget.labelColor ?? UiColors.neutral700,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: widget.labelGap),
        ],

        // Input field with focus ring
        Stack(
          children: [
            // Focus ring
            if (_focusRingDecoration != null)
              Positioned.fill(
                child: Container(
                  decoration: _focusRingDecoration,
                ),
              ),

            // Main input container
            Container(
              constraints: BoxConstraints(
                minHeight: _sizedMinHeight,
              ),
              decoration: BoxDecoration(
                color: _backgroundColor,
                border: _border,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: Row(
                children: [
                  // Leading icon
                  if (widget.leadingIcon != null) ...[
                    Padding(
                      padding: EdgeInsets.only(
                          left: _sizedContentPadding.horizontal / 2),
                      child: widget.leadingIcon!,
                    ),
                    SizedBox(width: widget.iconGap),
                  ],

                  // Text field
                  Expanded(
                    child: EditableText(
                      controller: _controller,
                      focusNode: _focusNode,
                      style: _effectiveTextStyle.copyWith(color: _textColor),
                      cursorColor:
                          widget.focusBorderColor ?? UiColors.primary600,
                      backgroundCursorColor: UiColors.neutral200,
                      keyboardType: widget.keyboardType ?? TextInputType.text,
                      textInputAction: widget.textInputAction,
                      textCapitalization: widget.textCapitalization,
                      obscureText: widget.obscureText,
                      autocorrect: widget.autocorrect,
                      enableSuggestions: widget.enableSuggestions,
                      maxLines: widget.maxLines,
                      minLines: widget.minLines,
                      readOnly: widget.readOnly || !widget.enabled,
                      inputFormatters: widget.inputFormatters,
                      onChanged: widget.onChanged,
                      onSubmitted: widget.onSubmitted,
                      // Custom selection controls could be added here
                    ),
                  ),

                  // Trailing icon
                  if (widget.trailingIcon != null) ...[
                    SizedBox(width: widget.iconGap),
                    Padding(
                      padding: EdgeInsets.only(
                          right: _sizedContentPadding.horizontal / 2),
                      child: widget.trailingIcon!,
                    ),
                  ],
                ],
              ),
            ),

            // Overlay for placeholder text
            if (widget.placeholder != null && _controller.text.isEmpty)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    padding: _sizedContentPadding.add(
                      EdgeInsets.only(
                        left: widget.leadingIcon != null
                            ? 24.0 + widget.iconGap
                            : 0.0,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.placeholder!,
                      style: widget.placeholderStyle ??
                          _effectiveTextStyle.copyWith(
                            color:
                                widget.placeholderColor ?? UiColors.neutral400,
                          ),
                    ),
                  ),
                ),
              ),
          ],
        ),

        // Helper/Error text
        if (widget.errorText != null || widget.helperText != null) ...[
          SizedBox(height: widget.helperGap),
          Text(
            widget.errorText ?? widget.helperText!,
            style: widget.errorText != null
                ? (widget.errorStyle ??
                    UiTextStyles.textXs.copyWith(
                      color: widget.errorTextColor ?? UiColors.error600,
                    ))
                : (widget.helperStyle ??
                    UiTextStyles.textXs.copyWith(
                      color: widget.helperTextColor ?? UiColors.neutral500,
                    )),
          ),
        ],
      ],
    );
  }
}
