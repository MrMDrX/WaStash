import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wastash/constants/app_constants.dart';
import 'package:wastash/cubits/language_cubit.dart';
import 'package:wastash/cubits/theme_cubit.dart';
import 'package:wastash/l10n/generated/app_localizations.dart';
import 'package:wastash/pages/onboarding_page.dart';
import 'package:wastash/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageCubit(), lazy: false),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                title: AppConstants.appName,
                theme: AppTheme.light(isArabic: locale.languageCode == 'ar'),
                darkTheme: AppTheme.dark(isArabic: locale.languageCode == 'ar'),
                themeMode: themeMode,
                locale: locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                debugShowCheckedModeBanner: false,
                home: OnboardingPage(),
              );
            },
          );
        },
      ),
    );
  }
}
