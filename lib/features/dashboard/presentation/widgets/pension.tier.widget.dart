import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PensionTierWidget extends StatelessWidget {
  final Function()? onTap;
  const PensionTierWidget({super.key, required this.scheme, this.onTap});

  final Map<String, String> scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s12),
      margin: EdgeInsets.only(bottom: PAppSize.s25),
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
            scheme['title'] ?? '',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          PAppSize.s16.verticalSpace,
          Text(
            scheme['amount'] ?? '',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          PAppSize.s4.verticalSpace,
          Text(
            'Started on ${scheme['date'] ?? ''}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: PAppSize.s12,
              color: PAppColor.blackColor.withOpacityExt(PAppSize.s0_5),
            ),
          ),
        ],
      ),
    ).onPressed(onTap: onTap);
  }
}
