import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

class ContributionHistoryWidgetRedact extends StatelessWidget {
  final LoadingState loadingState;
  const ContributionHistoryWidgetRedact({
    super.key,
    required this.loadingState,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '***********************',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ).redacted(
        context: context,
        redact: loadingState == LoadingState.loading ? true : false,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: PAppSize.s0),
      subtitle: Text(
        '******************',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
      ).redacted(
        context: context,
        redact: loadingState == LoadingState.loading ? true : false,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '***********************',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
          ).redacted(
            context: context,
            redact: loadingState == LoadingState.loading ? true : false,
          ),
          PAppSize.s2.verticalSpace,
          Text(
            '******************',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
          ).redacted(
            context: context,
            redact: loadingState == LoadingState.loading ? true : false,
          ),
        ],
      ),
    ).redacted(
      context: context,
      redact: loadingState == LoadingState.loading ? true : false,
    );
  }
}
