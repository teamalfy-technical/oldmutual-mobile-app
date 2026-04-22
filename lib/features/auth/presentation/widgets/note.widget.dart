import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class NoteWidget extends StatelessWidget {
  final String? title;
  final String description;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;
  const NoteWidget({
    super.key,
    this.title,
    required this.description,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s18),
      decoration: BoxDecoration(
        color: color ?? Color(0xFFFFF8E8),
        borderRadius: borderRadius ?? BorderRadius.circular(PAppSize.s8),
        border: Border.all(
          width: PAppSize.s1,
          color: borderColor ?? Color(0xFFFDDB8B),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title ?? '',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: PAppColor.text700,
              ),
            ),
            PAppSize.s8.verticalSpace,
          ],

          Text(
            description,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textColor ?? PAppColor.darkAppBarColor,
              fontSize: PAppSize.s14,
            ),
          ),
        ],
      ),
    );
  }
}
