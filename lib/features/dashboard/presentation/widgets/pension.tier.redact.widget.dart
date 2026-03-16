import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

class PensionTierRedactWidget extends StatelessWidget {
  final Function()? onTap;
  final LoadingState loading;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  const PensionTierRedactWidget({
    super.key,
    this.onTap,
    required this.loading,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s22),
      margin: margin ?? EdgeInsets.only(right: PAppSize.s20),
      height: height,
      width: width ?? PDeviceUtil.getDeviceWidth(context) * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PAppSize.s20),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '******************',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: PAppSize.s16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    PAppSize.s2.verticalSpace,
                    Text(
                      'You have \n** schemes',
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: PAppSize.s16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    PAppSize.s8.verticalSpace,
                    Container(
                      width: PAppSize.s36,
                      height: PAppSize.s36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.whiteColor
                            : PAppColor.blackColor,
                      ),
                    ),
                    PAppSize.s8.verticalSpace,
                  ],
                ),
              ),
              Container(
                width: PAppSize.s20,
                height: PAppSize.s20,
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.whiteColor
                    : PAppColor.blackColor,
              ),
            ],
          ),
          Text(
            '**************',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'GHS *,***.**',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          PAppSize.s8.verticalSpace,
          SizedBox(
            width: double.infinity,
            child: Divider(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.successLight
                  : PAppColor.successDark,
              thickness: PAppSize.s4,
            ),
          ),
        ],
      ),
    ).redacted(
      context: context,
      redact: loading == LoadingState.loading,
    );
  }
}
