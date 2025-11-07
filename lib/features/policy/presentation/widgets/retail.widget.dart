import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class RetailWidget extends StatelessWidget {
  final Policy policy;
  final double? width;
  final EdgeInsets? margin;
  final Function()? onTap;
  RetailWidget({
    super.key,
    required this.policy,
    this.width,
    this.margin,
    this.onTap,
  });
  final vm = Get.put(PPolicyVm());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s22),
      margin: margin ?? EdgeInsets.only(right: PAppSize.s20),
      width: width ?? PDeviceUtil.getDeviceWidth(context) * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PAppSize.s20),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
      ),
      child: Column(
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
                      '${policy.planDescription}',
                      textAlign: TextAlign.start,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: PAppSize.s16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    PAppSize.s2.verticalSpace,
                    Text(
                      'You have \n${policy.dependants?.length} accounts',
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: PAppSize.s16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    PAppSize.s8.verticalSpace,

                    Assets.icons.wallet
                        .svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.blackColor,
                        )
                        .onPressed(onTap: onTap),

                    PAppSize.s8.verticalSpace,

                    Text(
                      'available_balance'.tr,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: PAppSize.s14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      PFormatter.formatCurrency(
                        amount: policy.availableBalance ?? 0,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    PAppSize.s8.verticalSpace,
                  ],
                ),
              ),
              Assets.icons.arrowRightBlack
                  .svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : PAppColor.blackColor,
                  )
                  .onPressed(onTap: onTap),
            ],
          ),
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
    ).onPressed(onTap: onTap);
  }
}
