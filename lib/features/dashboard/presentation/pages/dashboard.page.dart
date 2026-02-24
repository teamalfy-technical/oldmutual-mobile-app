import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/more/more.services.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/widgets/annotated.region.dart';
import 'package:upgrader/upgrader.dart';

class PDashboardPage extends StatelessWidget {
  PDashboardPage({super.key});

  final ctrl = Get.put(PHomeVm());

  BottomNavigationBarItem _buildNavItem({
    required BuildContext context,
    required Widget icon,
    required String label,
  }) {
    final unselectedColor = PHelperFunction.isDarkMode(context)
        ? PAppColor.whiteColor
        : PAppColor.blackColor;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
            child: icon,
          ),
          SizedBox(height: PAppSize.s4),
          Text(
            label,
            style: TextStyle(
              fontSize: PAppSize.s10,
              color: unselectedColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      activeIcon: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) =>
            PAppColor.primaryGradient.createShader(bounds),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: icon,
            ),
            SizedBox(height: PAppSize.s4),
            Text(
              label,
              style: TextStyle(
                fontSize: PAppSize.s10,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      label: label,
    );
  }

  List<Widget> get _pages => [
    PHomePage(),
    PUserDetailPage(isShowAppBar: false),
    if (ctrl.user.value?.affluent == false) ...[
      PSupportPage(user: ctrl.user.value),
    ],
    PMorePage(),
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
            child:
                // Hide AppBar if user is affluent, but keep status bar spacing
                ctrl.user.value?.affluent == false
                ? Container(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.darkAppBarColor
                        : PAppColor.whiteColor,
                    height: MediaQuery.of(context).padding.top,
                  )
                : AppBar(
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
                  ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ctrl.currentIndex.value,
            onTap: ctrl.onPageChanged,
            elevation: PAppSize.s2,
            backgroundColor: PHelperFunction.isDarkMode(context)
                ? PAppColor.darkAppBarColor
                : PAppColor.whiteColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              _buildNavItem(
                context: context,
                icon: Assets.icons.homeIcon.svg(),
                label: 'home'.tr,
              ),
              _buildNavItem(
                context: context,
                icon: Assets.icons.manageIcon.svg(),
                label: 'manage'.tr,
              ),
              if (ctrl.user.value?.affluent == false) ...[
                _buildNavItem(
                  context: context,
                  icon: Assets.icons.supportIcon.svg(),
                  label: 'support'.tr,
                ),
              ],
              _buildNavItem(
                context: context,
                icon: Assets.icons.moreIcon.svg(),
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
