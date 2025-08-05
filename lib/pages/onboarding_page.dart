import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wastash/constants/app_assets.dart';
import 'package:wastash/constants/app_constants.dart';
import 'package:wastash/utils/extensions.dart';
import 'package:wastash/widgets/feature_widget.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  void _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.completedOnboardingKey, true);
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final iconColor = isDark ? Colors.white : Colors.black;
    final textColor = isDark ? Colors.white70 : Colors.black54;

    return CupertinoOnboarding(
      onPressedOnLastPage: () => _completeOnboarding(context),
      bottomButtonColor: context.colors.primary,
      bottomButtonChild: Text(
        context.l10n.continueOnboarding,
        style: TextStyle(
          color: context.colors.onPrimary,
          fontFamily: context.isArabic ? 'Rubik' : 'Geist',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      widgetAboveBottomButton: const SizedBox(height: 20),
      pages: [
        FeatureWidget(
          title: context.l10n.welcome,
          description: context.l10n.appSlogan,
          image: SvgPicture.asset(
            AppAssets.logo,
            height: 148,
            width: 148,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          textColor: textColor,
          titleColor: iconColor,
        ),
        FeatureWidget(
          title: context.l10n.statusViewer,
          description: context.l10n.statusViewerDescription,
          image: SvgPicture.asset(
            AppAssets.onboarding1,
            height: 148,
            width: 148,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          textColor: textColor,
          titleColor: iconColor,
        ),
        FeatureWidget(
          title: context.l10n.statusSaver,
          description: context.l10n.statusSaverDescription,
          image: SvgPicture.asset(
            AppAssets.onboarding2,
            height: 148,
            width: 148,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          textColor: textColor,
          titleColor: iconColor,
        ),
        FeatureWidget(
          title: context.l10n.beautifulDesign,
          description: context.l10n.beautifulDesignDescription,
          image: SvgPicture.asset(
            AppAssets.onboarding3,
            height: 148,
            width: 148,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          textColor: textColor,
          titleColor: iconColor,
        ),
      ],
    );
  }
}
