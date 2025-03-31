import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/presentation/vm/auth.vm.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

import '../../../../../gen/assets.gen.dart';

class PPhoneNumberPage extends StatelessWidget {
  PPhoneNumberPage({super.key});

  final ctrl = Get.put(PAuthVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('let_get_started'.tr)),
      body: SafeArea(
        child: Column(
          children: [
            PAppSize.s8.verticalSpace,
            Expanded(
              child: Obx(
                () => Form(
                  key: ctrl.memberIDFormKey,
                  child:
                      Column(
                        children: [
                          PCustomTextField(
                            labelText: 'phone'.tr,
                            hintText: 'enter_phone_number'.tr,
                            prefixIcon: Assets.icons.phoneIcon.path,
                            controller: ctrl.phoneTEC,
                            validator: PValidator.validatePhoneNumber,
                            // focusColor: PAppColor.primary,
                          ),
                          PAppSize.s20.verticalSpace,
                          PCustomCheckbox(
                            value: ctrl.agreeToTerms.value,
                            onChanged: ctrl.onTermsCheckboxChanged,
                            child: RichText(
                              text: TextSpan(
                                text: '${'i_agree_to'.tr} ',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: PAppColor.blackColor),
                                children: [
                                  TextSpan(
                                    text: 'terms_conditions'.tr,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: PAppColor.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: PAppColor.primary,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap =
                                              () =>
                                                  PHelperFunction.switchScreen(
                                                    destination:
                                                        Routes.webviewPage,
                                                    args: [
                                                      'terms_conditions'.tr,
                                                      PAppConstant
                                                          .termsConditionsLink,
                                                    ],
                                                  ),
                                  ),
                                ],
                              ),
                            ),
                            //Text('agree_to_terms'.tr),
                          ),
                          (PDeviceUtil.getDeviceWidth(context) / 2.5)
                              .verticalSpace,
                          PGradientButton(
                            label: 'next'.tr,
                            width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                            onTap: () {
                              if (ctrl.memberIDFormKey.currentState!
                                  .validate()) {
                                ctrl.signup();
                              }
                            },
                          ),
                        ],
                      ).scrollable(),
                ),
              ),
            ),
            // already have an account
            PAuthLinkButton(
              title: '${'already_have_account'.tr} ',
              subtitle: 'sign_in'.tr,
              onTap:
                  () => PHelperFunction.switchScreen(
                    destination: Routes.loginPage,
                  ),
            ),
            // PAppSize.s10.verticalSpace,
          ],
        ).symmetric(horizontal: PAppSize.s28, vertical: PAppSize.s10),
      ),
    );
  }
}
