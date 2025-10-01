import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unping_ui/unping_ui.dart';

class ToggleSwitch extends StatefulWidget {
  /// Current state of the switch
  final bool value;

  /// Callback when toggled
  final ValueChanged<bool> onChanged;

  /// Track color when ON
  final Color activeColor;

  /// Track color when OFF
  final Color inactiveColor;

  /// Thumb color
  final Color thumbColor;

  /// Toggle size variant
  final ToggleSize size;

  /// Whether the toggle is disabled
  /// When true:
  /// - The toggle cannot be interacted with (tapping is ignored)
  /// - The track is dimmed to indicate a disabled state
  final bool isDisabled;

  /// Animation duration for state changes
  final Duration animationDuration;

  /// Focus ring color (for focus state shadow)
  final Color focusRingColor;

  /// Focus ring width (for focus state shadow)
  final double focusRingWidth;

  /// Optional label text displayed next to the toggle
  final String? label;

  /// Optional description text displayed below the label
  final String? description;

  final TextStyle? labelStyle;
  final TextStyle? descriptionStyle;

  /// Space between toggle and text
  final double spacing;

  /// Opacity when disabled
  final double disabledOpacity;

  /// Force a specific visual state regardless of current conditions.
  /// When provided, this overrides [_currentVisualState].
  final ToggleVisualState? forceVisualState;

  const ToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = UiColors.toggleActive,
    this.inactiveColor = UiColors.neutral600,
    this.thumbColor = UiColors.neutral400,
    this.size = ToggleSize.md,
    this.isDisabled = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.focusRingColor = UiColors.neutral25,
    this.focusRingWidth = 3.0,
    this.label,
    this.description,
    this.labelStyle,
    this.descriptionStyle,
    this.spacing = UiSpacing.xs,
    this.disabledOpacity = 0.4,
    this.forceVisualState,
  });

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late FocusNode _focusNode;

  // Map ToggleSize → actual dimensions
  double get _trackWidth {
    switch (widget.size) {
      case ToggleSize.sm:
        return 36;
      case ToggleSize.md:
        return 50;
      case ToggleSize.lg:
        return 64;
    }
  }

  double get _trackHeight {
    switch (widget.size) {
      case ToggleSize.sm:
        return 20;
      case ToggleSize.md:
        return 28;
      case ToggleSize.lg:
        return 36;
    }
  }

  double get _thumbSize {
    switch (widget.size) {
      case ToggleSize.sm:
        return 14;
      case ToggleSize.md:
        return 20;
      case ToggleSize.lg:
        return 28;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: widget.value ? 1.0 : 0.0,
    );
    _focusNode = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant ToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Determines the current state of the toggle.
  void _toggle() {
    if (!widget.isDisabled) widget.onChanged(!widget.value);
  }

  // Determines the current visual state of the toggle.
  ToggleVisualState get _currentVisualState {
    if (widget.forceVisualState != null) {
      return widget.forceVisualState!;
    }

    if (widget.isDisabled) return ToggleVisualState.disabled;
    if (_focusNode.hasFocus) return ToggleVisualState.focused;
    return ToggleVisualState.normal;
  }

  @override
  Widget build(BuildContext context) {
    final toggleWidget = Focus(
      focusNode: _focusNode,
      // Handle keyboard input
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.space) {
            _toggle();
            return KeyEventResult.handled;
          }
        }
        // coverage:ignore-start
        return KeyEventResult.ignored;
        // coverage:ignore-end
      },
      child: GestureDetector(
        onTap: _toggle,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Determine track color
            final trackColor = _currentVisualState == ToggleVisualState.disabled
                ? widget.inactiveColor.withValues(
                    alpha: (widget.disabledOpacity * 255).round().toDouble(),
                  )
                : Color.lerp(
                    widget.inactiveColor,
                    widget.activeColor,
                    _controller.value,
                  );

            return Container(
              width: _trackWidth,
              height: _trackHeight,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(_trackHeight / 2),
                border: _currentVisualState == ToggleVisualState.focused
                    ? Border.all(
                        color: widget.focusRingColor,
                        width: widget.focusRingWidth)
                    : null,
              ),
              child: Align(
                alignment: Alignment.lerp(
                  Alignment.centerLeft,
                  Alignment.centerRight,
                  _controller.value,
                )!,
                child: Container(
                  width: _thumbSize,
                  height: _thumbSize,
                  decoration: BoxDecoration(
                    color: widget.thumbColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    // If no label or description, return just the toggle
    if (widget.label == null && widget.description == null) {
      return toggleWidget;
    }

    // Build label + description
    final textWidgets = <Widget>[];
    if (widget.label != null) {
      textWidgets.add(Text(
        widget.label!,
        style: widget.labelStyle ??
            UiTextStyles.textSmMedium.copyWith(
              color:
                  widget.isDisabled ? UiColors.neutral500 : UiColors.onPrimary,
            ),
      ));
    }
    if (widget.description != null) {
      if (textWidgets.isNotEmpty) textWidgets.add(SizedBox(height: 4));
      textWidgets.add(Text(
        widget.description!,
        style: widget.descriptionStyle ??
            UiTextStyles.textSm.copyWith(
              color:
                  widget.isDisabled ? UiColors.neutral500 : UiColors.onPrimary,
            ),
      ));
    }

    return GestureDetector(
      onTap: _toggle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          toggleWidget,
          SizedBox(width: widget.spacing),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: textWidgets,
            ),
          ),
        ],
      ),
    );
  }
}
