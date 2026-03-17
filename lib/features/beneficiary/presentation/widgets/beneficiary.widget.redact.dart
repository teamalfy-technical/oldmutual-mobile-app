import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PBeneficiaryWidgetRedact extends StatelessWidget {
  final LoadingState loading;

  const PBeneficiaryWidgetRedact({super.key, required this.loading});

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: loading == LoadingState.loading,
      child: Column(
        children: [
          ExpansionTile(
            title: PShimmerBox(width: 160, height: PAppSize.s16),
            tilePadding: EdgeInsets.symmetric(horizontal: PAppSize.s22),
            initiallyExpanded: true,
            expandedAlignment: Alignment.centerLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: EdgeInsets.symmetric(
              horizontal: PAppSize.s22,
              vertical: PAppSize.s10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide.none,
            ),
            expansionAnimationStyle: AnimationStyle(
              curve: Curves.linearToEaseOut,
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide.none,
            ),
            trailing: PShimmerBox(width: PAppSize.s24, height: PAppSize.s24),
            children: [
              PShimmerBox(width: 180, height: PAppSize.s14),
              PAppSize.s6.verticalSpace,
              PShimmerBox(width: 150, height: PAppSize.s14),
              PAppSize.s6.verticalSpace,
              PShimmerBox(width: 130, height: PAppSize.s14),
            ],
          ),
          Divider(color: PAppColor.fillColor),
        ],
      ),
    );
  }
}
