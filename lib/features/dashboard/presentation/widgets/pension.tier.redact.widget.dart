import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

class PensionTierRedactWidget extends StatelessWidget {
  final Function()? onTap;
  final LoadingState loading;
  const PensionTierRedactWidget({super.key, this.onTap, required this.loading});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s12),
      margin: EdgeInsets.only(bottom: PAppSize.s20),
      decoration: BoxDecoration(
        color:
            PHelperFunction.isDarkMode(context)
                ? PAppColor.blackColor
                : PAppColor.whiteColor,
        borderRadius: BorderRadius.circular(PAppSize.s10),
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
            '******************',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          PAppSize.s16.verticalSpace,
          Text('**************', style: Theme.of(context).textTheme.titleSmall),
          PAppSize.s4.verticalSpace,
          Text(
            '*********************',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: PAppSize.s12,
              color: PAppColor.blackColor.withOpacityExt(PAppSize.s0_5),
            ),
          ),
        ],
      ),
    ).redacted(
      context: context,
      redact: loading == LoadingState.loading ? true : false,
    );
  }
}
