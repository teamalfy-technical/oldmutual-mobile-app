import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PLoginPage extends StatefulWidget {
  const PLoginPage({super.key});

  @override
  State<PLoginPage> createState() => _PLoginPageState();
}

class _PLoginPageState extends State<PLoginPage>
    with SingleTickerProviderStateMixin {
  final ctrl = Get.put(PAuthVm());
  late AnimationController _controller;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.2,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> authenticate() async {
    // Animate the Face ID icon (shrink → expand → shrink back)
    await _controller.forward();
    await _controller.reverse();

    final success = await LocalAuthService().authenticateUser();
    pensionAppLogger.e(success);
  }

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
                    key: formKey,
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
                          controller: ctrl.passwordTEC,
                          labelText: 'hint_password'.tr,
                          // suffixIcon: Assets.icons.visibilityOn.svg(),
                          obscure: ctrl.obscure.value,
                          onObscureChanged: ctrl.onObscureChanged,
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
                          loading: ctrl.loading.value,
                          width: PDeviceUtil.getDeviceWidth(context),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              PDeviceUtil.hideKeyboard(context);
                              ctrl.login();
                            }
                          },
                        ),

                        PAppSize.s16.verticalSpace,

                        if (ctrl.isBiometricAvailable.value &&
                            PSecureStorage().getAuthResponse() != null) ...[
                          ScaleTransition(
                            scale: _controller.drive(
                              CurveTween(curve: Curves.easeInOut),
                            ),
                            child: IconButton(
                              onPressed: () async => await authenticate(),
                              icon: PDeviceUtil.isIOS()
                                  ? Assets.icons.fingerprint.svg()
                                  : Assets.icons.faceId.svg(),
                            ),
                          ),

                          PAppSize.s4.verticalSpace,
                        ],

                        // (PDeviceUtil.getDeviceWidth(context) * 0.20)
                        //     .verticalSpace,
                        TextButton(
                          onPressed: () {
                            PHelperFunction.switchScreen(
                              destination: Routes.forgotPasswordPage,
                            );
                          },
                          child: Text(
                            '${'forgot_password'.tr}?',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  color: PAppColor.primaryRest,
                                  fontSize: PAppSize.s16,
                                ),
                          ),
                        ),

                        PAppSize.s16.verticalSpace,

                        // don't have an account
                        PAuthLinkButton(
                          title: '${'dont_have_account'.tr} ',
                          subtitle: 'create_new'.tr,
                          subtitleColor: PAppColor.primary,
                          onTap: () => PHelperFunction.switchScreen(
                            destination: Routes.idEntryPage,
                          ),
                        ),

                        PAppSize.s16.verticalSpace,
                        // Explore other services
                        PCustomExpansionTile(
                          title: 'explore_other_services'.tr,
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
