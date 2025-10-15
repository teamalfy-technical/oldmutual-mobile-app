import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomCardWidget extends StatelessWidget {
  const PCustomCardWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.useBorder = true,
  });
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final bool useBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      //?? EdgeInsets.all(PAppSize.s16),
      decoration: BoxDecoration(
        border: useBorder
            ? PHelperFunction.isDarkMode(context)
                  ? null
                  : Border.all(width: PAppSize.s1, color: PAppColor.fillColor2)
            : null,
        borderRadius: BorderRadius.circular(PAppSize.s20),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
      ),
      child: child,
    );
  }
}
