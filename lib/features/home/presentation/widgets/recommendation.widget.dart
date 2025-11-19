import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class RecommendationWidget extends StatelessWidget {
  final Map<String, dynamic> recommendation;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final bool showArrowButton;
  final Function()? onTap;
  const RecommendationWidget({
    super.key,
    required this.recommendation,
    this.width,
    this.margin,
    this.onTap,
    this.height,
    this.showArrowButton = true,
  });
  // final vm = Get.put(PPolicyVm());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s18),
      margin: margin ?? EdgeInsets.only(right: PAppSize.s20),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PAppSize.s20),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
      ),
      child: Column(
        children: [
          Container(
            height: width == null
                ? PDeviceUtil.getDeviceHeight(context) * 0.2
                : PDeviceUtil.getDeviceHeight(context) * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PAppSize.s16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(recommendation['image']),
              ),
            ),
          ),
          PAppSize.s10.verticalSpace,
          Expanded(
            flex: width == null ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      recommendation['title'],
                      textAlign: TextAlign.start,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: PAppSize.s16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (showArrowButton)
                      Assets.icons.arrowRightBlack
                          .svg(
                            color: PHelperFunction.isDarkMode(context)
                                ? PAppColor.whiteColor
                                : PAppColor.blackColor,
                          )
                          .onPressed(onTap: onTap),
                  ],
                ),
                PAppSize.s4.verticalSpace,
                Text(
                  recommendation['subTitle'],
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: PAppSize.s15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).onPressed(onTap: onTap);
  }
}
