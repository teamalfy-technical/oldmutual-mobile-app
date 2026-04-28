import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PDeleteAccountPageOne extends StatelessWidget {
  const PDeleteAccountPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('delete_account'.tr)),
      body: Column(
        children: [
          // Personal Details
          Container(
            padding: EdgeInsets.all(PAppSize.s20),
            height: PDeviceUtil.getDeviceHeight(context) * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PAppSize.s20),
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.darkAppBarColor
                  : PAppColor.whiteColor,
              border: Border.all(
                width: PAppSize.s1,
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.transparentColor
                    : PAppColor.fillColor2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'head_up'.tr,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontSize: PAppSize.s14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      PAppSize.s8.verticalSpace,

                      Text(
                        'delete_account_meaning'.tr,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      PAppSize.s12.verticalSpace,

                      Text(
                        'delete_account_lose_policies'.tr,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      PAppSize.s12.verticalSpace,

                      Text(
                        'delete_account_temporary'.tr,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      PAppSize.s12.verticalSpace,

                      Text(
                        'delete_account_lose_funds'.tr,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      PAppSize.s12.verticalSpace,

                      Text(
                        'delete_account_no_recovery'.tr,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      PAppSize.s12.verticalSpace,

                      Text(
                        'delete_account_pensions_inaccessible'.tr,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ).scrollable(),
                ),

                PGradientButton(
                  label: 'delete_acc_positive'.tr,
                  showIcon: false,
                  textColor: PAppColor.whiteColor,
                  width: PDeviceUtil.getDeviceWidth(context),
                  onTap: () => PHelperFunction.switchScreen(
                    destination: Routes.deleteAccountPageTwo,
                  ),
                ),

                PAppSize.s4.verticalSpace,

                TextButton(
                  onPressed: () => PHelperFunction.pop(),
                  child: Text(
                    'go_back'.tr,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.successLight
                          : PAppColor.successDark,
                    ),
                  ),
                ).centered(),

                PAppSize.s32.verticalSpace,
              ],
            ),
          ),
        ],
      ).all(PAppSize.s20),
    );
  }
}
