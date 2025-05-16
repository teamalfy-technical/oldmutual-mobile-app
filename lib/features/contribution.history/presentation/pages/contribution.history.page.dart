import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PContributionHistoryPage extends StatelessWidget {
  PContributionHistoryPage({super.key});

  final ctrl = Get.put(PContributionHistoryVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('contribution_history'.tr)),
      body: Obx(
        () => Column(
          children: [
            PPageTagWidget(
              tag: 'contribution_history_tag'.tr,
              textAlign: TextAlign.center,
            ),

            // Filter
            Expanded(
              child: Column(
                children: [
                  GetBuilder<PContributionHistoryVm>(
                    builder: (ctrl) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: PCustomDropdown<ContributedYear>(
                              label: 'filter_by_year'.tr,
                              value: ctrl.selectedYear,
                              onChanged: ctrl.onYearChanged,
                              items: ctrl.contributionYears,
                            ),
                          ),

                          PAppSize.s20.horizontalSpace,

                          Expanded(
                            child: PCustomDropdown<String>(
                              label: 'filter_by_month'.tr,
                              value: ctrl.selectedMonth,
                              onChanged: ctrl.onMonthChanged,
                              items: ctrl.contributionMonths,
                            ),
                          ),

                          PAppSize.s18.horizontalSpace,

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'clear_filters'.tr,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: PAppColor.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: PAppColor.primary,
                                  //  fontSize: PAppSize.s13,
                                ),
                              ).onPressed(onTap: () => ctrl.resetFilters()),
                              PAppSize.s4.verticalSpace,
                              PGradientButton(
                                label: 'apply'.tr,
                                showIcon: false,
                                radius: PAppSize.s5,
                                width:
                                    PDeviceUtil.getDeviceWidth(context) * 0.28,
                                onTap: () => ctrl.filterContributions(),
                              ),
                            ],
                          ),

                          // PCustomCheckbox(
                          //   value: ctrl.all.value,
                          //   scale: PAppSize.s1_3,
                          //   onChanged: ctrl.onAllChanged,
                          //   checkboxDirection: Direction.right,
                          //   child: Text(
                          //     'all'.tr,
                          //     style: Theme.of(context).textTheme.headlineSmall
                          //         ?.copyWith(fontWeight: FontWeight.w400),
                          //   ),
                          // ),
                        ],
                      );
                    },
                  ),

                  PAppSize.s25.verticalSpace,

                  Expanded(
                    child:
                        ctrl.loading.value == LoadingState.loading
                            ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ContributionHistoryWidgetRedact(
                                  loadingState: ctrl.loading.value,
                                );
                              },
                            )
                            : ctrl
                                .history
                                .value
                                .transactionHistory!
                                .transactions!
                                .where((e) => e.paymentFlag != 'B')
                                .toList()
                                .isEmpty
                            ? PEmptyStateWidget(message: 'no_results_found'.tr)
                            : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  ctrl
                                      .history
                                      .value
                                      .transactionHistory
                                      ?.transactions
                                      ?.length,
                              itemBuilder: (context, index) {
                                final transaction =
                                    ctrl
                                        .history
                                        .value
                                        .transactionHistory!
                                        .transactions![index];
                                return ContributionHistoryWidget(
                                  transaction: transaction,
                                );
                              },
                            ),
                  ),
                ],
              ).all(PAppSize.s20),
            ),
          ],
        ),
      ),
    );
  }
}
