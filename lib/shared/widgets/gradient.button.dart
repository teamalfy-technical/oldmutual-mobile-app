import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PGradientButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final double radius;
  final double fontSize;
  final Color textColor;
  final Function()? onTap;
  final bool showIcon;
  final Widget? icon;
  final LoadingState loading;
  final IconDirection iconDirection;
  const PGradientButton({
    super.key,
    required this.label,
    this.width,
    this.height = PAppSize.buttonHeight,
    this.onTap,
    this.showIcon = true,
    this.radius = PAppSize.s24,
    this.loading = LoadingState.completed,
    this.fontSize = PAppSize.s16,
    this.textColor = PAppColor.blackColor,
    this.icon,
    this.iconDirection = IconDirection.left,
  });

  @override
  Widget build(BuildContext context) {
    final btnWidth = width ?? PDeviceUtil.getDeviceWidth(context) * 0.28;
    return Container(
      alignment: Alignment.center,
      width: btnWidth,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: onTap == null
              ? [PAppColor.greyColor, PAppColor.greyColor]
              : [PAppColor.primaryDark, PAppColor.primary],
        ), // Match button shape
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: BorderSide.none,
          padding: EdgeInsets.all(PAppSize.s0),
          backgroundColor: Colors.transparent, // Make background transparent
          shadowColor: Colors.transparent, // Remove shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: loading == LoadingState.loading
            ? PCustomLoadingIndicator(size: PAppSize.s16, color: textColor)
            : showIcon
            ? iconDirection == IconDirection.left
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon ?? Assets.icons.arrowIcon.svg(),
                        PAppSize.s8.horizontalSpace,
                        Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                            fontSize: fontSize,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                            fontSize: fontSize,
                          ),
                        ),
                        PAppSize.s8.horizontalSpace,
                        icon ?? Assets.icons.arrowIcon.svg(),
                      ],
                    )
            : Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: fontSize,
                ),
              ),
      ),
    );
  }
}
