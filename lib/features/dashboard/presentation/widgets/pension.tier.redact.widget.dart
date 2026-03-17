import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PensionTierRedactWidget extends StatelessWidget {
  final Function()? onTap;
  final LoadingState loading;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  const PensionTierRedactWidget({
    super.key,
    this.onTap,
    required this.loading,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: loading == LoadingState.loading,
      child: Container(
        padding: EdgeInsets.all(PAppSize.s22),
        margin: margin ?? EdgeInsets.only(right: PAppSize.s20),
        height: height,
        width: width ?? PDeviceUtil.getDeviceWidth(context) * 0.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PAppSize.s20),
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.darkAppBarColor
              : PAppColor.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PShimmerBox(width: 140, height: PAppSize.s16),
                      PAppSize.s8.verticalSpace,
                      PShimmerBox(width: 100, height: PAppSize.s14),
                      PAppSize.s4.verticalSpace,
                      PShimmerBox(width: 80, height: PAppSize.s14),
                      PAppSize.s12.verticalSpace,
                      Container(
                        width: PAppSize.s36,
                        height: PAppSize.s36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PAppColor.whiteColor,
                        ),
                      ),
                      PAppSize.s8.verticalSpace,
                    ],
                  ),
                ),
                PShimmerBox(width: PAppSize.s20, height: PAppSize.s20),
              ],
            ),
            PShimmerBox(width: 120, height: PAppSize.s14),
            PAppSize.s4.verticalSpace,
            PShimmerBox(width: 160, height: PAppSize.s22),
            PAppSize.s8.verticalSpace,
            PShimmerBox(width: double.infinity, height: PAppSize.s4, borderRadius: 2),
          ],
        ),
      ),
    );
  }
}
