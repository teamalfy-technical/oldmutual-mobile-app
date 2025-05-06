import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PRadioListTileWidget<T> extends StatelessWidget {
  final String label;
  final T value;
  final T? groupValue;
  final double fontSize;
  final Function(T?)? onChanged;

  const PRadioListTileWidget({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.fontSize = PAppSize.s14,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio<T>(value: value, groupValue: groupValue, onChanged: onChanged),
        PAppSize.s4.horizontalSpace,
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: PAppColor.blackColor,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
