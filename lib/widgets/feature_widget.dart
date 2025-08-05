import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:flutter/material.dart';

import 'package:wastash/utils/extensions.dart';

class FeatureWidget extends StatelessWidget {
  final String title;
  final String description;
  final Widget image;
  final Color textColor;
  final Color titleColor;

  const FeatureWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.textColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoOnboardingPage(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: context.isArabic ? 'Rubik' : 'Geist',
          color: titleColor,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          image,
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2,
                fontSize: 18,
                color: textColor,
                fontFamily: context.isArabic ? 'Rubik' : 'GeistMono',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
