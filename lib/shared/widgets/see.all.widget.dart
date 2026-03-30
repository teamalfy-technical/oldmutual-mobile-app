import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PSeeAllWidget extends StatelessWidget {
  final String leadingText;
  final double? leadingFontSize;
  final bool showTrailing;
  final String? trailingText;
  // final String trailingText;
  final Function()? onTap;
  const PSeeAllWidget({
    super.key,
    required this.leadingText,
    this.showTrailing = true,
    this.leadingFontSize,
    this.trailingText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingText,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: leadingFontSize ?? PAppSize.s16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (showTrailing) ...[
          ShaderMask(
            shaderCallback: (bounds) =>
                PAppColor.primaryGradient.createShader(bounds),
            child: Text(
              trailingText ?? 'see_all'.tr,
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: PAppSize.s16,
                color: PAppColor.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ).onPressed(onTap: onTap),
        ],
      ],
    );
  }
}
