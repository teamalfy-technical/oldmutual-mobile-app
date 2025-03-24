import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PVerifyOTPPage extends StatelessWidget {
  final bool isSignup;
  PVerifyOTPPage({super.key, this.isSignup = true});

  final ctrl = Get.put(PAuthVm());
  final timerCtrl = Get.put(PTimerVm());

  @override
  Widget build(BuildContext context) {
    timerCtrl.startCountdown();
    return Scaffold(
      appBar: AppBar(
        title: Text(isSignup ? 'verify_phone_number'.tr : 'reset_password'.tr),
      ),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            children: [
              PAppSize.s8.verticalSpace,
              Expanded(
                child:
                    Column(
                      children: [
                        PAppSize.s20.verticalSpace,
                        Text(
                          'verify_phone_number_hint'.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomPinput(
                          length: 6,
                          onCompleted: (pin) {
                            ctrl.updateOTP(pin);
                            ctrl.verifyOTP(pin: pin, isSignup: isSignup);
                          },
                        ),
                        PAppSize.s10.verticalSpace,
                        Obx(() {
                          final seconds = timerCtrl.seconds.value;
                          final formattedTime =
                              "00:${seconds.toString().padLeft(2, '0')}";
                          return PAuthLinkButton(
                            title:
                                timerCtrl.completed.value
                                    ? '${'not_receive_code'.tr}? '
                                    : '${'code_expires_in'.tr} ',
                            subtitleColor:
                                timerCtrl.completed.value
                                    ? PAppColor.primary
                                    : null,
                            subtitle:
                                timerCtrl.completed.value
                                    ? 'resend'.tr
                                    : formattedTime,
                            onTap:
                                timerCtrl.completed.value
                                    ? () {
                                      timerCtrl.startCountdown();
                                    }
                                    : null,
                          );
                          // return Text(
                          //   '${'code_expires_in'.tr} $formattedTime',
                          //   textAlign: TextAlign.center,
                          //   style: Theme.of(context).textTheme.bodyMedium,
                          // );
                        }),
                        (PDeviceUtil.getDeviceWidth(context) / 2.5)
                            .verticalSpace,
                        PGradientButton(
                          label: 'next'.tr,
                          width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                          onTap:
                              () => ctrl.verifyOTP(
                                pin: ctrl.otpcode.value,
                                isSignup: isSignup,
                              ),
                        ).centered(),
                      ],
                    ).scrollable(),
              ),
            ],
          ).horizontal(PAppSize.s25),
        ),
      ),
    );
  }
}
