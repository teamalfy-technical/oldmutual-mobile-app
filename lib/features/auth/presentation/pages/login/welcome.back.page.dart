import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PWelcomeBackPage extends StatefulWidget {
  const PWelcomeBackPage({super.key});

  @override
  State<PWelcomeBackPage> createState() => _PWelcomeBackPageState();
}

class _PWelcomeBackPageState extends State<PWelcomeBackPage>
    with SingleTickerProviderStateMixin {
  final ctrl = Get.put(PAuthVm());

  final formKey = GlobalKey<FormState>();

  late AnimationController _controller;

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

  @override
  Widget build(BuildContext context) {
    final name =
        (PSecureStorage().getAuthResponse()?.name != null &&
            PSecureStorage().getAuthResponse()!.name!.isNotEmpty)
        ? PSecureStorage().getAuthResponse()?.name
        : PSecureStorage().getBioData()?.firstName;
    return Scaffold(
      appBar: AppBar(
        title: null,
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

                        Text(
                          '${'hi'.tr},',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        PAppSize.s4.verticalSpace,
                        Text(
                          name ?? 'User',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),

                        PAppSize.s24.verticalSpace,
                        PCustomPasswordTextField(
                          labelText: 'hint_password'.tr,
                          // suffixIcon: Assets.icons.passwordViewIcon.svg(
                          //   // color: PAppColor.hintTextColor,
                          // ),
                          // validator: PValidator.validatePassword,
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
                        PAppSize.s25.verticalSpace,

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

                        PAppSize.s20.verticalSpace,

                        if (PSecureStorage().isFaceIdEnabled &&
                            ctrl.isBiometricAvailable.value &&
                            PSecureStorage().getAuthResponse() != null) ...[
                          ScaleTransition(
                            scale: _controller.drive(
                              CurveTween(curve: Curves.easeInOut),
                            ),
                            child: IconButton(
                              onPressed: () async => await ctrl
                                  .authenticateWithBiometrics(_controller),
                              icon: PDeviceUtil.isIOS()
                                  ? Assets.icons.fingerprint.svg()
                                  : Assets.icons.faceId.svg(),
                            ),
                          ),

                          PAppSize.s4.verticalSpace,
                        ],

                        // Assets.icons.fingerprint.svg(),
                        PAppSize.s8.verticalSpace,

                        // (PDeviceUtil.getDeviceWidth(context) * 0.25)
                        //     .verticalSpace,
                        TextButton(
                          onPressed: () {
                            if (PSecureStorage().getUserEmail() != null) {
                              // clear cached user when user decides to login with different account
                              PSecureStorage().removeData(
                                PSecureStorage().emailKey,
                              );
                            }
                            PHelperFunction.switchScreen(
                              destination: Routes.loginPage,
                            );
                          },
                          child: Text(
                            'login_with_different_account'.tr,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: PAppColor.primaryRest,
                                  fontSize: PAppSize.s16,
                                ),
                          ),
                        ),

                        // Explore other services
                        PCustomExpansionTile(
                          title: 'explore_other_services'.tr,
                        ),
                        // Theme(
                        //   data: Theme.of(
                        //     context,
                        //   ).copyWith(dividerColor: Colors.transparent),
                        //   child: ExpansionTile(
                        //     initiallyExpanded: false,
                        //     onExpansionChanged: (value) {},
                        //     title: Text(
                        //       'explore_other_services'.tr,
                        //       style: Theme.of(context).textTheme.headlineSmall,
                        //     ),
                        //     trailing: Icon(Icons.keyboard_arrow_down),
                        //     children: [
                        //       ServiceLinkWidget(
                        //         label: 'special_investments_plan'.tr,
                        //         onLinkTap: () {},
                        //       ),
                        //       PAppSize.s10.verticalSpace,
                        //       ServiceLinkWidget(
                        //         label: 'special_investments_plan'.tr,
                        //         onLinkTap: () {},
                        //       ),
                        //       PAppSize.s10.verticalSpace,
                        //       ServiceLinkWidget(
                        //         label: 'special_investments_plan'.tr,
                        //         onLinkTap: () {},
                        //       ),
                        //       PAppSize.s10.verticalSpace,
                        //       ServiceLinkWidget(
                        //         label: 'special_investments_plan'.tr,
                        //         onLinkTap: () {},
                        //       ),
                        //       PAppSize.s10.verticalSpace,
                        //       ServiceLinkWidget(
                        //         label: 'special_investments_plan'.tr,
                        //         onLinkTap: () {},
                        //       ),
                        //       PAppSize.s10.verticalSpace,
                        //       ServiceLinkWidget(
                        //         label: 'special_investments_plan'.tr,
                        //         onLinkTap: () {},
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ).scrollable(),
                  ),
                ),
              ),
              // don't have an account
              // PAuthLinkButton(
              //   title: '${'dont_have_account'.tr} ',
              //   subtitle: 'sign_up'.tr,
              //   onTap: () => PHelperFunction.switchScreen(
              //     destination: Routes.signupPage,
              //   ),
              // ),
            ],
          ).symmetric(horizontal: PAppSize.s24, vertical: PAppSize.s10),
        ),
      ),
    );
  }
}
