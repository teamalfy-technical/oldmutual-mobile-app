import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/vm/auth.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PAppSize.s8.verticalSpace,
                      Text(
                        'reset_password_hint'.tr,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: PAppColor.secondary500,
                              fontSize: PAppSize.s16,
                            ),
                      ),
                      PAppSize.s32.verticalSpace,
                      PCustomTextField(
                        labelText: 'email'.tr,
                        controller: ctrl.emailTEC,
                        validator: PValidator.validateEmail,
                      ),

                      PAppSize.s25.verticalSpace,

                      PGradientButton(
                        label: 'continue'.tr,
                        showIcon: false,
                        width: PDeviceUtil.getDeviceWidth(context),
                        onTap: () {
                          if (ctrl.emailFormKey.currentState!.validate()) {
                            ctrl.forgotPassword();
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
          ).horizontal(PAppSize.s24),
        ),
      ),
    );
  }
}
