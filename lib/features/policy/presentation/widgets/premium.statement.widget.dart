import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';

class PPremiumStatementWidget extends StatelessWidget {
  const PPremiumStatementWidget({
    super.key,
    required this.statement,
    this.selectedYear,
  });

  final PolicyReport statement;
  final ContributedYear? selectedYear;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Policy contributions (${statement.filters?.year ?? 'All'})',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: PAppSize.s14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        PFormatter.formatDate(
          dateFormat: DateFormat('yMMMMd'),
          date: DateTime.parse(
            statement.createdAt ??
                statement.updatedAt ??
                DateTime.now().toIso8601String(),
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: PAppSize.s13,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: TextButton(
        onPressed: () => PHelperFunction.openFileWithURL(
          url: statement.downloadUrl ?? '',
          fileName: selectedYear?.fundYear == 'all'.tr
              ? 'All_Policy_Report.pdf'
              : 'Policy_${statement.filters?.year ?? ''}_Report.pdf',
        ),
        child: Text(
          'view_pdf'.tr,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s14,
            color: PAppColor.successMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
