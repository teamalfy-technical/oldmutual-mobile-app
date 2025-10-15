import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PCreateAccountPage extends StatefulWidget {
  const PCreateAccountPage({super.key});

  @override
  State<PCreateAccountPage> createState() => _PCreateAccountPageState();
}

class _PCreateAccountPageState extends State<PCreateAccountPage> {
  final ctrl = Get.find<PAuthVm>();

  final formKey = GlobalKey<FormState>();

  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8;
      hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      hasNumber = RegExp(r'[0-9]').hasMatch(password);
      hasSpecialChar = RegExp(r'[!@#\$&*~%^().,?":{}|<>]').hasMatch(password);
    });
  }

  @override
  Widget build(BuildContext context) {
    pensionAppLogger.i('Verification Token: ${ctrl.verificationToken}');
    return Scaffold(
      appBar: AppBar(title: Text('create_account'.tr)),
      body: SafeArea(
        child: Column(
          children: [
            PAppSize.s16.verticalSpace,

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'lets_get_started'.tr,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.secondary500
                      : PAppColor.darkAppBarColor2,

                  fontSize: PAppSize.s16,
                ),
              ),
            ),

            Expanded(
              child: Obx(
                () => Form(
                  key: formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PAppSize.s34.verticalSpace,
                      PCustomTextField(
                        // labelText: 'password'.tr,
                        controller: ctrl.emailOrPhoneTEC,
                        labelText: 'hint_email'.tr,
                        textInputType: TextInputType.emailAddress,
                        validator: PValidator.validateEmail,
                      ),
                      PAppSize.s24.verticalSpace,
                      PCustomTextField(
                        // labelText: 'password'.tr,
                        controller: ctrl.phoneTEC,
                        labelText: 'phone_number'.tr,
                        textInputType: TextInputType.phone,
                        validator: PValidator.validatePhoneNumber,
                      ),
                      PAppSize.s20.verticalSpace,

                      // ✅ Live checklist
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PPasswordCheckerWidget(
                                isValid: hasMinLength,
                                label: 'min_8_characters'.tr,
                              ),
                              PAppSize.s12.verticalSpace,
                              PPasswordCheckerWidget(
                                isValid: hasSpecialChar,
                                label: 'a_special_case'.tr,
                              ),
                            ],
                          ),
                          PAppSize.s24.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PPasswordCheckerWidget(
                                isValid: hasUppercase,
                                label: 'an_uppercase'.tr,
                              ),
                              PAppSize.s12.verticalSpace,
                              PPasswordCheckerWidget(
                                isValid: hasNumber,
                                label: 'a_number'.tr,
                              ),
                            ],
                          ),
                        ],
                      ),

                      PAppSize.s20.verticalSpace,

                      PCustomPasswordTextField(
                        labelText: 'hint_password'.tr,
                        // suffixIcon: Assets.icons.visibilityOn.svg(),
                        obscure: ctrl.obscure.value,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        onObscureChanged: ctrl.onObscureChanged,
                        controller: ctrl.passwordTEC,
                        onChanged: _validatePassword,
                      ),

                      PAppSize.s24.verticalSpace,
                      PCustomPasswordTextField(
                        labelText: 'confirm_password'.tr,
                        validator: (val) => PValidator.validateConfirmPassword(
                          val,
                          ctrl.passwordTEC.text.trim(),
                        ),
                        obscure: ctrl.obscure.value,
                        onObscureChanged: ctrl.onObscureChanged,
                        controller: ctrl.confirmPasswordTEC,
                      ),

                      PAppSize.s20.verticalSpace,

                      // (PDeviceUtil.getDeviceWidth(context) * 0.20)
                      //     .verticalSpace,
                      TextButton(
                        onPressed: () {
                          PHelperFunction.switchScreen(
                            destination: Routes.forgotPasswordPage,
                          );
                        },
                        child: Text(
                          '${'need_help'.tr}?',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                color: PHelperFunction.isDarkMode(context)
                                    ? PAppColor.whiteColor
                                    : PAppColor.darkAppBarColor2,
                                fontSize: PAppSize.s16,
                              ),
                        ),
                      ),

                      TextButton.icon(
                        iconAlignment: IconAlignment.start,
                        icon: Assets.icons.lockIcon.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.blackColor,
                        ),

                        // Icon(
                        //   Icons.lock_outline,
                        //   color: PAppColor.whiteColor,
                        // ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(left: PAppSize.s7),
                        ),
                        onPressed: null,
                        label: Text(
                          'info_secured_hint'.tr,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: PAppSize.s13,

                                color: PHelperFunction.isDarkMode(context)
                                    ? PAppColor.fillColor2
                                    : PAppColor.blackColor,
                              ),
                        ),
                      ),

                      PAppSize.s20.verticalSpace,

                      PGradientButton(
                        label: 'continue'.tr,
                        showIcon: false,
                        loading: ctrl.loading.value,
                        width: PDeviceUtil.getDeviceWidth(context),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            ctrl.createAccount();
                          }
                        },
                      ),
                      PAppSize.s24.verticalSpace,
                      // already have an account
                      PAuthLinkButton(
                        title: '${'already_have_account'.tr} ',
                        titleColor: PHelperFunction.isDarkMode(context)
                            ? Color(0xFFCCCCCC)
                            : PAppColor.blackColor,
                        subtitle: 'sign_in'.tr,
                        subtitleColor: PAppColor.primary,
                        onTap: () => PHelperFunction.switchScreen(
                          destination: Routes.loginPage,
                        ),
                      ),
                    ],
                  ).scrollable(),
                ),
              ),
            ),

            // PAppSize.s10.verticalSpace,
          ],
        ).symmetric(horizontal: PAppSize.s24, vertical: PAppSize.s10),
      ),
    );
  }
}
