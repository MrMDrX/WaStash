import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wastash/l10n/generated/app_localizations.dart';

class LanguageCubit extends Cubit<Locale> {
  static const String _prefKey = 'language';

  LanguageCubit() : super(const Locale('en')) {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_prefKey);
    if (languageCode != null) {
      emit(Locale(languageCode));
    }
  }

  Future<void> changeLanguage(Locale newLocale) async {
    if (!AppLocalizations.supportedLocales.contains(newLocale)) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, newLocale.languageCode);
    emit(newLocale);
  }
}
