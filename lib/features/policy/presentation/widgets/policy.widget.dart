import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPolicyWidget extends StatelessWidget {
  final Function()? onTap;
  final Policy policy;
  final bool loading;
  const PPolicyWidget({
    super.key,
    this.onTap,
    required this.policy,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: PAppSize.s16),
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
          policy.planDescription ?? 'not_applicable'.tr,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s13,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          PFormatter.formatCurrency(
            amount: policy.sumAssured?.toDouble() ?? 0,
            symbol: policy.planDescription == PAppConstant.internationalTravel
                ? '€'
                : '₵',
          ),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s18,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: loading
            ? PShimmerBox(
                width: PAppSize.s20,
                height: PAppSize.s20,
                shape: BoxShape.circle,
              )
            : Assets.icons.arrowRightBlack.svg(
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.whiteColor
                    : PAppColor.blackColor,
              ),
      ),
    ).onPressed(onTap: onTap, radius: BorderRadius.circular(PAppSize.s20));
  }
}
