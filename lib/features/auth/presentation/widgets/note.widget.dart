import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class NoteWidget extends StatelessWidget {
  final String title;
  final String description;
  const NoteWidget({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s18),
      decoration: BoxDecoration(
        color: Color(0xFFFFF8E8),
        borderRadius: BorderRadius.circular(PAppSize.s8),
        border: Border.all(width: PAppSize.s1, color: Color(0xFFFDDB8B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: PAppColor.text700,
            ),
          ),
          PAppSize.s8.verticalSpace,
          Text(
            description,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: PAppColor.darkAppBarColor,
              fontSize: PAppSize.s14,
            ),
          ),
        ],
      ),
    );
  }
}
