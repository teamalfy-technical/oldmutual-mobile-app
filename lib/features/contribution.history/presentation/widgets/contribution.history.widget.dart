import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

class ContributionHistoryWidget extends StatelessWidget {
  const ContributionHistoryWidget({super.key, required this.history});

  final Map<String, dynamic> history;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        history['title'] ?? '',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ).redacted(context: context, redact: false),
      contentPadding: EdgeInsets.symmetric(horizontal: PAppSize.s0),
      subtitle: Text(
        '\$${history['amount']}',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
      ).redacted(context: context, redact: false),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            history['status'] ? 'successful'.tr : 'unsuccessful'.tr,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: history['status'] ? PAppColor.primary : PAppColor.redColor,
              fontWeight: FontWeight.w400,
            ),
          ).redacted(context: context, redact: false),
          PAppSize.s2.verticalSpace,
          Text(
            'Date: ${PFormatter.formatDate(date: DateTime.parse(history['date'] ?? DateTime.now().toIso8601String()), dateFormat: DateFormat('yyyy-MM-dd'))}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
          ).redacted(context: context, redact: false),
        ],
      ),
    );
  }
}
