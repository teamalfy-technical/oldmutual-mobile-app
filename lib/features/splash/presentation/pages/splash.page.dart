import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/splash/presentation/vm/splash.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

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
          Positioned.fill(
            child: Image.asset(
              Assets.images.splashImg.path,
              fit: BoxFit.cover,
              width: PDeviceUtil.getDeviceWidth(context),
            ),
          ),

          // Positioned.fill(
          //   child: Opacity(
          //     opacity: PAppSize.s0_7,
          //     child: Image.asset(
          //       Assets.images.splashOverlayImg.path,
          //       fit: BoxFit.cover,
          //       width: PDeviceUtil.getDeviceWidth(context),
          //     ),
          //   ),
          // ),
          Positioned(
            top: PAppSize.s0,
            left: PDeviceUtil.getDeviceWidth(context) * 0.1,
            child: Assets.icons.topLogoBanner.svg(),
          ),

          Positioned(
            top: PDeviceUtil.getDeviceHeight(context) * 0.17,
            left: PDeviceUtil.getDeviceWidth(context) * 0.1,
            child: Text(
              'welcome_text'.tr,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: PAppSize.s36,
                height: PAppSize.s1_2,
                fontWeight: FontWeight.w600,
                color: PAppColor.whiteColor,
              ),
            ),
          ),

          Positioned(
            bottom: PAppSize.s0,
            left: PDeviceUtil.getDeviceWidth(context) * 0.1,
            child: Assets.icons.bottomLogoBanner.svg(),
          ),

          // Positioned.fill(
          //   top: PAppSize.s0,
          //   bottom: PAppSize.s0,
          //   left: PAppSize.s0,
          //   right: PAppSize.s0,
          //   child: SafeArea(
          //     child: Column(
          //       children: [
          //         Expanded(
          //           child: Container(
          //             padding: EdgeInsets.only(
          //               top: PAppSize.s12,
          //               left: PAppSize.s0,
          //               bottom: PAppSize.s0,
          //             ),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(PAppSize.s10),
          //                 topRight: Radius.circular(PAppSize.s10),
          //                 bottomLeft: Radius.circular(PAppSize.s30),
          //                 bottomRight: Radius.circular(PAppSize.s30),
          //               ),
          //               color: PHelperFunction.isLightMode(context)
          //                   ? Colors.white54
          //                   : PAppColor.transparentColor,
          //             ),
          //             child: Container(
          //               width: double.infinity,
          //               margin: EdgeInsets.symmetric(horizontal: PAppSize.s10),
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.only(
          //                   topLeft: Radius.circular(PAppSize.s10),
          //                   topRight: Radius.circular(PAppSize.s10),
          //                   bottomLeft: Radius.circular(PAppSize.s30),
          //                   bottomRight: Radius.circular(PAppSize.s30),
          //                 ),
          //                 image: DecorationImage(
          //                   fit: BoxFit.cover,
          //                   image: AssetImage(Assets.images.splashImg.path),
          //                 ),
          //               ),
          //               child: Stack(
          //                 children: [
          //                   Align(
          //                     alignment: Alignment.center,
          //                     child: Container(
          //                       width: PDeviceUtil.getDeviceWidth(context),
          //                       margin: EdgeInsets.symmetric(
          //                         horizontal: PAppSize.s5,
          //                       ),
          //                       padding: EdgeInsets.symmetric(
          //                         vertical: PAppSize.s8,
          //                         horizontal: PAppSize.s5,
          //                       ),
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(
          //                           PAppSize.s4,
          //                         ),
          //                         color: PHelperFunction.isDarkMode(context)
          //                             ? PAppColor.blackColor.withOpacityExt(
          //                                 PAppSize.s0_3,
          //                               )
          //                             : PAppColor.whiteColor.withOpacityExt(
          //                                 PAppSize.s0_5,
          //                               ),
          //                       ),
          //                       child: Text(
          //                         'welcome_text'.tr,
          //                         textAlign: TextAlign.center,
          //                         style: Theme.of(context)
          //                             .textTheme
          //                             .headlineLarge
          //                             ?.copyWith(
          //                               fontSize: PAppSize.s32,
          //                               color:
          //                                   PHelperFunction.isDarkMode(context)
          //                                   ? PAppColor.whiteColor
          //                                   : PAppColor.primaryTextColor,
          //                             ),
          //                       ),
          //                     ),
          //                   ),

          //                   // Spacer(),
          //                   Positioned(
          //                     bottom: PDeviceUtil.isIOS()
          //                         ? PDeviceUtil.getDeviceHeight(context) * 0.015
          //                         : PDeviceUtil.getDeviceHeight(context) * 0.03,
          //                     left: PAppSize.s8,
          //                     right: PAppSize.s8,
          //                     child: PCustomLoadingIndicator(
          //                       color: PAppColor.primary,
          //                     ),
          //                   ),
          //                   // PAppSize.s8.verticalSpace,
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),

          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
