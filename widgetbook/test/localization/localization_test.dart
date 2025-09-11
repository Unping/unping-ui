import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widgetbook_workspace/l10n/language_extension.dart';

import 'package:widgetbook_workspace/l10n/unping_widgetbook_localizations.dart';

void main() {
  group('Localization', () {
    testWidgets('Test English localization', (WidgetTester tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        _localizedApp(
          Builder(
            builder: (context) {
              localizations = context.lang;
              return const SizedBox.shrink();
            },
          ),
          const Locale('en'),
        ),
      );

      await tester.pumpAndSettle();

      expect(localizations.button, 'Button');
    });
    testWidgets('Test Spanish localization', (WidgetTester tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        _localizedApp(
          Builder(
            builder: (context) {
              localizations = context.lang;
              return const SizedBox.shrink();
            },
          ),
          const Locale('es'),
        ),
      );

      await tester.pumpAndSettle();

      expect(localizations.button, 'Botón');
    });
    testWidgets('Test German localization', (WidgetTester tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        _localizedApp(
          Builder(
            builder: (context) {
              localizations = context.lang;
              return const SizedBox.shrink();
            },
          ),
          const Locale('de'),
        ),
      );

      await tester.pumpAndSettle();

      expect(localizations.button, 'Knopf');
    });

    testWidgets('Widget shows localized text in English', (tester) async {
      await tester.pumpWidget(
        _localizedApp(
          Builder(
            builder: (context) {
              return Scaffold(
                body: Text(context.lang.button),
              );
            },
          ),
          const Locale('en'),
        ),
      );

      expect(find.text('Button'), findsOneWidget);
    });

    testWidgets('Widget shows localized text in German', (tester) async {
      await tester.pumpWidget(
        _localizedApp(
          Builder(
            builder: (context) {
              return Scaffold(
                body: Text(context.lang.button),
              );
            },
          ),
          const Locale('de'),
        ),
      );

      expect(find.text('Knopf'), findsOneWidget);
    });

    testWidgets('Widget shows localized text in Spanish', (tester) async {
      await tester.pumpWidget(
        _localizedApp(
          Builder(
            builder: (context) {
              return Scaffold(
                body: Text(context.lang.button),
              );
            },
          ),
          const Locale('es'),
        ),
      );

      expect(find.text('Botón'), findsOneWidget);
    });
    testWidgets('Widget shows localized text change from English to Germen',
        (tester) async {
      final localeNotifier = ValueNotifier(const Locale('en'));
      await tester.pumpWidget(
        _localizedAppWithNotifier(
          localeNotifier,
          Builder(
            builder: (context) {
              return Scaffold(
                body: GestureDetector(
                    onTap: () {
                      localeNotifier.value = Locale('de');
                    },
                    child: Text(context.lang.button)),
              );
            },
          ),
        ),
      );
      // before change
      expect(find.text('Button'), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // after change
      expect(find.text('Knopf'), findsOneWidget);
    });
  });
}

Widget _localizedApp(Widget child, Locale locale) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
}

Widget _localizedAppWithNotifier(
    ValueNotifier<Locale> localeNotifier, Widget child) {
  return ValueListenableBuilder<Locale>(
    valueListenable: localeNotifier,
    builder: (context, locale, _) {
      return MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      );
    },
  );
}
