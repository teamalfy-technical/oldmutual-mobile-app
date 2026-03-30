import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PMoreListTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final bool isLoading;
  final Function()? onTap;
  const PMoreListTitle({
    super.key,
    required this.title,
    required this.subTitle,
    this.leading,
    this.trailing,
    this.contentPadding,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: isLoading,
      child: ListTile(
        onTap: onTap,
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
      ),
    );
  }
}
