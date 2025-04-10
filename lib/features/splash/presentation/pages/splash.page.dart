import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/splash/presentation/vm/splash.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PSplashPage extends StatelessWidget {
  PSplashPage({super.key});

  final ctrl = Get.put(PSplashVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Your background image
          if (PHelperFunction.isLightMode(context))
            Positioned.fill(
              child: Opacity(
                opacity: PAppSize.s0_7,
                child: Image.asset(
                  Assets.images.dashboardBg.path,
                  fit: BoxFit.cover,
                  width: PDeviceUtil.getDeviceWidth(context),
                  colorBlendMode: BlendMode.difference,
                  color: PAppColor.blackColor.withOpacityExt(
                    PAppSize.s0_5,
                  ), // Adjust opacity
                ),
              ),
              // child: Image.asset(
              //   Assets.images.dashboardBg.path,
              //   fit: BoxFit.cover,
              // ),
            ),

          Positioned.fill(
            top: PAppSize.s0,
            bottom: PAppSize.s0,
            left: PAppSize.s0,
            right: PAppSize.s0,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: PAppSize.s12,
                        left: PAppSize.s0,
                        bottom: PAppSize.s0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(PAppSize.s10),
                          topRight: Radius.circular(PAppSize.s10),
                          bottomLeft: Radius.circular(PAppSize.s30),
                          bottomRight: Radius.circular(PAppSize.s30),
                        ),
                        color:
                            PHelperFunction.isLightMode(context)
                                ? Colors.white54
                                : PAppColor.transparentColor,
                      ),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: PAppSize.s10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(PAppSize.s10),
                            topRight: Radius.circular(PAppSize.s10),
                            bottomLeft: Radius.circular(PAppSize.s30),
                            bottomRight: Radius.circular(PAppSize.s30),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(Assets.images.splashImg.path),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: PDeviceUtil.getDeviceWidth(context),
                                margin: EdgeInsets.symmetric(
                                  horizontal: PAppSize.s5,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: PAppSize.s8,
                                  horizontal: PAppSize.s5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    PAppSize.s4,
                                  ),
                                  color:
                                      PHelperFunction.isDarkMode(context)
                                          ? PAppColor.blackColor.withOpacityExt(
                                            PAppSize.s0_3,
                                          )
                                          : PAppColor.whiteColor.withOpacityExt(
                                            PAppSize.s0_5,
                                          ),
                                ),
                                child: Text(
                                  'welcome_text'.tr,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge?.copyWith(
                                    fontSize: PAppSize.s32,
                                    color:
                                        PHelperFunction.isDarkMode(context)
                                            ? PAppColor.whiteColor
                                            : PAppColor.primaryTextColor,
                                  ),
                                ),
                              ),
                            ),

                            // Spacer(),
                            Positioned(
                              bottom:
                                  PDeviceUtil.isIOS()
                                      ? PDeviceUtil.getDeviceHeight(context) *
                                          0.015
                                      : PDeviceUtil.getDeviceHeight(context) *
                                          0.03,
                              left: PAppSize.s8,
                              right: PAppSize.s8,
                              child: PCustomLoadingIndicator(
                                color: PAppColor.primary,
                              ),
                            ),
                            // PAppSize.s8.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Positioned.fill(
                  //   child: Container(
                  //     // height: PDeviceUtil.getDeviceHeight(context),
                  //     width: double.infinity,
                  //     margin: EdgeInsets.symmetric(horizontal: PAppSize.s7),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(PAppSize.s10),
                  //         topRight: Radius.circular(PAppSize.s10),
                  //         bottomLeft: Radius.circular(PAppSize.s30),
                  //         bottomRight: Radius.circular(PAppSize.s30),
                  //       ),
                  //       image: DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: AssetImage(Assets.images.splashImg.path),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // Positioned(
                  //   bottom: PAppSize.s0,
                  //   left: PAppSize.s0,
                  //   right: PAppSize.s0,
                  //   child: Container(
                  //     width: PDeviceUtil.getDeviceWidth(context),
                  //     height: PDeviceUtil.getDeviceHeight(context) * 0.61,
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: AssetImage(
                  //           PHelperFunction.isDarkMode(context)
                  //               ? Assets.images.darkBlurBg.path
                  //               : Assets.images.lightBlurBg.path,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // welcome text
                  // Positioned(
                  //   top: PDeviceUtil.getDeviceHeight(context) * 0.45,
                  //   left: PAppSize.s0,
                  //   right: PAppSize.s0,
                  //   child: Text(
                  //     'welcome_text'.tr,
                  //     textAlign: TextAlign.center,
                  //     style: Theme.of(
                  //       context,
                  //     ).textTheme.headlineLarge?.copyWith(
                  //       fontSize: PAppSize.s36,
                  //       color:
                  //           PHelperFunction.isDarkMode(context)
                  //               ? PAppColor.whiteColor
                  //               : PAppColor.primaryTextColor,
                  //     ),
                  //   ).horizontal(PAppSize.s4),
                  // ),

                  // Positioned(
                  //   bottom: PAppSize.s10,
                  //   right: PAppSize.s0,
                  //   left: PAppSize.s0,
                  //   child: PCustomLoadingIndicator(color: PAppColor.primary),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
