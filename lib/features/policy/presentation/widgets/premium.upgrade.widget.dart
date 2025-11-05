import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/presentation/pages/home.page.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPremiumUpgradeWidget extends StatelessWidget {
  final Policy policy;
  PPremiumUpgradeWidget({super.key, required this.policy});

  final vm = Get.put(PPolicyVm());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InvestmentWidget(
          title: 'premium_upgrade_title'.tr,
          value: 'premium_upgrade_subtitle'.tr,
          titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s16,
            fontWeight: FontWeight.w600,
          ),
          subTitleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s15,
            fontWeight: FontWeight.w400,
          ),
        ),
        PAppSize.s12.verticalSpace,
        PCustomCardWidget(
          useBorder: false,
          child: Column(
            children: [
              buildListTile(
                context,
                'current_premium'.tr,
                PFormatter.formatCurrency(
                  amount: policy.modalPrem?.toDouble() ?? 0,
                ),
              ),
              Divider(height: PAppSize.s1).horizontal(PAppSize.s14),
              buildListTile(
                context,
                'suggested_premium'.tr,
                PFormatter.formatCurrency(
                  amount: policy.premiumPaid?.toDouble() ?? 0,
                ),
              ),
              // Card
              Container(
                width: PDeviceUtil.getDeviceWidth(context),
                padding: EdgeInsets.all(PAppSize.s14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [PAppColor.primaryDark, PAppColor.primary],
                  ),
                  borderRadius: BorderRadius.circular(PAppSize.s16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'new_coverage'.tr,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: PAppSize.s16,
                        color: PAppColor.whiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // PAppSize.s16.verticalSpace,
                    PAppSize.s4.verticalSpace,
                    // Cost
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: PAppSize.s18,
                          color: PAppColor.whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                        text: '${PFormatter.formatCurrency(amount: 1090.70)} ',
                        children: [
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s13,
                                  color: PAppColor.whiteColor,
                                  fontWeight: FontWeight.w500,
                                  decorationColor: PAppColor.whiteColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                            text: PFormatter.formatCurrency(amount: 1090.70),
                          ),
                        ],
                      ),
                    ),
                    PAppSize.s3.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Assets.icons.checkIcon.svg(
                          color: PAppColor.whiteColor,
                          width: PAppSize.s28,
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s13,
                                  color: PAppColor.whiteColor,
                                  fontWeight: FontWeight.w500,
                                ),
                            text: '${PFormatter.formatCurrency(amount: 10)} ',
                            children: [
                              TextSpan(
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontSize: PAppSize.s13,
                                      color: PAppColor.whiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                text: 'additional_advantage'.tr,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).horizontal(PAppSize.s16),

              PAppSize.s20.verticalSpace,

              PGradientButton(
                label: 'upgrade_now'.tr,
                showIcon: true,
                icon: Assets.icons.upgradeIcon.svg(),
                textColor: PAppColor.whiteColor,
                loading: LoadingState.completed,
                width: PDeviceUtil.getDeviceWidth(context),
                onTap: () => showUpgradeModal(context),
              ).horizontal(PAppSize.s16),

              PAppSize.s8.verticalSpace,

              OutlinedButton(
                onPressed: () {},
                child: Text('learn_more'.tr),
              ).horizontal(PAppSize.s16),

              // PAppSize.s8.verticalSpace,

              // learn more
              TextButton(
                onPressed: () {},
                child: Text(
                  'not_interested'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s16,
                    color: PAppColor.darkBgColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              PAppSize.s16.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required Widget icon,
    required String title,
    required String subTitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        PAppSize.s5.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(subTitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  /// Shows modal to logout user from app
  /// params ;- context
  Future<dynamic> showUpgradeModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkAppBarColor
          : PAppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PAppSize.s24),
      ),
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: PAppSize.s16,
              vertical: PAppSize.s4,
            ),
            height: PDeviceUtil.getDeviceHeight(context) * 0.42,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'upgrade_benefits'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: PAppSize.s16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CircleAvatar(
                      radius: PAppSize.s20,
                      backgroundColor: PAppColor.fillColor,
                      child: Assets.icons.closeIcon.svg(
                        color: PHelperFunction.isDarkMode(context)
                            ? const Color.fromARGB(255, 26, 23, 23)
                            : PAppColor.darkAppBarColor,
                      ),
                    ).onPressed(
                      onTap: PHelperFunction.pop,
                      radius: BorderRadius.circular(PAppSize.s20),
                    ),
                  ],
                ),
                PAppSize.s14.verticalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildListTile(
                        context: context,
                        icon: Assets.icons.checkDark.svg(),
                        title: 'Higher Coverage',
                        subTitle:
                            'Increase your sum assured from ₵1.5M to ₵2.5M - that\'s ₵1M in additional protection for your loved ones.',
                      ),
                      PAppSize.s18.verticalSpace,
                      _buildListTile(
                        context: context,
                        icon: Assets.icons.shieldDark.svg(),
                        title: 'Better Financial Security',
                        subTitle:
                            'Enhanced coverage means better financial protection against unexpected events.',
                      ),

                      PAppSize.s18.verticalSpace,
                      _buildListTile(
                        context: context,
                        icon: Assets.icons.upgradeDark.svg(),
                        title: 'Affordable Increase',
                        subTitle:
                            'For just ₵5,000 more per month, you get significantly more peace of mind.',
                      ),
                    ],
                  ).scrollable(),
                ),

                PAppSize.s20.verticalSpace,
                // Action buttons
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: PGradientButton(
                          label: 'upgrade_now'.tr,
                          showIcon: false,
                          loading: vm.loading.value,
                          textColor: PAppColor.whiteColor,
                          width: PDeviceUtil.getDeviceWidth(context),
                          onTap: () {},
                        ),
                      ),
                      PAppSize.s8.horizontalSpace,
                      Expanded(
                        child: OutlinedButton(
                          onPressed: PHelperFunction.pop,

                          style: OutlinedButton.styleFrom(
                            foregroundColor: PAppColor.successDark,
                            side: BorderSide(color: PAppColor.successDark),
                            minimumSize: Size.fromHeight(PAppSize.buttonHeight),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(PAppSize.s24),
                            ),
                          ),
                          child: Text('cancel'.tr),
                        ),
                      ),
                    ],
                  ),
                ),
                PAppSize.s4.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
