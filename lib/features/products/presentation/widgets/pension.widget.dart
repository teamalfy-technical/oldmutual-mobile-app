import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/dashboard/dashboard.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PPensionWidget extends StatelessWidget {
  final Function()? onTap;
  final Scheme scheme;
  const PPensionWidget({super.key, this.onTap, required this.scheme});

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
        title: Text(
          scheme.masterSchemeDescription ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s13,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'employer_name'.tr}: ${scheme.employerName}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              PFormatter.formatCurrency(
                amount: scheme.schemeCurrentValue?.toDouble() ?? 0,
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        trailing: Assets.icons.arrowRightBlack.svg(
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.whiteColor
              : PAppColor.blackColor,
        ),
      ),
    ).onPressed(onTap: onTap);
  }
}
