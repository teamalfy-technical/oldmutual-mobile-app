import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PRelationshipOfficerCard extends StatelessWidget {
  final Member? user;
  const PRelationshipOfficerCard({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return user?.affluent == true
        ? Container(
            padding: EdgeInsets.all(PAppSize.s16),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PAppSize.s20),
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.darkAppBarColor
                  : PAppColor.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Office Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'your_relationship_officer'.tr,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: PAppSize.s14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Sarah Osei',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: PAppSize.s16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                ctaButton(
                  context: context,
                  onTap: () {},
                  icon: Assets.icons.call.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : PAppColor.primary,
                  ),
                ),
                PAppSize.s8.horizontalSpace,
                ctaButton(
                  context: context,
                  onTap: () {},
                  icon: Assets.icons.chat.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : PAppColor.primary,
                  ),
                ),

                PAppSize.s8.horizontalSpace,
                ctaButton(
                  context: context,
                  onTap: () {},
                  icon: Assets.icons.mail.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : PAppColor.primary,
                  ),
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  Widget ctaButton({
    required BuildContext context,
    required Function()? onTap,
    required Widget icon,
  }) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: PAppSize.s1,
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.whiteColor
              : PAppColor.primary,
        ),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
      ),
      child: icon.onPressed(onTap: onTap),
    );
  }
}
