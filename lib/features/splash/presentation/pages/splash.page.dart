import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/splash/presentation/vm/splash.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/widgets/annotated.region.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.loading.indicator.dart';

class PSplashPage extends StatelessWidget {
  PSplashPage({super.key});

  final ctrl = Get.put(PSplashVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: OAppColor.blackColor,
      body: SafeArea(
        child: PAnnotatedRegion(
          child: Stack(
            children: [
              Container(
                height: PDeviceUtil.getDeviceHeight(context) - 190,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: PAppSize.s7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(PAppSize.s10),
                    topRight: Radius.circular(PAppSize.s10),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Assets.images.splashImg.path),
                  ),
                ),
              ),

              Positioned(
                bottom: PAppSize.s0,
                left: PAppSize.s0,
                right: PAppSize.s0,
                child: Container(
                  width: PDeviceUtil.getDeviceWidth(context),
                  height: PDeviceUtil.getDeviceHeight(context) * 0.61,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        PHelperFunction.isDarkMode(context)
                            ? Assets.images.darkBlurBg.path
                            : Assets.images.lightBlurBg.path,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'welcome_text'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color:
                        PHelperFunction.isDarkMode(context)
                            ? PAppColor.whiteColor
                            : PAppColor.primaryTextColor,
                  ),
                ),
              ).horizontal(PAppSize.s4),

              Positioned(
                bottom: PAppSize.s10,
                right: PAppSize.s0,
                left: PAppSize.s0,
                child: PCustomLoadingIndicator(color: PAppColor.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
