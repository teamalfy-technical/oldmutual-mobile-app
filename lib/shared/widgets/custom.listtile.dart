import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const PCustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        PAppSize.s12.verticalSpace,
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ).symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s0);
  }
}
