import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'unping_widgetbook_localizations_de.dart';
import 'unping_widgetbook_localizations_en.dart';
import 'unping_widgetbook_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/unping_widgetbook_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @button.
  ///
  /// In en, this message translates to:
  /// **'Button'**
  String get button;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @option.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get option;

  /// No description provided for @inputLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get inputLabel;

  /// No description provided for @inputPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Placeholder'**
  String get inputPlaceholder;

  /// No description provided for @inputFocused.
  ///
  /// In en, this message translates to:
  /// **'Focused'**
  String get inputFocused;

  /// No description provided for @inputError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get inputError;

  /// No description provided for @inputErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error message'**
  String get inputErrorMessage;

  /// No description provided for @inputDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get inputDisabled;

  /// No description provided for @inputWithPrefix.
  ///
  /// In en, this message translates to:
  /// **'With prefix'**
  String get inputWithPrefix;

  /// No description provided for @inputWithSuffix.
  ///
  /// In en, this message translates to:
  /// **'With suffix'**
  String get inputWithSuffix;

  /// No description provided for @inputEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get inputEmailPlaceholder;

  /// No description provided for @inputUsernamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get inputUsernamePlaceholder;

  /// No description provided for @inputDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get inputDescription;

  /// No description provided for @inputDescriptionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write something...'**
  String get inputDescriptionPlaceholder;

  /// No description provided for @inputWritePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write...'**
  String get inputWritePlaceholder;

  /// No description provided for @inputTooLong.
  ///
  /// In en, this message translates to:
  /// **'Too long'**
  String get inputTooLong;

  /// No description provided for @inputWithCounter.
  ///
  /// In en, this message translates to:
  /// **'With counter'**
  String get inputWithCounter;

  /// No description provided for @inputMaxCharsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Max 120 chars'**
  String get inputMaxCharsPlaceholder;

  /// No description provided for @inputSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get inputSearchPlaceholder;

  /// No description provided for @inputClearableSearch.
  ///
  /// In en, this message translates to:
  /// **'Clearable search'**
  String get inputClearableSearch;

  /// No description provided for @inputPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get inputPasswordLabel;

  /// No description provided for @inputPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get inputPasswordPlaceholder;

  /// No description provided for @inputWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Weak password'**
  String get inputWeakPassword;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
