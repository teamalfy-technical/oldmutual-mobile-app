import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PNotificationRedactWidget extends StatelessWidget {
  const PNotificationRedactWidget({super.key, required this.loading});

  final LoadingState loading;

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: loading == LoadingState.loading,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: PAppSize.s6),
        decoration: BoxDecoration(
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.darkAppBarColor
              : PAppColor.fillColor,
          borderRadius: BorderRadius.circular(PAppSize.s10),
        ),
        child: Row(
          children: [
            Container(
              width: PAppSize.s50,
              height: PAppSize.s50,
              decoration: BoxDecoration(
                color: PAppColor.whiteColor,
                borderRadius: BorderRadius.circular(PAppSize.s16),
              ),
            ),
            PAppSize.s8.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PShimmerBox(width: 180, height: PAppSize.s14),
                  PAppSize.s6.verticalSpace,
                  PShimmerBox(width: double.infinity, height: PAppSize.s12),
                  PAppSize.s4.verticalSpace,
                  PShimmerBox(width: 140, height: PAppSize.s12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
