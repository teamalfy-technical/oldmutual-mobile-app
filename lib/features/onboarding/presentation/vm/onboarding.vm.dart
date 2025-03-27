import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/onboarding/domain/models/onboarding.model.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class POnboardingVm extends GetxController {
  static POnboardingVm get instance => Get.find();

  var pageIndex = 0.obs;

  final PageController pageController = PageController();

  onPageChanged(int val) {
    pageIndex.value = val;
  }

  // navigate between slides on onboarding page
  navigateToNextScreen() {
    if (pageIndex.value < slides.length - 1) {
      pageIndex.value++;
      pageController.animateToPage(
        pageIndex.value,
        duration: const Duration(milliseconds: PAppSize.s500),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      navigateToSignup();
    }
  }

  navigateToSignup() {
    // mark onboarding as completed
    PSecureStorage().saveData(PSecureStorage().onboardingKey, true);
    // navigate to sign up
    PHelperFunction.switchScreen(destination: Routes.signupPage, replace: true);
  }
}
