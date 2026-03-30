import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PPasswordCheckerWidget extends StatelessWidget {
  final String label;
  final bool isValid;
  const PPasswordCheckerWidget({
    super.key,
    required this.label,
    this.isValid = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isValid
            ? Assets.icons.checkIcon.svg()
            : Icon(Icons.close, size: PAppSize.s16, color: PAppColor.redColor),
        PAppSize.s5.horizontalSpace,
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.text200
                : PAppColor.text300,
            fontSize: PAppSize.s12,
          ),
        ),
      ],
    );
  }
}
