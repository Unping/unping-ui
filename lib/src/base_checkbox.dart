import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

/// Checkbox size variants
enum CheckboxSize {
  /// Small checkbox - compact size
  sm,

  /// Medium checkbox - default size
  md,

  /// Large checkbox - expanded size
  lg,
}

/// Checkbox shape variants
enum CheckboxShape {
  /// Rectangle shape - traditional checkbox
  rectangle,

  /// Circle shape - radio button style
  circle,
}

/// Checkbox state variants
enum CheckboxState {
  /// Unchecked state
  unchecked,

  /// Checked state
  checked,

  /// Indeterminate state (mixed/partial selection)
  indeterminate,
}

/// Radio button state variants (only supports checked/unchecked)
enum RadioState {
  /// Unchecked state
  unchecked,

  /// Checked state
  checked,
}

/// Checkbox visual states (for styling)
enum CheckboxVisualState {
  /// Normal state - default appearance
  normal,

  /// Hovered state - when mouse is over the checkbox
  hovered,

  /// Focused state - when checkbox has keyboard focus
  focused,

  /// Disabled state - when checkbox is not interactive
  disabled,
}

/// A base checkbox widget that follows the same pattern as BaseBadge.
/// Supports customizable states, shapes, sizes, and styling options.
class BaseCheckbox extends StatefulWidget {
  /// Current state of the checkbox
  final CheckboxState state;

  /// Callback when the checkbox state changes
  final ValueChanged<CheckboxState>? onChanged;

  /// Size of the checkbox
  final CheckboxSize size;

  /// Shape of the checkbox
  final CheckboxShape shape;

  /// Optional label text to display beside the checkbox
  final String? label;

  /// Optional description text to display below the label
  final String? description;

  /// Style for the label text
  final TextStyle? labelStyle;

  /// Style for the description text
  final TextStyle? descriptionStyle;

  /// Spacing between the checkbox and the text content
  final double textSpacing;

  /// Background color when unchecked
  final Color uncheckedBackgroundColor;

  /// Background color when checked
  final Color checkedBackgroundColor;

  /// Background color when indeterminate
  final Color indeterminateBackgroundColor;

  /// Border color when unchecked
  final Color uncheckedBorderColor;

  /// Border color when checked
  final Color checkedBorderColor;

  /// Border color when indeterminate
  final Color indeterminateBorderColor;

  /// Check mark color
  final Color checkColor;

  /// Indeterminate mark color
  final Color indeterminateColor;

  /// Border width
  final double borderWidth;

  /// Border radius (only applies to rectangle shape)
  final double? borderRadius;

  /// Opacity when disabled
  final double disabledOpacity;

  /// Animation duration for state changes
  final Duration animationDuration;

  /// Focus ring color (for focus state shadow)
  final Color? focusRingColor;

  /// Focus ring width (for focus state shadow)
  final double focusRingWidth;

  /// Force a specific visual state (overrides automatic state detection)
  /// Useful for showcasing different states in Widgetbook or design systems
  final CheckboxVisualState? forceVisualState;

  const BaseCheckbox({
    super.key,
    this.state = CheckboxState.unchecked,
    this.onChanged,
    this.size = CheckboxSize.md,
    this.shape = CheckboxShape.rectangle,
    this.label,
    this.description,
    this.labelStyle,
    this.descriptionStyle,
    this.textSpacing = 8.0,
    this.uncheckedBackgroundColor = const Color(0xFFFFFFFF),
    this.checkedBackgroundColor = const Color(0xFF3B4554),
    this.indeterminateBackgroundColor = const Color(0xFF3B4554),
    this.uncheckedBorderColor = const Color(0xFFD0D5DD),
    this.checkedBorderColor = const Color(0xFF3B4554),
    this.indeterminateBorderColor = const Color(0xFF3B4554),
    this.checkColor = const Color(0xFFFFFFFF),
    this.indeterminateColor = const Color(0xFFFFFFFF),
    this.borderWidth = 1.0,
    this.borderRadius,
    this.disabledOpacity = 0.4,
    this.animationDuration = const Duration(milliseconds: 200),
    this.focusRingColor,
    this.focusRingWidth = 3.0,
    this.forceVisualState,
  });

  /// Get the actual size based on the size variant
  double get actualSize {
    switch (size) {
      case CheckboxSize.sm:
        return 16.0;
      case CheckboxSize.md:
        return 20.0;
      case CheckboxSize.lg:
        return 24.0;
    }
  }

  /// Get the default border radius based on size (only for rectangle shape)
  double get defaultBorderRadius {
    switch (size) {
      case CheckboxSize.sm:
        return 3.0;
      case CheckboxSize.md:
        return 4.0;
      case CheckboxSize.lg:
        return 5.0;
    }
  }

  @override
  State<BaseCheckbox> createState() => _BaseCheckboxState();
}

class _BaseCheckboxState extends State<BaseCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (widget.state != CheckboxState.unchecked) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BaseCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      if (widget.state == CheckboxState.unchecked) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Get the current visual state based on conditions
  /// Priority: forceVisualState > disabled > focused > hovered > normal
  CheckboxVisualState get _currentVisualState {
    // If forceVisualState is provided, use it (except when disabled)
    if (widget.forceVisualState != null) {
      // Still respect disabled state when onChanged is null
      if (widget.onChanged == null) return CheckboxVisualState.disabled;
      return widget.forceVisualState!;
    }

    // Normal state detection logic
    if (widget.onChanged == null) return CheckboxVisualState.disabled;
    if (_isFocused) return CheckboxVisualState.focused;
    if (_isHovered) return CheckboxVisualState.hovered;
    return CheckboxVisualState.normal;
  }

  void _handleTap() {
    if (widget.onChanged == null) return;

    CheckboxState newState;
    switch (widget.state) {
      case CheckboxState.unchecked:
        newState = CheckboxState.checked;
        break;
      case CheckboxState.checked:
        // For circle shape (radio button), don't allow unchecking
        if (widget.shape == CheckboxShape.circle) {
          return; // Radio buttons typically don't uncheck themselves
        }
        newState = CheckboxState.unchecked;
        break;
      case CheckboxState.indeterminate:
        // Radio buttons should never be in indeterminate state
        if (widget.shape == CheckboxShape.circle) {
          newState = CheckboxState.checked;
        } else {
          newState = CheckboxState.checked;
        }
        break;
    }

    widget.onChanged!(newState);
  }

  Color _getCurrentBackgroundColor() {
    switch (widget.state) {
      case CheckboxState.unchecked:
        return widget.uncheckedBackgroundColor;
      case CheckboxState.checked:
        return widget.checkedBackgroundColor;
      case CheckboxState.indeterminate:
        return widget.indeterminateBackgroundColor;
    }
  }

  Color _getCurrentBorderColor() {
    switch (widget.state) {
      case CheckboxState.unchecked:
        return widget.uncheckedBorderColor;
      case CheckboxState.checked:
        return widget.checkedBorderColor;
      case CheckboxState.indeterminate:
        return widget.indeterminateBorderColor;
    }
  }

  Widget _buildCheckMark() {
    if (widget.state == CheckboxState.checked) {
      return CustomPaint(
        size: Size(widget.actualSize, widget.actualSize),
        painter: _CheckMarkPainter(
          color: widget.checkColor,
          progress: _animation.value,
        ),
      );
    } else if (widget.state == CheckboxState.indeterminate) {
      return CustomPaint(
        size: Size(widget.actualSize, widget.actualSize),
        painter: _IndeterminatePainter(
          color: widget.indeterminateColor,
          progress: _animation.value,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.shape == CheckboxShape.circle
        ? widget.actualSize / 2
        : (widget.borderRadius ?? widget.defaultBorderRadius);

    final currentVisualState = _currentVisualState;

    Widget checkbox = AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Build decoration with focus ring support
        BoxDecoration decoration = BoxDecoration(
          color: _getCurrentBackgroundColor(),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: _getCurrentBorderColor(),
            width: widget.borderWidth,
          ),
        );

        // Add focus ring shadow if focused
        if (currentVisualState == CheckboxVisualState.focused &&
            widget.focusRingColor != null) {
          decoration = decoration.copyWith(
            boxShadow: [
              BoxShadow(
                color: widget.focusRingColor!,
                offset: Offset.zero,
                blurRadius: 0,
                spreadRadius: widget.focusRingWidth,
              ),
            ],
          );
        }

        return Container(
          width: widget.actualSize,
          height: widget.actualSize,
          decoration: decoration,
          child: Center(
            child: _buildCheckMark(),
          ),
        );
      },
    );

    final isDisabled = widget.onChanged == null;

    if (isDisabled) {
      checkbox = Opacity(
        opacity: widget.disabledOpacity,
        child: checkbox,
      );
    }

    // Wrap checkbox with interaction handlers for non-disabled state
    if (!isDisabled) {
      checkbox = Focus(
        onFocusChange: (hasFocus) {
          setState(() => _isFocused = hasFocus);
        },
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.space ||
                event.logicalKey == LogicalKeyboardKey.enter) {
              _handleTap();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _handleTap,
            child: checkbox,
          ),
        ),
      );
    }

    // If no label or description, return just the checkbox
    if (widget.label == null && widget.description == null) {
      return checkbox;
    }

    // Build the text content
    Widget? textContent;
    if (widget.label != null || widget.description != null) {
      final labelStyle = widget.labelStyle ??
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color:
                isDisabled ? const Color(0xFF647690) : const Color(0xFFFFFFFF),
            height: 20 / 14,
          );

      final descriptionStyle = widget.descriptionStyle ??
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                isDisabled ? const Color(0xFF647690) : const Color(0xFFFFFFFF),
            height: 20 / 14,
          );

      final textWidgets = <Widget>[];

      if (widget.label != null) {
        textWidgets.add(
          Text(
            widget.label!,
            style: labelStyle,
          ),
        );
      }

      if (widget.description != null) {
        if (textWidgets.isNotEmpty) {
          textWidgets.add(const SizedBox(height: 4));
        }
        textWidgets.add(
          Text(
            widget.description!,
            style: descriptionStyle,
          ),
        );
      }

      textContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: textWidgets,
      );
    }

    // Create the combined layout
    Widget combinedWidget = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: widget.label != null ? 2.0 : 0.0),
          child: checkbox,
        ),
        if (textContent != null) ...[
          SizedBox(width: widget.textSpacing),
          Flexible(child: textContent),
        ],
      ],
    );

    // If the checkbox is interactive and has text, make the entire row tappable
    if (!isDisabled && (widget.label != null || widget.description != null)) {
      combinedWidget = GestureDetector(
        onTap: _handleTap,
        child: combinedWidget,
      );
    }

    // Ensure proper layout constraints
    return IntrinsicWidth(
      child: combinedWidget,
    );
  }
}

/// Radio button group for managing multiple radio buttons
class RadioGroup<T> extends StatefulWidget {
  /// List of radio button options
  final List<RadioOption<T>> options;

  /// Currently selected value
  final T? value;

  /// Callback when selection changes
  final ValueChanged<T?>? onChanged;

  /// Size of the radio buttons
  final CheckboxSize size;

  /// Spacing between radio buttons
  final double spacing;

  /// Whether to arrange options vertically or horizontally
  final Axis direction;

  /// Whether the radio group is disabled
  final bool disabled;

  /// Custom styling for radio buttons
  final Color? checkedBackgroundColor;
  final Color? uncheckedBackgroundColor;
  final Color? checkedBorderColor;
  final Color? uncheckedBorderColor;
  final Color? checkColor;

  const RadioGroup({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.size = CheckboxSize.md,
    this.spacing = 8.0,
    this.direction = Axis.vertical,
    this.disabled = false,
    this.checkedBackgroundColor,
    this.uncheckedBackgroundColor,
    this.checkedBorderColor,
    this.uncheckedBorderColor,
    this.checkColor,
  });

  @override
  State<RadioGroup<T>> createState() => _RadioGroupState<T>();
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  void _handleChanged(T value) {
    if (widget.disabled || widget.onChanged == null) return;
    widget.onChanged!(value);
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.options.map((option) {
      final isSelected = widget.value == option.value;

      return GestureDetector(
        onTap: widget.disabled ? null : () => _handleChanged(option.value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseCheckbox(
              state:
                  isSelected ? CheckboxState.checked : CheckboxState.unchecked,
              shape: CheckboxShape.circle,
              size: widget.size,
              onChanged:
                  widget.disabled ? null : (_) => _handleChanged(option.value),
              checkedBackgroundColor:
                  widget.checkedBackgroundColor ?? const Color(0xFF3B4554),
              uncheckedBackgroundColor:
                  widget.uncheckedBackgroundColor ?? const Color(0xFFFFFFFF),
              checkedBorderColor:
                  widget.checkedBorderColor ?? const Color(0xFF3B4554),
              uncheckedBorderColor:
                  widget.uncheckedBorderColor ?? const Color(0xFFD0D5DD),
              checkColor: widget.checkColor ?? const Color(0xFFFFFFFF),
            ),
            if (option.label != null) ...[
              SizedBox(width: widget.size == CheckboxSize.sm ? 6.0 : 8.0),
              option.label!,
            ],
          ],
        ),
      );
    }).toList();

    if (widget.direction == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
            .expand((child) => [child, SizedBox(height: widget.spacing)])
            .take(children.length * 2 - 1)
            .toList(),
      );
    } else {
      return Row(
        children: children
            .expand((child) => [child, SizedBox(width: widget.spacing)])
            .take(children.length * 2 - 1)
            .toList(),
      );
    }
  }
}

/// Radio option data class
class RadioOption<T> {
  /// The value associated with this option
  final T value;

  /// Optional label widget to display next to the radio button
  final Widget? label;

  const RadioOption({
    required this.value,
    this.label,
  });

  /// Create a radio option with text label
  factory RadioOption.text({
    required T value,
    required String text,
    TextStyle? style,
  }) {
    return RadioOption(
      value: value,
      label: Text(
        text,
        style: style ??
            const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2A313C),
            ),
      ),
    );
  }
}

/// Predefined checkbox configurations matching common design patterns
class Checkboxes {
  /// Creates a standard checkbox
  static BaseCheckbox checkbox({
    CheckboxState state = CheckboxState.unchecked,
    ValueChanged<CheckboxState>? onChanged,
    CheckboxSize size = CheckboxSize.md,
    String? label,
    String? description,
    TextStyle? labelStyle,
    TextStyle? descriptionStyle,
    double textSpacing = 8.0,
    Color? checkedBackgroundColor,
    Color? uncheckedBackgroundColor,
    Color? checkedBorderColor,
    Color? uncheckedBorderColor,
    Color? checkColor,
    Color? focusRingColor = const Color(0xFF989DB3),
    CheckboxVisualState? forceVisualState,
  }) {
    return BaseCheckbox(
      state: state,
      onChanged: onChanged,
      size: size,
      shape: CheckboxShape.rectangle,
      label: label,
      description: description,
      labelStyle: labelStyle,
      descriptionStyle: descriptionStyle,
      textSpacing: textSpacing,
      checkedBackgroundColor: checkedBackgroundColor ?? const Color(0xFF3B4554),
      uncheckedBackgroundColor:
          uncheckedBackgroundColor ?? const Color(0xFFFFFFFF),
      checkedBorderColor: checkedBorderColor ?? const Color(0xFF3B4554),
      uncheckedBorderColor: uncheckedBorderColor ?? const Color(0xFFD0D5DD),
      checkColor: checkColor ?? const Color(0xFFFFFFFF),
      focusRingColor: focusRingColor,
      forceVisualState: forceVisualState,
    );
  }

  /// Creates a radio button
  /// Note: Radio buttons only support checked/unchecked states, not indeterminate
  static BaseCheckbox radio({
    RadioState state = RadioState.unchecked,
    ValueChanged<RadioState>? onChanged,
    CheckboxSize size = CheckboxSize.md,
    String? label,
    String? description,
    TextStyle? labelStyle,
    TextStyle? descriptionStyle,
    double textSpacing = 8.0,
    Color? checkedBackgroundColor,
    Color? uncheckedBackgroundColor,
    Color? checkedBorderColor,
    Color? uncheckedBorderColor,
    Color? checkColor,
    Color? focusRingColor = const Color(0xFF989DB3),
    CheckboxVisualState? forceVisualState,
  }) {
    return BaseCheckbox(
      state: state == RadioState.checked
          ? CheckboxState.checked
          : CheckboxState.unchecked,
      onChanged: onChanged != null
          ? (checkboxState) {
              // Convert CheckboxState back to RadioState
              // Radio buttons should never receive indeterminate state, but handle it just in case
              final radioState = checkboxState == CheckboxState.checked
                  ? RadioState.checked
                  : RadioState.unchecked;
              onChanged(radioState);
            }
          : null,
      size: size,
      shape: CheckboxShape.circle,
      label: label,
      description: description,
      labelStyle: labelStyle,
      descriptionStyle: descriptionStyle,
      textSpacing: textSpacing,
      checkedBackgroundColor: checkedBackgroundColor ?? const Color(0xFF3B4554),
      uncheckedBackgroundColor:
          uncheckedBackgroundColor ?? const Color(0xFFFFFFFF),
      checkedBorderColor: checkedBorderColor ?? const Color(0xFF3B4554),
      uncheckedBorderColor: uncheckedBorderColor ?? const Color(0xFFD0D5DD),
      checkColor: checkColor ?? const Color(0xFFFFFFFF),
      focusRingColor: focusRingColor,
      forceVisualState: forceVisualState,
    );
  }

  /// Creates a radio group
  static RadioGroup<T> radioGroup<T>({
    required List<RadioOption<T>> options,
    T? value,
    ValueChanged<T?>? onChanged,
    CheckboxSize size = CheckboxSize.md,
    double spacing = 8.0,
    Axis direction = Axis.vertical,
    bool disabled = false,
    Color? checkedBackgroundColor,
    Color? uncheckedBackgroundColor,
    Color? checkedBorderColor,
    Color? uncheckedBorderColor,
    Color? checkColor,
  }) {
    return RadioGroup<T>(
      options: options,
      value: value,
      onChanged: onChanged,
      size: size,
      spacing: spacing,
      direction: direction,
      disabled: disabled,
      checkedBackgroundColor: checkedBackgroundColor,
      uncheckedBackgroundColor: uncheckedBackgroundColor,
      checkedBorderColor: checkedBorderColor,
      uncheckedBorderColor: uncheckedBorderColor,
      checkColor: checkColor,
    );
  }
}

/// Custom painter for check mark icon
class _CheckMarkPainter extends CustomPainter {
  final Color color;
  final double progress;

  _CheckMarkPainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    final checkSize = size.width * 0.6;
    final offsetX = (size.width - checkSize) / 2;
    final offsetY = (size.height - checkSize) / 2;

    // Draw check mark with animation
    path.moveTo(offsetX + checkSize * 0.2, offsetY + checkSize * 0.5);
    path.lineTo(
      offsetX + checkSize * (0.2 + (0.25 * progress)),
      offsetY + checkSize * (0.5 + (0.2 * progress)),
    );

    if (progress > 0.5) {
      final secondProgress = (progress - 0.5) * 2;
      path.lineTo(
        offsetX + checkSize * (0.45 + (0.35 * secondProgress)),
        offsetY + checkSize * (0.7 - (0.4 * secondProgress)),
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Custom painter for indeterminate mark icon
class _IndeterminatePainter extends CustomPainter {
  final Color color;
  final double progress;

  _IndeterminatePainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final lineWidth = size.width * 0.5 * progress;
    final centerY = size.height / 2;
    final startX = (size.width - lineWidth) / 2;
    final endX = startX + lineWidth;

    canvas.drawLine(
      Offset(startX, centerY),
      Offset(endX, centerY),
      paint,
    );
  }

  // coverage:ignore-line
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
