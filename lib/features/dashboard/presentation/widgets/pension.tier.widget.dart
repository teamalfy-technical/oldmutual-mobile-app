import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

class PensionTierWidget extends StatelessWidget {
  final Function()? onTap;
  const PensionTierWidget({super.key, required this.scheme, this.onTap});

  final Scheme scheme;

  @override
  Widget build(BuildContext context) {
    // final balance = scheme.
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
            scheme.masterSchemeDescription ?? '',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          PAppSize.s6.verticalSpace,
          Text(
            '${'employer_name'.tr} : ${scheme.employerName ?? ''}',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          PAppSize.s16.verticalSpace,
          Text(
            PFormatter.formatCurrency(amount: scheme.schemeCurrentValue ?? 0),
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
          ),
          PAppSize.s4.verticalSpace,
          Text(
            'Started on ${PFormatter.formatDate(dateFormat: DateFormat('dd-MM-yyyy'), date: DateTime.parse(scheme.effectiveDate ?? DateTime.now().toIso8601String()))}',
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
