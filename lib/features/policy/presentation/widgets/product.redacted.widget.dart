import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

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
    return Container(
      margin: EdgeInsets.only(bottom: PAppSize.s16),
      padding: EdgeInsets.symmetric(horizontal: PAppSize.s16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PAppSize.s20),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title:
            Text(
              '************************',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s13,
                fontWeight: FontWeight.w400,
              ),
            ).redacted(
              context: context,
              redact: _isLoading,
            ),
        subtitle:
            Text(
              '**************',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s18,
                fontWeight: FontWeight.w600,
              ),
            ).redacted(
              context: context,
              redact: _isLoading,
            ),
        trailing:
            Text(
              '***',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s18,
                fontWeight: FontWeight.w600,
              ),
            ).redacted(
              context: context,
              redact: _isLoading,
            ),
      ),
    ).redacted(
      context: context,
      redact: _isLoading,
    );
  }
}
