import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PGradientButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final double radius;
  final Function()? onTap;
  final bool showIcon;
  const PGradientButton({
    super.key,
    required this.label,
    this.width,
    this.height = PAppSize.buttonHeight,
    this.onTap,
    this.showIcon = true,
    this.radius = PAppSize.s24,
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
          colors: [
            PAppColor.primaryDark,
            PAppColor.primaryDark,
            PAppColor.primary,
          ],
        ), // Match button shape
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: BorderSide.none,
          backgroundColor: Colors.transparent, // Make background transparent
          shadowColor: Colors.transparent, // Remove shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PAppSize.s8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: PAppColor.whiteColor,
              ),
            ),
            showIcon
                ? PAppSize.s8.horizontalSpace
                : PAppSize.s0.horizontalSpace,
            showIcon ? Assets.icons.arrowIcon.svg() : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
