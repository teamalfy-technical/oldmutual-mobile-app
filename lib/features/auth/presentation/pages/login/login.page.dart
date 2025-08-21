import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/vm/auth.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PLoginPage extends StatelessWidget {
  PLoginPage({super.key});

  final ctrl = Get.put(PAuthVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: SizedBox.shrink(),
        actions: [
          IconButton(onPressed: () {}, icon: Assets.icons.ghanaFlag.svg()),
        ],
      ),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Column(
            children: [
              PAppSize.s8.verticalSpace,
              Expanded(
                child: Obx(
                  () => Form(
                    key: ctrl.loginFormKey,
                    child: Column(
                      children: [
                        PAppSize.s24.verticalSpace,
                        // PCustomTextField(
                        //   labelText: 'phone'.tr,
                        //   hintText: 'enter_phone_number'.tr,
                        //   prefixIcon: Assets.icons.phoneIcon.path,
                        //   controller: ctrl.phoneTEC,
                        //   validator: PValidator.validatePhoneNumber,
                        //   // focusColor: PAppColor.primary,
                        // ),
                        // PCustomPhoneTextfield(
                        //   ctrl: ctrl,
                        //   labelText: 'phone'.tr,
                        // ),
                        Text(
                          '${'sign_in'.tr},',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,

                                // fontSize: 20,
                              ),
                        ),
                        PAppSize.s4.verticalSpace,
                        Text(
                          'sign_in_hint'.tr,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: PAppSize.s16,
                                color: PAppColor.secondary700,
                                // fontSize: 20,
                              ),
                        ),
                        PAppSize.s34.verticalSpace,
                        PCustomTextField(
                          // labelText: 'password'.tr,
                          controller: ctrl.emailTEC,
                          labelText: 'hint_email'.tr,

                          textInputType: TextInputType.emailAddress,
                          validator: PValidator.validateEmail,
                        ),
                        PAppSize.s24.verticalSpace,
                        PCustomPasswordTextField(
                          labelText: 'hint_password'.tr,
                          suffixIcon: Assets.icons.passwordViewIcon.svg(),
                          obscure: ctrl.obscure.value,
                          onObscureChanged: ctrl.onObscureChanged,
                          controller: ctrl.passwordTEC,
                        ),
                        // PAppSize.s10.verticalSpace,

                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: PAuthLinkButton(
                        //     title: '${'forgot_password'.tr}? ',
                        //     subtitle: 'reset'.tr,
                        //     subtitleColor: PAppColor.primary,
                        //     fontSize: PAppSize.s14,
                        //     onTap: () => PHelperFunction.switchScreen(
                        //       destination: Routes.enterEmailPage,
                        //     ),
                        //   ),
                        // ),
                        PAppSize.s32.verticalSpace,

                        // (PDeviceUtil.getDeviceWidth(context) / 3).verticalSpace,
                        PGradientButton(
                          label: 'sign_in'.tr,
                          showIcon: false,
                          width: PDeviceUtil.getDeviceWidth(context),
                          onTap: () {
                            if (ctrl.loginFormKey.currentState!.validate()) {
                              PDeviceUtil.hideKeyboard(context);
                              ctrl.login();
                            }
                          },
                        ),

                        (PDeviceUtil.getDeviceWidth(context) * 0.20)
                            .verticalSpace,

                        TextButton(
                          onPressed: () {
                            PHelperFunction.switchScreen(
                              destination: Routes.enterEmailPage,
                            );
                          },
                          child: Text(
                            '${'forgot_password'.tr}?',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  color: PAppColor.primaryLight,
                                  fontSize: PAppSize.s16,
                                ),
                          ),
                        ),

                        PAppSize.s20.verticalSpace,

                        // don't have an account
                        PAuthLinkButton(
                          title: '${'dont_have_account'.tr} ',
                          subtitle: 'create_new'.tr,
                          subtitleColor: PAppColor.primary,
                          onTap: () => PHelperFunction.switchScreen(
                            destination: Routes.signupPage,
                          ),
                        ),
                      ],
                    ).scrollable(),
                  ),
                ),
              ),
            ],
          ).symmetric(horizontal: PAppSize.s24, vertical: PAppSize.s10),
        ),
      ),
    );
  }
}
