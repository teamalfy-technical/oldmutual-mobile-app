import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PAffluentMemberCard extends StatelessWidget {
  const PAffluentMemberCard({
    super.key,
    required this.memberName,
    this.cardNumber,
    this.memberSince,
    this.relationshipOfficer,
    this.gradientColors,
    this.onTap,
  });

  final String memberName;
  final String? cardNumber;
  final String? memberSince;
  final String? relationshipOfficer;
  final List<Color>? gradientColors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = PHelperFunction.isDarkMode(context);
    final colors =
        gradientColors ?? [const Color(0xFFD4AF37), const Color(0xFFF4E5B0)];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PAppSize.s20),
        boxShadow: [
          BoxShadow(
            color: PAppColor.blackColor.withOpacityExt(0.14),
            blurRadius: 3,
            spreadRadius: 0,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: PAppColor.blackColor.withOpacityExt(0.14),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.all(PAppSize.s2),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? PAppColor.cardDarkColor : PAppColor.whiteColor,
          borderRadius: BorderRadius.circular(PAppSize.s18),
        ),
        padding: EdgeInsets.all(PAppSize.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Member Info + Logomark
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Member Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'affluent_member_card'.tr,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: PAppSize.s16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      PAppSize.s8.verticalSpace,
                      Text(
                        memberName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: PAppSize.s16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (cardNumber != null) ...[
                        PAppSize.s4.verticalSpace,
                        Text(
                          '${'ghana_card_no'.tr} $cardNumber',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: PAppSize.s14,
                                fontWeight: FontWeight.w500,
                                color: PAppColor.primary,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Right: Logomark Icon
                Assets.icons.logomark.svg(
                  width: PAppSize.s40,
                  height: PAppSize.s40,
                ),
              ],
            ),

            PAppSize.s16.verticalSpace,

            // Divider
            Divider(
              color: isDarkMode
                  ? PAppColor.greyColor.withOpacityExt(PAppSize.s0_3)
                  : PAppColor.greyColor.withOpacityExt(PAppSize.s0_2),
              thickness: PAppSize.s1,
              height: PAppSize.s1,
            ),

            PAppSize.s16.verticalSpace,

            // Bottom Row: Member Since & Your RO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Column 1: Member Since
                if (memberSince != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'member_since'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: PAppSize.s14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      PAppSize.s2.verticalSpace,
                      Text(
                        memberSince!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: PAppSize.s16,
                          fontWeight: FontWeight.w500,
                          color: PAppColor.primary,
                        ),
                      ),
                    ],
                  ),

                // Column 2: Your RO
                if (relationshipOfficer != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'your_ro'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: PAppSize.s14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      PAppSize.s2.verticalSpace,
                      Text(
                        relationshipOfficer!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: PAppSize.s14,
                          fontWeight: FontWeight.w500,
                          color: PAppColor.primary,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    ).onPressed(onTap: onTap);
  }
}
