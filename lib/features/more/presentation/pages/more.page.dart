import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/settings/settings.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PMorePage extends StatelessWidget {
  PMorePage({super.key});

  Widget divider() => Divider(
    color: PAppColor.fillColor2.withOpacityExt(PAppSize.s0_6),
    height: PAppSize.s0,
    thickness: PAppSize.s2,
  );

  final vm = Get.put(PSettingsVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      body: SafeArea(
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PAppSize.s14.verticalSpace,
                // Username
                Text(
                  '${PSecureStorage().getAuthResponse()?.name}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                PAppSize.s8.verticalSpace,
                // Manage Personal Details section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PAppSize.s20),
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.darkAppBarColor
                        : PAppColor.whiteColor,
                  ),
                  child: SettingsListTile(
                    onTap: () => PHelperFunction.switchScreen(
                      destination: Routes.userDetailsPage,
                    ),
                    padding: EdgeInsets.only(
                      left: PAppSize.s14,
                      right: PAppSize.s24,
                      top: PAppSize.s18,
                      bottom: PAppSize.s18,
                    ),
                    title: Text(
                      'manage_ur_personal_details'.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Assets.icons.arrowForwardIos.svg(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor
                          : PAppColor.darkAppBarColor,
                    ),
                  ),
                ),

                PAppSize.s16.verticalSpace,

                //   Other More section
                Container(
                  // padding: EdgeInsets.all(PAppSize.s8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PAppSize.s20),
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.darkAppBarColor
                        : PAppColor.whiteColor,
                  ),
                  child: Column(
                    children: [
                      SettingsListTile(
                        leading: Assets.icons.helpIcon.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.darkAppBarColor,
                        ),
                        onTap: () => PHelperFunction.switchScreen(
                          destination: Routes.supportPage,
                        ),
                        padding: EdgeInsets.only(
                          left: PAppSize.s14,
                          right: PAppSize.s24,
                          top: PAppSize.s18,
                          bottom: PAppSize.s18,
                        ),
                        title: Text(
                          'help'.tr,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        trailing: Assets.icons.arrowForwardIos.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.darkAppBarColor,
                        ),
                      ),
                      divider(),
                      SettingsListTile(
                        leading: Assets.icons.settingsIcon.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.darkAppBarColor,
                        ),
                        onTap: () => PHelperFunction.switchScreen(
                          destination: Routes.profileSettingsPage,
                        ),
                        padding: EdgeInsets.only(
                          left: PAppSize.s14,
                          right: PAppSize.s24,
                          top: PAppSize.s18,
                          bottom: PAppSize.s18,
                        ),
                        title: Text(
                          'profile_and_settings'.tr,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        trailing: Assets.icons.arrowForwardIos.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.darkAppBarColor,
                        ),
                      ),
                      divider(),
                      SettingsListTile(
                        leading: Assets.icons.termsIcon.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.darkAppBarColor,
                        ),
                        onTap: () => PHelperFunction.switchScreen(
                          destination: Routes.termsAndConditionsPage,
                        ),
                        padding: EdgeInsets.only(
                          left: PAppSize.s14,
                          right: PAppSize.s24,
                          top: PAppSize.s18,
                          bottom: PAppSize.s18,
                        ),
                        title: Text(
                          'terms_n_conditions'.tr,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        trailing: Assets.icons.arrowForwardIos.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.darkAppBarColor,
                        ),
                      ),
                      divider(),
                      SettingsListTile(
                        leading: Assets.icons.faqIcon.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.darkAppBarColor,
                        ),
                        onTap: () => PHelperFunction.switchScreen(
                          destination: Routes.webviewPage,
                          args: [
                            '${'faq'.tr.toUpperCase()}s',
                            PAppConstant.faqUrl,
                          ],
                        ),
                        padding: EdgeInsets.only(
                          left: PAppSize.s14,
                          right: PAppSize.s24,
                          top: PAppSize.s18,
                          bottom: PAppSize.s18,
                        ),
                        title: Text(
                          'faq'.tr.toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        trailing: Assets.icons.arrowForwardIos.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.darkAppBarColor,
                        ),
                      ),
                    ],
                  ),
                ),

                PAppSize.s32.verticalSpace,

                // Logout section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PAppSize.s20),
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.darkAppBarColor
                        : PAppColor.whiteColor,
                  ),
                  child: SettingsListTile(
                    leading: Assets.icons.logoutIcon.svg(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor
                          : PAppColor.darkAppBarColor,
                    ),
                    onTap: () => showLogoutModal(context),
                    padding: EdgeInsets.only(
                      left: PAppSize.s14,
                      right: PAppSize.s24,
                      top: PAppSize.s18,
                      bottom: PAppSize.s18,
                    ),
                    title: Text(
                      'logout'.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Assets.icons.arrowForwardIos.svg(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor
                          : PAppColor.darkAppBarColor,
                    ),
                  ),
                ),
              ],
            ).scrollable().symmetric(
              horizontal: PAppSize.s20,
              vertical: PAppSize.s20,
            ),
      ),
    );
  }

  /// Shows modal to logout user from app
  /// params ;- context
  Future<dynamic> showLogoutModal(BuildContext context) {
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
            height: PDeviceUtil.getDeviceHeight(context) * 0.18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${'logout'.tr}?',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Assets.icons.closeIcon
                              .svg(
                                color: PHelperFunction.isDarkMode(context)
                                    ? PAppColor.whiteColor
                                    : PAppColor.darkAppBarColor,
                              )
                              .onPressed(
                                onTap: PHelperFunction.pop,
                                radius: BorderRadius.circular(PAppSize.s20),
                              ),
                        ],
                      ),
                      PAppSize.s14.verticalSpace,
                      Text(
                        'logout_msg'.tr,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: PAppSize.s13.sp,
                          fontWeight: FontWeight.w400,
                        ),
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
                          label: 'yes_logout'.tr,
                          showIcon: false,
                          loading: vm.loading.value,
                          textColor: PAppColor.whiteColor,
                          width: PDeviceUtil.getDeviceWidth(context),
                          onTap: () => vm.signout(soft: false),
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
                          child: Text('no'.tr),
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
