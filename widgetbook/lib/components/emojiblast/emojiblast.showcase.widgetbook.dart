import 'dart:math';

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
  final GlobalKey<BaseEmojiBlastState> baseEmojiBlastKey =
      GlobalKey<BaseEmojiBlastState>();

  return UnpingUIContainer(
      child: Column(
    children: [
      BaseEmojiBlast(
        amount: Amount.medium,
        key: baseEmojiBlastKey,
        position: Position.random,
        size: size,
      ),
      Buttons.outline(
          text: context.lang.emojiBlast,
          onPressed: () {
            baseEmojiBlastKey.currentState!.blast();
          }),
    ],
  ));
}
