import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.leading,
    required this.trailing,
    required this.title,
    required this.padding,
    this.onTap,
  });

  final Function()? onTap;
  final Widget leading;
  final Widget trailing;
  final Widget title;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [leading, PAppSize.s10.horizontalSpace, title]),
          trailing,
        ],
      ),
    ).onPressed(
      onTap: onTap,
      radius: BorderRadius.only(
        topLeft: Radius.circular(PAppSize.s20),
        topRight: Radius.circular(PAppSize.s20),
        bottomLeft: Radius.circular(PAppSize.s20),
        bottomRight: Radius.circular(PAppSize.s20),
      ),
    );
  }
}
