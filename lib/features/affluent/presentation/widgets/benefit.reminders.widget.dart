import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';

class PBenefitRemindersWidget extends StatelessWidget {
  final BenefitReminder reminder;
  const PBenefitRemindersWidget({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s25),
      // margin: EdgeInsets.only(bottom: PAppSize.s25),
      decoration: BoxDecoration(
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.cardDarkColor
            : PAppColor.whiteColor,
        borderRadius: BorderRadius.circular(PAppSize.s20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reminder.title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: PAppSize.s16,
              fontWeight: FontWeight.w700,
            ),
          ),
          PAppSize.s8.verticalSpace,
          Text(
            reminder.description,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: PAppSize.s15,
              fontWeight: FontWeight.w600,
            ),
          ),
          PAppSize.s8.verticalSpace,
          Text(
            reminder.createdAt.difference(DateTime.now()).inDays > 3
                ? 'available'.tr
                : 'expires_soon'.tr,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w600,
              color: reminder.createdAt.difference(DateTime.now()).inDays > 3
                  ? PAppColor.primaryBorderColor
                  : PAppColor.alert100,
            ),
          ),
        ],
      ),
    );
  }
}
