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

  /// Display splash screen
  /// check if user is logged in or not
  /// [showSplashPage]
  void showSplashPage() async {
    Timer(Duration(seconds: 3), () {
      if (PSecureStorage().readData(PSecureStorage().onboardingKey) == null) {
        PHelperFunction.switchScreen(
          destination: Routes.welcomePage,
          replace: true,
        );
      } else {
        pensionAppLogger.e(
          PFormatter.calculateDateDiff(
            PSecureStorage().getAuthResponse()!.lastLoggedIn!,
          ),
        );
        if (PSecureStorage().getAuthResponse() != null) {
          final lastLoggedIn = PFormatter.calculateDateDiff(
            PSecureStorage().getAuthResponse()!.lastLoggedIn!,
          );
          // redirect user to welcome back screen after been logged in for 3 days
          if (lastLoggedIn >= 3 && PSecureStorage().getUserEmail() != null) {
            PHelperFunction.switchScreen(
              destination: Routes.welcomeBackPage,
              replace: true,
            );
          } else {
            PHelperFunction.switchScreen(
              destination: Routes.dashboardPage,
              replace: true,
            );
          }
        } else {
          if (PSecureStorage().getUserEmail() != null) {
            PHelperFunction.switchScreen(
              destination: Routes.welcomeBackPage,
              replace: true,
            );
          } else {
            PHelperFunction.switchScreen(
              // destination: Routes.idEntryPage,
              destination: Routes.loginPage,
              replace: true,
            );
          }
        }
      }
    });
  }

  completeOnboarding(String route) {
    PSecureStorage().saveData(PSecureStorage().onboardingKey, true);
    PHelperFunction.switchScreen(destination: route, replace: true);
  }
}
