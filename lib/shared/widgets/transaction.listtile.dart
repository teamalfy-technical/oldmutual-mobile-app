import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PTransactionListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Function()? onTap;

  const PTransactionListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: PAppSize.s14,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: PAppSize.s13,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: trailing,
    );
  }
}
