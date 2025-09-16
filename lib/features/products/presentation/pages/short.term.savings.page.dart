import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/products/products.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PShortTermSavingsPage extends StatelessWidget {
  final String title;
  PShortTermSavingsPage({super.key, required this.title});

  final vm = Get.put(PProductVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text(title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PAppSize.s2.verticalSpace,
          // Cover Amount
          Text(
            'cover_amount'.tr,
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s13,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            PFormatter.formatCurrency(amount: 20000),
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              // fontSize: PAppSize.s12,
              fontWeight: FontWeight.w600,
            ),
          ),
          PAppSize.s2.verticalSpace,

          Divider(
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.successLight
                : PAppColor.successDark,
            thickness: PAppSize.s4,
          ),

          PAppSize.s5.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InvestmentWidget(title: 'monthly_premium'.tr, value: '₵500'),
              InvestmentWidget(
                crossAxisAlignment: CrossAxisAlignment.end,
                title: 'status'.tr,
                value: 'active'.tr,
              ),
            ],
          ),

          PAppSize.s12.verticalSpace,

          _buildCustomListTile(
            context: context,
            title: 'education_savings'.tr,
            subTitle: PFormatter.formatCurrency(amount: 5000.00),
          ),

          PAppSize.s16.verticalSpace,

          _buildCustomListTile(
            context: context,
            title: 'short_term_savings'.tr,
            subTitle: PFormatter.formatCurrency(amount: 4000.00),
          ),
        ],
      ).symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s10),
    );
  }

  Widget _buildCustomListTile({
    required BuildContext context,
    required String title,
    required String subTitle,
  }) {
    return Container(
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
          title,

          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s13,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          subTitle,
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
    );
  }
}
