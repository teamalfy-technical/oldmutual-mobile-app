import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:redacted/redacted.dart';

class PHomeView extends StatelessWidget {
  PHomeView({super.key});

  final ctrl = Get.put(PContributionHistoryVm());

  List<String> xLabels = [];

  // List<FlSpot> convertToSpots() {
  //   final data = getLastFiveMonthlyTransactions();
  //   return List.generate(data.length, (index) {
  //     double y = double.parse(data[index].received?.toStringAsFixed(2) ?? '0');
  //     final x = DateTime.parse(
  //       data[index].paymentDate ?? DateTime.now().toIso8601String(),
  //     );
  //     xLabels.add(
  //       ' ${PHelperFunction.monthAbbr(x.month)}-${x.year}',
  //     ); // e.g., Jan-2024
  //     // pensionAppLogger.e(y);
  //     return FlSpot(index.toDouble(), y);
  //   });
  // }

  List<FlSpot> convertToSpots() {
    final data = ctrl.contributions;
    return List.generate(data.length, (index) {
      double y = double.parse(
        data[index].mainCurrentValue?.toStringAsFixed(2) ?? '0',
      );

      xLabels.add(data[index].month ?? ''); // e.g., Jan-2024
      // pensionAppLogger.e(y);
      return FlSpot(index.toDouble(), y);
    });
  }

  List<FlSpot> getMonthlyChangeSpots() {
    final data = ctrl.contributions;
    return List.generate(data.length, (i) {
      return FlSpot(i.toDouble(), data[i].monthlyChange ?? 0);
    });
  }

  // double get interval {
  //   final data = getLastFiveMonthlyTransactions();
  //   final contribution = data.map((s) => s.received ?? 0).toList();
  //   double maxValue = contribution.reduce((a, b) => a > b ? a : b);
  //   // Determine a nice dynamic interval
  //   double interval = maxValue / 5;
  //   // Round interval to nearest 5 for nicer ticks
  //   return (interval / 5).ceil() * 5;
  // }

  double get interval {
    // final data = getLastFiveMonthlyTransactions();
    final data = ctrl.contributions;
    final contribution = data.map((s) => s.mainCurrentValue ?? 0).toList();
    double maxValue = contribution.reduce((a, b) => a > b ? a : b);
    // Determine a nice dynamic interval
    double interval = maxValue / 5;
    // Round interval to nearest 5 for nicer ticks
    return (interval / 5).ceil() * 5;
  }

  List<Transactions> getLastFiveMonthlyTransactions() {
    final data = ctrl.history.value.transactionHistory!.transactions!;
    // Parse and sort the data by payment_date in descending order

    data.sort(
      (a, b) => DateTime.parse(
        b.paymentDate ?? '',
      ).compareTo(DateTime.parse(a.paymentDate ?? '')),
    );

    // Set to keep track of unique "YYYY-MM" strings we've already included
    final Set<String> seenMonths = {};

    // List to store the final 5 unique-month transactions

    final List<Transactions> latestMonthlyTransactions = [];

    // Loop through sorted data
    for (var txn in data) {
      final date = DateTime.parse(txn.paymentDate ?? '');
      // Create a string key like "2024-01" for uniqueness
      final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';

      // If this month is not already in our set, add it
      if (!seenMonths.contains(monthKey)) {
        seenMonths.add(monthKey);
        latestMonthlyTransactions.add(txn);
      }

      // Stop once we have 5 unique months
      if (latestMonthlyTransactions.length == 5) {
        break;
      }
    }

    //Now sort the final 5 by paymentAmount ascending
    latestMonthlyTransactions.sort((a, b) {
      final aAmount = a.received ?? 0;
      final bAmount = b.received ?? 0;
      return aAmount.compareTo(bAmount);
    });

    return latestMonthlyTransactions;
  }

  List<Transactions> filterLatestContributionsPerMonth(
    // List<Map<String, dynamic>> data,
  ) {
    final Map<String, Transactions> uniqueContributions = {};

    final data =
        ctrl.history.value.transactionHistory!.transactions!.take(5).toList();

    for (var item in data) {
      final date = DateTime.parse(item.paymentDate ?? '');
      final key = '${date.year}-${date.month.toString().padLeft(2, '0')}';

      final existing = uniqueContributions[key];
      final currentValue = item.received ?? 0;

      // Keep the higher or latest contribution for that month
      if (existing == null) {
        uniqueContributions[key] = item;
      } else {
        final existingValue = existing.received ?? 0;
        if (currentValue > existingValue) {
          uniqueContributions[key] = item;
        }
      }
    }

    return uniqueContributions.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Column(
            children: [
              Container(
                width: PDeviceUtil.getDeviceWidth(context),
                // height: PDeviceUtil.getDeviceHeight(context) / 4.0,
                height: PDeviceUtil.getDeviceHeight(context) * 0.27,
                decoration: BoxDecoration(color: PAppColor.blackColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${'welcome'.tr}, ${PSecureStorage().getAuthResponse()?.name ?? ''}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: PAppColor.whiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    PAppSize.s6.verticalSpace,
                    Text(
                      '${PSecureStorage().getAuthResponse()?.schemeType}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: PAppColor.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: PAppSize.s14,
                      ),
                    ),
                    PAppSize.s6.verticalSpace,
                    Text(
                      PSecureStorage().getAuthResponse()?.employerName ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: PAppColor.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: PAppSize.s12,
                      ),
                    ),
                    PAppSize.s14.verticalSpace,
                    Text(
                      'view_all_schemes'.tr,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: PAppColor.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: PAppColor.primary,
                        fontSize: PAppSize.s13,
                      ),
                    ).onPressed(
                      onTap:
                          () => PHelperFunction.switchScreen(
                            destination: Routes.dashboardPage,
                          ),
                    ),
                  ],
                ),
              ),
              // PAppSize.s6.verticalSpace,
              Expanded(
                child: Container(
                  color: PAppColor.whiteColor.withOpacityExt(PAppSize.s0_5),
                  child: Opacity(
                    opacity: PAppSize.s0_3,
                    child: Image.asset(
                      Assets.images.dashboardBg.path,
                      fit: BoxFit.cover,
                      width: PDeviceUtil.getDeviceWidth(context),
                      height: PDeviceUtil.getDeviceHeight(context) * 0.75,
                      colorBlendMode: BlendMode.dstATop,
                      color: PAppColor.whiteColor.withOpacityExt(
                        PAppSize.s0_6,
                      ), // Adjust opacity
                    ),
                  ),
                ),
              ),
            ],
          ),

          Positioned.fill(
            top: PDeviceUtil.getDeviceHeight(context) / 4.8,
            left: PAppSize.s16,
            right: PAppSize.s16,
            child:
                Column(
                  children: [
                    // Align(
                    //   alignment: Alignment.bottomLeft,
                    //   child: Text(
                    //     'View All Schemes',
                    //     textAlign: TextAlign.start,
                    //     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    //       color: PAppColor.primary,
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: PAppSize.s12,
                    //     ),
                    //   ).onPressed(
                    //     onTap:
                    //         () => PHelperFunction.switchScreen(
                    //           destination: Routes.dashboardPage,
                    //         ),
                    //   ),
                    // ),
                    PAppSize.s6.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(PAppSize.s14),
                      margin: EdgeInsets.only(bottom: PAppSize.s25),
                      width: PDeviceUtil.getDeviceWidth(context),
                      decoration: BoxDecoration(
                        color: PAppColor.blackColor,
                        borderRadius: BorderRadius.circular(PAppSize.s10),
                        border: Border.all(
                          width: PAppSize.s0_8,
                          color: PAppColor.whiteColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(PAppSize.s0, PAppSize.s2),
                            blurRadius: PAppSize.s4,
                            spreadRadius: PAppSize.s0,
                            color: PAppColor.greyColorShade300,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'total_contribution'.tr,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: PAppColor.text50),
                          ).redacted(
                            context: context,
                            redact:
                                ctrl.loading.value == LoadingState.loading
                                    ? true
                                    : false,
                          ),
                          PAppSize.s4.verticalSpace,
                          Text(
                            // ctrl.summmary.value.totalContributions.toString(),
                            PFormatter.formatCurrency(
                              amount: ctrl.summmary.value.mainCurrentValue ?? 0,
                            ),
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: PAppColor.whiteColor,
                              fontSize: PAppSize.s18,
                            ),
                          ).redacted(
                            context: context,
                            redact:
                                ctrl.loading.value == LoadingState.loading
                                    ? true
                                    : false,
                          ),
                          PAppSize.s4.verticalSpace,
                          if (ctrl.summmary.value.lastContributionDate != null)
                            Text(
                              'Last contribution date ${PFormatter.formatDate(dateFormat: DateFormat('dd/MM/yyyy'), date: DateTime.parse(ctrl.summmary.value.lastContributionDate ?? DateTime.now().toIso8601String()))}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                fontSize: PAppSize.s14,
                                color: PAppColor.text100,
                              ),
                            ).redacted(
                              context: context,
                              redact:
                                  ctrl.loading.value == LoadingState.loading
                                      ? true
                                      : false,
                            ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PHomeStatsWidget(
                            title: 'accrued_interest'.tr,
                            loading: ctrl.loading.value,
                            subTitle: PFormatter.formatCurrency(
                              amount: ctrl.summmary.value.totalInterest ?? 0,
                            ),
                            onTap: () {},
                          ),
                        ),
                        PAppSize.s16.horizontalSpace,
                        Expanded(
                          child: PHomeStatsWidget(
                            title: 'total_redemptions'.tr,
                            loading: ctrl.loading.value,
                            subTitle: PFormatter.formatCurrency(
                              amount: ctrl.summmary.value.totalRedemption ?? 0,
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    PAppSize.s24.verticalSpace,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'contribution_progress'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: PAppSize.s14,
                          fontWeight: FontWeight.w600,
                          color: PAppColor.text700,
                        ),
                      ).symmetric(horizontal: PAppSize.s0),
                    ),
                    PAppSize.s16.verticalSpace,
                    //  line chart
                    ctrl.loading.value == LoadingState.loading
                        ? PChartRedactWidget(loadingState: ctrl.loading.value)
                        : SizedBox(
                          width: PDeviceUtil.getDeviceWidth(context) + 300,
                          height: PDeviceUtil.getDeviceHeight(context) * 0.3,
                          child: PCustomLineChart(
                            data: convertToSpots(),
                            data2: ctrl.contributions.value,
                            xLabels: xLabels,
                            interval: interval,
                          ),
                        ),
                    PAppSize.s24.verticalSpace,
                    // recent contributions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'recent_contributions'.tr,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'view_history'.tr,
                          textAlign: TextAlign.start,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: PAppColor.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: PAppColor.primary,
                            fontSize: PAppSize.s13,
                          ),
                        ).onPressed(
                          onTap:
                              () => PHelperFunction.switchScreen(
                                destination: Routes.contributionHistoryPage,
                              ),
                        ),
                      ],
                    ),

                    ctrl.loading.value == LoadingState.loading
                        ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return ContributionHistoryWidgetRedact(
                              loadingState: ctrl.loading.value,
                            );
                          },
                        )
                        : (ctrl
                                    .history
                                    .value
                                    .transactionHistory
                                    ?.transactions ==
                                null ||
                            ctrl.history.value.transactionHistory!.transactions!
                                .where((e) => e.paymentFlag != 'B')
                                .toList()
                                .isEmpty)
                        ? PEmptyStateWidget(message: 'no_results_found'.tr)
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount:
                              ctrl
                                  .history
                                  .value
                                  .transactionHistory
                                  ?.transactions
                                  ?.take(5)
                                  .length,
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
                  ],
                ).scrollable(),
          ),
        ],
      ),
    );
  }
}
