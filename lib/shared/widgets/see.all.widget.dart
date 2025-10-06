import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PSeeAllWidget extends StatelessWidget {
  final String leadingText;
  final double? leadingFontSize;
  final String trailingText;
  final Function()? onTap;
  const PSeeAllWidget({
    super.key,
    required this.leadingText,
    required this.trailingText,
    this.leadingFontSize,
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
        Text(
          trailingText,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: PAppSize.s16,
            color: PAppColor.primary,
            fontWeight: FontWeight.w600,
          ),
        ).onPressed(onTap: onTap),
      ],
    );
  }
}
