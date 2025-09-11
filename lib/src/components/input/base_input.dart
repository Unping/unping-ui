import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// A base, token-driven input field that matches the Figma design system.
///
/// It powers text fields, text areas, search, and password inputs. The widget
/// avoids Material dependencies by building atop [EditableText] and custom
/// decoration. Use [Inputs] factory methods for common variants.
class BaseInput extends StatefulWidget {
  /// Placeholder (hint) rendered when the field is empty.
  final String? placeholder;

  /// identifies search input
  final bool isSearch;

  /// Tooltip message displayed below the input (can be helper or error).
  final String? tooltipMessage;

  /// Optional helper text displayed below the input when there's no error.
  final String? helperText;

  /// Error text displayed below the input; when provided, forces error state.
  final String? errorText;

  /// Text controller. If null, an internal controller is created.
  final TextEditingController? controller;

  /// Focus node. If null, an internal focus node is created.
  final FocusNode? focusNode;

  /// Called whenever the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the field (e.g., presses Enter).
  final ValueChanged<String>? onSubmitted;

  /// Whether the field is enabled.
  final bool enabled;

  /// Size of the input, impacting paddings, height, and typography.
  final InputSize size;

  /// Minimum number of lines (for multi-line / text area).
  final int? minLines;

  /// Maximum number of lines. When > 1, the field behaves as a textarea.
  final int? maxLines;

  /// Whether the text area is resizable via a bottom-right drag handle.
  final bool resizable;

  /// Maximum allowed characters (for counter). If null, counter is hidden
  /// unless [showCharacterCount] is true in which case we show current length.
  final int? maxLength;

  /// Whether to show a character count; when [maxLength] is null, show only
  /// current length.
  final bool showCharacterCount;

  /// Keyboard type.
  final TextInputType? keyboardType;

  /// Optional autofill hints.
  final Iterable<String>? autofillHints;

  /// Obscure (mask) the input — used for passwords.
  final bool obscureText;

  /// If true, shows an eye icon to toggle [obscureText].
  final bool showObscureToggle;

  /// If true, shows a visual strength indicator (passwords).
  final bool showStrengthIndicator;

  /// Custom strength calculator. If null, a default heuristic is used.
  final PasswordStrength Function(String value)? strengthCalculator;

  /// Show a clear (✕) button to reset the text (useful for search fields).
  final bool showClearButton;

  /// Force a specific state for showcasing (except when disabled).
  final InputState? forceState;

  /// Custom prefix widget (overrides [prefixIcon]).
  final Widget? prefix;

  /// Custom suffix widget (overrides [suffixIcon]).
  final Widget? suffix;

  /// Optional prefix icon (when [prefix] is null).
  final IconData? prefixIcon;

  /// Optional suffix icon (when [suffix] is null).
  final IconData? suffixIcon;

  /// Icon size for prefix/suffix.
  final double iconSize;

  /// Icon color for prefix/suffix.
  final Color? iconColor;

  /// Colors & visuals — derive from tokens by default but can be overridden.
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? focusBackgroundColor;
  final Color? disabledBackgroundColor;

  final Color? borderColor;
  final Color? hoverBorderColor;
  final Color? focusBorderColor;
  final Color? disabledBorderColor;
  final double borderWidth;

  final double borderRadius;
  final Color? focusRingColor;
  final double focusRingWidth;

  /// Text and placeholder styles. If null, derived from [InputSize].
  final TextStyle? textStyle;
  final TextStyle? placeholderStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;

  /// Optional semantic label for accessibility.
  final String? semanticsLabel;

  /// Optional scroll physics override for multi-line content.
  final ScrollPhysics? scrollPhysics;

  /// Internal padding override. By default derived from [InputSize].
  final EdgeInsetsGeometry? contentPadding;

  /// Create a token-driven input field. Prefer using [Inputs] factories.
  const BaseInput({
    super.key,
    this.placeholder,
    this.tooltipMessage,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.size = InputSize.md,
    this.minLines,
    this.maxLines = 1,
    this.resizable = false,
    this.maxLength,
    this.showCharacterCount = false,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSize = 0,
    this.iconColor,
    this.keyboardType,
    this.autofillHints,
    this.obscureText = false,
    this.showObscureToggle = false,
    this.showStrengthIndicator = false,
    this.strengthCalculator,
    this.showClearButton = false,
    this.forceState,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.focusBackgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.hoverBorderColor,
    this.focusBorderColor,
    this.disabledBorderColor,
    this.isSearch = false,
    this.borderWidth = 1.0,
    this.borderRadius = UiRadius.sm,
    this.focusRingColor,
    this.focusRingWidth = 3.0,
    this.textStyle,
    this.placeholderStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.semanticsLabel,
    this.scrollPhysics,
    this.contentPadding,
  });

  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  var _ownsController = false;
  var _ownsFocusNode = false;
  var _focused = false;
  var _obscured = false;
  var _validationMessage;
  var _currentHeight;
  var _hasText = false;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();
    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _obscured = widget.obscureText;
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant BaseInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _obscured = widget.obscureText;
    }
    if (!widget.resizable) {
      _currentHeight = null;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _controller.removeListener(_onTextChanged);
    if (_ownsController) {
      _controller.dispose();
    }
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _focused = _focusNode.hasFocus);
  }

  void _onTextChanged() {
    final text = _controller.text;
    final newHasText = text.isNotEmpty;

    if (newHasText != _hasText) {
      setState(() => _hasText = newHasText);
    }

    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final spec = InputSizeTokens.of(context, widget.size);

// Base icon size proportional to text field height
    double resolvedIconSize = switch (widget.size) {
      InputSize.sm => 14.0,
      InputSize.md => 16.0,
      InputSize.lg => 18.0,
    };

// If user explicitly provided an iconSize, override
    if (widget.iconSize != 0) {
      resolvedIconSize = widget.iconSize;
    }

    final hasExplicitError =
        (widget.errorText?.isNotEmpty ?? false) || (_validationMessage != null);

    final InputState effectiveState = widget.forceState ??
        (hasExplicitError
            ? InputState.error
            : !widget.enabled
                ? InputState.disabled
                : _focused || _hasText
                    ? InputState.focused
                    : InputState.normal);

// Resolve error message
    final errorMessage = effectiveState == InputState.error
        ? (widget.errorText?.isNotEmpty == true
            ? widget.errorText
            : (_validationMessage?.isNotEmpty == true
                ? _validationMessage
                : 'Error message'))
        : null;

// Tooltip should show error message if error, else normal tooltip
    final tooltip = errorMessage ?? widget.tooltipMessage;

    final baseTextStyle = widget.textStyle ?? UiTextStyles.textSm;
    final textStyle = baseTextStyle
        .merge(spec.textStyle)
        .copyWith(color: UiColors.neutral100);
    final placeholderStyle = widget.placeholderStyle ??
        textStyle.copyWith(
          color: effectiveState == InputState.disabled
              ? UiColors.neutral300.withValues(alpha: 0.25)
              : UiColors.neutral400,
        );
    final helperStyle = widget.helperStyle ??
        UiTextStyles.textXs.copyWith(
          color: effectiveState == InputState.error
              ? UiColors.error
              : UiColors.neutral400,
        );
    final isDisabled = effectiveState == InputState.disabled;
    final strut = StrutStyle.fromTextStyle(textStyle, forceStrutHeight: true);

    final editable = EditableText(
      controller: _controller,
      focusNode: _focusNode,
      style: textStyle,
      strutStyle: strut,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      keyboardType: widget.keyboardType ??
          (widget.maxLines != null && widget.maxLines! > 1
              ? TextInputType.multiline
              : TextInputType.text),
      obscureText: _obscured,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onChanged: (v) {
        if (widget.onChanged != null) {
          widget.onChanged!(v);
        }
      },
      onSubmitted: widget.onSubmitted,
      autofocus: false,
      selectionColor: UiColors.neutral300,
      readOnly: isDisabled,
      enableInteractiveSelection: !isDisabled,
      cursorColor: UiColors.background,
      backgroundCursorColor: UiColors.background,
      autocorrect: true,
      enableSuggestions: true,
      expands: false,
      forceLine: true,
    );

    final isTextArea = (widget.maxLines ?? 1) > 1;
    final isSingleLine = !isTextArea;

    final resolvedPadding = widget.contentPadding ?? spec.padding;
    final contentHeight =
        (spec.minHeight - resolvedPadding.vertical).clamp(16.0, spec.minHeight);

    // Prefix & Suffix
    final List<Widget> rowChildren = [];
    if (widget.prefix != null) {
      rowChildren.add(Padding(
        padding: UiSpacing.onlyRightXs,
        child: widget.prefix!,
      ));
    }

    final List<Widget> suffixUtilities = [];

    if (widget.suffix != null) {
      suffixUtilities.add(widget.suffix!);
    }

    if (suffixUtilities.isNotEmpty) {
      rowChildren.add(UiSpacing.horizontalGapXs);
      rowChildren.addAll(suffixUtilities
          .map((w) => Padding(padding: UiSpacing.onlyLeftXxs, child: w)));
    }

    Widget inputStack = Stack(
      children: [
        if (_controller.text.isEmpty &&
            (widget.placeholder?.isNotEmpty ?? false))
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: UiSpacing.spacing0_5),
            child: IgnorePointer(
              child: Align(
                alignment:
                    isTextArea ? Alignment.topLeft : Alignment.centerLeft,
                child: Text(
                  widget.placeholder ?? '',
                  style: placeholderStyle,
                  strutStyle: strut,
                ),
              ),
            ),
          ),
        Align(
          alignment: isTextArea ? Alignment.topLeft : Alignment.centerLeft,
          child: editable,
        ),
      ],
    );

    Widget maybeResizable(Widget child) {
      if (!widget.resizable || !isTextArea) return child;
      _currentHeight ??= math.max(spec.minHeight,
          (widget.minLines ?? 3) * (spec.textStyle.fontSize ?? 16) * 1.4);
      return _ResizableBox(
        initialHeight: _currentHeight!,
        onHeightChanged: (h) => setState(() => _currentHeight = h),
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: spec.minHeight, maxHeight: 600),
          child: SizedBox(height: _currentHeight, child: child),
        ),
      );
    }

    final box = AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInOut,
      constraints: BoxConstraints(minHeight: spec.minHeight),
      padding: resolvedPadding,
      decoration: BoxDecoration(
        color: UiColors.neutral600,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: effectiveState == InputState.error
              ? UiColors.error
              : effectiveState == InputState.focused
                  ? UiColors.neutral500
                  : effectiveState == InputState.disabled
                      ? Color(0x00000000)
                      : UiColors.neutral500,
          width: widget.borderWidth,
        ),
        boxShadow: effectiveState == InputState.focused
            ? [
                BoxShadow(
                  color: UiColors.neutral500,
                  blurRadius: 0,
                  spreadRadius: widget.focusRingWidth,
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment:
            isTextArea ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          if (widget.isSearch) ...[
            Padding(
              padding: UiSpacing.onlyRightXs,
              child: isSingleLine
                  ? ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                        height: contentHeight,
                        width: contentHeight,
                      ),
                      child: Center(
                        child: CustomPaint(
                          size: Size.square(resolvedIconSize),
                          painter: _SearchIconPainter(
                            color: widget.iconColor ?? UiColors.neutral400,
                          ),
                        ),
                      ),
                    )
                  : CustomPaint(
                      size: Size.square(resolvedIconSize),
                      painter: _SearchIconPainter(
                        color: widget.iconColor ?? UiColors.neutral400,
                      ),
                    ),
            ),
          ] else if (widget.prefix != null || widget.prefixIcon != null) ...[
            Padding(
              padding: UiSpacing.onlyRightXs,
              child: widget.prefix ??
                  Icon(
                    widget.prefixIcon,
                    size: resolvedIconSize,
                    color: widget.iconColor ?? UiColors.neutral400,
                  ),
            ),
          ],
          Expanded(child: inputStack),
          if ((widget.showClearButton || widget.isSearch) &&
              _controller.text.isNotEmpty &&
              widget.enabled) ...[
            isSingleLine
                ? ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      height: contentHeight,
                      width: contentHeight,
                    ),
                    child: Semantics(
                      label: 'Clear text',
                      button: true,
                      onTap: () {
                        _controller.clear();
                        _focusNode.requestFocus();
                      },
                      child: _IconButton(
                        icon: CustomPaint(
                          size: Size(resolvedIconSize, resolvedIconSize),
                          painter: _XIconPainter(
                            color: widget.iconColor ?? UiColors.neutral400,
                          ),
                        ),
                        onTap: () {
                          _controller.clear();
                          _focusNode.requestFocus();
                        },
                      ),
                    ),
                  )
                : Semantics(
                    label: 'Clear text',
                    button: true,
                    onTap: () {
                      _controller.clear();
                      _focusNode.requestFocus();
                    },
                    child: _IconButton(
                      icon: CustomPaint(
                        size: Size(resolvedIconSize, resolvedIconSize),
                        painter: _XIconPainter(
                          color: widget.iconColor ?? UiColors.neutral400,
                        ),
                      ),
                      onTap: () {
                        _controller.clear();
                        _focusNode.requestFocus();
                      },
                    ),
                  ),
          ],
          if (widget.showObscureToggle &&
              _controller.text.isNotEmpty &&
              widget.enabled) ...[
            isSingleLine
                ? ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      height: contentHeight,
                      width: contentHeight,
                    ),
                    child: Semantics(
                      label: _obscured ? 'Show password' : 'Hide password',
                      button: true,
                      onTap: () => setState(() => _obscured = !_obscured),
                      child: _IconButton(
                        icon: CustomPaint(
                          size: Size.square(resolvedIconSize),
                          painter: _obscured
                              ? _VisibilityOffIconPainter(
                                  color:
                                      widget.iconColor ?? UiColors.neutral400,
                                )
                              : _VisibilityIconPainter(
                                  color:
                                      widget.iconColor ?? UiColors.neutral400,
                                ),
                        ),
                        onTap: () => setState(() => _obscured = !_obscured),
                      ),
                    ),
                  )
                : Semantics(
                    label: _obscured ? 'Show password' : 'Hide password',
                    button: true,
                    onTap: () => setState(() => _obscured = !_obscured),
                    child: _IconButton(
                      icon: CustomPaint(
                        size: Size.square(resolvedIconSize),
                        painter: _obscured
                            ? _VisibilityOffIconPainter(
                                color: widget.iconColor ?? UiColors.neutral400,
                              )
                            : _VisibilityIconPainter(
                                color: widget.iconColor ?? UiColors.neutral400,
                              ),
                      ),
                      onTap: () => setState(() => _obscured = !_obscured),
                    ),
                  ),
          ],
          if (!widget.isSearch &&
              (widget.suffix != null || widget.suffixIcon != null)) ...[
            Padding(
              padding: UiSpacing.onlyLeftXs,
              child: isSingleLine
                  ? ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                        height: contentHeight,
                        width: contentHeight,
                      ),
                      child: Center(
                        child: widget.suffix ??
                            Icon(
                              widget.suffixIcon,
                              size: resolvedIconSize,
                              color: widget.iconColor ?? UiColors.neutral400,
                            ),
                      ),
                    )
                  : (widget.suffix ??
                      Icon(
                        widget.suffixIcon,
                        size: resolvedIconSize,
                        color: widget.iconColor ?? UiColors.neutral400,
                      )),
            ),
          ],
          if (widget.showCharacterCount || widget.maxLength != null)
            Text(
              widget.maxLength != null
                  ? '${_controller.text.characters.length}/${widget.maxLength}'
                  : '${_controller.text.characters.length}',
              style: helperStyle.copyWith(
                color: UiColors.neutral400,
              ),
            )
        ],
      ),
    );

    final fieldColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.autofillHints != null)
          AutofillGroup(child: maybeResizable(box))
        else
          maybeResizable(box),
        if (tooltip != null ||
            widget.maxLength != null ||
            widget.showCharacterCount) ...[
          Row(
            children: [
              if (tooltip != null)
                Expanded(
                  child: Semantics(
                    hint: tooltip,
                    child: Text(
                      tooltip,
                      style: helperStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              if (tooltip != null) const SizedBox(width: 8),
            ],
          ),
        ],
        _buildStrengthIndicator(),
      ],
    );

    return Semantics(
      label: widget.semanticsLabel ?? widget.placeholder,
      textField: true,
      enabled: widget.enabled,
      value: _controller.text,
      hint: widget.placeholder,
      child: fieldColumn,
    );
  }

  PasswordStrength _calculateStrength(String value) {
    if (widget.strengthCalculator != null) {
      return widget.strengthCalculator!(value);
    }
    // Default heuristic
    if (value.length > 7 &&
        RegExp(r'[A-Z]').hasMatch(value) &&
        RegExp(r'[0-9]').hasMatch(value)) {
      return PasswordStrength.strong;
    } else if (value.length >= 6) {
      return PasswordStrength.medium;
    } else {
      return PasswordStrength.weak;
    }
  }

  Widget _buildStrengthIndicator() {
    if (!widget.showStrengthIndicator || _controller.text.isEmpty) {
      return const SizedBox.shrink();
    }

    final strength = _calculateStrength(_controller.text);
    final colors = const PasswordStrengthColors(
      weak: UiColors.error400,
      medium: UiColors.warning400,
      strong: UiColors.success400,
    );

    var color;
    var label;
    switch (strength) {
      case PasswordStrength.weak:
        color = colors.weak;
        label = 'Weak';
        break;
      case PasswordStrength.medium:
        color = colors.medium;
        label = 'Medium';
        break;
      case PasswordStrength.strong:
        color = colors.strong;
        label = 'Strong';
        break;
    }

    return Padding(
      padding: UiSpacing.onlyTopXxs,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(UiRadius.xs),
              ),
            ),
          ),
          UiSpacing.horizontalGapXs,
          Text(label, style: UiTextStyles.textXs.copyWith(color: color)),
        ],
      ),
    );
  }
}

/// Lightweight icon button used inside the field for suffix/prefix controls.
class _IconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;

  const _IconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: UiSpacing.xl,
        height: UiSpacing.xl,
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}

/// A resizable wrapper that adds a bottom-right drag handle.
class _ResizableBox extends StatefulWidget {
  final double initialHeight;
  final Widget child;
  final ValueChanged<double> onHeightChanged;

  const _ResizableBox({
    required this.initialHeight,
    required this.child,
    required this.onHeightChanged,
  });

  @override
  State<_ResizableBox> createState() => _ResizableBoxState();
}

class _ResizableBoxState extends State<_ResizableBox> {
  late double _height;

  @override
  void initState() {
    super.initState();
    _height = widget.initialHeight;
  }

  @override
  void didUpdateWidget(covariant _ResizableBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialHeight != widget.initialHeight) {
      _height = widget.initialHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: _height, child: widget.child),
        Positioned(
          right: UiSpacing.xxs,
          bottom: UiSpacing.xxs,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanUpdate: (details) {
              setState(() {
                _height = (_height + details.delta.dy)
                    .clamp(UiSpacing.spacing20, 600.0);
                widget.onHeightChanged(_height);
              });
            },
            child: const SizedBox(
              width: UiSpacing.m,
              height: UiSpacing.m,
              child: CustomPaint(
                painter: _ResizeHandlePainter(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ResizeHandlePainter extends CustomPainter {
  const _ResizeHandlePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = UiColors.neutral400
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width * 0.20, size.height * 0.80),
        Offset(size.width * 0.80, size.height * 0.20), paint);
    canvas.drawLine(Offset(size.width * 0.35, size.height * 0.95),
        Offset(size.width * 0.95, size.height * 0.35), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _XIconPainter extends CustomPainter {
  final Color color;

  _XIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw X shape
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.25),
      Offset(size.width * 0.75, size.height * 0.75),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.75, size.height * 0.25),
      Offset(size.width * 0.25, size.height * 0.75),
      paint,
    );
  }

  // coverage:ignore-start
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// coverage:ignore-end
}

class _SearchIconPainter extends CustomPainter {
  final Color color;

  _SearchIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw circle (lens)
    final radius = size.width * 0.35;
    final center = Offset(size.width * 0.45, size.height * 0.45);
    canvas.drawCircle(center, radius, paint);

    // Draw handle
    final startHandle = Offset(
      center.dx + radius * 0.7,
      center.dy + radius * 0.7,
    );
    final endHandle = Offset(size.width * 0.85, size.height * 0.85);

    canvas.drawLine(startHandle, endHandle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _VisibilityIconPainter extends CustomPainter {
  final Color color;

  _VisibilityIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.25;

    // Eye outline (oval)
    final eyeRect = Rect.fromCenter(
      center: center,
      width: size.width * 0.7,
      height: size.height * 0.5,
    );
    canvas.drawOval(eyeRect, paint);

    // Iris (circle in the middle)
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _VisibilityOffIconPainter extends CustomPainter {
  final Color color;

  _VisibilityOffIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.25;

    // Eye outline (oval)
    final eyeRect = Rect.fromCenter(
      center: center,
      width: size.width * 0.7,
      height: size.height * 0.5,
    );
    canvas.drawOval(eyeRect, paint);

    // Iris
    canvas.drawCircle(center, radius, paint);

    // Slash line
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
