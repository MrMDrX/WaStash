import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('ar'),
    Locale('zh'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pt'),
    Locale('ru'),
  ];

  /// No description provided for @thisLanguage.
  ///
  /// In en, this message translates to:
  /// **'English 🇺🇸'**
  String get thisLanguage;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'WaStash'**
  String get appName;

  /// No description provided for @appSlogan.
  ///
  /// In en, this message translates to:
  /// **'Minimal WhatsApp Status Viewer & Saver App for Android'**
  String get appSlogan;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic 🇸🇦'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English 🇺🇸'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French 🇫🇷'**
  String get french;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish 🇪🇸'**
  String get spanish;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian 🇷🇺'**
  String get russian;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese 🇨🇳'**
  String get chinese;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese 🇵🇹'**
  String get portuguese;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to WaStash!'**
  String get welcome;

  /// No description provided for @continueOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueOnboarding;

  /// No description provided for @statusSaver.
  ///
  /// In en, this message translates to:
  /// **'Status Saver'**
  String get statusSaver;

  /// No description provided for @statusViewer.
  ///
  /// In en, this message translates to:
  /// **'Status Viewer'**
  String get statusViewer;

  /// No description provided for @statusSaverDescription.
  ///
  /// In en, this message translates to:
  /// **'Easily save and share any status you\'ve viewed. Never miss out on important moments.'**
  String get statusSaverDescription;

  /// No description provided for @statusViewerDescription.
  ///
  /// In en, this message translates to:
  /// **'Quickly view all your friend\'s statuses in one place. Stay updated with every moment they share.'**
  String get statusViewerDescription;

  /// No description provided for @statusSaverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Easily save any WhatsApp\nStatus to your local storage'**
  String get statusSaverSubtitle;

  /// No description provided for @beautifulDesign.
  ///
  /// In en, this message translates to:
  /// **'Beautiful Design'**
  String get beautifulDesign;

  /// No description provided for @beautifulDesignDescription.
  ///
  /// In en, this message translates to:
  /// **'A thoughtfully designed and optimized UI that makes navigating through the app a delightful experience.'**
  String get beautifulDesignDescription;

  /// No description provided for @storageAccessIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Storage access is required for Status files'**
  String get storageAccessIsRequired;

  /// No description provided for @selectStatusFolder.
  ///
  /// In en, this message translates to:
  /// **'Select Status Folder'**
  String get selectStatusFolder;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @noStatus.
  ///
  /// In en, this message translates to:
  /// **'No statuses found'**
  String get noStatus;

  /// No description provided for @savedStatus.
  ///
  /// In en, this message translates to:
  /// **'Saved Status'**
  String get savedStatus;

  /// No description provided for @savedStatusSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage your\nsaved statuses in one place'**
  String get savedStatusSubtitle;

  /// No description provided for @noSavedStatus.
  ///
  /// In en, this message translates to:
  /// **'No saved statuses found'**
  String get noSavedStatus;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteStatus.
  ///
  /// In en, this message translates to:
  /// **'Delete Status'**
  String get deleteStatus;

  /// No description provided for @deleteStatusMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this file?'**
  String get deleteStatusMessage;

  /// No description provided for @savedTo.
  ///
  /// In en, this message translates to:
  /// **'Saved to'**
  String get savedTo;

  /// No description provided for @errorSaving.
  ///
  /// In en, this message translates to:
  /// **'Error saving file'**
  String get errorSaving;

  /// No description provided for @fileDeleted.
  ///
  /// In en, this message translates to:
  /// **'File deleted successfully!'**
  String get fileDeleted;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @fileNotFound.
  ///
  /// In en, this message translates to:
  /// **'File not found'**
  String get fileNotFound;

  /// No description provided for @errorDeleting.
  ///
  /// In en, this message translates to:
  /// **'Error deleting file'**
  String get errorDeleting;

  /// No description provided for @errorSharing.
  ///
  /// In en, this message translates to:
  /// **'Error sharing file'**
  String get errorSharing;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get important;

  /// No description provided for @accessHowTo.
  ///
  /// In en, this message translates to:
  /// **'On the next screen, make sure to select the location \"Android/media/com.whatsapp/WhatsApp/Media/.Statuses\". Once done, press the \"Use this folder\" button at the bottom to confirm. Selecting any other folder would not work.'**
  String get accessHowTo;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Adjust your settings or\nknow more about the app'**
  String get settingsDescription;

  /// No description provided for @statusFileLocation.
  ///
  /// In en, this message translates to:
  /// **'Status file location'**
  String get statusFileLocation;

  /// No description provided for @statusFileLocationDescription.
  ///
  /// In en, this message translates to:
  /// **'... /Media/.Statuses'**
  String get statusFileLocationDescription;

  /// No description provided for @donateOrSupport.
  ///
  /// In en, this message translates to:
  /// **'Donate or Support'**
  String get donateOrSupport;

  /// No description provided for @supportMeOnKoFi.
  ///
  /// In en, this message translates to:
  /// **'Support me on Ko-Fi'**
  String get supportMeOnKoFi;

  /// No description provided for @githubRepo.
  ///
  /// In en, this message translates to:
  /// **'Github Repository'**
  String get githubRepo;

  /// No description provided for @reviewCode.
  ///
  /// In en, this message translates to:
  /// **'Review the codebase'**
  String get reviewCode;

  /// No description provided for @viewOnboarding.
  ///
  /// In en, this message translates to:
  /// **'View Onboarding'**
  String get viewOnboarding;

  /// No description provided for @madeWith.
  ///
  /// In en, this message translates to:
  /// **'Made with '**
  String get madeWith;

  /// No description provided for @loveEmoji.
  ///
  /// In en, this message translates to:
  /// **'❤️'**
  String get loveEmoji;

  /// No description provided for @andFlutter.
  ///
  /// In en, this message translates to:
  /// **' and Flutter by '**
  String get andFlutter;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'zh',
    'en',
    'es',
    'fr',
    'pt',
    'ru',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'zh':
      return AppLocalizationsZh();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
