import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PContributionsPage extends StatelessWidget {
  PContributionsPage({super.key});

  final contributionVm = Get.find<PContributionHistoryVm>();

  Future showFilterModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(PAppSize.s24),
          topRight: Radius.circular(PAppSize.s24),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(PAppSize.s20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PAppSize.s20),
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.darkBgColor
                : PAppColor.fillColor,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PAppSize.s16.verticalSpace,
                PSeeAllWidget(
                  leadingText: 'filter'.tr,
                  leadingFontSize: PAppSize.s20,
                  trailing: Text(
                    'done'.tr,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: PAppSize.s16,
                      color: PAppColor.successMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => PHelperFunction.pop(),
                ),
                PAppSize.s8.verticalSpace,
                Text(
                  'year'.tr,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: PAppSize.s16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PAppSize.s8.verticalSpace,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: PHelperFunction.isDarkMode(context)
                          ? null
                          : Border.all(
                              width: PAppSize.s1,
                              color: PAppColor.fillColor2,
                            ),
                      borderRadius: BorderRadius.circular(PAppSize.s20),
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.darkAppBarColor
                          : PAppColor.whiteColor,
                    ),
                    child: ListView.separated(
                      itemCount: contributionVm.contributionYears.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final contributedYear =
                            contributionVm.contributionYears[index];
                        return ListTile(
                          onTap: () async {
                            PHelperFunction.pop();
                            contributionVm.onYearChanged(contributedYear);
                            await contributionVm.filterContributions();
                          },
                          title: Text(
                            contributedYear.fundYear ?? '2020',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s15,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(
        title: Text('contributions'.tr),
        actions: [
          IconButton(
            onPressed: () => showFilterModal(context),
            icon: Assets.icons.filter.svg(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.blackColor,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: PCustomCardWidget(
                padding: EdgeInsets.symmetric(
                  vertical: PAppSize.s16,
                  horizontal: PAppSize.s4,
                ),

                child: contributionVm.loading.value == LoadingState.loading
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ContributionHistoryWidgetRedact(
                            loadingState: contributionVm.loading.value,
                          );
                        },
                      )
                    : (contributionVm
                                  .history
                                  .value
                                  .transactionHistory
                                  ?.transactions
                                  ?.where((e) => e.paymentFlag != 'B')
                                  .toList() ??
                              [])
                          .isEmpty
                    ? PEmptyStateWidget(message: 'no_results_found'.tr)
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: contributionVm
                            .history
                            .value
                            .transactionHistory!
                            .transactions!
                            .length,
                        itemBuilder: (context, index) {
                          final contribution = contributionVm
                              .history
                              .value
                              .transactionHistory
                              ?.transactions![index];
                          return ListTile(
                            title: Text(
                              contribution?.schemeName ?? '',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s14,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            subtitle: Text(
                              PFormatter.formatDate(
                                dateFormat: DateFormat('yMMMMd'),
                                date: DateTime.parse(
                                  contribution?.paymentDate ??
                                      DateTime.now().toIso8601String(),
                                ),
                              ),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontSize: PAppSize.s13,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            trailing: Text(
                              PFormatter.formatCurrency(
                                amount: contribution?.received ?? 0,
                              ),
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s14,
                                    color: PAppColor.successMedium,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider().symmetric(horizontal: PAppSize.s20),
                      ),
              ),
            ),
            (PDeviceUtil.getDeviceHeight(context) * 0.08).verticalSpace,
          ],
        ).all(PAppSize.s20),
      ),
    );
  }
}
