import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PMoreListTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  const PMoreListTitle({
    super.key,
    required this.title,
    required this.subTitle,
    this.leading,
    this.trailing,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      contentPadding:
          contentPadding ?? EdgeInsets.symmetric(horizontal: PAppSize.s0),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: PAppSize.s14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: PAppSize.s14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: trailing,
    );
  }
}
