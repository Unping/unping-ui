import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/l10n/language_extension.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@UseCase(
    name: 'Emoji Blast',
    type: BaseEmojiBlast,
    path: 'Components/Emojiblast/Showcase')
Widget emojiBlast(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return UnpingUIContainer(
      child: Stack(
    children: [
      Text(
        context.lang.emojiBlast,
        style: UiTextStyles.textMd.copyWith(color: UiColors.surface),
      ),
      BaseEmojiBlast(
        amount: Amount.medium,
        position: Position.random,
        size: size,
      ),
    ],
  ));
}
