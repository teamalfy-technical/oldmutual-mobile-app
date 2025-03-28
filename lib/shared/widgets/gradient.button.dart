import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PGradientButton extends StatelessWidget {
  final String label;
  final double? width;
  final double radius;
  final Function()? onTap;
  final bool showIcon;
  const PGradientButton({
    super.key,
    required this.label,
    this.width,
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
      height: PAppSize.buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: [
            PAppColor.primaryDark,
            PAppColor.primaryDark,
            PAppColor.primary,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: PAppColor.whiteColor,
            ),
          ),
          showIcon ? PAppSize.s8.horizontalSpace : PAppSize.s0.horizontalSpace,
          showIcon ? Assets.icons.arrowIcon.svg() : SizedBox.shrink(),
        ],
      ),
    ).onPressed(onTap: onTap);
  }
}
