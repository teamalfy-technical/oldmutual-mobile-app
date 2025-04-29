import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';
import 'package:oldmutual_pensions_app/features/home/presentation/pages/home.view.dart';
import 'package:oldmutual_pensions_app/features/home/presentation/vm/home.vm.dart';
import 'package:oldmutual_pensions_app/features/more.services/presentation/pages/more.services.page.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/features/profile/profile.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/widgets/annotated.region.dart';

class PHomePage extends StatelessWidget {
  PHomePage({super.key});

  final ctrl = Get.put(PHomeVm());

  final List<Widget> _pages = [
    PHomeView(),
    PFactSheetPage(),
    PNotificationPage(),
    PProfilePage(),
    PMoreServicesPage(),
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
          backgroundColor:
              PHelperFunction.isDarkMode(context)
                  ? PAppColor.blackColor
                  : PAppColor.whiteColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: PAppColor.blackColor,
          selectedIconTheme: IconThemeData(color: PAppColor.primary),
          selectedFontSize: PAppSize.s10,
          unselectedItemColor: PAppColor.blackColor,
          unselectedIconTheme: IconThemeData(color: PAppColor.blackColor),
          unselectedFontSize: PAppSize.s10,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Assets.icons.homeIcon.svg(
                color: ctrl.currentIndex.value == 0 ? PAppColor.primary : null,
              ),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Assets.icons.factsheetIcon.svg(
                color: ctrl.currentIndex.value == 1 ? PAppColor.primary : null,
              ),
              label: 'factsheet'.tr,
            ),
            BottomNavigationBarItem(
              icon:
                  Get.find<PNotificationVM>().unreadCount.value > 0
                      ? Assets.icons.notificationCountIcon.svg(
                        color:
                            ctrl.currentIndex.value == 2
                                ? PAppColor.primary
                                : null,
                      )
                      : Assets.icons.notificationIcon.svg(
                        color:
                            ctrl.currentIndex.value == 2
                                ? PAppColor.primary
                                : null,
                      ),
              label: 'notification'.tr,
            ),
            BottomNavigationBarItem(
              icon: Assets.icons.profileIcon.svg(
                color: ctrl.currentIndex.value == 3 ? PAppColor.primary : null,
              ),
              label: 'profile'.tr,
            ),
            BottomNavigationBarItem(
              icon: Assets.icons.moreIcon.svg(
                color: ctrl.currentIndex.value == 4 ? PAppColor.primary : null,
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
