import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class ServiceLinkWidget extends StatelessWidget {
  final String label;
  final Function()? onLinkTap;
  const ServiceLinkWidget({super.key, required this.label, this.onLinkTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s20),
      decoration: BoxDecoration(
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.fillColor,
        borderRadius: BorderRadius.circular(PAppSize.s20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.textGrayColor
                  : PAppColor.darkAppBarColor,
            ),
          ),
          Assets.icons.linkBtnIcon.svg(
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.whiteColor
                : PAppColor.darkAppBarColor,
          ),
        ],
      ),
    ).onPressed(onTap: onLinkTap, radius: BorderRadius.circular(PAppSize.s20));
  }
}
