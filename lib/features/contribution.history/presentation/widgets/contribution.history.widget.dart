import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/contribution.history.model.dart';

class ContributionHistoryWidget extends StatelessWidget {
  const ContributionHistoryWidget({super.key, required this.transaction});

  final Transactions transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        transaction.schemeName ?? '',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: PAppSize.s0),
      subtitle: Text(
        PFormatter.formatCurrency(amount: transaction.received ?? 0),
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'successful'.tr,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: PAppColor.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
          PAppSize.s2.verticalSpace,
          Text(
            'Date: ${PFormatter.formatDate(date: DateTime.parse(transaction.paymentDate ?? DateTime.now().toIso8601String()), dateFormat: DateFormat('yyyy-MM-dd'))}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
