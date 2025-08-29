import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/vm/auth.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PCreatePasswordPage extends StatelessWidget {
  PCreatePasswordPage({super.key});

  final formKey = GlobalKey<FormState>();

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
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          validator: PValidator.validatePassword,
                          obscure: ctrl.obscure.value,
                          onObscureChanged: ctrl.onObscureChanged,
                          controller: ctrl.passwordTEC,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomPasswordTextField(
                          labelText: 'confirm_new_password'.tr,
                          validator: (val) =>
                              PValidator.validateConfirmPassword(
                                val,
                                ctrl.passwordTEC.text.trim(),
                              ),
                          obscure: ctrl.obscure.value,
                          onObscureChanged: ctrl.onObscureChanged,
                          controller: ctrl.confirmPasswordTEC,
                        ),

                        PAppSize.s28.verticalSpace,
                        PGradientButton(
                          label: 'continue'.tr,
                          showIcon: false,
                          loading: ctrl.loading.value,
                          width: PDeviceUtil.getDeviceWidth(context),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              PDeviceUtil.hideKeyboard(context);
                              ctrl.resetPassword();
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
          ).horizontal(PAppSize.s24),
        ),
      ),
    );
  }
}
