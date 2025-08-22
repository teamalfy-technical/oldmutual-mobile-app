import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/vm/auth.vm.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

import '../../../../../gen/assets.gen.dart';

class PCreatePasswordPage extends StatelessWidget {
  final bool isSignup;
  PCreatePasswordPage({super.key, this.isSignup = true});

  final ctrl = Get.find<PAuthVm>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('enter_new_password'.tr)),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            children: [
              PAppSize.s8.verticalSpace,
              Expanded(
                child: Obx(
                  () => Form(
                    key: ctrl.createPasswordFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isSignup)
                          Column(
                            children: [
                              PAppSize.s20.verticalSpace,
                              PCustomTextField(
                                labelText: 'phone'.tr,

                                prefixIcon: Assets.icons.phoneIcon.svg(),
                                controller: ctrl.phoneTEC,
                                enabled: false,
                                validator: PValidator.validatePhoneNumber,
                                // focusColor: PAppColor.primary,
                              ),
                            ],
                          ),
                        PAppSize.s10.verticalSpace,
                        Text(
                          'reset_password_hint'.tr,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: PAppColor.secondary500,
                                fontSize: PAppSize.s16,
                              ),
                        ),
                        PAppSize.s32.verticalSpace,
                        PCustomPasswordTextField(
                          labelText: 'new_password'.tr,
                          // suffixIcon: Assets.icons.passwordViewIcon.svg(
                          //   // color: PAppColor.hintTextColor,
                          // ),
                          validator: PValidator.validatePassword,
                          obscure: ctrl.obscure.value,
                          onObscureChanged: ctrl.onObscureChanged,
                          controller: ctrl.passwordTEC,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomPasswordTextField(
                          labelText: 'confirm_new_password'.tr,
                          // suffixIcon: Assets.icons.passwordViewIcon.svg(
                          //   // color: PAppColor.hintTextColor,
                          // ),
                          validator: PValidator.validatePassword,
                          obscure: ctrl.obscure.value,
                          onObscureChanged: ctrl.onObscureChanged,
                          controller: ctrl.confirmPasswordTEC,
                        ),

                        PAppSize.s28.verticalSpace,
                        PGradientButton(
                          label: 'continue'.tr,
                          showIcon: false,
                          width: PDeviceUtil.getDeviceWidth(context),
                          onTap: () {
                            PHelperFunction.switchScreen(
                              destination: Routes.successPage,
                              args: [
                                'password_changed_title'.tr,
                                'password_changed_msg'.tr,
                                'go_to_dashboard'.tr,
                                () => PHelperFunction.switchScreen(
                                  destination: Routes.dashboardPage,
                                ),
                              ],
                            );
                            // if (ctrl.createPasswordFormKey.currentState!
                            //     .validate()) {
                            //   PDeviceUtil.hideKeyboard(context);
                            //   isSignup
                            //       ? ctrl.createPassword(isSignup: isSignup)
                            //       : ctrl.resetPassword();
                            // }
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
          ).horizontal(PAppSize.s24),
        ),
      ),
    );
  }
}
