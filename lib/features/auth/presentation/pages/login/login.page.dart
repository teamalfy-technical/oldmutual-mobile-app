import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/vm/auth.vm.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

import '../../../../../gen/assets.gen.dart';

class PLoginPage extends StatelessWidget {
  PLoginPage({super.key});

  final ctrl = Get.put(PAuthVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('welcome_back'.tr)),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            children: [
              PAppSize.s8.verticalSpace,
              Expanded(
                child: Obx(
                  () => Form(
                    key: ctrl.loginFormKey,
                    child:
                        Column(
                          children: [
                            PAppSize.s20.verticalSpace,
                            PCustomTextField(
                              labelText: 'phone'.tr,
                              hintText: 'enter_phone_number'.tr,
                              prefixIcon: Assets.icons.phoneIcon.path,
                              controller: ctrl.phoneTEC,
                              validator: PValidator.validatePhoneNumber,
                              // focusColor: PAppColor.primary,
                            ),
                            PAppSize.s20.verticalSpace,
                            PCustomPasswordTextField(
                              labelText: 'password'.tr,
                              hintText: 'hint_password'.tr,
                              prefixIcon: Assets.icons.lockIcon.path,
                              suffixIcon: Assets.icons.eyeIcon.path,
                              obscure: ctrl.obscure.value,
                              onObscureChanged: ctrl.onObscureChanged,
                              controller: ctrl.passwordTEC,
                            ),
                            PAppSize.s10.verticalSpace,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: PAuthLinkButton(
                                title: '${'forgot_password'.tr}? ',
                                subtitle: 'reset'.tr,
                                subtitleColor: PAppColor.primary,
                                fontSize: PAppSize.s14,
                                onTap:
                                    () => PHelperFunction.switchScreen(
                                      destination: Routes.enterEmailPage,
                                    ),
                              ),
                            ),

                            (PDeviceUtil.getDeviceWidth(context) / 3)
                                .verticalSpace,
                            PGradientButton(
                              label: 'sign_in'.tr,
                              width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                              onTap: () {
                                if (ctrl.loginFormKey.currentState!
                                    .validate()) {
                                  ctrl.login();
                                }
                              },
                            ),
                          ],
                        ).scrollable(),
                  ),
                ),
              ),
              // don't have an account
              PAuthLinkButton(
                title: '${'dont_have_account'.tr} ',
                subtitle: 'sign_up'.tr,
                onTap:
                    () => PHelperFunction.switchScreen(
                      destination: Routes.signupPage,
                    ),
              ),
            ],
          ).horizontal(PAppSize.s28),
        ),
      ),
    );
  }
}
