import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/vm/auth.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

import '../../../../../gen/assets.gen.dart';

class PCreatePasswordPage extends StatelessWidget {
  final bool isSignup;
  PCreatePasswordPage({super.key, this.isSignup = true});

  final ctrl = Get.find<PAuthVm>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSignup ? 'welcome'.tr : 'reset_password'.tr),
      ),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            children: [
              PAppSize.s8.verticalSpace,
              Expanded(
                child: Obx(
                  () => Form(
                    key: ctrl.createPasswordFormKey,
                    child:
                        Column(
                          children: [
                            if (isSignup)
                              Column(
                                children: [
                                  PAppSize.s20.verticalSpace,
                                  PCustomTextField(
                                    labelText: 'phone'.tr,
                                    hintText: '',
                                    prefixIcon: Assets.icons.phoneIcon.path,
                                    controller: ctrl.phoneTEC,
                                    enabled: false,
                                    validator: PValidator.validatePhoneNumber,
                                    // focusColor: PAppColor.primary,
                                  ),
                                ],
                              ),
                            PAppSize.s20.verticalSpace,
                            PCustomPasswordTextField(
                              labelText: 'create_password'.tr,
                              hintText: 'hint_password'.tr,
                              validator: PValidator.validatePassword,
                              prefixIcon: Assets.icons.lockIcon.path,
                              suffixIcon: Assets.icons.eyeIcon.path,
                              obscure: ctrl.obscure.value,
                              onObscureChanged: ctrl.onObscureChanged,
                              controller: ctrl.passwordTEC,
                            ),
                            PAppSize.s20.verticalSpace,
                            PCustomPasswordTextField(
                              labelText:
                                  isSignup
                                      ? 'confirm_password'.tr
                                      : 're_enter_password'.tr,
                              hintText: 'hint_password'.tr,
                              validator: PValidator.validatePassword,
                              prefixIcon: Assets.icons.lockIcon.path,
                              suffixIcon: Assets.icons.eyeIcon.path,
                              obscure: ctrl.obscure.value,
                              onObscureChanged: ctrl.onObscureChanged,
                              controller: ctrl.confirmPasswordTEC,
                            ),

                            (PDeviceUtil.getDeviceWidth(context) / 5)
                                .verticalSpace,
                            PGradientButton(
                              label: 'next'.tr,
                              width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                              onTap: () {
                                if (ctrl.createPasswordFormKey.currentState!
                                    .validate()) {
                                  PDeviceUtil.hideKeyboard(context);
                                  isSignup
                                      ? ctrl.createPassword(isSignup: isSignup)
                                      : ctrl.resetPassword();
                                }
                              },
                            ),
                          ],
                        ).scrollable(),
                  ),
                ),
              ),
              // already have an account
              // PAuthLinkButton(
              //   title: '${'already_have_account'.tr} ',
              //   subtitle: 'sign_in'.tr,
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
