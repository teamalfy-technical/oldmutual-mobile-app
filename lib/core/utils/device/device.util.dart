import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PDeviceUtil {
  PDeviceUtil._();

  /// --- Hide current device keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// --- Update status bar color
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  /// --- Check if device is in landscape mode
  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  /// --- Check if device is in portrait mode
  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  /// --- Set full screen
  static Future<void> setFullScreen(bool enable) async {
    SystemChrome.setEnabledSystemUIMode(
      enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
  }

  /// --- Get device size
  static Size getDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// --- Get device width
  static double getDeviceWidth(BuildContext context) {
    return getDeviceSize(context).width;
  }

  /// --- Get device height
  static double getDeviceHeight(BuildContext context) {
    return getDeviceSize(context).height;
  }

  /// --- Get device pixel ratio
  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// --- Get device status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// --- Get bottom navigation bar height
  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  /// --- Get app bar height
  static double getAppBarHeight(BuildContext context) {
    return kToolbarHeight;
  }

  /// --- Get app bar height
  static double getKeyboardHeight(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom;
  }

  /// --- Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }

  /// --- Check if current device is physical or not
  static Future<bool> isPhysicalDevice(BuildContext context) async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  /// --- Vibrate device
  static void vibrate(Duration duration) async {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  /// --- Set device orientations
  static Future<void> setPreferredOrientations(
    List<DeviceOrientation> orientations,
  ) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  /// --- Hide status bar
  static Future<void> hideStatusBar(
    List<DeviceOrientation> orientations,
  ) async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  /// --- Show status bar
  static Future<void> showStatusBar(
    List<DeviceOrientation> orientations,
  ) async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  /// --- Check if device has internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// --- Check if device type is iOS
  static bool isIOS() => Platform.isIOS;

  /// --- Check if device type is Android
  static bool isAndroid() => Platform.isAndroid;
}
