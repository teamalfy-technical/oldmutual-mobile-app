import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/vm/settings.vm.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PInactivityService extends GetxService with WidgetsBindingObserver {
  static PInactivityService get instance => Get.find();

  /// Timeout duration for inactivity (finance apps: 2-5 minutes recommended)
  /// Change this value to adjust the timeout period
  static const Duration timeoutDuration = Duration(minutes: 5);
  // static const Duration timeoutDuration = Duration(hours: 1);

  /// Grace period when returning from background
  /// If app was in background longer than this, force logout
  static const Duration backgroundGracePeriod = Duration(minutes: 2);
  // static const Duration backgroundGracePeriod = Duration(seconds: 30);

  Timer? _inactivityTimer;
  DateTime? _appPausedTime;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      pensionAppLogger.i('Inactivity service disabled in debug mode');
      return;
    }
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
    pensionAppLogger.i(
      'Inactivity service initialized with ${timeoutDuration.inMinutes} minute timeout',
    );
  }

  void _startTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(timeoutDuration, _handleInactivity);
  }

  void resetTimer() {
    _startTimer();
  }

  /// Handle app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) return;
    switch (state) {
      case AppLifecycleState.paused:
        // App went to background
        _appPausedTime = DateTime.now();
        _inactivityTimer?.cancel();
        pensionAppLogger.i('App paused - inactivity timer stopped');
        break;

      case AppLifecycleState.resumed:
        // App came back to foreground
        if (_appPausedTime != null) {
          final backgroundDuration = DateTime.now().difference(_appPausedTime!);

          // Check if user is on login/signup pages - skip background check
          final currentRoute = Get.currentRoute;
          final isAuthRoute =
              currentRoute == Routes.loginPage ||
              currentRoute == Routes.createAccountPage ||
              currentRoute == Routes.idEntryPage ||
              currentRoute == Routes.livenessInfoPage ||
              currentRoute == Routes.verifyOTPPage ||
              currentRoute == Routes.webviewPage ||
              currentRoute == Routes.welcomeBackPage ||
              currentRoute == Routes.forgotPasswordPage;

          if (!isAuthRoute && backgroundDuration > backgroundGracePeriod) {
            // App was in background too long - soft logout
            pensionAppLogger.w(
              'App was in background for ${backgroundDuration.inSeconds}s - soft logout',
            );
            logoutUser();
          } else {
            // Resume timer
            _startTimer();
            pensionAppLogger.i('App resumed - inactivity timer restarted');
          }
        } else {
          _startTimer();
        }
        _appPausedTime = null;
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // Do nothing for these states
        break;
    }
  }

  void _handleInactivity() {
    if (kDebugMode) return;
    // Check if user is on login/signup pages - don't log out
    final currentRoute = Get.currentRoute;
    if (currentRoute != Routes.loginPage &&
        currentRoute != Routes.createAccountPage &&
        currentRoute != Routes.idEntryPage &&
        currentRoute != Routes.livenessInfoPage &&
        currentRoute != Routes.verifyOTPPage &&
        currentRoute != Routes.webviewPage &&
        currentRoute != Routes.welcomeBackPage &&
        currentRoute != Routes.forgotPasswordPage) {
      pensionAppLogger.w(
        'User inactive for ${timeoutDuration.inMinutes} minutes - logging out',
      );
      logoutUser();
    }
  }

  void logoutUser() {
    try {
      Get.put(PSettingsVm()).signout(soft: true);
    } catch (e) {
      pensionAppLogger.e('Error during inactivity logout: $e');
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityTimer?.cancel();
    super.onClose();
  }
}
