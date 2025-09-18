import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/products/products.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PPolicyWidget extends StatelessWidget {
  final Function()? onTap;
  final Policy policy;
  const PPolicyWidget({super.key, this.onTap, required this.policy});

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
          policy.planDescription ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s13,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          PFormatter.formatCurrency(amount: policy.sumAssured?.toDouble() ?? 0),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s18,
            fontWeight: FontWeight.w600,
          ),
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
