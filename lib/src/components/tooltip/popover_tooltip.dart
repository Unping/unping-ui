// lib/components/tooltip/popover_tooltip.dart
import 'package:flutter/material.dart';
import 'tooltip_types.dart';
import 'tooltip_overlay.dart';

class PopoverTooltip extends StatefulWidget {
  const PopoverTooltip({
    super.key,
    required this.child,
    required this.message,
    this.content, // NEW
    this.variant = UiTooltipVariant.neutral,
    this.placement = UiTooltipPlacement.auto,
    this.enabled = true,
    this.style,
    this.enableSemantics = true,
  });

  final Widget child;
  final String message;
  final Widget? content;
  final UiTooltipVariant variant;
  final UiTooltipPlacement placement;
  final bool enabled;
  final UiTooltipStyle? style;
  final bool enableSemantics;

  @override
  State<PopoverTooltip> createState() => _PopoverTooltipState();
}

class _PopoverTooltipState extends State<PopoverTooltip>
    with TickerProviderStateMixin {
  final _link = LayerLink();
  OverlayEntry? _entry;
  late final AnimationController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.style?.showDuration ?? kTooltipShowDuration,
      reverseDuration: widget.style?.hideDuration ?? kTooltipHideDuration,
    );
  }

  @override
  void dispose() {
    _remove();
    _controller.dispose();
    super.dispose();
  }

  void _toggle() => _visible ? _hide() : _show();

  void _show() {
    if (!widget.enabled || _visible) return;
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    final vw = MediaQuery.sizeOf(context).width;
    final style = widget.style ?? styleFor(widget.variant, vw);
    final placement = resolvePlacement(context: context, explicit: widget.placement);

    _entry = buildTooltipOverlay(
      context: context,
      link: _link,
      controller: _controller,
      message: widget.message,
      content: widget.content,
      placement: placement,
      style: style,
    );

    overlay.insert(_entry!);
    _visible = true;
    _controller.forward(from: 0);
  }

  void _hide() async {
    if (!_visible) return;
    try {
      await _controller.reverse();
    } finally {
      _remove();
    }
  }

  void _remove() {
    _entry?.remove();
    _entry = null;
    _visible = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget core = CompositedTransformTarget(link: _link, child: widget.child);
    if (widget.enableSemantics) {
      core = Semantics(tooltip: widget.message, child: core);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggle,
      child: FocusableActionDetector(
        onShowFocusHighlight: (f) => f ? _show() : _hide(),
        child: core,
      ),
    );
  }
}
