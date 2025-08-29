import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/splash/presentation/vm/splash.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PWelcomePage extends StatelessWidget {
  PWelcomePage({super.key});

  final ctrl = Get.put(PSplashVm());

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
                      'welcome_label_break'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w600,

                            // fontSize: 20,
                          ),
                    ),
                    PAppSize.s50.verticalSpace,

                    PGradientButton(
                      label: 'create_account'.tr,
                      showIcon: false,
                      width: PDeviceUtil.getDeviceWidth(context),
                      onTap: () => ctrl.completeOnboarding(Routes.idEntryPage),
                    ),

                    PAppSize.s5.verticalSpace,

                    TextButton(
                      onPressed: () =>
                          ctrl.completeOnboarding(Routes.loginPage),
                      child: Text(
                        '${'login_to_existing_account'.tr}?',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: PAppColor.primaryLight,
                              fontSize: PAppSize.s16,
                            ),
                      ),
                    ),
                  ],
                ).scrollable(),
              ),
            ],
          ).symmetric(horizontal: PAppSize.s24, vertical: PAppSize.s10),
        ),
      ),
    );
  }
}
