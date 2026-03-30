import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PHomeStatsWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final LoadingState loading;
  final Function()? onTap;
  const PHomeStatsWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.loading = LoadingState.completed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: loading == LoadingState.loading,
      child: Container(
        padding: EdgeInsets.all(PAppSize.s14),
        width: PDeviceUtil.getDeviceWidth(context),
        decoration: BoxDecoration(
          color: PAppColor.whiteColor,
          borderRadius: BorderRadius.circular(PAppSize.s5),
          border: Border.all(width: PAppSize.s0_8, color: PAppColor.whiteColor),
          boxShadow: [
            BoxShadow(
              offset: Offset(PAppSize.s0, PAppSize.s2),
              blurRadius: PAppSize.s4,
              spreadRadius: PAppSize.s0,
              color: PAppColor.greyColorShade300,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: PAppSize.s14,
              ),
            ),
            PAppSize.s4.verticalSpace,
            Text(
              subTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: PAppSize.s18,
                height: PAppSize.s1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ).onPressed(onTap: onTap),
    );
  }
}
