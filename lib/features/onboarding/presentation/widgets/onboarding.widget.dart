import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class POnboardingWidget extends StatelessWidget {
  final String imagePath;
  const POnboardingWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              image: AssetImage(imagePath),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
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
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   // stops: [0.2, 1.5],
              //   colors:
              //       PHelperFunction.isDarkMode(context)
              //           ? [
              //             PAppColor.blackColor.withOpacityExt(0.02),
              //             PAppColor.blackColor.withOpacityExt(0.50),
              //             PAppColor.blackColor.withOpacityExt(0.80),
              //             PAppColor.blackColor.withOpacityExt(0.99),
              //             PAppColor.blackColor,
              //             PAppColor.blackColor,
              //           ]
              //           : [
              //             Color(0x00252133), // #252133 with 0% opacity
              //             Color(0xBC252133), // #252133 with 55% opacity
              //             Color(0xA6252133), // #252133 with 55% opacity
              //             // White
              //             PAppColor.whiteColor.withOpacityExt(0.99), // White
              //             PAppColor.whiteColor.withOpacityExt(1.0), // White
              //             PAppColor.whiteColor, // White
              //             PAppColor.whiteColor, // White

              //           ],
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
