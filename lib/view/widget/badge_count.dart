import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

class BadgeCount extends StatelessWidget {
  final int count;
  final int maxCount;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle textStyle;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  BadgeCount({
    super.key,
    required this.count,
    this.maxCount = 99,
    this.backgroundColor = UiColors.neutral100,
    this.textColor = UiColors.neutral800,
    TextStyle? textStyle,
    this.borderRadius = UiRadius.xs,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
  }) : textStyle = textStyle ??
            UiTextStyles.textXs.copyWith(fontWeight: UiTextStyles.medium);

  @override
  Widget build(BuildContext context) {
    final displayText = count > maxCount ? '$maxCount+' : count.toString();

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: padding,
      child: Text(
        displayText,
        style: textStyle.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
