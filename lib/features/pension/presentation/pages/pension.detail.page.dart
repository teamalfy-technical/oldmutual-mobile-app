import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/pension/domain/models/scheme.model.dart';
import 'package:oldmutual_pensions_app/features/pension/presentation/vm/pension.vm.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:redacted/redacted.dart';

class PPensionDetailPage extends StatefulWidget {
  final Scheme scheme;
  const PPensionDetailPage({super.key, required this.scheme});

  @override
  State<PPensionDetailPage> createState() => _PPensionDetailPageState();
}

class _PPensionDetailPageState extends State<PPensionDetailPage> {
  final vm = Get.put(PPensionVm());

  final contributionVm = Get.put(PContributionHistoryVm());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchSelectScheme();
      setState(() {});
    });
    // fetchSelectScheme();
    super.initState();
  }

  Future<void> fetchSelectScheme() async {
    await vm.getMemberSelectedScheme(scheme: widget.scheme);
  }

  List<String> xLabels = [];

  double get interval {
    // final data = getLastFiveMonthlyTransactions();
    if (contributionVm.contributions.isEmpty) return 5;
    final data = contributionVm.contributions;
    final contribution = data.map((s) => s.mainCurrentValue ?? 0).toList();
    double maxValue = contribution.reduce((a, b) => a > b ? a : b);
    // Determine a nice dynamic interval
    double interval = maxValue / 5;
    // Round interval to nearest 5 for nicer ticks
    return (interval / 5).ceil() * 5;
  }

  List<FlSpot> convertToSpots() {
    final data = contributionVm.contributions;
    return List.generate(data.length, (index) {
      double y = double.parse(
        data[index].mainCurrentValue?.toStringAsFixed(2) ?? '0',
      );

      xLabels.add(data[index].month ?? ''); // e.g., Jan-2024
      // pensionAppLogger.e(y);
      return FlSpot(index.toDouble(), y);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text(widget.scheme.masterSchemeDescription ?? '')),
      body: Obx(
        () => SafeArea(
          child:
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PAppSize.s2.verticalSpace,
                      // Cover Amount
                      Text(
                        'cover_balance'.tr,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: PAppSize.s13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        PFormatter.formatCurrency(
                          amount:
                              // vm.summary.value.totalInvestment?.toDouble() ??
                              // 0.00,
                              widget.scheme.schemeCurrentValue ?? 0,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              // fontSize: PAppSize.s12,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      PAppSize.s2.verticalSpace,

                      Divider(
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.successLight
                            : PAppColor.successDark,
                        thickness: PAppSize.s4,
                      ),

                      PAppSize.s6.verticalSpace,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InvestmentWidget(
                            title: 'monthly_premium'.tr,
                            value: PFormatter.formatCurrency(
                              amount: widget.scheme.monthlyContribution ?? 0,
                            ),
                          ),
                          InvestmentWidget(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            title: 'status'.tr,
                            value: activeStatuses.contains(widget.scheme.status)
                                ? 'active'.tr
                                : 'inactive'.tr,
                          ),
                        ],
                      ),

                      PAppSize.s18.verticalSpace,

                      /// Quick Actions
                      Row(
                        children: [
                          if (widget.scheme.memberNumber != null &&
                              widget.scheme.memberNumber!
                                  .toLowerCase()
                                  .contains('mv') &&
                              activeStatuses.contains(
                                widget.scheme.status,
                              )) ...[
                            QuickActionWidget(
                              label: 'pay_now'.tr,
                              icon: Assets.icons.payIcon.svg(
                                color: PHelperFunction.isDarkMode(context)
                                    ? PAppColor.successLight
                                    : PAppColor.successDark,
                              ),
                              onTap: () {
                                showPayModal(
                                  context: context,
                                  product: widget.scheme,
                                );
                              },
                            ),
                            PAppSize.s8.horizontalSpace,
                          ],
                          QuickActionWidget(
                            label: 'generate_statement'.tr,
                            icon: Assets.icons.factsheetIcon.svg(
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.successLight
                                  : PAppColor.successDark,
                            ),
                            onTap: () => PHelperFunction.switchScreen(
                              destination: Routes.statementPage,
                            ),
                          ),
                          PAppSize.s8.horizontalSpace,
                          QuickActionWidget(
                            label: 'certificate'.tr,
                            icon: Assets.icons.document.svg(
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.successLight
                                  : PAppColor.successDark,
                            ),
                            onTap: () => vm.downloadPensionCertificate(),
                          ),
                          PAppSize.s8.horizontalSpace,
                          QuickActionWidget(
                            label: 'performance_chart'.tr,
                            icon: Assets.icons.chartData.svg(
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.successLight
                                  : PAppColor.successDark,
                            ),
                            onTap: () => PHelperFunction.switchScreen(
                              destination: Routes.factsheetPage,
                            ),
                          ),

                          PAppSize.s8.horizontalSpace,
                          QuickActionWidget(
                            label: 'future_val_cal'.tr,
                            icon: Assets.icons.calculate.svg(
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.successLight
                                  : PAppColor.successDark,
                            ),
                            onTap: () => PHelperFunction.switchScreen(
                              destination: Routes.futureValueCalcPage,
                            ),
                          ),

                          PAppSize.s8.horizontalSpace,
                          QuickActionWidget(
                            label: 'withdrawal'.tr,
                            icon: Assets.icons.accountBalanceWallet.svg(
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.successLight
                                  : PAppColor.successDark,
                            ),
                            onTap: () => PHelperFunction.switchScreen(
                              destination: Routes.redemptionPage,
                            ),
                          ),

                          PAppSize.s8.horizontalSpace,
                          QuickActionWidget(
                            label: 'beneficiaries'.tr,
                            icon: Assets.icons.person.svg(
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.successLight
                                  : PAppColor.successDark,
                            ),
                            onTap: () => PHelperFunction.switchScreen(
                              destination: Routes.beneficiariesPage,
                            ),
                          ),
                        ],
                      ).scrollable(scrollDirection: Axis.horizontal),

                      PAppSize.s14.verticalSpace,
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      // Pension
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(PAppSize.s20),
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.darkAppBarColor
                              : PAppColor.whiteColor,
                        ),
                        child: Column(
                          children: [
                            _buildListTile(
                              context,
                              'member_number'.tr,
                              widget.scheme.memberNumber ?? 'not_applicable'.tr,
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'member_name'.tr,
                              widget.scheme.memberName ?? 'not_applicable'.tr,
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'pension_type'.tr,
                              widget.scheme.penTypeDescription ??
                                  'not_applicable'.tr,
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'employer_name'.tr,
                              widget.scheme.employerName ?? 'not_applicable'.tr,
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'employer_number'.tr,
                              widget.scheme.employerNumber ??
                                  'not_applicable'.tr,
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'ssnit_number'.tr,
                              widget.scheme.ssnitNumber ?? 'not_applicable'.tr,
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'total_premium_amount'.tr,
                              PFormatter.formatCurrency(
                                amount: widget.scheme.schemeCurrentValue ?? 0,
                              ),
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'premium_amount'.tr,
                              PFormatter.formatCurrency(
                                amount: widget.scheme.monthlyContribution ?? 0,
                              ),
                            ),

                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'total_contributions'.tr,
                              PFormatter.formatCurrency(
                                amount:
                                    contributionVm
                                        .summary
                                        .value
                                        .totalContributions ??
                                    0,
                              ),
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'total_redemptions'.tr,
                              PFormatter.formatCurrency(
                                amount:
                                    contributionVm
                                        .summary
                                        .value
                                        .totalRedemption ??
                                    0,
                              ),
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'accrued_interest'.tr,
                              PFormatter.formatCurrency(
                                amount:
                                    contributionVm
                                        .summary
                                        .value
                                        .totalInterest ??
                                    0,
                              ),
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'premium_frequency'.tr,
                              'monthly',
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'scheme_start_date'.tr,
                              PFormatter.formatDate(
                                dateFormat: DateFormat('yMMMMd'),
                                date: DateTime.parse(
                                  widget.scheme.effectiveDate ??
                                      DateTime.now().toIso8601String(),
                                ),
                              ),
                            ),
                            Divider(height: PAppSize.s1),
                            _buildListTile(
                              context,
                              'scheme_end_date'.tr,
                              'not_applicable'.tr,
                            ),
                          ],
                        ),
                      ),

                      PAppSize.s16.verticalSpace,

                      /// Contribution Progress
                      Text(
                        'contribution_progress'.tr,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontSize: PAppSize.s16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),

                      PAppSize.s16.verticalSpace,

                      (vm.loading.value == LoadingState.loading ||
                              contributionVm.loading.value ==
                                  LoadingState.loading)
                          ? PChartRedactWidget(
                              height:
                                  PDeviceUtil.getDeviceHeight(context) * 0.4,
                              loadingState: contributionVm.loading.value,
                            )
                          : PCustomCardWidget(
                              height: contributionVm.contributions.isEmpty
                                  ? null
                                  : PDeviceUtil.getDeviceHeight(context) * 0.4,
                              padding: EdgeInsets.all(PAppSize.s16),
                              child: contributionVm.contributions.isEmpty
                                  ? PEmptyStateWidget(
                                      message: 'no_data_found'.tr,
                                    )
                                  : PCustomLineChart(
                                      data: convertToSpots(),
                                      data2: contributionVm.contributions,
                                      xLabels: xLabels,
                                      interval: interval,
                                    ),
                            ),

                      PAppSize.s16.verticalSpace,

                      /// Contributions
                      PSeeAllWidget(
                        leadingText: 'contributions'.tr,

                        onTap: () => PHelperFunction.switchScreen(
                          destination: Routes.contributionsPage,
                        ),
                      ),

                      PAppSize.s16.verticalSpace,

                      if (vm.loading.value == LoadingState.loading ||
                          contributionVm.loading.value ==
                              LoadingState.loading) ...[
                        PChartRedactWidget(
                          height: PDeviceUtil.getDeviceHeight(context) * 0.4,
                          loadingState: contributionVm.loading.value,
                        ),
                      ] else ...[
                        PCustomCardWidget(
                          padding: EdgeInsets.symmetric(
                            vertical: PAppSize.s16,
                            horizontal: PAppSize.s4,
                          ),

                          child:
                              (contributionVm
                                          .history
                                          .value
                                          .transactionHistory
                                          ?.transactions
                                          ?.toList() ??
                                      [])
                                  .isEmpty
                              ? PEmptyStateWidget(
                                  message: 'no_results_found'.tr,
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      (contributionVm
                                                  .history
                                                  .value
                                                  .transactionHistory
                                                  ?.transactions
                                                  ?.length ??
                                              0)
                                          .clamp(0, 4), // limits to 4 safely
                                  itemBuilder: (context, index) {
                                    final contribution = contributionVm
                                        .history
                                        .value
                                        .transactionHistory
                                        ?.transactions![index];
                                    return ListTile(
                                      title: Text(
                                        contribution?.schemeName ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontSize: PAppSize.s14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      subtitle: Text(
                                        PFormatter.formatDate(
                                          dateFormat: DateFormat('yMMMMd'),
                                          date: DateTime.parse(
                                            contribution?.paymentDate ??
                                                DateTime.now()
                                                    .toIso8601String(),
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: PAppSize.s13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                      trailing: Text(
                                        PFormatter.formatCurrency(
                                          amount: contribution?.received ?? 0,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontSize: PAppSize.s14,
                                              color: PAppColor.successMedium,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Divider().symmetric(
                                        horizontal: PAppSize.s20,
                                      ),
                                ),
                        ),
                      ],

                      PAppSize.s16.verticalSpace,
                      //   ],
                      // ),
                    ],
                  )
                  .symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s10)
                  .scrollable(),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, String subTitle) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: PAppSize.s16),
      title:
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w400,
            ),
          ).redacted(
            context: context,
            redact:
                vm.loading.value == LoadingState.loading ||
                    contributionVm.loading.value == LoadingState.loading
                ? true
                : false,
          ),
      subtitle:
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s18,
              fontWeight: FontWeight.w500,
            ),
          ).redacted(
            context: context,
            redact:
                vm.loading.value == LoadingState.loading ||
                    contributionVm.loading.value == LoadingState.loading
                ? true
                : false,
          ),
    );
  }
}
