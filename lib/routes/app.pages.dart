import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/pages/forgot.password/forgot.password.page.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/pages/login/welcome.back.page.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/pages/signup/create.password.page.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/pages/verify.otp.page.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/presentation/pages/add.beneficiary.page.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/future.value.calculator/future.value.calculator.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/manage/manage.dart';
import 'package:oldmutual_pensions_app/features/more/more.services.dart';
import 'package:oldmutual_pensions_app/features/more/presentation/pages/support.page.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/features/redemptions/presentation/pages/porting.page.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/pages/change.password.page.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/pages/profile.settings.page.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/pages/settings.success.page.dart';
import 'package:oldmutual_pensions_app/features/settings/settings.dart';
import 'package:oldmutual_pensions_app/features/splash/splash.dart';
import 'package:oldmutual_pensions_app/features/statements/presentation/pages/statement.page.dart';
import 'package:oldmutual_pensions_app/features/webview/webview.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

import '../features/onboarding/presentation/pages/onboarding.page.dart';

part 'app.routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashPage;

  static final routes = [
    GetPage(name: _Paths.splashPage, page: () => PSplashPage()),

    GetPage(
      name: _Paths.onboardingPage,
      page: () => POnboardingPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.welcomePage,
      page: () => PWelcomePage(),
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
      name: _Paths.welcomeBackPage,
      page: () => PWelcomeBackPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.loadingPage,
      page: () => PCustomLoadingPage(message: Get.arguments),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.successPage,
      page: () => PCustomSuccessPage(
        title: Get.arguments[0],
        message: Get.arguments[1],
        buttonTitle: Get.arguments[2],
        onTap: Get.arguments[3],
      ),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.settingsSuccessPage,
      page: () => PSettingsSuccessPage(
        title: Get.arguments[0],
        message: Get.arguments[1],
        buttonTitle: Get.arguments[2],
        onTap: Get.arguments[3],
      ),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.createAccountPage,
      page: () => PCreateAccountPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.idEntryPage,
      page: () => PIdEntryPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.livenessInfoPage,
      page: () => PLivenessInfoPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.verifyOTPPage,
      page: () => PVerifyOTPPage(isSignup: Get.arguments ?? true),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.forgotPasswordPage,
      page: () => PForgotPasswordPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.createPasswordPage,
      page: () => PCreatePasswordPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    // GetPage(
    //   name: _Paths.signupPage,
    //   page: () => const SSignupPage(),
    // ),
    GetPage(
      name: _Paths.dashboardPage,
      page: () => PDashboardPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.dashboardHighlightPage,
      page: () => PDashboardHighlightPage(highlight: Get.arguments),
      // transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s450),
    ),

    /// Policy Pages
    GetPage(
      name: _Paths.productsPage,
      page: () => PPolicyPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s450),
    ),
    GetPage(
      name: _Paths.policyOverviewPage,
      page: () => PPolicyOverviewPage(product: Get.arguments),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s450),
    ),
    GetPage(
      name: _Paths.policyDetailPage,
      page: () => PPolicyDetailPage(policy: Get.arguments),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s450),
    ),

    /// Pensions Pages
    GetPage(
      name: _Paths.pensionOverviewPage,
      page: () => PPensionOverviewPage(product: Get.arguments),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s450),
    ),

    GetPage(
      name: _Paths.pensionDetailPage,
      page: () => PPensionDetailPage(scheme: Get.arguments),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s450),
    ),

    GetPage(
      name: _Paths.contributionsPage,
      page: () => PContributionsPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s450),
    ),

    GetPage(
      name: _Paths.homePage,
      page: () => PHomePageOld(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.profileSettingsPage,
      page: () => PProfileSettingsPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.userDetailsPage,
      page: () => PUserDetailPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(
      name: _Paths.termsAndConditionsPage,
      page: () => PTermsAndConditionsPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: PAppSize.s700),
    ),
    GetPage(name: _Paths.notificationPage, page: () => PNotificationPage()),
    GetPage(name: _Paths.factsheetPage, page: () => PFactSheetPage()),
    GetPage(
      name: _Paths.redemptionAndTransferPage,
      page: () => PRedemptionTransferPage(),
    ),
    GetPage(name: _Paths.redemptionPage, page: () => PRedemptionPage()),
    GetPage(name: _Paths.portingPage, page: () => PPortingPage()),
    GetPage(name: _Paths.beneficiariesPage, page: () => PBeneficiaryListPage()),
    GetPage(
      name: _Paths.manageBeneficiaryPage,
      page: () => PManageBeneficiaryPage(
        beneficiary: Get.arguments[0],
        isEdit: Get.arguments[1],
      ),
    ),
    // GetPage(
    //   name: _Paths.addbeneficiaryPage,
    //   page: () => PEditBeneficiaryPage(),
    // ),
    GetPage(
      name: _Paths.contributionHistoryPage,
      page: () => PContributionHistoryPage(),
    ),

    GetPage(
      name: _Paths.futureValueCalcPage,
      page: () => PFutureValueCalcPage(),
      // page: () => PFutureValueCalcPage(),
    ),
    GetPage(name: _Paths.statementPage, page: () => PStatementPage()),
    GetPage(name: _Paths.settingsPage, page: () => PSettingsPage()),
    GetPage(name: _Paths.changePasswordPage, page: () => PChangePasswordPage()),
    GetPage(name: _Paths.supportPage, page: () => PSupportPage()),
    GetPage(
      name: _Paths.deleteAccountPageOne,
      page: () => PDeleteAccountPageOne(),
    ),
    GetPage(
      name: _Paths.deleteAccountPageTwo,
      page: () => PDeleteAccountPageTwo(),
    ),
    GetPage(
      name: _Paths.webviewPage,
      page: () => PWebView(title: Get.arguments[0], url: Get.arguments[1]),
    ),

    /// --- Manage Feature Pages
    GetPage(name: _Paths.managePage, page: () => PManagePage()),
    GetPage(name: _Paths.documentsPage, page: () => PDocumentsPage()),
  ];
}
