import 'package:flutter/material.dart';

enum ButtonType { filled, outline, ghost }

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final Icon? icon;
  final bool isLoading;

  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.filled,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    BorderSide? border;

    switch (type) {
      case ButtonType.outline:
        backgroundColor = Colors.transparent;
        textColor = Theme.of(context).primaryColor;
        border = BorderSide(color: Theme.of(context).primaryColor, width: 2);
        break;
      case ButtonType.ghost:
        backgroundColor = Colors.transparent;
        textColor = Theme.of(context).primaryColor;
        border = null;
        break;
      case ButtonType.filled:
        backgroundColor = Theme.of(context).primaryColor;
        textColor = Colors.white;
        border = null;
        break;
    }

    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: border ?? BorderSide.none,
          ),
          elevation: type == ButtonType.filled ? 2 : 0,
        ),
        child: isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}