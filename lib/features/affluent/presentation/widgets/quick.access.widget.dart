import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class QuickAccessCard extends StatelessWidget {
  const QuickAccessCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = PHelperFunction.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? PAppColor.cardDarkColor : PAppColor.whiteColor,
        borderRadius: BorderRadius.circular(PAppSize.s20),
      ),
      child:
          Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(PAppSize.s14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.fillColor.withOpacityExt(
                                  PAppSize.s0_3,
                                )
                              : PAppColor.primary.withOpacityExt(PAppSize.s0_3),
                          width: PAppSize.s1,
                        ),
                      ),
                      child: icon,
                    ),
                  ),
                  PAppSize.s18.verticalSpace,
                  Text(
                    label,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: PAppSize.s15,
                      height: 1.5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
              .paddingAll(PAppSize.s25)
              .onPressed(
                onTap: onTap,
                radius: BorderRadius.circular(PAppSize.s20),
              ),
    );
  }
}
