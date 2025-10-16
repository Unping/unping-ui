import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

class MyButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final IconData? icon;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    // Postavljamo iconPosition samo ako ikona postoji, inače default
    final IconPosition iconPos = widget.icon != null ? IconPosition.leading : IconPosition.leading;

    return Buttons.filled(
      text: widget.isLoading ? 'Please wait...' : widget.text,
      onPressed: widget.isLoading ? null : widget.onPressed,
      backgroundColor: UiColors.primary,
      textColor: UiColors.onPrimary,
      icon: widget.icon != null
          ? Icon(widget.icon, size: 16, color: UiColors.onPrimary)
          : null,
      iconPosition: iconPos,
    );
  }
}