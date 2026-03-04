import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PForceUpdateService {
  PForceUpdateService._internal();
  static final PForceUpdateService _instance = PForceUpdateService._internal();
  factory PForceUpdateService() => _instance;

  static const String _keyEnabled = 'force_update_enabled';
  static const String _keyMinVersion = 'force_update_min_version';
  static const String _keyUpdateUrlIos = 'force_update_url_ios';
  static const String _keyUpdateUrlAndroid = 'force_update_url_android';

  late final FirebaseRemoteConfig _remoteConfig;
  bool _initialized = false;
  bool _dialogShowing = false;

  Future<void> init() async {
    _remoteConfig = FirebaseRemoteConfig.instance;

    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 15),
      ),
    );

    await _remoteConfig.setDefaults({
      _keyEnabled: false,
      _keyMinVersion: '1.0.0',
      _keyUpdateUrlIos: '',
      _keyUpdateUrlAndroid: '',
    });

    try {
      final activated = await _remoteConfig.fetchAndActivate();
      pensionAppLogger.i('Remote Config fetched & activated: $activated');
    } catch (e) {
      pensionAppLogger.e('Remote Config fetch failed: $e');
    }

    _initialized = true;
    pensionAppLogger.i('ForceUpdateService initialized');
  }

  Future<void> checkForUpdate(BuildContext context) async {
    pensionAppLogger.d('Force update check started');

    if (!_initialized) {
      pensionAppLogger.w('ForceUpdateService not initialized, skipping check');
      return;
    }
    if (_dialogShowing) {
      pensionAppLogger.w('Force update dialog already showing, skipping');
      return;
    }

    final enabled = _remoteConfig.getBool(_keyEnabled);
    pensionAppLogger.d('force_update_enabled: $enabled');
    if (!enabled) return;

    final minVersionStr = _remoteConfig.getString(_keyMinVersion);
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersionStr = packageInfo.version;

    pensionAppLogger.d(
      'Current version: $currentVersionStr, Min required: $minVersionStr',
    );

    final needsUpdate = _isVersionBelow(currentVersionStr, minVersionStr);
    pensionAppLogger.d('Update required: $needsUpdate');

    if (needsUpdate) {
      _dialogShowing = true;
      if (context.mounted) {
        pensionAppLogger.i('Showing force update dialog');
        _showForceUpdateDialog(context);
      }
    }
  }

  bool _isVersionBelow(String current, String minimum) {
    final currentParts = current.split('.').map(int.tryParse).toList();
    final minimumParts = minimum.split('.').map(int.tryParse).toList();

    for (int i = 0; i < 3; i++) {
      final c = (i < currentParts.length ? currentParts[i] : 0) ?? 0;
      final m = (i < minimumParts.length ? minimumParts[i] : 0) ?? 0;
      if (c < m) return true;
      if (c > m) return false;
    }
    return false;
  }

  void _showForceUpdateDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: PHelperFunction.isDarkMode(context)
                ? PAppColor.darkAppBarColor
                : PAppColor.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PAppSize.s16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.system_update,
                  size: PAppSize.s50,
                  color: PAppColor.primary,
                ),
                PAppSize.s16.verticalSpace,
                Text(
                  'New Version Available!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PAppSize.s8.verticalSpace,
                Text(
                  'We\'ve improved your experience with important updates and security enhancements. Please update your app today.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                PAppSize.s16.verticalSpace,
                PGradientButton(
                  label: 'Update Now',
                  showIcon: false,
                  textColor: PAppColor.whiteColor,
                  width: PDeviceUtil.getDeviceWidth(context),
                  onTap: () => _openStore(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openStore() async {
    String url;
    if (Platform.isIOS) {
      url = _remoteConfig.getString(_keyUpdateUrlIos);
      if (url.isEmpty) {
        url = 'https://apps.apple.com/app/my-oldmutual-gh/id6746150180';
      }
    } else {
      url = _remoteConfig.getString(_keyUpdateUrlAndroid);
      if (url.isEmpty) {
        url =
            'https://play.google.com/store/apps/details?id=com.oldmutual.pensions.app';
      }
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
