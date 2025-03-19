import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PGradientButton extends StatelessWidget {
  final String label;
  final double? width;
  final Function()? onTap;
  const PGradientButton({
    super.key,
    required this.label,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final btnWidth = width ?? PDeviceUtil.getDeviceWidth(context) * 0.28;
    return Container(
      alignment: Alignment.center,
      width: btnWidth,
      height: PAppSize.buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PAppSize.s24),
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
          PAppSize.s8.horizontalSpace,
          Assets.icons.arrowIcon.svg(),
        ],
      ),
    ).onPressed(onTap: onTap);
  }
}
