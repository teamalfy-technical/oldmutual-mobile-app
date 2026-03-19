import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PWelcomeBackPage extends StatefulWidget {
  const PWelcomeBackPage({super.key});

  @override
  State<PWelcomeBackPage> createState() => _PWelcomeBackPageState();
}

class _PWelcomeBackPageState extends State<PWelcomeBackPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final ctrl = Get.put(PAuthVm());

  final formKey = GlobalKey<FormState>();

  late AnimationController _controller;

  /// Track if biometric auth is in progress to avoid duplicate prompts
  bool _isBiometricInProgress = false;

  /// Track whether the app was genuinely backgrounded (not just the biometric dialog)
  bool _wasBackgrounded = false;

  /// Track consecutive biometric failures to silently fall back to password
  static const int _maxBiometricAttempts = 3;
  int _biometricFailureCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.2,
    );

    // Auto-trigger biometric authentication if enabled and user email exists
    _autoTriggerBiometrics();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // Only mark as backgrounded if biometric auth is NOT in progress.
      // The biometric dialog causes a pause/resume cycle that should not
      // be treated as a genuine background event.
      if (!_isBiometricInProgress) {
        _wasBackgrounded = true;
        pensionAppLogger.i('App backgrounded on Welcome Back page');
      }
    } else if (state == AppLifecycleState.resumed && mounted) {
      if (_wasBackgrounded) {
        _wasBackgrounded = false;
        pensionAppLogger.i(
          'App resumed from background - re-triggering biometrics',
        );
        _autoTriggerBiometrics();
      } else {
        pensionAppLogger.i(
          'App resumed (biometric dialog dismissed) - skipping re-trigger',
        );
      }
    }
  }

  Future<void> _autoTriggerBiometrics() async {
    // Prevent duplicate biometric prompts — set flag immediately before any
    // async gaps to block concurrent calls (e.g. rapid taps during the delay).
    if (_isBiometricInProgress) {
      pensionAppLogger.i('Biometric auth already in progress - skipping');
      return;
    }

    _isBiometricInProgress = true;

    try {
      // Small delay to ensure the page is fully loaded
      await Future.delayed(const Duration(milliseconds: 300));

      // Check if widget is still mounted after delay
      if (!mounted) return;

      // Check if biometric authentication is enabled and user email exists
      if (!PSecureStorage().isBiometricEnabled) {
        pensionAppLogger.i(
          'Biometric authentication is not enabled - skipping auto-trigger',
        );
        return;
      }

      final userEmail = await PSecureStorage().getUserEmail();
      final userPassword = await PSecureStorage().getBiometricPassword();
      if (userEmail == null || userPassword == null) {
        pensionAppLogger.i('Missing user credentials - skipping auto-trigger');
        return;
      }

      // Check biometric availability (in case it's not ready yet)
      await ctrl.checkBiometricAvailability();

      if (!ctrl.isBiometricAvailable.value) {
        pensionAppLogger.i('Biometrics not available - skipping auto-trigger');
        return;
      }

      // If max attempts reached, silently default to password login
      if (_biometricFailureCount >= _maxBiometricAttempts) {
        pensionAppLogger.i(
          'Max biometric attempts reached - defaulting to password login',
        );
        return;
      }

      // Suppress error popup on the final allowed attempt
      final isLastAttempt = _biometricFailureCount == _maxBiometricAttempts - 1;

      pensionAppLogger.i('Auto-triggering biometric authentication');
      final success = await ctrl.authenticateWithBiometrics(
        _controller,
        silent: isLastAttempt,
      );

      if (!success) {
        _biometricFailureCount++;
        pensionAppLogger.i(
          'Biometric failure count: $_biometricFailureCount/$_maxBiometricAttempts',
        );
        if (_biometricFailureCount >= _maxBiometricAttempts && mounted) {
          setState(() {});
        }
      } else {
        // Reset on success
        _biometricFailureCount = 0;
      }
    } finally {
      _isBiometricInProgress = false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          IconButton(onPressed: () {}, icon: Assets.icons.ghanaFlag.svg()),
        ],
      ),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            children: [
              PAppSize.s8.verticalSpace,
              Expanded(
                child: Obx(
                  () => Form(
                    key: formKey,
                    child: Column(
                      children: [
                        PAppSize.s24.verticalSpace,

                        Text(
                          '${'hi'.tr},',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        PAppSize.s4.verticalSpace,

                        // Display user's first name (loaded async from secure storage)
                        FutureBuilder<String?>(
                          future: PSecureStorage().getUserFirstName(),
                          builder: (context, snapshot) {
                            final name = snapshot.data;
                            return Text(
                              name ?? 'User',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            );
                          },
                        ),

                        PAppSize.s24.verticalSpace,
                        PCustomPasswordTextField(
                          labelText: 'hint_password'.tr,
                          // suffixIcon: Assets.icons.passwordViewIcon.svg(
                          //   // color: PAppColor.hintTextColor,
                          // ),
                          validator: PValidator.validatePassword,
                          obscure: ctrl.obscure.value,
                          onObscureChanged: ctrl.onObscureChanged,
                          controller: ctrl.passwordTEC,
                        ),

                        PAppSize.s25.verticalSpace,

                        PGradientButton(
                          label: 'sign_in'.tr,
                          showIcon: false,
                          loading: ctrl.loading.value,
                          width: PDeviceUtil.getDeviceWidth(context),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              PDeviceUtil.hideKeyboard(context);
                              ctrl.login();
                            }
                          },
                        ),

                        PAppSize.s20.verticalSpace,

                        if (PSecureStorage().isBiometricEnabled &&
                            _biometricFailureCount < _maxBiometricAttempts) ...[
                          IconButton(
                            onPressed: () async =>
                                await _autoTriggerBiometrics(),
                            icon: PDeviceUtil.isAndroid()
                                ? Assets.icons.fingerprint.svg(
                                    color: PHelperFunction.isDarkMode(context)
                                        ? PAppColor.whiteColor
                                        : PAppColor.darkBgColor,
                                  )
                                : Assets.icons.faceId.svg(
                                    color: PHelperFunction.isDarkMode(context)
                                        ? PAppColor.whiteColor
                                        : PAppColor.darkBgColor,
                                  ),
                          ),
                        ],

                        PAppSize.s8.verticalSpace,

                        TextButton(
                          onPressed: () async {
                            final userEmail = await PSecureStorage()
                                .getUserEmail();
                            if (userEmail != null) {
                              // clear cached user data when user decides to login with different account
                              await PSecureStorage().removeSecureData(
                                PSecureStorage().emailKey,
                              );
                              await PSecureStorage().removeSecureData(
                                PSecureStorage().firstNameKey,
                              );
                            }
                            await PSecureStorage().removeSecureData(
                              PSecureStorage().biometricPasswordKey,
                            );
                            PHelperFunction.switchScreen(
                              destination: Routes.loginPage,
                            );
                          },
                          child: Text(
                            'login_with_different_account'.tr,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: PAppColor.primaryRest,
                                  fontSize: PAppSize.s16,
                                ),
                          ),
                        ),

                        // Explore other services
                        PCustomExpansionTile(
                          title: 'explore_other_services'.tr,
                        ),
                      ],
                    ).scrollable(),
                  ),
                ),
              ),
            ],
          ).symmetric(horizontal: PAppSize.s24, vertical: PAppSize.s10),
        ),
      ),
    );
  }
}
