import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:safe_device/safe_device.dart';

/// Device security status containing all security check results
class DeviceSecurityStatus {
  final bool isRooted;
  final bool isJailbroken;
  final bool isEmulator;
  final bool isRealDevice;
  final bool isDeveloperModeEnabled;
  final bool isOnExternalStorage;
  final bool isMockLocation;
  final bool isSafeDevice;

  const DeviceSecurityStatus({
    required this.isRooted,
    required this.isJailbroken,
    required this.isEmulator,
    required this.isRealDevice,
    required this.isDeveloperModeEnabled,
    required this.isOnExternalStorage,
    required this.isMockLocation,
    required this.isSafeDevice,
  });

  /// Returns true if the device is considered compromised
  bool get isCompromised =>
      !isSafeDevice ||
      isRooted ||
      isJailbroken ||
      isEmulator ||
      !isRealDevice;

  /// Returns a human-readable message describing the security issue
  String? get securityIssueMessage {
    if (isEmulator || !isRealDevice) {
      return 'This app cannot run on an emulator or virtual device for security reasons.';
    }
    if (isRooted || isJailbroken) {
      return 'This app cannot run on a rooted or jailbroken device for security reasons.';
    }
    if (!isSafeDevice) {
      return 'This app cannot run on this device for security reasons.';
    }
    return null;
  }

  @override
  String toString() {
    return 'DeviceSecurityStatus('
        'isRooted: $isRooted, '
        'isJailbroken: $isJailbroken, '
        'isEmulator: $isEmulator, '
        'isRealDevice: $isRealDevice, '
        'isDeveloperModeEnabled: $isDeveloperModeEnabled, '
        'isOnExternalStorage: $isOnExternalStorage, '
        'isMockLocation: $isMockLocation, '
        'isSafeDevice: $isSafeDevice)';
  }
}

/// Service for detecting compromised devices (rooted, jailbroken, emulators)
class DeviceSecurityService {
  static final DeviceSecurityService _instance =
      DeviceSecurityService._internal();

  factory DeviceSecurityService() => _instance;

  DeviceSecurityService._internal();

  DeviceSecurityStatus? _cachedStatus;

  /// Performs all security checks and returns the status
  /// Results are cached after first check
  Future<DeviceSecurityStatus> checkDeviceSecurity() async {
    if (_cachedStatus != null) return _cachedStatus!;

    // Skip security checks in debug mode for development
    if (kDebugMode) {
      pensionAppLogger.w('Device security checks skipped in debug mode');
      _cachedStatus = const DeviceSecurityStatus(
        isRooted: false,
        isJailbroken: false,
        isEmulator: false,
        isRealDevice: true,
        isDeveloperModeEnabled: false,
        isOnExternalStorage: false,
        isMockLocation: false,
        isSafeDevice: true,
      );
      return _cachedStatus!;
    }

    try {
      bool isRooted = false;
      bool isJailbroken = false;
      bool isEmulator = false;
      bool isRealDevice = true;
      bool isDeveloperModeEnabled = false;
      bool isOnExternalStorage = false;
      bool isMockLocation = false;
      bool isSafeDevice = true;

      // Check using flutter_jailbreak_detection
      isJailbroken = await FlutterJailbreakDetection.jailbroken;
      isEmulator = await FlutterJailbreakDetection.developerMode;

      // Use safe_device's comprehensive check
      isSafeDevice = await SafeDevice.isSafeDevice;
      isRealDevice = await SafeDevice.isRealDevice;
      isEmulator = isEmulator || !isRealDevice;

      // Additional platform-specific checks using safe_device 1.3.8
      if (Platform.isAndroid) {
        isRooted = await SafeDevice.isJailBroken;
        isDeveloperModeEnabled = await SafeDevice.isDevelopmentModeEnable;
        isOnExternalStorage = await SafeDevice.isOnExternalStorage;
        isMockLocation = await SafeDevice.isMockLocation;
      } else if (Platform.isIOS) {
        isJailbroken = await SafeDevice.isJailBroken;
      }

      _cachedStatus = DeviceSecurityStatus(
        isRooted: isRooted,
        isJailbroken: isJailbroken,
        isEmulator: isEmulator,
        isRealDevice: isRealDevice,
        isDeveloperModeEnabled: isDeveloperModeEnabled,
        isOnExternalStorage: isOnExternalStorage,
        isMockLocation: isMockLocation,
        isSafeDevice: isSafeDevice,
      );

      pensionAppLogger.i('Device security status: $_cachedStatus');

      return _cachedStatus!;
    } catch (e) {
      pensionAppLogger.e('Error checking device security: $e');
      // Default to safe status on error to avoid blocking legitimate users
      _cachedStatus = const DeviceSecurityStatus(
        isRooted: false,
        isJailbroken: false,
        isEmulator: false,
        isRealDevice: true,
        isDeveloperModeEnabled: false,
        isOnExternalStorage: false,
        isMockLocation: false,
        isSafeDevice: true,
      );
      return _cachedStatus!;
    }
  }

  /// Quick check if device is compromised
  Future<bool> isDeviceCompromised() async {
    final status = await checkDeviceSecurity();
    return status.isCompromised;
  }

  /// Quick check if running on emulator
  Future<bool> isRunningOnEmulator() async {
    final status = await checkDeviceSecurity();
    return status.isEmulator || !status.isRealDevice;
  }

  /// Quick check if device is rooted/jailbroken
  Future<bool> isDeviceRootedOrJailbroken() async {
    final status = await checkDeviceSecurity();
    return status.isRooted || status.isJailbroken;
  }

  /// Clears the cached security status (useful for re-checking)
  void clearCache() {
    _cachedStatus = null;
  }
}
