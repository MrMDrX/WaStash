import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroine/heroine.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wastash/constants/app_constants.dart';
import 'package:wastash/cubits/bottom_nav_cubit.dart';
import 'package:wastash/cubits/language_cubit.dart';
import 'package:wastash/cubits/status_cubit.dart';
import 'package:wastash/cubits/theme_cubit.dart';
import 'package:wastash/l10n/generated/app_localizations.dart';
import 'package:wastash/pages/onboarding_page.dart';
import 'package:wastash/themes/app_theme.dart';
import 'package:wastash/utils/extensions.dart';
import 'package:wastash/widgets/home_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(AppConstants.completedOnboardingKey) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageCubit(), lazy: false),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => StatusCubit()),
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
                navigatorObservers: [HeroineController()],
                scrollBehavior: const MaterialScrollBehavior().copyWith(
                  physics: const BouncingScrollPhysics(),
                  scrollbars: false,
                ),
                builder: (context, child) {
                  final isDark = context.isDark;
                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: isDark
                          ? Brightness.light
                          : Brightness.dark,
                      statusBarBrightness: isDark
                          ? Brightness.dark
                          : Brightness.light,
                      systemNavigationBarColor: Colors.transparent,
                      systemNavigationBarIconBrightness: isDark
                          ? Brightness.light
                          : Brightness.dark,
                    ),
                  );
                  return child!;
                },
                initialRoute: '/',
                routes: {
                  '/': (context) => FutureBuilder<bool>(
                    future: _checkFirstLaunch(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return snapshot.data == true
                          ? const OnboardingPage()
                          : const HomeNavigator();
                    },
                  ),
                },
              );
            },
          );
        },
      ),
    );
  }
}
