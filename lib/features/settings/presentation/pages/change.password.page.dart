import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/vm/settings.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PChangePasswordPage extends StatelessWidget {
  PChangePasswordPage({super.key});

  final ctrl = Get.put(PSettingsVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('change_password'.tr)),
      body: Obx(
        () => Form(
          key: ctrl.changePasswordFormKey,
          child:
              Column(
                children: [
                  PAppSize.s20.verticalSpace,
                  PCustomPasswordTextField(
                    labelText: 'old_password'.tr,
                    hintText: 'hint_password'.tr,
                    prefixIcon: Assets.icons.lockIcon.path,
                    suffixIcon: Assets.icons.eyeIcon.path,
                    obscure: ctrl.obscureOldPassword.value,
                    onObscureChanged: ctrl.onObscureOldPasswordChanged,
                    controller: ctrl.oldPasswordTEC,
                  ),
                  PAppSize.s20.verticalSpace,
                  PCustomPasswordTextField(
                    labelText: 'new_password'.tr,
                    hintText: 'hint_password'.tr,
                    prefixIcon: Assets.icons.lockIcon.path,
                    suffixIcon: Assets.icons.eyeIcon.path,
                    validator: PValidator.validatePassword,
                    obscure: ctrl.obscureNewPassword.value,
                    onObscureChanged: ctrl.onObscureNewPasswordChanged,
                    controller: ctrl.newPasswordTEC,
                  ),
                  PAppSize.s20.verticalSpace,
                  PCustomPasswordTextField(
                    labelText: 'confirm_password'.tr,
                    hintText: 'hint_password'.tr,
                    prefixIcon: Assets.icons.lockIcon.path,
                    suffixIcon: Assets.icons.eyeIcon.path,
                    validator: PValidator.validatePassword,
                    obscure: ctrl.obscureNewPassword.value,
                    onObscureChanged: ctrl.onObscureNewPasswordChanged,
                    controller: ctrl.confirmPasswordTEC,
                  ),

                  (PDeviceUtil.getDeviceWidth(context) / 5).verticalSpace,
                  PGradientButton(
                    label: 'change'.tr,
                    width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                    onTap: () {
                      if (ctrl.changePasswordFormKey.currentState!.validate()) {
                        PDeviceUtil.hideKeyboard(context);
                        ctrl.changePassword();
                      }
                    },
                  ),
                ],
              ).symmetric(horizontal: PAppSize.s20).scrollable(),
        ),
      ),
    );
  }
}
