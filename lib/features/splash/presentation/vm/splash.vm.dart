import 'dart:async';

import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PSplashVm extends GetxController {
  static PSplashVm get instance => Get.find();

  @override
  void onInit() {
    showSplashPage();
    super.onInit();
  }

  /// Disply splash screen
  /// check if user is logged in or not
  /// [showSplashPage]
  void showSplashPage() async {
    // final message = await Get.put(SAuthVm()).checkIfUserIsLoggedIn();
    // if (message == 'okay'.tr) {
    //   PHelperFunction.switchScreen(
    //       destination: Routes.dashboardPage, replace: true);
    // } else {
    //   if (SSecureStorage().readData(SSecureStorage().onboardingKey) == null) {
    //     SHelperFunction.switchScreen(
    //         destination: Routes.onboardingPage, replace: true);
    //   } else {
    //     SHelperFunction.switchScreen(
    //         destination: Routes.loginPage, replace: true);
    //   }
    // }

    Timer(Duration(seconds: 3), () {
      if (PSecureStorage().readData(PSecureStorage().onboardingKey) == null) {
        PHelperFunction.switchScreen(
          destination: Routes.onboardingPage,
          replace: true,
        );
      } else {
        if (PSecureStorage().getAuthResponse() != null) {
          PHelperFunction.switchScreen(
            destination: Routes.dashboardPage,
            replace: true,
          );
        } else {
          bool? isRegistered = PSecureStorage().readData<bool>(
            PSecureStorage().registerdKey,
          );
          if (isRegistered != null && isRegistered) {
            PHelperFunction.switchScreen(
              destination: Routes.loginPage,
              replace: true,
            );
          } else {
            PHelperFunction.switchScreen(
              destination: Routes.signupPage,
              replace: true,
            );
          }
        }
      }
    });
  }
}
