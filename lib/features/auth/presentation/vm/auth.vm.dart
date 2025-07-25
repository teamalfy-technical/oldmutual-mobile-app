import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/application/auth.service.impl.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/widgets/popup.dialog.dart';

class PAuthVm extends GetxController {
  static PAuthVm get instance => Get.find();

  // final memberIDTEC = TextEditingController();
  final emailTEC = TextEditingController();
  final phoneTEC = TextEditingController();
  final passwordTEC = TextEditingController();
  final confirmPasswordTEC = TextEditingController();

  final memberIDFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final createPasswordFormKey = GlobalKey<FormState>();

  var obscure = true.obs;

  var agreeToTerms = false.obs;

  var otpcode = ''.obs;

  final authService = Get.put(AuthServiceImpl());

  onTermsCheckboxChanged(bool? value) => agreeToTerms.value = value ?? false;

  onObscureChanged() => obscure.value = !obscure.value;

  final context = Get.context!;

  void updateOTP(String pin) => otpcode.value = pin;

  var selectedCountry =
      Country(
        phoneCode: '233',
        e164Sc: 1,
        countryCode: 'GH',
        level: 1,
        geographic: true,
        name: 'Ghana',
        example: '2012345678',
        displayName: 'Ghana (GH) [+233]',
        displayNameNoCountryCode: 'Ghana (GH)',
        e164Key: '1-GH-0',
      ).obs;

  void setSelectedCountry(Country country) {
    selectedCountry.value = country;
    selectedCountry.value.flagEmoji;
  }

  /// Function to sign up user by sending OTP code
  Future<void> signup() async {
    String phone = PFormatter.formatPhone(
      code: selectedCountry.value.phoneCode,
      phone: phoneTEC.text.trim(),
    );

    if (!agreeToTerms.value) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message: 'You need to agree to our terms and conditions to continue.',
      );
      return;
    }
    showLoadingDialog(
      context: context,
      content: Text(
        'signing_up'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    final result = await authService.signup(
      terms: agreeToTerms.value ? '1' : '0',
      phone: phone,
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PHelperFunction.pop();
        PHelperFunction.switchScreen(
          destination: Routes.verifyOTPPage,
          args: true,
        );
      },
    );
  }

  /// Function to verify OTP code sent to device
  /// @params => pin
  /// @params => isSignup
  Future<void> verifyOTP({required String pin, required bool isSignup}) async {
    // final context = Get.context!;

    String phone = PFormatter.formatPhone(
      code: selectedCountry.value.phoneCode,
      phone: phoneTEC.text.trim(),
    );
    String email = emailTEC.text.trim();

    if (otpcode.isEmpty) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message:
            'You need to enter the 6 digit code sent to your phone or email.',
      );
      return;
    }

    showLoadingDialog(
      context: context,
      barrierDismissible: true,
      content: Text(
        'verifying_to_msg'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    final result =
        isSignup
            ? await authService.verifyOTP(otp: pin, phone: phone)
            : await authService.verifyForgotPasswordOTP(otp: pin, email: email);
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PHelperFunction.pop();
        // show success dialog
        showSuccessDialog(context: context, title: 'verified_otp_msg'.tr);
        Future.delayed(Duration(seconds: 2), () {
          PHelperFunction.pop();
          // navigate to next screen
          PHelperFunction.switchScreen(
            destination: Routes.createPasswordPage,
            replace: true,
            args: isSignup,
          );
        });
      },
    );
  }

  void checkIfPasswordMatch() {
    if (passwordTEC.text.trim() != confirmPasswordTEC.text.trim()) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message: 'Passwords do not match',
      );
    }
    return;
  }

  /// [Function] Create password for either sign
  /// or reset password flow
  /// @ params - bool isSignup
  Future<void> createPassword({required bool isSignup}) async {
    // String phone = phoneTEC.text.trim();
    String password = passwordTEC.text.trim();
    String confirmPassword = confirmPasswordTEC.text.trim();

    String phone = PFormatter.formatPhone(
      code: selectedCountry.value.phoneCode,
      phone: phoneTEC.text.trim(),
    );

    checkIfPasswordMatch();

    showLoadingDialog(
      context: context,
      barrierDismissible: true,
      content: Text(
        'setting_up_account'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );

    final result = await authService.addPassword(
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PHelperFunction.pop();
        PSecureStorage().removeData(PSecureStorage().authResKey);
        PSecureStorage().saveData<bool>(PSecureStorage().registeredKey, true);
        // show success dialog
        showSuccessDialog(context: context, title: res.message ?? '');
        Future.delayed(Duration(seconds: 2), () {
          PHelperFunction.pop();
          // navigate to next screen
          clearFields();
          PHelperFunction.switchScreen(
            destination: Routes.loginPage,
            replace: true,
          );
        });
      },
    );
  }

  /// [Function] Forgot password to send password reset link
  Future<void> forgotPassword() async {
    String email = emailTEC.text.trim();

    showLoadingDialog(
      context: context,
      content: Text(
        'sending_reset_link'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );

    final result = await authService.forgotPassword(email: email);
    result.fold(
      (err) {
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PHelperFunction.pop();
        PHelperFunction.switchScreen(
          destination: Routes.verifyOTPPage,
          args: false,
        );
      },
    );
  }

  /// [Function] Forgot password to reset
  Future<void> resetPassword() async {
    String password = passwordTEC.text.trim();
    String confirmPassword = confirmPasswordTEC.text.trim();

    checkIfPasswordMatch();

    showLoadingDialog(
      context: context,
      content: Text(
        'creating_new_password_msg'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );

    final result = await authService.resetPassword(
      password: password,
      confirmPassword: confirmPassword,
    );
    result.fold(
      (err) {
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PHelperFunction.pop();
        clearFields();
        PHelperFunction.switchScreen(
          destination: Routes.loginPage,
          replace: true,
        );
      },
    );
  }

  clearFields() {
    phoneTEC.clear();
    emailTEC.clear();
    passwordTEC.clear();
    confirmPasswordTEC.clear();
  }

  /// Function to login a user
  /// @params - String pin
  /// @params - bool isSignup
  Future<void> login() async {
    String phone = PFormatter.formatPhone(
      code: selectedCountry.value.phoneCode,
      phone: phoneTEC.text.trim(),
    );
    String password = passwordTEC.text.trim();
    // final deviceToken = await PNotificationService().getToken();
    // pensionAppLogger.e(deviceToken);
    showLoadingDialog(
      context: context,
      barrierDismissible: false,
      content: Text(
        'signing_in'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    final result = await authService.signIn(phone: phone, password: password);
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message:
              err.message == '${'unauthorised'.tr}.'
                  ? 'phone_exist_msg'.tr
                  : err.message,
        );
      },
      (res) async {
        PSecureStorage().saveData<bool>(PSecureStorage().registeredKey, true);
        // if (PDeviceUtil.isAndroid()) {
        // await PNotificationService().saveToken();
        // }
        // await getBioData();
        clearFields();
        PHelperFunction.pop();
        PHelperFunction.switchScreen(
          destination: Routes.dashboardPage,
          replace: true,
        );
        PPopupDialog(
          context,
        ).successMessage(title: 'success'.tr, message: res.message ?? '');
      },
    );
  }
}
