import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PDashboardHighlightPage extends StatelessWidget {
  final Highlight highlight;
  PDashboardHighlightPage({super.key, required this.highlight});

  final vm = Get.put(PHomeVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(
        title: Text(
          highlight.title2 ?? highlight.title.tr.replaceAll('\n', ''),
        ),
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: PHelperFunction.pop,
            icon: Assets.icons.closeIcon.svg(
              height: PAppSize.s28,
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.cardDarkColor,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.images.dashboardBg.path,
              fit: BoxFit.cover,
              colorBlendMode: PHelperFunction.isDarkMode(context)
                  ? BlendMode.multiply
                  : BlendMode.dstATop,
              color: PHelperFunction.isDarkMode(context)
                  ? Color(0xFF252133)
                  : PAppColor.whiteColor.withOpacityExt(PAppSize.s0_6),
            ),
          ),

          // Overlay
          // Positioned.fill(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: PHelperFunction.isDarkMode(context)
          //           ? PAppColor.cardDarkColor.withOpacityExt(0.95)
          //           : null,
          //       // gradient: LinearGradient(
          //       //   colors: [
          //       //     Color(0xFFF37021),
          //       //     Color(0xFFFF3B52),
          //       //     Color(0XFFED0080),
          //       //   ],
          //       // ), //
          //     ),
          //   ),
          // ),

          // Product image
          Positioned(
            top: PAppSize.s50,
            left: PAppSize.s10,
            right: PAppSize.s10,
            bottom: PAppSize.s100,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(PAppSize.s12),
                  topRight: Radius.circular(PAppSize.s12),
                ),
                // color: Color(0xFF252133).withOpacityExt(0.97),
                image: DecorationImage(
                  image: AssetImage(highlight.image),
                  fit: BoxFit.cover,
                ),
                // gradient: LinearGradient(
                //   colors: [
                //     Color(0xFFF37021),
                //     Color(0xFFFF3B52),
                //     Color(0XFFED0080),
                //   ],
                // ), //
              ),
            ),
          ),

          // Product Overlay
          Positioned(
            top: PDeviceUtil.getDeviceHeight(context) * 0.22,
            left: PAppSize.s0,
            right: PAppSize.s0,
            bottom: PAppSize.s0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    PHelperFunction.isDarkMode(context)
                        ? Assets.images.darkBlurBg.path
                        : Assets.images.lightBlurBg.path,
                  ),
                ),
                // border: Border.all(color: Colors.red),
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Color(0X00252133),
                //     Color(0x8C252133),
                //     Color(0xFF252133),
                //     // Color(0xFF252133),
                //     Color(0xFF252133),
                //   ],
                // ), //
              ),
            ),
          ),

          // Title and description
          Positioned(
            top: PDeviceUtil.getDeviceHeight(context) * 0.42,
            left: PAppSize.s24,
            right: PAppSize.s0,
            bottom: PAppSize.s0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  highlight.heading ?? highlight.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                PAppSize.s20.verticalSpace,

                Text(
                  highlight.description ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                PAppSize.s24.verticalSpace,

                if (highlight.title != 'new_feature'.tr) ...[
                  PGradientButton(
                    label: 'quote_now'.tr.toUpperCase(),
                    textColor: PAppColor.whiteColor,
                    height: PAppSize.buttonHeightMid,
                    fontSize: PAppSize.s14,
                    width: PDeviceUtil.getDeviceWidth(context) * 0.42,
                    onTap: highlight.onQuoteTap,
                  ),

                  PAppSize.s10.verticalSpace,
                  SizedBox(
                    width: PDeviceUtil.getDeviceWidth(context) * 0.42,
                    child: TextButton.icon(
                      iconAlignment: IconAlignment.end,
                      onPressed: highlight.onLearnMoreTap,
                      label: Text(
                        'learn_more'.tr.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.textColorDark,
                          fontSize: PAppSize.s14,
                        ),
                      ),
                      icon: Assets.icons.arrowIcon.svg(
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.whiteColor
                            : PAppColor.textColorDark,
                      ),
                    ),
                  ),
                ],
              ],
            ).scrollable(),
          ),
        ],
      ).hero(tag: highlight.title),
    );
  }
}
