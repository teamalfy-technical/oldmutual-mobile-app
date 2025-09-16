import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/products/products.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;
  PProductDetailPage({super.key, required this.product});

  final vm = Get.put(PProductVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text(product['name'])),
      body: Stack(
        children: [
          Positioned(top: -16, right: -0, child: Assets.icons.pictogram.svg()),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PAppSize.s2.verticalSpace,
                // Overview Balance
                Text(
                  'overview'.tr,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  PFormatter.formatCurrency(
                    amount: vm.products[0]['contribution'],
                  ),
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

                InvestmentWidget(title: 'status'.tr, value: 'active'.tr),

                PAppSize.s12.verticalSpace,

                _buildCustomListTile(
                  context: context,
                  title: 'education_savings'.tr,
                  subTitle: PFormatter.formatCurrency(amount: 5000.00),
                  onTap: () => PHelperFunction.switchScreen(
                    destination: Routes.shortTermSavingsPage,
                    args: 'short_term_savings'.tr,
                  ),
                ),

                PAppSize.s16.verticalSpace,

                _buildCustomListTile(
                  context: context,
                  title: 'short_term_savings'.tr,
                  subTitle: PFormatter.formatCurrency(amount: 4000.00),
                  onTap: () => PHelperFunction.switchScreen(
                    destination: Routes.shortTermSavingsPage,
                    args: 'short_term_savings'.tr,
                  ),
                ),
              ],
            ).symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s10),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomListTile({
    required BuildContext context,
    Function()? onTap,
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
    ).onPressed(onTap: onTap);
  }
}
