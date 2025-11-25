import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/l10n/language_extension.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
    name: 'ConfigurableEmojiBlast',
    type: BaseEmojiBlast,
    path: 'Components/EmojiBlast/Configurable')
Widget buildConfigurableEmojiBlast(BuildContext context) {
  // size of screen for position estimation
  final size = MediaQuery.of(context).size;

// positioning of emote blast
  final position = context.knobs.list(
      label: 'Selected Position',
      options: Position.values,
      labelBuilder: (value) => value.name,
      initialOption: Position.center);

// specific emote selection
  final specificEmote =
      context.knobs.boolean(label: 'Specfic Emote', initialValue: false);

// amount of emotes selection
  final selectedAmount = context.knobs.list(
      label: 'Selected Amount',
      options: Amount.values,
      labelBuilder: (value) => value.name);

  String? emote;
  if (specificEmote) {
    emote = context.knobs.list(
        label: 'Emote',
        options: ['😀', '😂', '😍', '🥳', '🎉', '🔥'],
        initialOption: '🔥');
  }

  return UnpingUIContainer(
      child: Stack(
    children: [
      Text(
        context.lang.emojiBlast,
        style: UiTextStyles.textMd.copyWith(color: UiColors.surface),
      ),
      BaseEmojiBlast(
        amount: selectedAmount,
        emote: emote,
        position: position,
        size: size,
      ),
    ],
  ));
}
