import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PStatementWidgetRedact extends StatelessWidget {
  final LoadingState loading;

  const PStatementWidgetRedact({super.key, required this.loading});

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: loading == LoadingState.loading,
      child: Container(
        width: PDeviceUtil.getDeviceWidth(context),
        padding: EdgeInsets.all(PAppSize.s20),
        margin: EdgeInsets.only(bottom: PAppSize.s12),
        decoration: BoxDecoration(
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.darkAppBarColor
              : PAppColor.whiteColor,
          borderRadius: BorderRadius.circular(PAppSize.s10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PShimmerBox(width: 180, height: PAppSize.s14),
                  PAppSize.s8.verticalSpace,
                  PShimmerBox(width: 120, height: PAppSize.s12),
                ],
              ),
            ),
            PShimmerBox(width: 60, height: PAppSize.s14, borderRadius: 4),
          ],
        ),
      ),
    );
  }
}
