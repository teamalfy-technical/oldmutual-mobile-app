import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PCustomSuccessPage extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonTitle;
  final Function()? onTap;
  const PCustomSuccessPage({
    super.key,
    required this.message,
    required this.title,
    this.onTap,
    this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PAppSize.s80.verticalSpace,
              const PAnimatedCheckmark(),
              PAppSize.s16.verticalSpace,
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,

                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.primary950
                      : PAppColor.textColorDark,
                  fontSize: PAppSize.s24,
                ),
              ),
              PAppSize.s12.verticalSpace,
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: PAppSize.s16,
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.whiteColor.withOpacityExt(PAppSize.s0_7)
                      : PAppColor.textColorLight,
                ),
              ),
              PAppSize.s18.verticalSpace,
              PGradientButton(
                label: buttonTitle ?? 'continue'.tr,
                showIcon: false,
                width: PDeviceUtil.getDeviceWidth(context),
                onTap: onTap,
              ),
            ],
          ).symmetric(horizontal: PAppSize.s24, vertical: PAppSize.s10),
        ),
      ),
    );
  }
}
