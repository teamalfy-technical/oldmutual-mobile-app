import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/pages/profile.settings.page.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/widgets/annotated.region.dart';

class PDashboardPage extends StatelessWidget {
  PDashboardPage({super.key});

  final ctrl = Get.put(PHomeVm());

  final List<Widget> _pages = [
    PHomePage(),
    Container(
      alignment: Alignment.center,
      color: PAppColor.darkAppBarColor2,
      child: Text('manage'.tr),
    ),
    PProfileSettingsPage(),
    // Container(
    //   alignment: Alignment.center,
    //   color: PAppColor.darkAppBarColor2,
    //   child: Text('more'.tr),
    // ),
    // PFactSheetPage(),
    // PNotificationPage(),
    // PProfilePage(),
    // PMoreServicesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: PAppColor.fillColor,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: ctrl.currentIndex.value,
          onTap: ctrl.onPageChanged,
          elevation: PAppSize.s2,
          backgroundColor: PHelperFunction.isDarkMode(context)
              ? PAppColor.darkAppBarColor
              : PAppColor.whiteColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: PHelperFunction.isDarkMode(context)
              ? PAppColor.successLight
              : PAppColor.successDark,
          selectedIconTheme: IconThemeData(
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.successLight
                : PAppColor.successDark,
          ),
          selectedFontSize: PAppSize.s10,
          unselectedItemColor: PHelperFunction.isDarkMode(context)
              ? PAppColor.whiteColor
              : PAppColor.blackColor,
          unselectedIconTheme: IconThemeData(
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.whiteColor
                : PAppColor.blackColor,
          ),
          // unselectedFontSize: PAppSize.s1,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Assets.icons.homeIcon.svg(
                color: ctrl.currentIndex.value == 0
                    ? PHelperFunction.isDarkMode(context)
                          ? PAppColor.successLight
                          : PAppColor.successDark
                    : PHelperFunction.isDarkMode(context)
                    ? PAppColor.whiteColor
                    : PAppColor.blackColor,
              ),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Assets.icons.manageIcon.svg(
                color: ctrl.currentIndex.value == 1
                    ? PHelperFunction.isDarkMode(context)
                          ? PAppColor.successLight
                          : PAppColor.successDark
                    : PHelperFunction.isDarkMode(context)
                    ? PAppColor.whiteColor
                    : PAppColor.blackColor,
              ),
              label: 'manage'.tr,
            ),
            BottomNavigationBarItem(
              icon: Assets.icons.moreIcon.svg(
                color: ctrl.currentIndex.value == 2
                    ? PHelperFunction.isDarkMode(context)
                          ? PAppColor.successLight
                          : PAppColor.successDark
                    : PHelperFunction.isDarkMode(context)
                    ? PAppColor.whiteColor
                    : PAppColor.blackColor,
              ),
              label: 'more'.tr,
            ),
          ],
        ),
        body: PAnnotatedRegion(child: _pages[ctrl.currentIndex.value]),
      ),
    );
  }
}
