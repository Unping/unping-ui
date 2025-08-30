import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/introduction.dart';
import 'package:unping_ui/unping_ui.dart';

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var readme = '';
  try {
    readme = await rootBundle.loadString('assets/README_UNPING_UI_COPIED.md');
  } catch (e) {
    debugPrint('Cannot read README.md: $e');
  } finally {
    runApp(WidgetbookApp(readme: readme));
  }
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key, this.readme = ''});
  
  final String readme;
  
  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appBuilder: (context, child) => MaterialApp(
        title: 'Unping UI Widgetbook',
        theme: UiTheme.lightTheme(),
        darkTheme: UiTheme.darkTheme(),
        home: child,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return DefaultTextStyle(
            style: const TextStyle(decoration: TextDecoration.none),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
      // The [directories] variable does not exist yet,
      // it will be generated in the next step
      directories: [
        WidgetbookUseCase(
          name: 'Introduction',
          builder: (BuildContext context) => IntroductionWidgetbook(readme: readme),
        ),
        // Find and place Foundation directory as second entry
        ...directories.where((dir) => dir.name == 'Foundation'),
        // Add all other directories except Foundation
        ...directories.where((dir) => dir.name != 'Foundation'),
      ],
    );
  }
}