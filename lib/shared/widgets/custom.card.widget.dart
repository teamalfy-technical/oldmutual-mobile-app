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
    this.onTap,
    this.darkColor,
    this.borderRadius,
    this.color,
  });
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final bool useBorder;
  final Color? darkColor;
  final Color? color;
  final Function()? onTap;
  final BorderRadius? borderRadius;

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
        borderRadius: borderRadius ?? BorderRadius.circular(PAppSize.s20),
        color:
            color ??
            (PHelperFunction.isDarkMode(context)
                ? darkColor ?? PAppColor.darkAppBarColor
                : PAppColor.whiteColor),
      ),
      child: child.onPressed(
        onTap: onTap,
        radius: BorderRadius.circular(PAppSize.s20),
      ),
    );
    //
    // .onPressed(onTap: onTap, radius: BorderRadius.circular(PAppSize.s20));
  }
}
