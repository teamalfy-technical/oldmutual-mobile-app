import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPartialWithdrawalPage extends StatelessWidget {
  const PPartialWithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('partial_withdrawal'.tr)),
      body: PAnimatedColumnWidget(
        children: [
          PAppSize.s14.verticalSpace,

          // Instant Claim Option
          _buildClaimOption(
            context: context,
            title: 'instant_claim'.tr,
            subtitle: 'get_funds_title'.tr,
            options: [
              'Max 40% of cash value (up to GH₵3,000)'.tr,
              '2% processing charge applies'.tr,
              'Mobile money disbursement only'.tr,
            ],
            onTap: () {
              PHelperFunction.switchScreen(
                destination: Routes.instantClaimPage,
              );
            },
          ),

          PAppSize.s20.verticalSpace,

          // Standard Claim Option
          _buildClaimOption(
            context: context,
            title: 'standard_claim'.tr,
            subtitle: 'get_funds_title'.tr,
            options: [
              'Max 50% of cash value (up to GH₵3,000)'.tr,
              'No monetary caps or charges'.tr,
              'Mobile money or Bank Payment'.tr,
            ],
            onTap: () {
              // Handle Instant Claim Option Tap
            },
          ),
        ],
      ).all(PAppSize.s20),
    );
  }

  Widget _buildRowOption({
    required BuildContext context,
    required String title,
    required Widget icon,
  }) {
    return Row(
      children: [
        Assets.icons.checkDark.svg(
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.whiteColor
              : PAppColor.darkAppBarColor,
        ),
        PAppSize.s6.horizontalSpace,
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    ).marginOnly(bottom: PAppSize.s8);
  }

  Widget _buildClaimOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required List<String> options,
    required VoidCallback onTap,
  }) {
    return PCustomCardWidget(
      useBorder: false,

      darkColor: PAppColor.cardDarkColor,
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            trailing: Assets.icons.arrowForwardIos.svg(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.darkAppBarColor,
            ),
            title: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          ...options.map(
            (element) => _buildRowOption(
              context: context,
              title: element,
              icon: Assets.icons.checkDark.svg(
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.whiteColor
                    : PAppColor.darkAppBarColor,
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: PAppSize.s20, vertical: PAppSize.s25),
    );
  }
}
