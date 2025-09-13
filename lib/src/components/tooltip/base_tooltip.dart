// lib/components/tooltip/base_tooltip.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'tooltip_types.dart';
import 'tooltip_overlay.dart';

class UiTooltip extends StatefulWidget {
  const UiTooltip({
    super.key,
    required this.child,
    required this.message,
    this.content, // rich content
    this.variant = UiTooltipVariant.neutral,
    this.placement = UiTooltipPlacement.auto,
    this.enabled = true,
    this.style,
    this.triggerOnLongPress = true,
    this.triggerOnHover = true,
    this.enableSemantics = true,
  });

  final Widget child;
  final String message;
  final Widget? content;
  final UiTooltipVariant variant;
  final UiTooltipPlacement placement;
  final bool enabled;
  final UiTooltipStyle? style;
  final bool triggerOnHover;
  final bool triggerOnLongPress;
  final bool enableSemantics;

  @override
  State<UiTooltip> createState() => _UiTooltipState();
}

class _UiTooltipState extends State<UiTooltip> with TickerProviderStateMixin {
  final _link = LayerLink();
  OverlayEntry? _entry;
  Timer? _delay;
  late final AnimationController _controller;
  bool _visible = false;

  // Track real hover to avoid canceling focus-driven shows.
  bool _hovering = false;

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
  void didUpdateWidget(covariant UiTooltip old) {
    super.didUpdateWidget(old);
    if (!widget.enabled) _hide(immediate: true);

    _controller
      ..duration = widget.style?.showDuration ?? kTooltipShowDuration
      ..reverseDuration = widget.style?.hideDuration ?? kTooltipHideDuration;

    if (old.message != widget.message || old.child.key != widget.child.key) {
      _hide(immediate: true);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _hide(immediate: true);
  }

  @override
  void reassemble() {
    super.reassemble();
    _hide(immediate: true);
  }

  @override
  void dispose() {
    _delay?.cancel();
    _removeEntry();
    _controller.dispose();
    super.dispose();
  }

  void _scheduleShow() {
    if (!widget.enabled || _visible) return;
    _delay?.cancel();
    _delay = Timer(widget.style?.showDelay ?? kTooltipShowDelay, _show);
  }

  void _show() {
    if (!mounted || _visible || !widget.enabled) return;

    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    final vw = MediaQuery.sizeOf(context).width;
    final style = widget.style ?? styleFor(widget.variant, vw);

    final placement = resolvePlacement(
      context: context,
      explicit: widget.placement,
    );

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

  void _hide({bool immediate = false}) async {
    _delay?.cancel();
    if (!_visible) return;
    if (immediate) {
      _removeEntry();
      return;
    }
    try {
      await _controller.reverse();
    } finally {
      _removeEntry();
    }
  }

  void _removeEntry() {
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

    //   KEYBOARD: react to actual descendant focus changes (TextField et al).
    core = FocusScope(
      onFocusChange: (hasFocus) {
        if (!widget.enabled) return;
        if (hasFocus) {
          _scheduleShow(); // keep 350ms delay for keyboard
        } else {
          _hide();
        }
      },
      child: core,
    );

    // TOUCH
    core = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: widget.triggerOnLongPress ? _scheduleShow : null,
      onLongPressEnd: (_) => _hide(),
      onTapDown: (_) {
        if (!widget.triggerOnLongPress &&
            defaultTargetPlatform == TargetPlatform.android) {
          _scheduleShow();
        }
      },
      onTapCancel: _hide,
      onTapUp: (_) => _hide(),
      child: core,
    );

    // HOVER (guarded so an exit without enter doesn't cancel focus show)
    core = MouseRegion(
      onEnter: widget.triggerOnHover
          ? (_) {
              _hovering = true;
              _scheduleShow();
            }
          : null,
      onExit: widget.triggerOnHover
          ? (_) {
              if (_hovering) {
                _hovering = false;
                _hide();
              }
            }
          : null,
      child: core,
    );

    // Do not drive visibility from highlight modes.
    return FocusableActionDetector(
      onShowHoverHighlight: null,
      onShowFocusHighlight: null,
      child: core,
    );
  }
}
