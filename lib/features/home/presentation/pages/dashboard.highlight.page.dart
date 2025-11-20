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

                if (highlight.title2 != 'new_feature'.tr) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
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
                      PAppSize.s8.horizontalSpace,
                      Assets.icons.arrowIcon.svg(
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.whiteColor
                            : PAppColor.textColorDark,
                      ),
                    ],
                  ).onPressed(onTap: highlight.onLearnMoreTap),
                  // SizedBox(
                  //   width: PDeviceUtil.getDeviceWidth(context) * 0.40,
                  //   child: TextButton.icon(
                  //     iconAlignment: IconAlignment.end,
                  //     onPressed: highlight.onLearnMoreTap,
                  //     label: Text(
                  //       'learn_more'.tr.toUpperCase(),
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w600,
                  //         color: PHelperFunction.isDarkMode(context)
                  //             ? PAppColor.whiteColor
                  //             : PAppColor.textColorDark,
                  //         fontSize: PAppSize.s14,
                  //       ),
                  //     ),
                  //     icon: Assets.icons.arrowIcon.svg(
                  //       color: PHelperFunction.isDarkMode(context)
                  //           ? PAppColor.whiteColor
                  //           : PAppColor.textColorDark,
                  //     ),
                  //   ),
                  // ),
                  PAppSize.s16.verticalSpace,
                  if (highlight.title != 'retirement_savings'.tr)
                    Row(
                      children: [
                        PGradientButton(
                          label: 'apply_now'.tr.toUpperCase(),
                          textColor: PAppColor.whiteColor,
                          height: PAppSize.buttonHeightMid,
                          showIcon: false,
                          fontSize: PAppSize.s14,
                          width: PDeviceUtil.getDeviceWidth(context) * 0.40,
                          onTap: () {
                            if (highlight.planDescription != null &&
                                highlight.benefits != null) {
                              showApplyModal(context, highlight);
                            }
                          },
                        ),
                        PAppSize.s8.horizontalSpace,
                        SizedBox(
                          width: PDeviceUtil.getDeviceWidth(context) * 0.42,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                width: PAppSize.s1,
                                color: PHelperFunction.isDarkMode(context)
                                    ? PAppColor.whiteColor
                                    : PAppColor.textColorDark,
                              ),
                            ),
                            onPressed: () => PHelperFunction.pop(),
                            child: Text(
                              'im_interested'.tr.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: PHelperFunction.isDarkMode(context)
                                    ? PAppColor.whiteColor
                                    : PAppColor.textColorDark,
                                fontSize: PAppSize.s16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ],
            ).scrollable(),
          ),
        ],
      ).hero(tag: highlight.title),
    );
  }

  /// Shows modal to apply for Cross Sell
  /// params ;- context
  Future<dynamic> showApplyModal(BuildContext context, Highlight highlight) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkAppBarColor
          : PAppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PAppSize.s24),
      ),
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: PAppSize.s16,
              vertical: PAppSize.s8,
            ),
            height: PDeviceUtil.getDeviceHeight(context) * 0.50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      highlight.title.split('\n').join('') ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: PAppSize.s16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CircleAvatar(
                      radius: PAppSize.s20,
                      backgroundColor: PHelperFunction.isDarkMode(context)
                          ? PAppColor.cardDarkColor
                          : PAppColor.fillColor,
                      child: Assets.icons.closeIcon.svg(
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.fillColor
                            : PAppColor.darkAppBarColor,
                      ),
                    ).onPressed(
                      onTap: PHelperFunction.pop,
                      radius: BorderRadius.circular(PAppSize.s20),
                    ),
                  ],
                ),
                // Description
                Text(
                  highlight.planDescription ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                PAppSize.s10.verticalSpace,
                // Key Benefits
                Text(
                  'key_benefits'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PAppSize.s10.verticalSpace,
                Expanded(
                  child: ListView.builder(
                    itemCount: highlight.benefits?.length,
                    itemBuilder: (context, index) {
                      final benefit = highlight.benefits![index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Assets.icons.checkIcon.svg(
                            color: PAppColor.primary,
                            width: PAppSize.s28,
                          ),
                          PAppSize.s8.horizontalSpace,
                          Expanded(
                            child: Text(
                              benefit,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                        ],
                      ).only(bottom: PAppSize.s4);
                    },
                  ),
                ),

                PAppSize.s20.verticalSpace,
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: PGradientButton(
                        label: 'apply_now'.tr,
                        showIcon: false,
                        loading: LoadingState.completed,
                        textColor: PAppColor.whiteColor,
                        width: PDeviceUtil.getDeviceWidth(context),
                        onTap: () {},
                      ),
                    ),
                    PAppSize.s8.horizontalSpace,
                    Expanded(
                      child: OutlinedButton(
                        onPressed: PHelperFunction.pop,

                        style: OutlinedButton.styleFrom(
                          foregroundColor: PAppColor.successDark,
                          side: BorderSide(color: PAppColor.successDark),
                          minimumSize: Size.fromHeight(PAppSize.buttonHeight),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(PAppSize.s24),
                          ),
                        ),
                        child: Text('contact_sales'.tr),
                      ),
                    ),
                  ],
                ),

                PAppSize.s4.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
