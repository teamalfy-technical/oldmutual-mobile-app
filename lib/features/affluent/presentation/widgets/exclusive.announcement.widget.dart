import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PExclusiveWidget extends StatelessWidget {
  const PExclusiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s25),
      margin: EdgeInsets.only(bottom: PAppSize.s25),
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
            'New Premium Wellness Program',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: PAppSize.s16,
              fontWeight: FontWeight.w700,
            ),
          ),
          PAppSize.s10.verticalSpace,
          Text(
            'Access to exclusive wellness retreats and personalized...',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: PAppSize.s15,

              fontWeight: FontWeight.w600,
            ),
          ),
          PAppSize.s10.verticalSpace,
          Text(
            '24 Feb 2023 • 13:56',
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
