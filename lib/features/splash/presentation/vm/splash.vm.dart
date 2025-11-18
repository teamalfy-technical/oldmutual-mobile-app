import 'dart:async';

import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PSplashVm extends GetxController {
  static PSplashVm get instance => Get.find();

  Timer? _timer;

  @override
  void onInit() {
    showSplashPage();
    super.onInit();
  }

  /// Display splash screen
  /// check if user is logged in or not
  /// [showSplashPage]
  void showSplashPage() async {
    _timer = Timer(Duration(seconds: 3), () async {
      if (PSecureStorage().readData(PSecureStorage().onboardingKey) == null) {
        stop();
        PHelperFunction.switchScreen(
          destination: Routes.welcomePage,
          replace: true,
        );
      } else {
        // Check if user has valid auth token AND bioData (indicates active session)
        final authResponse = await PSecureStorage().getAuthResponse();
        final bioData = await PSecureStorage().getBioData();
        final userEmail = await PSecureStorage().getUserEmail();

        if (authResponse?.token != null && bioData != null) {
          final lastLoggedIn = PFormatter.calculateDateDiff(
            authResponse!.lastLoggedIn!,
            DateDiffUnit.days,
          );
          // redirect user to welcome back screen after been logged in for 3 days
          if (lastLoggedIn >= 3 && userEmail != null) {
            stop();
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
          stop();
        } else {
          if (userEmail != null) {
            PHelperFunction.switchScreen(
              destination: Routes.welcomeBackPage,
              replace: true,
            );
          } else {
            PHelperFunction.switchScreen(
              destination: Routes.loginPage,
              // destination: Routes.createAccountPage,
              replace: true,
            );
          }
          stop();
        }
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }

  completeOnboarding(String route) {
    PSecureStorage().saveData(PSecureStorage().onboardingKey, true);
    PHelperFunction.switchScreen(destination: route, replace: true);
  }
}
