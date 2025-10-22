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

  /// No description provided for @tooltipTitle.
  ///
  /// In en, this message translates to:
  /// **'Tooltips'**
  String get tooltipTitle;

  /// No description provided for @tooltipDescription.
  ///
  /// In en, this message translates to:
  /// **'Tooltips are essential for providing contextual information and guidance to users within an application. Our design system includes a variety of tooltip styles to ensure consistency and clarity across all user interfaces. These components are designed to be easily recognizable and to provide quick, helpful information without disrupting the user\'s workflow.'**
  String get tooltipDescription;

  /// No description provided for @tooltipCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories:'**
  String get tooltipCategories;

  /// No description provided for @tooltipBasicCategory.
  ///
  /// In en, this message translates to:
  /// **'Basic Tooltip'**
  String get tooltipBasicCategory;

  /// No description provided for @tooltipBasicCategoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Simple tooltips that provide brief information or descriptions.'**
  String get tooltipBasicCategoryDesc;

  /// No description provided for @tooltipExtendedCategory.
  ///
  /// In en, this message translates to:
  /// **'Extended Tooltip'**
  String get tooltipExtendedCategory;

  /// No description provided for @tooltipExtendedCategoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Tooltips with additional details or instructions.'**
  String get tooltipExtendedCategoryDesc;

  /// No description provided for @tooltipUsageTips.
  ///
  /// In en, this message translates to:
  /// **'Usage Tips:'**
  String get tooltipUsageTips;

  /// No description provided for @tooltipBasicUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'Basic Tooltip:'**
  String get tooltipBasicUsageTitle;

  /// No description provided for @tooltipConciseInfo.
  ///
  /// In en, this message translates to:
  /// **'Concise Information'**
  String get tooltipConciseInfo;

  /// No description provided for @tooltipConciseInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Use basic tooltips to provide brief, concise information or descriptions.'**
  String get tooltipConciseInfoDesc;

  /// No description provided for @tooltipContextualHelp.
  ///
  /// In en, this message translates to:
  /// **'Contextual Help'**
  String get tooltipContextualHelp;

  /// No description provided for @tooltipContextualHelpDesc.
  ///
  /// In en, this message translates to:
  /// **'Place tooltips near the relevant UI elements to offer immediate contextual help.'**
  String get tooltipContextualHelpDesc;

  /// No description provided for @tooltipConsistentStyling.
  ///
  /// In en, this message translates to:
  /// **'Consistent Styling'**
  String get tooltipConsistentStyling;

  /// No description provided for @tooltipConsistentStylingDesc.
  ///
  /// In en, this message translates to:
  /// **'Ensure that all basic tooltips have a consistent style, including font, color, and background.'**
  String get tooltipConsistentStylingDesc;

  /// No description provided for @tooltipExtendedUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'Extended Tooltip:'**
  String get tooltipExtendedUsageTitle;

  /// No description provided for @tooltipDetailedInfo.
  ///
  /// In en, this message translates to:
  /// **'Detailed Information'**
  String get tooltipDetailedInfo;

  /// No description provided for @tooltipDetailedInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Use extended tooltips to provide more detailed information or instructions.'**
  String get tooltipDetailedInfoDesc;

  /// No description provided for @tooltipUserGuidance.
  ///
  /// In en, this message translates to:
  /// **'User Guidance'**
  String get tooltipUserGuidance;

  /// No description provided for @tooltipUserGuidanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Place extended tooltips near complex UI elements to guide users through their interactions.'**
  String get tooltipUserGuidanceDesc;

  /// No description provided for @tooltipClearFormatting.
  ///
  /// In en, this message translates to:
  /// **'Clear Formatting'**
  String get tooltipClearFormatting;

  /// No description provided for @tooltipClearFormattingDesc.
  ///
  /// In en, this message translates to:
  /// **'Ensure that extended tooltips are well-formatted, with clear headings, bullet points, or steps as needed.'**
  String get tooltipClearFormattingDesc;

  /// No description provided for @tooltipGeneralTips.
  ///
  /// In en, this message translates to:
  /// **'General Tips:'**
  String get tooltipGeneralTips;

  /// No description provided for @tooltipPlacement.
  ///
  /// In en, this message translates to:
  /// **'Placement'**
  String get tooltipPlacement;

  /// No description provided for @tooltipPlacementDesc.
  ///
  /// In en, this message translates to:
  /// **'Position tooltips close to the relevant UI elements to maintain context and usability.'**
  String get tooltipPlacementDesc;

  /// No description provided for @tooltipTrigger.
  ///
  /// In en, this message translates to:
  /// **'Trigger'**
  String get tooltipTrigger;

  /// No description provided for @tooltipTriggerDesc.
  ///
  /// In en, this message translates to:
  /// **'Use hover or focus states to trigger tooltips, ensuring they appear when users need them.'**
  String get tooltipTriggerDesc;

  /// No description provided for @tooltipDismissal.
  ///
  /// In en, this message translates to:
  /// **'Dismissal'**
  String get tooltipDismissal;

  /// No description provided for @tooltipDismissalDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow users to dismiss tooltips easily, either by clicking away or after a short delay.'**
  String get tooltipDismissalDesc;

  /// No description provided for @tooltipAccessibility.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get tooltipAccessibility;

  /// No description provided for @tooltipAccessibilityDesc.
  ///
  /// In en, this message translates to:
  /// **'Ensure tooltips are accessible to screen readers and keyboard users.'**
  String get tooltipAccessibilityDesc;

  /// No description provided for @tooltipMessage.
  ///
  /// In en, this message translates to:
  /// **'This is a tooltip'**
  String get tooltipMessage;

  /// No description provided for @tooltipExtendedMessage.
  ///
  /// In en, this message translates to:
  /// **'Tooltips are used to describe or identify an element. In most scenarios, tooltips help the user understand the meaning, function or alt-text of an element.'**
  String get tooltipExtendedMessage;

  /// No description provided for @toggleSmall.
  ///
  /// In en, this message translates to:
  /// **'Small toggle'**
  String get toggleSmall;

  /// No description provided for @toggleSmallDesc.
  ///
  /// In en, this message translates to:
  /// **'This is a small sized toggle.'**
  String get toggleSmallDesc;

  /// No description provided for @toggleMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium toggle'**
  String get toggleMedium;

  /// No description provided for @toggleMediumDesc.
  ///
  /// In en, this message translates to:
  /// **'This is a medium sized toggle.'**
  String get toggleMediumDesc;

  /// No description provided for @toggleLarge.
  ///
  /// In en, this message translates to:
  /// **'Large toggle'**
  String get toggleLarge;

  /// No description provided for @toggleLargeDesc.
  ///
  /// In en, this message translates to:
  /// **'This is a large sized toggle.'**
  String get toggleLargeDesc;

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// No description provided for @newItem.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newItem;

  /// No description provided for @singleSelect.
  ///
  /// In en, this message translates to:
  /// **'Single Selection'**
  String get singleSelect;

  /// No description provided for @multiSelect.
  ///
  /// In en, this message translates to:
  /// **'Multi Selection'**
  String get multiSelect;

  /// No description provided for @chooseALanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose a Language'**
  String get chooseALanguage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;
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
