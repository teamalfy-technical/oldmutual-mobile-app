import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PVerifyOTPPage extends StatelessWidget {
  final bool isSignup;
  PVerifyOTPPage({super.key, this.isSignup = true});

  final ctrl = Get.find<PAuthVm>();
  final timerCtrl = Get.put(PTimerVm());



  @override
  Widget build(BuildContext context) {
    timerCtrl.startCountdown();
    return Scaffold(
      appBar: AppBar(title: Text('verify_phone_number'.tr)),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            children: [
              PAppSize.s8.verticalSpace,
              Obx(
                () => Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PAppSize.s20.verticalSpace,
                      Text(
                        'verify_phone_number_hint'.trParams({
                          'contact': PHelperFunction.isPhone(ctrl.maskedValue.value)
                              ? 'phone_number'.tr.toLowerCase()
                              : 'email_address'.tr.toLowerCase(),
                          'value': ctrl.maskedValue.value,
                        }),
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.3,
                          fontWeight: FontWeight.w500,
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.secondary500
                              : PAppColor.darkAppBarColor2,
                        ),
                      ),
                      PAppSize.s20.verticalSpace,
                      PCustomPinput(
                        length: 6,
                        onCompleted: (pin) {
                          ctrl.updateOTP(pin);
                          ctrl.verifyOTP(pin: pin, isSignup: isSignup);
                        },
                      ),
                      PAppSize.s3.verticalSpace,
                      Text(
                        'one_time_pin'.tr,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: PAppSize.s14,
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.textDisabledColor
                              : PAppColor.darkAppBarColor2,

                          letterSpacing: 0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      PAppSize.s12.verticalSpace,

                      // final seconds = timerCtrl.seconds.value;
                      // final formattedTime =
                      //     "00:${seconds.toString().padLeft(2, '0')}";
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'did_not_receive_code'.tr,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s14,
                                  color: PHelperFunction.isDarkMode(context)
                                      ? PAppColor.whiteColor
                                      : PAppColor.textColorDark,

                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            timerCtrl.completed.value
                                ? 'resend'.tr
                                : 'resend_in'.trParams({
                                    'time': '${timerCtrl.formattedTime} sec',
                                  }),
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s14,
                                  color: timerCtrl.completed.value
                                      ? PAppColor.primary
                                      : PHelperFunction.isDarkMode(context)
                                      ? PAppColor.secondary900
                                      : PAppColor.darkAppBarColor2,

                                  fontWeight: FontWeight.w700,
                                ),
                          ).onPressed(
                            onTap: timerCtrl.completed.value
                                ? () {
                                    ctrl.resendOTP(
                                      pin: ctrl.otpcode.value,
                                      isSignup: isSignup,
                                    );
                                    timerCtrl.startCountdown();
                                  }
                                : null,
                          ),
                          // PAuthLinkButton(
                          //   title: timerCtrl.completed.value
                          //       ? '${'not_receive_code'.tr}? '
                          //       : '${'code_expires_in'.tr} ',
                          //   subtitleColor: timerCtrl.completed.value
                          //       ? PAppColor.primary
                          //       : null,
                          //   subtitle: timerCtrl.completed.value
                          //       ? 'resend'.tr
                          //       : 'resend_in'.trParams({
                          //           'time': timerCtrl.formattedTime,
                          //         }),
                          //   onTap: timerCtrl.completed.value
                          //       ? () {
                          //           ctrl.verifyOTP(
                          //             pin: ctrl.otpcode.value,
                          //             isSignup: isSignup,
                          //           );
                          //           timerCtrl.startCountdown();
                          //         }
                          //       : null,
                          // ),
                        ],
                      ),
                      PAppSize.s28.verticalSpace,
                      PGradientButton(
                        label: 'continue'.tr,
                        showIcon: false,
                        loading: ctrl.loading.value,
                        width: PDeviceUtil.getDeviceWidth(context),
                        onTap: () {
                          ctrl.verifyOTP(
                            isSignup: isSignup,
                            pin: ctrl.otpcode.value,
                          );
                        },
                      ),
                    ],
                  ).scrollable(),
                ),
              ),
            ],
          ).horizontal(PAppSize.s24),
        ),
      ),
    );
  }
}
