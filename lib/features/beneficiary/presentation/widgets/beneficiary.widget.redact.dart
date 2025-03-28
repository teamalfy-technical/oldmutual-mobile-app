import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

class PBeneficiaryWidgetRedact extends StatelessWidget {
  final LoadingState loading;

  const PBeneficiaryWidgetRedact({super.key, required this.loading});

  @override
  Widget build(BuildContext context) {
    // debugPrint(beneficiary['show'].toString());
    return Column(
      children: [
        ExpansionTile(
          title: Text(
            '********************',
            style: Theme.of(context).textTheme.bodyLarge,
          ).redacted(
            context: context,
            redact: loading == LoadingState.loading ? true : false,
          ),
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
            // side: BorderSide(width: 1, color: PAppColor.fillColor),
            side: BorderSide.none,
          ),

          trailing: Icon(Icons.abc_outlined).redacted(
            context: context,
            redact: loading == LoadingState.loading ? true : false,
          ),
          children: [
            Text('**********************').redacted(
              context: context,
              redact: loading == LoadingState.loading ? true : false,
            ),
            Text('*******************').redacted(
              context: context,
              redact: loading == LoadingState.loading ? true : false,
            ),
            Text('*****************').redacted(
              context: context,
              redact: loading == LoadingState.loading ? true : false,
            ),
          ],
        ),
        Divider(color: PAppColor.fillColor),
      ],
    );
  }

  Widget detailWidget(BuildContext context, String label, String value) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: label,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        children: [
          TextSpan(
            text: ' : $value',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    ).redacted(
      context: context,
      redact: loading == LoadingState.loading ? true : false,
    );
  }
}
