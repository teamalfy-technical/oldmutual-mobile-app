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
      // Perform device security check first
      final securityStatus = await DeviceSecurityService().checkDeviceSecurity();

      if (securityStatus.isCompromised) {
        stop();
        PHelperFunction.switchScreen(
          destination: Routes.securityBlockedPage,
          replace: true,
          args: securityStatus.securityIssueMessage,
        );
        return;
      }

      if (PSecureStorage().readData(PSecureStorage().onboardingKey) == null) {
        stop();
        PHelperFunction.switchScreen(
          destination: Routes.welcomePage,
          replace: true,
        );
      } else {
        // On a fresh app start, always require re-authentication.
        // Never go directly to the dashboard from splash.
        final userEmail = await PSecureStorage().getUserEmail();
        final userPassword = await PSecureStorage().getBiometricPassword();

        // Clear any stale session data so user must re-authenticate
        await PSecureStorage().removeSecureData(PSecureStorage().authResKey);
        await PSecureStorage().removeSecureData(PSecureStorage().bioDataKey);

        if (userEmail != null &&
            userPassword != null &&
            PSecureStorage().isBiometricEnabled) {
          // User has saved credentials and biometric enabled - show welcome back for biometric/quick login
          PHelperFunction.switchScreen(
            destination: Routes.welcomeBackPage,
            replace: true,
          );
        } else {
          // No saved credentials - show full login
          PHelperFunction.switchScreen(
            destination: Routes.loginPage,
            replace: true,
          );
        }
        stop();
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
