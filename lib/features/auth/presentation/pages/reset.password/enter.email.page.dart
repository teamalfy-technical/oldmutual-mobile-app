import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/vm/auth.vm.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

import '../../../../../gen/assets.gen.dart';

class PEnterEmailPage extends StatelessWidget {
  PEnterEmailPage({super.key});

  final ctrl = Get.put(PAuthVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('reset_password'.tr)),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            children: [
              PAppSize.s8.verticalSpace,
              Expanded(
                child: Form(
                  key: ctrl.emailFormKey,
                  child:
                      Column(
                        children: [
                          PAppSize.s20.verticalSpace,
                          PCustomTextField(
                            labelText: 'email'.tr,
                            hintText: 'email_hint'.tr,
                            prefixIcon: Assets.icons.emailIcon.path,
                            controller: ctrl.emailTEC,
                            validator: PValidator.validateEmail,
                            // focusColor: PAppColor.primary,
                          ),

                          (PDeviceUtil.getDeviceWidth(context) / 3)
                              .verticalSpace,
                          PGradientButton(
                            label: 'sent_otp'.tr,
                            width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                            onTap: () {
                              if (ctrl.emailFormKey.currentState!.validate()) {
                                PHelperFunction.switchScreen(
                                  destination: Routes.verifyOTPPage,
                                  args: false,
                                );
                              }
                            },
                          ),
                        ],
                      ).scrollable(),
                ),
              ),
              // don't have an account
              // PAuthLinkButton(
              //   title: '${'dont_have_account'.tr} ',
              //   subtitle: 'sign_up'.tr,
              //   onTap:
              //       () => PHelperFunction.switchScreen(
              //         destination: Routes.signupPage,
              //       ),
              // ),
            ],
          ).horizontal(PAppSize.s28),
        ),
      ),
    );
  }
}
