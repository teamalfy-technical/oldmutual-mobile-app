import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PMVestPage extends StatelessWidget {
  const PMVestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? PAppColor.darkBgColor : PAppColor.fillColor,
      appBar: AppBar(title: Text('mvest_title'.tr)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PAppSize.s20),
          child: PAnimatedColumnWidget(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PAppSize.s16.verticalSpace,
              Text(
                'mvest_intro'.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: PAppSize.s14,
                  color: isDark ? PAppColor.fillColor2 : PAppColor.text700,
                ),
              ),
              PAppSize.s24.verticalSpace,
              _MVestBenefitTile(
                icon: Assets.icons.savingsIcon,
                title: 'flexible_contributions'.tr,
                description: 'flexible_contributions_desc'.tr,
              ),
              PAppSize.s20.verticalSpace,
              _MVestBenefitTile(
                icon: Assets.icons.increaseInterestIcon,
                title: 'competitive_returns'.tr,
                description: 'competitive_returns_desc'.tr,
              ),
              PAppSize.s20.verticalSpace,
              _MVestBenefitTile(
                icon: Assets.icons.insureOutline,
                title: 'secure_and_regulated'.tr,
                description: 'secure_and_regulated_desc'.tr,
              ),
              PAppSize.s20.verticalSpace,
              _MVestBenefitTile(
                icon: Assets.icons.withdrawal,
                title: 'easy_withdrawals'.tr,
                description: 'easy_withdrawals_desc'.tr,
              ),
              PAppSize.s24.verticalSpace,
              NoteWidget(
                borderRadius: BorderRadius.circular(PAppSize.s12),
                color: isDark
                    ? PAppColor.primary.withOpacityExt(PAppSize.s0_2)
                    : PAppColor.primaryBorderLight,
                borderColor: PAppColor.primaryBorderColor,
                textColor: isDark ? PAppColor.whiteColor : PAppColor.text700,
                description: 'mvest_note'.tr,
              ),

              PAppSize.s50.verticalSpace,
              PGradientButton(
                label: 'start_investing'.tr,
                showIcon: false,
                textColor: PAppColor.whiteColor,
                width: PDeviceUtil.getDeviceWidth(context),
                onTap: () => PHelperFunction.switchScreen(
                  destination: Routes.mvestSchemeDetailsPage,
                ),
              ),
              PAppSize.s24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class _MVestBenefitTile extends StatelessWidget {
  final SvgGenImage icon;
  final String title;
  final String description;

  const _MVestBenefitTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        icon.svg(width: PAppSize.s32, height: PAppSize.s32),
        PAppSize.s12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: PAppSize.s16,
                  color: isDark ? PAppColor.whiteColor : PAppColor.text700,
                ),
              ),
              PAppSize.s0.verticalSpace,
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: PAppSize.s13,
                  color: isDark
                      ? PAppColor.fillColor2
                      : PAppColor.darkAppBarColor.withOpacityExt(PAppSize.s0_7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
