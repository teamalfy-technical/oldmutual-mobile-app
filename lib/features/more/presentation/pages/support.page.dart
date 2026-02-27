import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/more/more.services.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class PSupportPage extends StatelessWidget {
  const PSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('help'.tr)),
      body: SafeArea(
        child: Column(
          children: [
            // Personal Details
            Container(
              padding: EdgeInsets.symmetric(
                vertical: PAppSize.s8,
                horizontal: PAppSize.s8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PAppSize.s20),
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.darkAppBarColor
                    : PAppColor.whiteColor,
                border: Border.all(
                  width: PAppSize.s1,
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.transparentColor
                      : PAppColor.fillColor2,
                ),
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: PAppColor.transparentColor),
                child: ExpansionTile(
                  title: Text(
                    'app_support'.tr,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: PAppSize.s14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child:
                          Text(
                            'operating_hours'.tr,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ).symmetric(
                            horizontal: PAppSize.s14,
                            vertical: PAppSize.s20,
                          ),
                    ),

                    PMoreListTitle(
                      title: 'monday_to_friday'.tr,
                      subTitle: '08:00AM to 5:00PM',
                    ).symmetric(horizontal: PAppSize.s14),

                    PAppSize.s8.verticalSpace,

                    Text(
                      'close_on_msg'.tr,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: PAppSize.s14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ).symmetric(horizontal: PAppSize.s14),

                    PAppSize.s8.verticalSpace,

                    PMoreListTitle(
                      title: 'call_support'.tr,
                      subTitle: PAppConstant.phoneSupport,
                      trailing: Assets.icons.callIcon.svg(
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.whiteColor
                            : PAppColor.darkAppBarColor,
                      ),
                      onTap: () async {
                        final uri = Uri(
                          scheme: 'tel',
                          path: PAppConstant.phoneSupport,
                        );
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                    ).symmetric(horizontal: PAppSize.s14),
                    Divider(
                      height: PAppSize.s1,
                    ).symmetric(horizontal: PAppSize.s14),
                    PMoreListTitle(
                      title: 'email_support'.tr,
                      subTitle: PAppConstant.emailSupport,
                      trailing: Assets.icons.emailIcon.svg(
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.whiteColor
                            : PAppColor.darkAppBarColor,
                      ),
                      onTap: () async {
                        final uri = Uri(
                          scheme: 'mailto',
                          path: PAppConstant.emailSupport,
                        );
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                    ).symmetric(horizontal: PAppSize.s14),
                    Divider(
                      height: PAppSize.s1,
                    ).symmetric(horizontal: PAppSize.s14),
                    PAppSize.s14.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ).all(PAppSize.s20),
      ),
    );
  }
}
