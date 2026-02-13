import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/more/more.services.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/widgets/annotated.region.dart';
import 'package:upgrader/upgrader.dart';

class PDashboardPage extends StatelessWidget {
  PDashboardPage({super.key});

  final ctrl = Get.put(PHomeVm());

  final List<Widget> _pages = [
    PHomePage(),
    PUserDetailPage(isShowAppBar: false),
    // PManagePage(),
    // Container(
    //   alignment: Alignment.center,
    //   color: PAppColor.darkAppBarColor2,
    //   child: Text('manage'.tr),
    // ),
    PMorePage(),
    // PProfileSettingsPage(),
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
    return UpgradeAlert(
      dialogStyle: PDeviceUtil.isIOS()
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      child: Obx(
        () => Scaffold(
          backgroundColor: PHelperFunction.isDarkMode(context)
              ? PAppColor.darkBgColor
              : PAppColor.fillColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top),
            child: FutureBuilder<Member?>(
              future: PSecureStorage().getAuthResponse(),
              builder: (context, snapshot) {
                final user = snapshot.data;
                // Hide AppBar if user is affluent, but keep status bar spacing
                if (user?.affluent == true) {
                  return Container(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.darkAppBarColor
                        : PAppColor.whiteColor,
                    height: MediaQuery.of(context).padding.top,
                  );
                }
                // Show AppBar if user is not affluent
                return AppBar(
                  title: ctrl.currentIndex.value == 1
                      ? Text('manage'.tr)
                      : ctrl.currentIndex.value == 2
                      ? Text('more'.tr)
                      : FutureBuilder<String?>(
                          future: PSecureStorage().getUserFirstName(),
                          builder: (context, snapshot) {
                            return Text('Hi ${snapshot.data ?? ''}');
                          },
                        ),
                  actions: [
                    IconButton(
                      onPressed: () => PHelperFunction.switchScreen(
                        destination: Routes.notificationPage,
                      ),
                      icon: Assets.icons.notificationIcon.svg(
                        height: PAppSize.s28,
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.whiteColor
                            : PAppColor.cardDarkColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
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
      ),
    );
  }
}
