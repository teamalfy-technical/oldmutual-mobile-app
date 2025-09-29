import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/settings/settings.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PMorePage extends StatelessWidget {
  const PMorePage({super.key});

  Widget divider() => Divider(
    color: PAppColor.fillColor2.withOpacityExt(PAppSize.s0_6),
    height: PAppSize.s0,
    thickness: PAppSize.s2,
  );

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
                        onTap: () {},
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
                    onTap: () {},
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
}
