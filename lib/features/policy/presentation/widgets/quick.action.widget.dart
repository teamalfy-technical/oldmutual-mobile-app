import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class QuickActionWidget extends StatelessWidget {
  final String label;
  final Widget icon;
  final Function()? onTap;
  const QuickActionWidget({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: PDeviceUtil.getDeviceWidth(context) * 0.32,
      height: PDeviceUtil.getDeviceHeight(context) * 0.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PAppSize.s20),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
      ),
      child:
          Column(
                children: [
                  icon,

                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: PAppSize.s11,
                          fontWeight: FontWeight.w500,
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.successLight
                              : PAppColor.successDark,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              )
              .symmetric(vertical: PAppSize.s16, horizontal: PAppSize.s28)
              .onPressed(
                onTap: onTap,
                radius: BorderRadius.circular(PAppSize.s20),
              ),
    );
  }
}
