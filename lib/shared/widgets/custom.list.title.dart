import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.title, this.subtitle});
  final String title;

  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: PAppSize.s16,
          fontWeight: subtitle != null ? FontWeight.w500 : FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle ?? 'not_applicable'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s14,
                fontWeight: FontWeight.w400,
              ),
            )
          : null,
    );
  }
}
