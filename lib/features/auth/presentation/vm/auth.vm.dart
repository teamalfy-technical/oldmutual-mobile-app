import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/widgets/popup.dialog.dart';

class PAuthVm extends GetxController {
  static PAuthVm get instance => Get.find();

  final memberIDTEC = TextEditingController();
  final emailTEC = TextEditingController();
  final phoneTEC = TextEditingController(text: '0591056230');
  final passwordTEC = TextEditingController();
  final confirmPasswordTEC = TextEditingController();

  final memberIDFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final createPasswordFormKey = GlobalKey<FormState>();

  var obscure = true.obs;

  var agreeToTerms = false.obs;

  onTermsCheckboxChanged(bool? value) => agreeToTerms.value = value ?? false;
  onObscureChanged() => obscure.value = !obscure.value;

  final context = Get.context!;

  /// Function to verify OTP code sent to device
  /// @params => pin
  Future<void> verifyOTP({required String pin, required bool isSignup}) async {
    final context = Get.context!;
    showLoadingdialog(
      context: context,
      content: Text(
        'verifying_to_msg'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );

    Future.delayed(Duration(seconds: 3), () {
      PHelperFunction.pop();
      // show success dialog
      showSucccessdialog(context: context, title: 'verified_otp_msg'.tr);

      Future.delayed(Duration(seconds: 2), () {
        PHelperFunction.pop();
        // navigate to next screen
        PHelperFunction.switchScreen(
          destination: Routes.createPasswordPage,
          replace: true,
          args: isSignup,
        );
      });
    });
  }

  /// [Function] Create password for either sign
  /// or reset password flow
  /// @ params - bool isSignup
  void createPassword({required bool isSignup}) {
    if (isSignup) {
      PHelperFunction.switchScreen(
        destination: Routes.signupPage,
        replace: true,
      );
    } else {
      PHelperFunction.switchScreen(
        destination: Routes.loginPage,
        replace: true,
      );
    }
  }

  /// Function to get user information
  Future<void> getMemberInfo() async {
    if (!agreeToTerms.value) {
      PPopupDialog(context).errorMessage(
        'Terms & Conditions',
        'You need to agree to our terms and conditions bo continue.',
      );
      return;
    }

    PHelperFunction.switchScreen(destination: Routes.verifyOTPPage, args: true);
  }

  /// Function to login a user
  /// @params - String pin
  /// @params - bool isSignup
  Future<void> login() async {
    String phone = phoneTEC.text.trim();
    String password = passwordTEC.text.trim();
    if (phone == '0591056230' && password != 'Test2+=##') {
      PPopupDialog(context).errorMessage(
        'Incorrect email or password',
        'Try entering your information again, or resetting your password',
      );
      return;
    }
    PHelperFunction.switchScreen(destination: Routes.dashboardPage, args: true);
  }

  /// Function to login a user
  /// @params - String pin
  /// @params - bool isSignup
  Future<void> signup({required String pin, required bool isSignup}) async {
    String phone = phoneTEC.text.trim();
    String password = passwordTEC.text.trim();
    if (phone == '0591056230' && password != 'test') {
      PPopupDialog(context).errorMessage(
        'Incorrect email or password',
        'Try entering your information again, or resetting your password',
      );
    }
  }
}
