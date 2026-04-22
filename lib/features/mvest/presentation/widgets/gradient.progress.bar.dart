import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PMVestGradientProgressBar extends StatelessWidget {
  final double percentage;
  final double height;

  const PMVestGradientProgressBar({
    super.key,
    required this.percentage,
    this.height = PAppSize.s6,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    final clamped = percentage.clamp(0.0, 100.0) / 100;
    return ClipRRect(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      child: Container(
        height: height,
        color: isDark ? PAppColor.cardDarkColor : PAppColor.fillColor4,
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: clamped,
          child: Container(
            decoration: BoxDecoration(gradient: PAppColor.primaryGradient),
          ),
        ),
      ),
    );
  }
}
