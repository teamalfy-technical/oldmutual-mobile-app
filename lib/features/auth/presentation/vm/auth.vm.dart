import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:permission_handler/permission_handler.dart';

class PAuthVm extends GetxController {
  static PAuthVm get instance => Get.find();

  // final memberIDTEC = TextEditingController();
  final emailOrPhoneTEC = TextEditingController();
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
  var obscure2 = true.obs;

  var loading = LoadingState.completed.obs;

  var url = ''.obs;
  var verificationToken = ''.obs;

  var agreeToTerms = false.obs;

  var otpcode = ''.obs;
  var otpRefValue = ''.obs;

  var isBiometricAvailable = false.obs;

  /// Flag to indicate if biometric auth succeeded (used to allow stored password usage)
  var biometricAuthSucceeded = false;

  var maskedValue = ''.obs;

  final authService = Get.put(AuthServiceImpl());

  onTermsCheckboxChanged(bool? value) => agreeToTerms.value = value ?? false;

  onObscureChanged() => obscure.value = !obscure.value;

  onObscure2Changed() => obscure2.value = !obscure2.value;

  final context = Get.context!;

  void updateOTP(String pin) => otpcode.value = pin;

  @override
  void onInit() {
    checkBiometricAvailability();
    _restoreOtpRef();
    super.onInit();
  }

  void _restoreOtpRef() {
    final savedOtpRef = PSecureStorage().getOtpRef();
    if (savedOtpRef != null && savedOtpRef.isNotEmpty) {
      otpRefValue.value = savedOtpRef;
    }
  }

  void _saveOtpRef(String value) {
    otpRefValue.value = value;
    PSecureStorage().saveOtpRef(value);
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

  /// Returns `true` if biometric auth succeeded, `false` otherwise.
  /// When [silent] is true, no error popup is shown on failure.
  Future<bool> authenticateWithBiometrics(
    AnimationController controller, {
    bool silent = false,
  }) async {
    // Animate the Face ID icon (shrink → expand → shrink back)
    await controller.forward();
    await controller.reverse();

    // Authenticate with biometrics
    final success = await LocalAuthService().authenticateUser();

    if (!success) {
      // Reset flag - user must enter password manually if biometric fails
      biometricAuthSucceeded = false;
      if (!silent) {
        PPopupDialog(context).warningMessage(
          title: 'error'.tr,
          message:
              'Biometric authentication failed. Please enter your password.',
        );
      }
      return false;
    }

    // Biometric succeeded - allow stored password usage
    biometricAuthSucceeded = true;
    await login();
    return true;
  }

  /// Function to verify user Ghana Card before signup
  Future<void> verifyGhanaCard() async {
    loading(LoadingState.loading);
    final res = await authService.verifyGhanaCard(
      cardNumber: ghanaCardNumberTEC.text.trim(),
    );
    res.fold(
      (err) {
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
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
      // Request camera permission
      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        cameraStatus = await Permission.camera.request();
      }

      // Handle camera permission denial
      if (!cameraStatus.isGranted) {
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: cameraStatus.isPermanentlyDenied
              ? 'Camera permission is permanently denied. Please enable it in Settings.'
              : 'Camera permission is required for face verification',
        );

        if (cameraStatus.isPermanentlyDenied) {
          await openAppSettings();
        }
        return;
      }

      // Request microphone permission
      var microphoneStatus = await Permission.microphone.status;
      if (!microphoneStatus.isGranted) {
        microphoneStatus = await Permission.microphone.request();
      }

      // Handle microphone permission denial
      if (!microphoneStatus.isGranted) {
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: microphoneStatus.isPermanentlyDenied
              ? 'Microphone permission is permanently denied. Please enable it in Settings.'
              : 'Microphone permission is required for face verification',
        );

        if (microphoneStatus.isPermanentlyDenied) {
          await openAppSettings();
        }
        return;
      }

      // Both permissions granted, navigate to webview
      PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['face_verification'.tr, url.value],
      );
    } catch (err) {
      pensionAppLogger.e('Error in verifyFaceIdentification: $err');
      PPopupDialog(context).errorMessage(
        title: 'error'.tr,
        message:
            'An error occurred while requesting permissions. Please try again.',
      );
    }
  }

  /// Function to login a user
  /// @params - String pin
  /// @params - bool isSignup
  Future<void> login() async {
    // final deviceToken = await PNotificationService().getToken();
    // pensionAppLogger.e(deviceToken);
    loading(LoadingState.loading);

    final emailOrPhone =
        await PSecureStorage().getUserEmail() ?? emailOrPhoneTEC.text.trim();

    // Only use stored biometric password if biometric auth succeeded
    // Otherwise, require user to enter password manually
    String password;
    if (biometricAuthSucceeded) {
      final storedPassword = await PSecureStorage().getBiometricPassword();
      if (storedPassword == null || storedPassword.isEmpty) {
        // Biometric auth succeeded but no stored password found
        loading(LoadingState.error);
        biometricAuthSucceeded = false;
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message:
              'Stored credentials not found. Please login with your password to re-enable biometrics.',
        );
        return;
      }
      password = storedPassword;
    } else {
      password = passwordTEC.text.trim();
    }

    // Reset the flag after using it
    biometricAuthSucceeded = false;

    final result = await authService.signIn(
      emailOrPhone: PHelperFunction.isPhone(emailOrPhone)
          ? PHelperFunction.formatPhoneNumber(emailOrPhone)
          : emailOrPhone,
      password: password,
    );
    result.fold(
      (err) {
        // PHelperFunction.pop();
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'login_error'.tr, message: err.message);
      },
      (res) async {
        loading(LoadingState.completed);

        _saveOtpRef(res.data?.otpRef ?? '');

        final isVerified = checkIfPhoneIsVerified(
          res.data?.phoneVerified,
          res.message,
        );

        if (!isVerified) return;

        navigateToDashBoard(
          emailOrPhone: emailOrPhone,
          password: password,
          res: res,
        );
      },
    );
  }

  bool checkIfPhoneIsVerified(String? isPhoneVerified, String? message) {
    if (isPhoneVerified != null && isPhoneVerified == 'false') {
      PHelperFunction.switchScreen(
        destination: Routes.verifyOTPPage,
        replace: true,
      );
      if (message != null && message.isNotEmpty) {
        PPopupDialog(
          context,
        ).successMessage(title: 'success'.tr, message: message);
      }
      return false;
    }
    return true;
  }

  navigateToDashBoard({
    required ApiResponse<Member> res,
    required String emailOrPhone,
    required String password,
  }) async {
    // loading(LoadingState.completed);
    await PSecureStorage().saveUserEmail(emailOrPhone);

    // Store password securely if biometric authentication is enabled
    if (PSecureStorage().isBiometricEnabled) {
      await PSecureStorage().saveBiometricPassword(password);
    }

    await PNotificationService().saveToken();

    if (res.data?.name != null && res.data!.name!.isNotEmpty) {
      await PSecureStorage().saveUserFirstName(
        res.data?.name?.split(' ')[0] ?? '',
      );
    }

    // Check if we should prompt biometric setup after navigating
    final shouldPromptBiometric =
        !PSecureStorage().isBiometricEnabled &&
        await LocalAuthService().isBiometricAvailable();

    clearFields();
    // await getBioData();
    PHelperFunction.switchScreen(
      destination: Routes.dashboardPage,
      replace: true,
    );

    // PPopupDialog(
    //   context,
    // ).successMessage(title: 'success'.tr, message: res.message ?? '');

    // Show disclaimer first if not yet acknowledged, then biometric prompt
    final shouldShowDisclaimer = !PSecureStorage().isDisclaimerAcknowledged;

    if (shouldShowDisclaimer) {
      _showDisclaimerPrompt(
        onAcknowledged: () {
          if (shouldPromptBiometric) {
            _showBiometricSetupPrompt(password);
          }
        },
      );
    } else if (shouldPromptBiometric) {
      _showBiometricSetupPrompt(password);
    }
  }

  /// Show a disclaimer bottom sheet about reported returns
  void _showDisclaimerPrompt({VoidCallback? onAcknowledged}) {
    Future.delayed(const Duration(seconds: 2), () {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PAppSize.s24),
        ),
        builder: (ctx) {
          return PopScope(
            canPop: false,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: PAppSize.s20,
                  vertical: PAppSize.s10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.icons.infoIcon.svg(
                      height: PAppSize.s44,
                      color: PAppColor.primary,
                    ),
                    PAppSize.s16.verticalSpace,
                    Text(
                      'disclaimer'.tr,
                      style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    PAppSize.s8.verticalSpace,
                    Text(
                      'disclaimer_message'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                        fontSize: PAppSize.s14.sp,
                      ),
                    ),
                    PAppSize.s24.verticalSpace,
                    PGradientButton(
                      label: 'i_understand'.tr,
                      showIcon: false,
                      width: PDeviceUtil.getDeviceWidth(ctx),
                      onTap: () async {
                        Navigator.of(ctx).pop();
                        await PSecureStorage().saveDisclaimerAcknowledged(true);
                        onAcknowledged?.call();
                      },
                    ),
                    PAppSize.s4.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  /// Show a bottom sheet prompting the user to enable biometric authentication
  void _showBiometricSetupPrompt(String password) {
    final biometricLabel = PDeviceUtil.isAndroid() ? 'Biometrics' : 'Face ID';

    // Delay slightly so the success message appears first
    Future.delayed(const Duration(seconds: 2), () {
      showModalBottomSheet(
        context: context,
        backgroundColor: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PAppSize.s24),
        ),
        builder: (ctx) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: PAppSize.s20,
                vertical: PAppSize.s10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PDeviceUtil.isAndroid()
                      ? Assets.icons.fingerprint.svg(
                          height: PAppSize.s44,
                          color: PAppColor.primary,
                        )
                      : Assets.icons.faceId.svg(
                          height: PAppSize.s44,
                          color: PAppColor.primary,
                        ),
                  PAppSize.s16.verticalSpace,
                  Text(
                    'Enable $biometricLabel',
                    style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PAppSize.s8.verticalSpace,
                  Text(
                    'Would you like to enable $biometricLabel for faster login next time?',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      ctx,
                    ).textTheme.bodyMedium?.copyWith(fontSize: PAppSize.s14.sp),
                  ),
                  PAppSize.s24.verticalSpace,
                  PGradientButton(
                    label: 'ENABLE',
                    showIcon: false,
                    width: PDeviceUtil.getDeviceWidth(ctx),
                    onTap: () async {
                      Navigator.of(ctx).pop();
                      await PSecureStorage().saveBiometric(true);
                      await PSecureStorage().saveBiometricPassword(password);
                      PPopupDialog(context).successMessage(
                        title: 'success'.tr,
                        message:
                            '$biometricLabel has been enabled. You can now login securely with your biometrics.',
                      );
                    },
                  ),
                  PAppSize.s14.verticalSpace,
                  OutlinedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: PAppColor.successDark,
                      side: BorderSide(color: PAppColor.successDark),
                      minimumSize: Size.fromHeight(PAppSize.buttonHeight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(PAppSize.s24),
                      ),
                    ),
                    child: Text('NOT NOW'),
                  ),
                  PAppSize.s4.verticalSpace,
                ],
              ),
            ),
          );
        },
      );
    });
  }

  /// Function to sign up user by sending OTP code
  Future<void> getBioData() async {
    final result = await authService.getBioData();
    await result.fold(
      (err) async {
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        loading(LoadingState.completed);
        final bioData = res.data?.first;

        // Save bio data securely
        if (bioData != null) {
          await PSecureStorage().saveBioData(bioData.toJson());

          pensionAppLogger.d(
            'bioData saved to secure storage: ${bioData.toJson()}',
          );

          // Save first name for welcome back page personalization
          if (bioData.firstName != null && bioData.firstName!.isNotEmpty) {
            await PSecureStorage().saveUserFirstName(bioData.firstName!);
          }
        }
      },
    );
  }

  /// Function to sign up user by sending OTP code
  Future<void> createAccount() async {
    String emailOrPhone = phoneTEC.text.trim();
    maskedValue.value = PHelperFunction.maskPhoneNumber(emailOrPhone);

    loading(LoadingState.loading);

    final result = await authService.signUp(
      phone: PHelperFunction.formatPhoneNumber(phoneTEC.text.trim()),
      email: emailOrPhoneTEC.text.trim(),
      password: passwordTEC.text.trim(),
      confirmPassword: confirmPasswordTEC.text.trim(),
      verificationToken: verificationToken.value,
    );
    result.fold(
      (err) {
        loading(LoadingState.error);
        // PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        _saveOtpRef(res.data?.otpRef ?? '');
        maskedValue.value = res.data?.phone ?? maskedValue.value;
        PHelperFunction.switchScreen(
          destination: Routes.verifyOTPPage,
          args: true,
        );
        if (res.message != null && res.message!.isNotEmpty) {
          PPopupDialog(
            context,
          ).successMessage(title: 'success'.tr, message: res.message!);
        }
      },
    );
  }

  /// Function to verify OTP code sent to device
  /// @params => pin
  /// @params => isSignup
  Future<void> verifyOTP({required String pin, required bool isSignup}) async {
    if (otpcode.isEmpty) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message:
            'You need to enter the 6 digit code sent to your phone or email.',
      );
      return;
    }
    pensionAppLogger.d('OTP: $pin, OTP Ref: ${otpRefValue.value}');

    loading(LoadingState.loading);
    final result = isSignup
        ? await authService.verifySignupOtp(otp: pin, otpRef: otpRefValue.value)
        : await authService.verifyForgotPasswordOTP(
            otp: pin,
            otpRef: otpRefValue.value,
          );
    result.fold(
      (err) {
        // PHelperFunction.pop();
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
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
    loading(LoadingState.loading);
    final result = await authService.resendOtp(otpRef: otpRefValue.value);
    result.fold(
      (err) {
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        _saveOtpRef(res.data?.otpRef ?? otpRefValue.value);
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

  /// [Function] Forgot password to send password reset link
  Future<void> forgotPassword() async {
    String emailOrPhone = emailOrPhoneTEC.text.trim();
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
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        _saveOtpRef(res.data?.otpRef ?? '');
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
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
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
    emailOrPhoneTEC.clear();
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
