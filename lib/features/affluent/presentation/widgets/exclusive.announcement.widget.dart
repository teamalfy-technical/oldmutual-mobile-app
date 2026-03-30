import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';

class PExclusiveWidget extends StatelessWidget {
  final BenefitReminder announcement;
  const PExclusiveWidget({super.key, required this.announcement});

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
            announcement.title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: PAppSize.s16,
              fontWeight: FontWeight.w700,
            ),
          ),
          PAppSize.s10.verticalSpace,
          Text(
            announcement.description,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: PAppSize.s15,

              fontWeight: FontWeight.w600,
            ),
          ),
          PAppSize.s10.verticalSpace,
          Text(
            PFormatter.formatDate(
              dateFormat: DateFormat('dd MMM yyyy • HH:mm'),
              date: announcement.createdAt,
            ),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: PAppSize.s15,

              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
