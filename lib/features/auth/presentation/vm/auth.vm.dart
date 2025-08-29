import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/widgets/popup.dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PAuthVm extends GetxController {
  static PAuthVm get instance => Get.find();

  // final memberIDTEC = TextEditingController();
  final emailTEC = TextEditingController();
  final phoneTEC = TextEditingController();
  final ghanaCardNumberTEC = TextEditingController();
  final passwordTEC = TextEditingController();
  final confirmPasswordTEC = TextEditingController();

  // final memberIDFormKey = GlobalKey<FormState>();
  // final loginFormKey = GlobalKey<FormState>();
  // final welcomeBackFormKey = GlobalKey<FormState>();
  // final emailFormKey = GlobalKey<FormState>();
  // final resetPasswordFormKey = GlobalKey<FormState>();
  // final createPasswordFormKey = GlobalKey<FormState>();

  var obscure = true.obs;

  var loading = LoadingState.completed.obs;

  var url = ''.obs;
  var verificationToken = ''.obs;

  var agreeToTerms = false.obs;

  var otpcode = ''.obs;

  var isBiometricAvailable = false.obs;

  var maskedValue = ''.obs;

  final authService = Get.put(AuthServiceImpl());

  onTermsCheckboxChanged(bool? value) => agreeToTerms.value = value ?? false;

  onObscureChanged() => obscure.value = !obscure.value;

  final context = Get.context!;

  void updateOTP(String pin) => otpcode.value = pin;

  @override
  void onInit() {
    checkBiometricAvailability();
    super.onInit();
  }

  Future<void> checkBiometricAvailability() async {
    isBiometricAvailable.value = await LocalAuthService()
        .isBiometricAvailable();
  }

  var selectedCountry = Country(
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

  Future<void> authenticateWithBiometrics(
    AnimationController controller,
  ) async {
    // Animate the Face ID icon (shrink → expand → shrink back)
    await controller.forward();
    await controller.reverse();
    final success = await LocalAuthService().authenticateUser();
    if (success) {
      PHelperFunction.switchScreen(
        destination: Routes.dashboardPage,
        replace: true,
      );
    }
    pensionAppLogger.e(success);
  }

  /// Function to verify user Ghana Card before signup
  Future<void> verifyGhanaCard() async {
    loading(LoadingState.loading);
    final res = await authService.verifyGhanaCard(
      cardNumber: 'GHA-${ghanaCardNumberTEC.text.trim()}',
    );
    res.fold(
      (err) {
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        url.value = res.data ?? '';
        PHelperFunction.switchScreen(
          destination: Routes.livenessInfoPage,
          args: true,
        );
      },
    );
  }

  /// Function to navigate user to face verification page
  Future<void> verifyFaceIdentification() async {
    try {
      // Request camera & microphone permissions
      final cam = await Permission.camera.request();
      final mic = await Permission.microphone.request();

      if (cam.isGranted && mic.isGranted) {
        PHelperFunction.switchScreen(
          destination: Routes.webviewPage,
          args: ['face_verification'.tr, url.value],
        );
      } else {
        // Show a dialog to enable permissions
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: 'Camera & microphone permissions are required',
        );
      }
    } catch (err) {
      pensionAppLogger.e(err.toString());
    }
  }

  /// Function to login a user
  /// @params - String pin
  /// @params - bool isSignup
  Future<void> login() async {
    // final deviceToken = await PNotificationService().getToken();
    // pensionAppLogger.e(deviceToken);
    loading(LoadingState.loading);

    final email = PSecureStorage().getUserEmail() ?? emailTEC.text.trim();
    final password = passwordTEC.text.trim();

    final result = await authService.signIn(
      emailOrPhone: email,
      password: password,
    );
    result.fold(
      (err) {
        // PHelperFunction.pop();
        loading(LoadingState.error);
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: err.message == '${'unauthorised'.tr}.'
              ? 'phone_exist_msg'.tr
              : err.message,
        );
      },
      (res) async {
        loading(LoadingState.completed);
        PSecureStorage().saveUserEmail<String>(email);
        // if (PDeviceUtil.isAndroid()) {
        // await PNotificationService().saveToken();
        // }
        // await getBioData();
        clearFields();

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

  /// Function to sign up user by sending OTP code
  Future<void> createAccount() async {
    String emailOrPhone = phoneTEC.text.trim();
    maskedValue.value = PHelperFunction.maskPhoneNumber(emailOrPhone);

    loading(LoadingState.loading);

    final result = await authService.signUp(
      phone: phoneTEC.text.trim(),
      email: emailTEC.text.trim(),
      password: passwordTEC.text.trim(),
      confirmPassword: passwordTEC.text.trim(),
      verificationToken: verificationToken.value,
    );
    result.fold(
      (err) {
        loading(LoadingState.error);
        // PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        // PHelperFunction.pop();
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
    String phone = phoneTEC.text.trim();
    String email = emailTEC.text.trim();

    if (otpcode.isEmpty) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message:
            'You need to enter the 6 digit code sent to your phone or email.',
      );
      return;
    }

    loading(LoadingState.loading);
    final result = isSignup
        ? await authService.verifySignupOtp(otp: pin, phone: phone)
        : await authService.verifyForgotPasswordOTP(
            otp: pin,
            emailOrPhone: email,
          );
    result.fold(
      (err) {
        // PHelperFunction.pop();
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);

        if (isSignup) {
          PSecureStorage().removeData(PSecureStorage().authResKey);

          PHelperFunction.switchScreen(
            destination: Routes.successPage,
            args: [
              'account_created_msg'.tr,
              'welcome_label'.tr,
              // 'go_to_dashboard'.tr,
              'go_to_login'.tr,
              () => PHelperFunction.switchScreen(
                // destination: Routes.dashboardPage,
                destination: Routes.loginPage,
                replace: true,
              ),
            ],
          );
        } else {
          PHelperFunction.switchScreen(
            destination: Routes.createPasswordPage,
            replace: true,
          );
        }
      },
    );
  }

  /// Function to verify OTP code sent to device
  /// @params => pin
  /// @params => isSignup
  Future<void> resendOTP({required String pin, required bool isSignup}) async {
    String phone = phoneTEC.text.trim();

    loading(LoadingState.loading);
    final result = await authService.resendOtp(phone: phone);
    result.fold(
      (err) {
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
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
  // Future<void> createPassword({required bool isSignup}) async {
  //   // String phone = phoneTEC.text.trim();
  //   String password = passwordTEC.text.trim();
  //   String confirmPassword = confirmPasswordTEC.text.trim();

  //   String phone = PFormatter.formatPhone(
  //     code: selectedCountry.value.phoneCode,
  //     phone: phoneTEC.text.trim(),
  //   );

  //   checkIfPasswordMatch();

  //   loading(LoadingState.loading);

  //   final result = await authService.addPassword(
  //     phone: phone,
  //     password: password,
  //     confirmPassword: confirmPassword,
  //   );
  //   result.fold(
  //     (err) {
  //       loading(LoadingState.error);
  //       // PHelperFunction.pop();
  //       PPopupDialog(
  //         context,
  //       ).errorMessage(title: 'error'.tr, message: err.message);
  //     },
  //     (res) {
  //       loading(LoadingState.loading);

  //       // navigate to next screen
  //       clearFields();
  //       PHelperFunction.switchScreen(
  //         destination: Routes.successPage,
  //         args: [
  //           'password_changed_title'.tr,
  //           'password_changed_msg'.tr,
  //           // 'go_to_dashboard'.tr,
  //           'go_to_login'.tr,
  //           () => PHelperFunction.switchScreen(
  //             // destination: Routes.dashboardPage,
  //             destination: Routes.loginPage,
  //             replace: true,
  //           ),
  //         ],
  //       );
  //       // });
  //     },
  //   );
  // }

  /// [Function] Forgot password to send password reset link
  Future<void> forgotPassword() async {
    String emailOrPhone = emailTEC.text.trim();
    maskedValue.value = emailOrPhone.isNumericOnly
        ? PHelperFunction.maskPhoneNumber(emailOrPhone)
        : PHelperFunction.maskEmailDomain(emailOrPhone);

    loading(LoadingState.loading);

    final result = await authService.forgotPassword(emailOrPhone: emailOrPhone);
    result.fold(
      (err) {
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        // PHelperFunction.pop();
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

    loading(LoadingState.loading);

    final result = await authService.resetPassword(
      password: password,
      confirmPassword: confirmPassword,
    );
    result.fold(
      (err) {
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        PSecureStorage().removeData(PSecureStorage().authResKey);

        clearFields();
        PHelperFunction.switchScreen(
          destination: Routes.successPage,
          args: [
            'password_changed_title'.tr,
            'password_changed_msg'.tr,
            // 'go_to_dashboard'.tr,
            'go_to_login'.tr,
            () => PHelperFunction.switchScreen(
              // destination: Routes.dashboardPage,
              destination: Routes.loginPage,
              replace: true,
            ),
          ],
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

  /// Function to login existing user
  /// @params - String pin
  /// @params - bool isSignup
  Future<void> loginUserWithExistingKey() async {
    PHelperFunction.switchScreen(
      destination: Routes.loadingPage,
      args: 'getting_ready_msg'.tr,
      replace: true,
    );
  }
}
