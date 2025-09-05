import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

class HighlightWidget extends StatelessWidget {
  const HighlightWidget({super.key, required this.highlight});

  final Highlight highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(PAppSize.s4),

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [PAppColor.primaryDark, PAppColor.primary],
            ), //
          ),
          child: Container(
            height: PAppSize.s70,
            width: PAppSize.s70,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.cardDarkColor
                    : PAppColor.whiteColor,
                width: PAppSize.s3,
              ),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(highlight.image),
              ),
            ),
          ),
        ),
        PAppSize.s6.verticalSpace,
        Text(
          highlight.title,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
