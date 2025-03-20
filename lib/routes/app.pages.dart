import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/pages/reset.password/enter.email.page.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/pages/signup/create.password.page.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/pages/verify.otp.page.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/presentation/pages/beneficiary.page.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/presentation/pages/contribution.history.page.dart';
import 'package:oldmutual_pensions_app/features/dashboard/presentation/pages/dashboard.page.dart';
import 'package:oldmutual_pensions_app/features/factsheet/presentation/pages/factsheet.page.dart';
import 'package:oldmutual_pensions_app/features/future.value.calculator/future.value.calculator.dart';
import 'package:oldmutual_pensions_app/features/home/presentation/pages/home.page.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/features/settings/settings.dart';

import '../features/onboarding/presentation/pages/onboarding.page.dart';
import '../features/splash/presentation/pages/splash.page.dart';

part 'app.routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.signupPage;

  static final routes = [
    GetPage(name: _Paths.splashPage, page: () => PSplashPage()),

    GetPage(
      name: _Paths.onboardingPage,
      page: () => POnboardingPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.loginPage,
      page: () => PLoginPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.signupPage,
      page: () => PMemberIdPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.verifyOTPPage,
      page: () => PVerifyOTPPage(isSignup: Get.arguments),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.enterEmailPage,
      page: () => PEnterEmailPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.createPasswordPage,
      page: () => PCreatePasswordPage(isSignup: Get.arguments),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    // GetPage(
    //   name: _Paths.signupPage,
    //   page: () => const SSignupPage(),
    // ),
    GetPage(name: _Paths.dashboardPage, page: () => PDashboardPage()),
    GetPage(name: _Paths.homePage, page: () => PHomePage()),
    GetPage(name: _Paths.notificationPage, page: () => PNotificationPage()),
    GetPage(name: _Paths.factsheetPage, page: () => PFactSheetPage()),
    GetPage(name: _Paths.beneficiariesPage, page: () => PBeneficiaryPage()),
    GetPage(
      name: _Paths.contributionHistoryPage,
      page: () => PContributionHistoryPage(),
    ),
    GetPage(
      name: _Paths.calculateResultPage,
      page: () => PCalculateResultsPage(),
    ),
    GetPage(
      name: _Paths.futureValueCalcPage,
      page: () => PFutureValueCalcPage(),
    ),
    GetPage(name: _Paths.settingsPage, page: () => PSettingsPage()),
    GetPage(name: _Paths.supportPage, page: () => PSupportPage()),
    // GetPage(name: _Paths.factsheetPage, page: () => PFactSheetPage()),
  ];
}
