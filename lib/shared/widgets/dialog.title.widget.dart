import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PDialogTitleWidget extends StatelessWidget {
  final String title;
  final Function()? onClose;
  const PDialogTitleWidget({super.key, required this.title, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: PAppSize.s16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Assets.icons.closeIcon
            .svg(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.blackColor,
            )
            .onPressed(onTap: onClose),
      ],
    );
  }
}
