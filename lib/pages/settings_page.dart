import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:wastash/constants/app_assets.dart';
import 'package:wastash/constants/app_constants.dart';
import 'package:wastash/cubits/language_cubit.dart';
import 'package:wastash/cubits/theme_cubit.dart';
import 'package:wastash/l10n/generated/app_localizations.dart';
import 'package:wastash/pages/onboarding_page.dart';
import 'package:wastash/themes/app_theme.dart';
import 'package:wastash/utils/extensions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
                child: Column(
                  children: [
                    Text(
                      context.l10n.settings,
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.settingsDescription,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .extension<AppThemeExtension>()
                          ?.secondaryText
                          .copyWith(height: 1.4),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildLanguageCard(context),
                  _buildAppearanceCard(context),
                  _buildPreferenceCard(
                    context,
                    icon: AppAssets.directoryIcon,
                    title: context.l10n.statusFileLocation,
                    subtitle: context.l10n.statusFileLocationDescription,
                  ),
                  _buildPreferenceCard(
                    context,
                    icon: AppAssets.drinkIcon,
                    title: context.l10n.donateOrSupport,
                    subtitle: context.l10n.supportMeOnKoFi,
                    onTap: () => _launchURL(AppConstants.koFiUrl),
                  ),
                  _buildPreferenceCard(
                    context,
                    icon: AppAssets.githubIcon,
                    title: context.l10n.githubRepo,
                    subtitle: context.l10n.reviewCode,
                    onTap: () => _launchURL(AppConstants.githubUrl),
                  ),
                  _buildPreferenceCard(
                    context,
                    icon: AppAssets.informationIcon,
                    title: context.l10n.viewOnboarding,
                    subtitle: '',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingPage(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: GestureDetector(
                      onTap: () => _launchURL(AppConstants.devProfileUrl),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context)
                              .extension<AppThemeExtension>()
                              ?.secondaryText
                              .copyWith(height: 1.5),
                          children: [
                            TextSpan(text: context.l10n.madeWith),
                            TextSpan(
                              text: context.l10n.loveEmoji,
                              style: TextStyle(fontSize: 14),
                            ),
                            TextSpan(text: context.l10n.andFlutter),
                            WidgetSpan(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  AppAssets.devAvatar,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(BuildContext context) {
    final isDark = context.isDark;

    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, currentLocale) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: ShapeDecoration(
            color: context.colors.surfaceContainer,
            shape: SquircleBorder(radius: BorderRadius.circular(24)),
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.languageIcon,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? Colors.white : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    context.l10n.language,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                      fontFamily: context.isArabic ? 'Rubik' : 'GeistMono',
                    ),
                  ),
                  const Spacer(),
                  PullDownButton(
                    itemBuilder: (context) => [
                      for (final locale in AppLocalizations.supportedLocales)
                        PullDownMenuItem(
                          onTap: () {
                            context.read<LanguageCubit>().changeLanguage(
                              locale,
                            );
                          },
                          itemTheme: PullDownMenuItemTheme(
                            textStyle: TextStyle(
                              fontFamily: context.isArabic
                                  ? 'Rubik'
                                  : 'GeistMono',
                            ),
                          ),
                          title: _getLanguageName(locale, context),
                        ),
                    ],
                    position: PullDownMenuPosition.over,
                    buttonBuilder: (context, showMenu) => GestureDetector(
                      onTap: showMenu,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getLanguageName(currentLocale, context),
                            style: TextStyle(
                              fontSize: 16,
                              color: context.colors.onSurface.withValues(
                                alpha: 0.54,
                              ),
                              fontFamily: context.isArabic
                                  ? 'Rubik'
                                  : 'GeistMono',
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            AppAssets.selectorVertical,
                            width: 28,
                            height: 28,
                            colorFilter: ColorFilter.mode(
                              context.colors.onSurface.withValues(alpha: 0.54),
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppearanceCard(BuildContext context) {
    final isDark = context.isDark;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, currentTheme) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: ShapeDecoration(
            color: context.colors.surfaceContainer,
            shape: SquircleBorder(radius: BorderRadius.circular(24)),
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.brightnessIcon,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? Colors.white : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    context.l10n.theme,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                      fontFamily: context.isArabic ? 'Rubik' : 'GeistMono',
                    ),
                  ),
                  const Spacer(),
                  PullDownButton(
                    itemBuilder: (context) => [
                      PullDownMenuItem(
                        itemTheme: PullDownMenuItemTheme(
                          textStyle: TextStyle(
                            fontFamily: context.isArabic
                                ? 'Rubik'
                                : 'GeistMono',
                          ),
                        ),
                        onTap: () {
                          context.read<ThemeCubit>().setTheme(ThemeMode.system);
                        },
                        title: context.l10n.system,
                      ),
                      PullDownMenuItem(
                        itemTheme: PullDownMenuItemTheme(
                          textStyle: TextStyle(
                            fontFamily: context.isArabic
                                ? 'Rubik'
                                : 'GeistMono',
                          ),
                        ),
                        onTap: () {
                          context.read<ThemeCubit>().setTheme(ThemeMode.light);
                        },
                        title: context.l10n.light,
                      ),
                      PullDownMenuItem(
                        itemTheme: PullDownMenuItemTheme(
                          textStyle: TextStyle(
                            fontFamily: context.isArabic
                                ? 'Rubik'
                                : 'GeistMono',
                          ),
                        ),
                        onTap: () {
                          context.read<ThemeCubit>().setTheme(ThemeMode.dark);
                        },
                        title: context.l10n.dark,
                      ),
                    ],
                    position: PullDownMenuPosition.over,
                    buttonBuilder: (context, showMenu) => GestureDetector(
                      onTap: showMenu,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getThemeModeText(currentTheme, context),
                            style: TextStyle(
                              fontSize: 16,
                              color: context.colors.onSurface.withValues(
                                alpha: 0.54,
                              ),
                              fontFamily: context.isArabic
                                  ? 'Rubik'
                                  : 'GeistMono',
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            AppAssets.selectorVertical,
                            width: 28,
                            height: 28,
                            colorFilter: ColorFilter.mode(
                              context.colors.onSurface.withValues(alpha: 0.54),
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreferenceCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    final isDark = context.isDark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: ShapeDecoration(
        color: context.colors.surfaceContainer,
        shape: SquircleBorder(radius: BorderRadius.circular(24)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: SquircleBorder(radius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: context.colors.onSurface,
                          fontFamily: context.isArabic ? 'Rubik' : 'GeistMono',
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: context.colors.onSurface.withValues(
                              alpha: 0.54,
                            ),
                            fontFamily: context.isArabic
                                ? 'Rubik'
                                : 'GeistMono',
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getLanguageName(Locale locale, BuildContext context) {
    switch (locale.languageCode) {
      case 'en':
        return context.l10n.english;
      case 'ar':
        return context.l10n.arabic;
      case 'fr':
        return context.l10n.french;
      case 'es':
        return context.l10n.spanish;
      case 'pt':
        return context.l10n.portuguese;
      case 'ru':
        return context.l10n.russian;
      case 'zh':
        return context.l10n.chinese;
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  String _getThemeModeText(ThemeMode mode, BuildContext context) {
    switch (mode) {
      case ThemeMode.system:
        return context.l10n.system;
      case ThemeMode.light:
        return context.l10n.light;
      case ThemeMode.dark:
        return context.l10n.dark;
    }
  }

  Future<void> _launchURL(String urlString) async {
    final url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}
