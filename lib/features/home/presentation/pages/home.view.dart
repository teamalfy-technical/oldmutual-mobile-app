import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:redacted/redacted.dart';

class PHomeView extends StatelessWidget {
  PHomeView({super.key});

  final ctrl = Get.put(PContributionHistoryVm());

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
                height: PDeviceUtil.getDeviceHeight(context) * 0.25,
                decoration: BoxDecoration(color: PAppColor.blackColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${'welcome'.tr}, ${PSecureStorage().getAuthResponse()?.name ?? ''}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: PAppColor.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
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
            top: PDeviceUtil.getDeviceHeight(context) / 6,
            left: PAppSize.s16,
            right: PAppSize.s16,
            child:
                Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'View All Schemes',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: PAppColor.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: PAppSize.s12,
                        ),
                      ).onPressed(
                        onTap:
                            () => PHelperFunction.switchScreen(
                              destination: Routes.dashboardPage,
                            ),
                      ),
                    ),
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
                            'Total Contribution',
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
                              amount:
                                  ctrl.summmary.value.totalContributions ?? 0,
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
                            title: 'Accrued Interest',
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
                            title: 'Total Redemptions',
                            loading: ctrl.loading.value,
                            subTitle: PFormatter.formatCurrency(
                              amount:
                                  ctrl
                                      .summmary
                                      .value
                                      .totalEmployerContributions ??
                                  0,
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    PAppSize.s32.verticalSpace,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'contribution_progress'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: PAppSize.s14,
                          fontWeight: FontWeight.w600,
                          color: PAppColor.text700,
                        ),
                      ).symmetric(horizontal: PAppSize.s14),
                    ),
                    PAppSize.s6.verticalSpace,
                    // line chart
                    ctrl.loading.value == LoadingState.loading
                        ? Container(
                          width: PDeviceUtil.getDeviceWidth(context),
                          height: PDeviceUtil.getDeviceHeight(context) * 0.3,
                          padding: EdgeInsets.all(PAppSize.s20),
                          color: PAppColor.whiteColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: PDeviceUtil.getDeviceWidth(context),
                                height: PAppSize.s20,
                                color: PAppColor.whiteColor,
                              ),
                              Container(
                                width: PDeviceUtil.getDeviceWidth(context),
                                height: PAppSize.s20,
                                color: PAppColor.whiteColor,
                              ),
                              Container(
                                width: PDeviceUtil.getDeviceWidth(context),
                                height: PAppSize.s20,
                                color: PAppColor.whiteColor,
                              ),
                              Container(
                                width: PDeviceUtil.getDeviceWidth(context),
                                height: PAppSize.s20,
                                color: PAppColor.whiteColor,
                              ),
                            ],
                          ),
                        ).redacted(
                          context: context,
                          redact:
                              ctrl.loading.value == LoadingState.loading
                                  ? true
                                  : false,
                        )
                        : SizedBox(
                          width: PDeviceUtil.getDeviceWidth(context),
                          height: PDeviceUtil.getDeviceHeight(context) * 0.3,
                          child: PCustomLineChart(
                            data:
                                ctrl
                                    .history
                                    .value
                                    .transactionHistory!
                                    .transactions!
                                    .take(3)
                                    .map(
                                      (e) => FlSpot(
                                        DateTime.parse(
                                          e.paymentDate ??
                                              DateTime.now().toIso8601String(),
                                        ).month.toDouble(),
                                        e.received ?? 0,
                                      ),
                                    )
                                    .toList(),
                            // data: [
                            //   FlSpot(1, 1),
                            //   FlSpot(2, 2),
                            //   FlSpot(3, 4),
                            //   FlSpot(4, 6),

                            // ],
                          ),
                        ),
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
                            ctrl
                                .history
                                .value
                                .transactionHistory!
                                .transactions!
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
