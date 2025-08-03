import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';

import 'package:wastash/utils/extensions.dart';

class ActionButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onPressed;
  final bool isHorizontal;
  final bool isDestructive;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isHorizontal = false,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    if (isHorizontal) {
      return Container(
        width: double.infinity,
        height: 56,
        decoration: ShapeDecoration(
          color: isDark ? Colors.grey[800] : Colors.grey[100],
          shape: SquircleBorder(radius: BorderRadius.circular(24)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            customBorder: SquircleBorder(radius: BorderRadius.circular(24)),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 16,
                  //fontFamily: 'Geist',
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 100,
      height: 100,
      decoration: ShapeDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        shape: SquircleBorder(radius: BorderRadius.circular(32)),
        shadows: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: SquircleBorder(radius: BorderRadius.circular(32)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDestructive
                      ? Colors.red[300]
                      : (isDark ? Colors.white : Colors.grey[900]),
                  fontSize: 14,
                  height: 1.2,
                  //fontFamily: 'Geist',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
