import 'package:flutter/material.dart';
import 'package:unping_ui/class/badge_size.dart';
import 'package:unping_ui/controller/base_badge_controller.dart';

class BaseBadge extends StatefulWidget {
  final String text;
  final Widget? leftWidget1;
  final Widget? leftWidget2;
  final Widget? rightWidget;
  final bool removable;
  final BaseBadgeController? controller;
  final BadgeSize size;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double borderWidth;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;

  const BaseBadge({
    super.key,
    required this.text,
    this.leftWidget1,
    this.leftWidget2,
    this.rightWidget,
    this.removable = false,
    this.controller,
    this.size = BadgeSize.md,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.textStyle,
    this.borderRadius,
  });

  @override
  State<BaseBadge> createState() => _BaseBadgeState();
}

class _BaseBadgeState extends State<BaseBadge> {
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.controller?.isVisible ?? true;

    widget.controller?.addListener(() {
      if (mounted) {
        setState(() {
          _isVisible = widget.controller!.isVisible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor!, width: widget.borderWidth)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.leftWidget1 != null) ...[
            widget.leftWidget1!,
            const SizedBox(width: 4),
          ],
          if (widget.leftWidget2 != null) ...[
            widget.leftWidget2!,
            const SizedBox(width: 4),
          ],
          Text(
            widget.text,
            style: widget.textStyle ??
                TextStyle(
                  color: widget.textColor,
                  fontSize: widget.size == BadgeSize.sm
                      ? 12
                      : widget.size == BadgeSize.md
                          ? 14
                          : 16,
                ),
          ),
          if (widget.rightWidget != null) ...[
            const SizedBox(width: 4),
            widget.rightWidget!,
          ],
          if (widget.removable) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => widget.controller?.remove(),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}
