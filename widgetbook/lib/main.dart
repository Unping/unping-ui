import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/introduction.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/l10n/unping_widgetbook_localizations.dart';

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var readme = '';
  var version = '';
  var title = 'Unping UI';

  try {
    readme = await rootBundle.loadString('assets/README_COPIED.md');
  } catch (e) {
    debugPrint('Cannot read README.md from assets: $e');
    readme =
        'README.md not available. Please run: ./scripts/sync-widgetbook-assets.sh';
  }

  try {
    version = await rootBundle.loadString('assets/UNPING_UI_VERSION.md');
    version = version.trim(); // Remove any whitespace/newlines
    // Generate title with version
    if (version.isNotEmpty && version != 'unknown') {
      title = 'Unping UI v$version';
    }
  } catch (e) {
    debugPrint('Cannot read version from assets: $e');
    version = 'unknown';
  }

  runApp(WidgetbookApp(readme: readme, version: version, title: title));
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp(
      {super.key,
      this.readme = '',
      this.version = '',
      this.title = 'Unping UI'});

  final String readme;
  final String version;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appBuilder: (context, child) => MaterialApp(
        title: 'Unping UI Widgetbook',
        theme: UiTheme.lightTheme(),
        darkTheme: UiTheme.darkTheme(),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: child,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return DefaultTextStyle(
            style: const TextStyle(decoration: TextDecoration.none),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
      addons: [
        LocalizationAddon(
            locales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates)
      ],
      darkTheme: UiTheme.darkTheme(),
      lightTheme: UiTheme.lightTheme(),
      themeMode: ThemeMode.system,
      initialRoute: '?path=introduction',
      // The [directories] variable does not exist yet,
      // it will be generated in the next step
      directories: [
        WidgetbookUseCase(
          name: 'Introduction',
          builder: (BuildContext context) => IntroductionWidgetbook(
            readme: readme,
            title: title,
          ),
        ),
        // Find and place Foundation directory as second entry
        ...directories.where((dir) => dir.name == 'Foundation'),
        // Add all other directories except Foundation
        ...directories.where((dir) => dir.name != 'Foundation'),
      ],
    );
  }
}
