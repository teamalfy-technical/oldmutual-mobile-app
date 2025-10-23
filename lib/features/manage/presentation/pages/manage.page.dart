import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/manage/manage.dart';
import 'package:oldmutual_pensions_app/features/settings/settings.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PManagePage extends StatelessWidget {
  PManagePage({super.key});

  final vm = Get.put(PManageVm());

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
                PAppSize.s8.verticalSpace,
                // Username
                Text(
                  'manage_hint'.tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : Color(0xFF666666),
                  ),
                ),

                PAppSize.s14.verticalSpace,

                // Documents section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PAppSize.s20),
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.darkAppBarColor
                        : PAppColor.whiteColor,
                  ),
                  child: SettingsListTile(
                    leading: Assets.icons.document.svg(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor
                          : PAppColor.darkAppBarColor,
                    ),
                    onTap: () => PHelperFunction.switchScreen(
                      destination: Routes.documentsPage,
                    ),
                    padding: EdgeInsets.only(
                      left: PAppSize.s14,
                      right: PAppSize.s24,
                      top: PAppSize.s18,
                      bottom: PAppSize.s18,
                    ),
                    title: Text(
                      'documents'.tr,
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
