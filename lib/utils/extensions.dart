import 'package:flutter/material.dart';
import 'package:wastash/l10n/generated/app_localizations.dart';

extension BuildXContext on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  Size get size => MediaQuery.of(this).size;
  double get scale => MediaQuery.of(this).devicePixelRatio;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
  Brightness get brightness => Theme.of(this).brightness;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  AppLocalizations get l10n => AppLocalizations.of(this)!;
  Locale get locale => Localizations.localeOf(this);
  bool get isArabic => locale.languageCode == 'ar';
}
