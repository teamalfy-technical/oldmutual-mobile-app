import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/vm/settings.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PChangePasswordPage extends StatefulWidget {
  const PChangePasswordPage({super.key});

  @override
  State<PChangePasswordPage> createState() => _PChangePasswordPageState();
}

class _PChangePasswordPageState extends State<PChangePasswordPage> {
  final vm = Get.put(PSettingsVm());

  final formKey = GlobalKey<FormState>();

  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasSpecialCharNumber = false;

  void _validatePassword(String password) {
    setState(() {
      hasMinLength = PValidator.validatePasswordLength(password);
      hasUppercase = PValidator.validatePasswordCapital(password);
      hasSpecialCharNumber = PValidator.validatePasswordSpecialAndNumber(
        password,
      );
    });
  }

  InputBorder inputBorder({Color? color}) => UnderlineInputBorder(
    borderSide: BorderSide(
      width: PAppSize.s0_8,
      color: color ?? PAppColor.fillColor2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(
        title: Text('change_password'.tr),
        leading: SizedBox.shrink(),
        actions: [
          IconButton(onPressed: PHelperFunction.pop, icon: Icon(Icons.clear)),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Form(
                key: vm.changePasswordFormKey,
                child: Container(
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.darkAppBarColor
                      : PAppColor.whiteColor,
                  child: Column(
                    children: [
                      // PAppSize.s20.verticalSpace,
                      // PCustomPasswordTextField(
                      //   // labelText: 'old_password'.tr,
                      //   labelText: 'hint_password'.tr,
                      //   prefixIcon: Assets.icons.lockIcon.svg(),
                      //   suffixIcon: Assets.icons.eyeIcon.svg(),
                      //   obscure: ctrl.obscureOldPassword.value,
                      //   onObscureChanged: ctrl.onObscureOldPasswordChanged,
                      //   controller: ctrl.oldPasswordTEC,
                      // ),
                      PAppSize.s8.verticalSpace,
                      Divider(
                        color: PAppColor.fillColor2,
                        thickness: PAppSize.s0_8,
                        // height: PAppSize.s0,
                      ).symmetric(horizontal: PAppSize.s16),
                      PAppSize.s6.verticalSpace,
                      PCustomPasswordTextField(
                        titleText: 'old_password'.tr,
                        hintText: 'old_password'.tr,
                        labelText: null,
                        // contentPadding: EdgeInsets.zero,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: PAppSize.s10,
                          horizontal: PAppSize.s0,
                        ),
                        border: inputBorder(),
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                        errorBorder: inputBorder(color: PAppColor.errorColor),
                        focusedErrorBorder: inputBorder(
                          color: PAppColor.errorColor,
                        ),
                        obscure: vm.obscureOldPassword.value,
                        onObscureChanged: vm.onObscureOldPasswordChanged,
                        controller: vm.oldPasswordTEC,
                        onChanged: _validatePassword,
                      ).symmetric(horizontal: PAppSize.s32),
                      PAppSize.s10.verticalSpace,
                      Divider(
                        color: PAppColor.fillColor2,
                        thickness: PAppSize.s0_8,
                        // height: PAppSize.s0,
                      ).symmetric(horizontal: PAppSize.s16),
                      PAppSize.s6.verticalSpace,
                      PCustomPasswordTextField(
                        titleText: 'password'.tr,
                        hintText: 'enter_password'.tr,
                        labelText: null,
                        // contentPadding: EdgeInsets.zero,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: PAppSize.s10,
                          horizontal: PAppSize.s0,
                        ),
                        border: inputBorder(),
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                        errorBorder: inputBorder(color: PAppColor.errorColor),
                        focusedErrorBorder: inputBorder(
                          color: PAppColor.errorColor,
                        ),
                        obscure: vm.obscureNewPassword.value,
                        onObscureChanged: vm.onObscureNewPasswordChanged,
                        controller: vm.newPasswordTEC,
                        onChanged: _validatePassword,
                      ).symmetric(horizontal: PAppSize.s32),

                      PAppSize.s10.verticalSpace,
                      Divider(
                        color: PAppColor.fillColor2,
                        thickness: PAppSize.s0_8,
                        // height: PAppSize.s0,
                      ).symmetric(horizontal: PAppSize.s16),
                      PAppSize.s6.verticalSpace,
                      PCustomPasswordTextField(
                        // labelText: 'confirm_password'.tr,
                        titleText: 'confirm_password'.tr,
                        hintText: 'confirm_password'.tr,

                        labelText: null,
                        // contentPadding: EdgeInsets.zero,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: PAppSize.s10,
                          horizontal: PAppSize.s0,
                        ),
                        border: inputBorder(),
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                        errorBorder: inputBorder(color: PAppColor.errorColor),
                        focusedErrorBorder: inputBorder(
                          color: PAppColor.errorColor,
                        ),
                        validator: (val) => PValidator.validateConfirmPassword(
                          val,
                          vm.newPasswordTEC.text.trim(),
                        ),

                        obscure: vm.obscureNewPassword.value,
                        onObscureChanged: vm.onObscureNewPasswordChanged,
                        controller: vm.confirmPasswordTEC,
                      ).symmetric(horizontal: PAppSize.s32),

                      PAppSize.s20.verticalSpace,

                      // ✅ Live checklist
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'supportive_text'.tr,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s13,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          PAppSize.s5.verticalSpace,
                          PPasswordCheckerWidget(
                            isValid: hasMinLength,
                            label: 'password_length_msg'.tr,
                          ),
                          PAppSize.s12.verticalSpace,
                          PPasswordCheckerWidget(
                            isValid: hasUppercase,
                            label: 'password_capital_msg'.tr,
                          ),
                          PAppSize.s12.verticalSpace,
                          PPasswordCheckerWidget(
                            isValid: hasSpecialCharNumber,
                            label: 'password_special_char_msg'.tr,
                          ),
                        ],
                      ).symmetric(horizontal: PAppSize.s32),

                      PAppSize.s20.verticalSpace,
                    ],
                  ).scrollable(),
                ),
              ),
              Expanded(child: Container()),

              Container(
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.darkAppBarColor
                    : PAppColor.whiteColor,
                padding: EdgeInsets.symmetric(
                  horizontal: PAppSize.s20,
                  vertical: PAppSize.s18,
                ),
                child: PGradientButton(
                  label: 'save'.tr,
                  showIcon: false,
                  loading: vm.loading.value,
                  textColor: PAppColor.whiteColor,
                  width: PDeviceUtil.getDeviceWidth(context),
                  onTap: () {
                    if (vm.changePasswordFormKey.currentState!.validate()) {
                      PDeviceUtil.hideKeyboard(context);
                      vm.changePassword();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
