import 'package:flutter/material.dart';
import 'package:widgetbook_workspace/l10n/unping_widgetbook_localizations.dart';

extension LanguageExtension on BuildContext {
  AppLocalizations get lang => AppLocalizations.of(this)!;
}
