import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class ContributionHistoryWidgetRedact extends StatelessWidget {
  final LoadingState loadingState;
  const ContributionHistoryWidgetRedact({
    super.key,
    required this.loadingState,
  });

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: loadingState == LoadingState.loading,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: PAppSize.s0),
        title: PShimmerBox(width: 160, height: PAppSize.s14),
        subtitle: Padding(
          padding: EdgeInsets.only(top: PAppSize.s4),
          child: PShimmerBox(width: 120, height: PAppSize.s12),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PShimmerBox(width: 100, height: PAppSize.s12),
            PAppSize.s4.verticalSpace,
            PShimmerBox(width: 80, height: PAppSize.s12),
          ],
        ),
      ),
    );
  }
}
