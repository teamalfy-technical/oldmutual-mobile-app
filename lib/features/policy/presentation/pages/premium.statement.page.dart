import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPremiumStatementPage extends StatelessWidget {
  PPremiumStatementPage({super.key});

  final vm = Get.put(PPolicyStatementVm());
  // final statementVm = Get.find<PStatementVm>();
  final statementVm = Get.put(PStatementVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('premium_statement'.tr)),
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PPageTagWidget(
              //   tag: 'statements_hint_tag'.tr,
              //   textAlign: TextAlign.center,
              // ),
              Text(
                'generate_premium_hint'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  // fontSize: PAppSize.s10,
                ),
              ),

              PAppSize.s10.verticalSpace,

              // Statements Filter Options
              PCustomCardWidget(
                padding: EdgeInsets.symmetric(
                  horizontal: PAppSize.s20,
                  vertical: PAppSize.s28,
                ),
                child: Column(
                  children: [
                    PCustomDropdownField<ContributedYear>(
                      labelText: 'select_year'.tr,
                      initialValue: vm.selectedYear,
                      items: vm.contributionYears
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.fundYear ?? ''),
                            ),
                          )
                          .toList(),
                      onChanged: vm.onYearChanged,
                    ),

                    PAppSize.s16.verticalSpace,

                    PCustomDropdownField<Policy>(
                      labelText: 'select_policy'.tr,
                      initialValue: vm.selectedPolicy,
                      items: Get.find<PPolicyVm>().policies
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.planDescription ?? ''),
                            ),
                          )
                          .toList(),
                      onChanged: vm.onSelectedPolicyReport,
                    ),

                    // PAppSize.s16.verticalSpace,
                    // DropdownButtonFormField<String>(
                    //   decoration: InputDecoration(labelText: 'select_scheme'.tr),
                    //   initialValue: 'All',
                    //   items: ['All', '2024']
                    //       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    //       .toList(),
                    //   onChanged: (val) {},
                    // ),
                    PAppSize.s16.verticalSpace,
                    PGradientButton(
                      label: 'generate_statement'.tr,
                      showIcon: false,
                      textColor: PAppColor.whiteColor,
                      radius: PAppSize.s20,
                      loading: vm.generating.value,
                      width: double.infinity,
                      height: PAppSize.s44,
                      onTap: () {
                        vm.generatePremiumStatement();
                      },
                    ),
                  ],
                ),
              ),

              PAppSize.s10.verticalSpace,

              Text(
                'premium_generated_hint'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  // fontSize: PAppSize.s10,
                ),
              ),
              PAppSize.s10.verticalSpace,

              Expanded(
                child: PCustomCardWidget(
                  padding: EdgeInsets.symmetric(
                    vertical: PAppSize.s16,
                    horizontal: PAppSize.s4,
                  ),

                  child: RefreshIndicator.adaptive(
                    onRefresh: () => vm.getAllGeneratedReports(),
                    child: vm.loading.value == LoadingState.loading
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return PStatementWidgetRedact(
                                loading: vm.loading.value,
                              );
                            },
                          ).symmetric(horizontal: PAppSize.s8)
                        : vm.statements.isEmpty
                        ? PEmptyStateWidget(message: 'no_results_found'.tr)
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount:
                                vm.statements.length, // limits to 4 safely
                            itemBuilder: (context, index) {
                              final statement = vm.statements[index];
                              return ListTile(
                                title: Text(
                                  'Policy contributions (${statement.filters?.year ?? 'All'})',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontSize: PAppSize.s14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                subtitle: Text(
                                  PFormatter.formatDate(
                                    dateFormat: DateFormat('yMMMMd'),
                                    date: DateTime.parse(
                                      statement.createdAt ??
                                          DateTime.now().toIso8601String(),
                                    ),
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontSize: PAppSize.s13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                trailing: TextButton(
                                  onPressed: () => PHelperFunction.openFileWithURL(
                                    url: statement.downloadUrl ?? '',
                                    fileName:
                                        vm.selectedYear?.fundYear == 'all'.tr
                                        ? 'All_Policy_Report.pdf'
                                        : 'Policy_${statement.filters?.year ?? ''}_Report.pdf',
                                  ),
                                  child: Text(
                                    'view_pdf'.tr,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontSize: PAppSize.s14,
                                          color: PAppColor.successMedium,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              height: 0,
                            ).symmetric(horizontal: PAppSize.s20),
                          ),
                  ),
                ),
              ),
            ],
          ).all(PAppSize.s20),
        ),
      ),
    );
  }
}
