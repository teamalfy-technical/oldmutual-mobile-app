import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PProductRedactedWidget extends StatelessWidget {
  final LoadingState loading;
  final LoadingState? secondaryLoading;
  const PProductRedactedWidget({
    super.key,
    required this.loading,
    this.secondaryLoading,
  });

  bool get _isLoading =>
      loading == LoadingState.loading ||
      secondaryLoading == LoadingState.loading;

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: _isLoading,
      child: Container(
        margin: EdgeInsets.only(bottom: PAppSize.s16),
        padding: EdgeInsets.symmetric(
          horizontal: PAppSize.s16,
          vertical: PAppSize.s12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PAppSize.s20),
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.darkAppBarColor
              : PAppColor.whiteColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PShimmerBox(width: 180, height: PAppSize.s13),
                  PAppSize.s8.verticalSpace,
                  PShimmerBox(width: 120, height: PAppSize.s18),
                ],
              ),
            ),
            PShimmerBox(width: 40, height: PAppSize.s18),
          ],
        ),
      ),
    );
  }
}
