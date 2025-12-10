import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// Page displayed when the app detects a compromised device
/// (rooted, jailbroken, or running on an emulator)
class SecurityBlockedPage extends StatelessWidget {
  final String? message;

  const SecurityBlockedPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final displayMessage = message ??
        'This app cannot run on this device for security reasons. '
            'Please use a non-rooted device that is not an emulator.';

    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(PAppSize.s24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Security Icon
              Container(
                padding: EdgeInsets.all(PAppSize.s24),
                decoration: BoxDecoration(
                  color: PAppColor.redColor.withOpacityExt(PAppSize.s0_1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.security,
                  size: 80.sp,
                  color: PAppColor.redColor,
                ),
              ),
              PAppSize.s32.verticalSpace,
              // Title
              Text(
                'security_alert'.tr,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: PAppColor.redColor,
                    ),
                textAlign: TextAlign.center,
              ),
              PAppSize.s16.verticalSpace,
              // Message
              Text(
                displayMessage,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor.withOpacityExt(0.8)
                          : PAppColor.darkBgColor.withOpacityExt(0.8),
                    ),
                textAlign: TextAlign.center,
              ),
              PAppSize.s24.verticalSpace,
              // Additional info
              Container(
                padding: EdgeInsets.all(PAppSize.s16),
                decoration: BoxDecoration(
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.darkAppBarColor
                      : PAppColor.whiteColor,
                  borderRadius: BorderRadius.circular(PAppSize.s12),
                  border: Border.all(
                    color: PAppColor.redColor.withOpacityExt(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'why_blocked'.tr,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    PAppSize.s8.verticalSpace,
                    _buildReasonItem(
                      context,
                      'rooted_jailbroken_reason'.tr,
                    ),
                    _buildReasonItem(
                      context,
                      'emulator_reason'.tr,
                    ),
                    _buildReasonItem(
                      context,
                      'protect_data_reason'.tr,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Close App Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _exitApp(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PAppColor.redColor,
                    padding: EdgeInsets.symmetric(vertical: PAppSize.s16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(PAppSize.s12),
                    ),
                  ),
                  child: Text(
                    'close_app'.tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: PAppColor.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              PAppSize.s16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReasonItem(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: PAppSize.s4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 16.sp,
            color: PAppColor.redColor,
          ),
          PAppSize.s8.horizontalSpace,
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  void _exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
