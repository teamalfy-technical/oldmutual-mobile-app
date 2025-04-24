import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomCheckbox extends StatelessWidget {
  final Widget child;
  final bool value;
  final double scale;
  final Function(bool?)? onChanged;
  final Direction checkboxDirection;
  final BorderSide? side;
  final WidgetStateProperty<Color?>? fillColor;
  const PCustomCheckbox({
    super.key,
    required this.child,
    required this.onChanged,
    required this.value,
    this.scale = PAppSize.s1,
    this.checkboxDirection = Direction.left,
    this.side,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return checkboxDirection == Direction.left
        ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: scale,
              child: Checkbox(
                side: side,
                value: value,
                onChanged: onChanged,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                fillColor: fillColor,
              ),
            ),
            PAppSize.s8.horizontalSpace,
            Expanded(child: child),
          ],
        )
        : Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Expanded(child: child),
            PAppSize.s2.horizontalSpace,
            Transform.scale(
              scale: scale,
              child: Checkbox(
                side: side,
                value: value,
                onChanged: onChanged,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                fillColor: fillColor,
              ),
            ),
          ],
        );
  }
}
