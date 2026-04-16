import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PBlueTagWidget extends StatelessWidget {
  final Widget child;
  const PBlueTagWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: PDeviceUtil.getDeviceWidth(context),
      padding: EdgeInsets.symmetric(
        vertical: PAppSize.s16,
        horizontal: PAppSize.s16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PAppSize.s8),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.cardDarkColor
            : PAppColor.lightBlueColor,
      ),
      child: child,
    );
  }
}
