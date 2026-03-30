import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class LivenessInstructionWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final String desc;
  const LivenessInstructionWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        PAppSize.s2.verticalSpace,
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          desc,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: PHelperFunction.isDarkMode(context)
                ? Color(0xFFE2E2E2)
                : PAppColor.textColorDark,

            fontSize: PAppSize.s12,
          ),
        ),
      ],
    );
  }
}
