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
                            hintText: 'hint_phone'.tr,
                            prefixIcon: Assets.icons.phoneIcon.path,
                            controller: ctrl.phoneTEC,
                            validator: PValidator.validatePhoneNumber,
                            // focusColor: PAppColor.primary,
                          ),
                          // PCustomTextField(
                          //   labelText: 'member_id'.tr,
                          //   hintText: 'hint_member_id'.tr,
                          //   prefixIcon: Assets.icons.memberIcon.path,
                          //   controller: ctrl.memberIDTEC,
                          //   validator: PValidator.validateText,
                          //   // focusColor: PAppColor.primary,
                          // ),
                          PAppSize.s20.verticalSpace,
                          PCustomCheckbox(
                            value: ctrl.agreeToTerms.value,
                            onChanged: ctrl.onTermsCheckboxChanged,
                            child: Text('agree_to_terms'.tr),
                          ),
                          (PDeviceUtil.getDeviceWidth(context) / 2.5)
                              .verticalSpace,
                          PGradientButton(
                            label: 'next'.tr,
                            width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                            onTap: () {
                              if (ctrl.memberIDFormKey.currentState!
                                  .validate()) {
                                ctrl.getMemberInfo();
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
          ],
        ).horizontal(PAppSize.s28),
      ),
    );
  }
}
