import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/factsheet/presentation/vm/factsheet.vm.dart';
import 'package:oldmutual_pensions_app/features/factsheet/presentation/widgets/chart.redact.widget.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:redacted/redacted.dart';

class PFactSheetPage extends StatefulWidget {
  const PFactSheetPage({super.key});

  @override
  State<PFactSheetPage> createState() => _PFactSheetPageState();
}

class _PFactSheetPageState extends State<PFactSheetPage> {
  final ctrl = Get.put(PFactsheetVm());

  @override
  void initState() {
    super.initState();
    // if (ctrl.performances.isEmpty && ctrl.compositions.isEmpty) {
    // setState(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ctrl.getPerformances();
    });
    // });

    //  }
  }

  String get getSchemeType {
    final isNotEmpty = ctrl.performances.isNotEmpty;
    return isNotEmpty &&
            ctrl.performances[0].scheme!.contains(
              SchemeType.aspire.name.toUpperCase(),
            )
        ? SchemeType.aspire.name.toUpperCase()
        : isNotEmpty &&
              ctrl.performances[0].scheme!.contains(
                SchemeType.prestige.name.toUpperCase(),
              )
        ? SchemeType.prestige.name.toUpperCase()
        : SchemeType.anchor.name.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    // int lowestYear = ctrl.performances.isEmpty
    //     ? DateTime.now().year - 5
    //     : ctrl.performances
    //           .map((e) => e.year ?? 0)
    //           .reduce((a, b) => a < b ? a : b);

    int lowestYear = 2020;
    int highestYear = 2024;
    if (ctrl.performances.isNotEmpty) {
      lowestYear = ctrl.performances
          .map((e) => e.year ?? 0)
          .reduce((a, b) => a < b ? a : b);
      highestYear = ctrl.performances
          .map((e) => e.year ?? 0)
          .reduce((a, b) => a > b ? a : b);
    }

    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(
        title: Text('performance_factsheet'.tr),
        actions: [
          IconButton(
            onPressed: () => ctrl.generateFactsheet(),
            icon: Assets.icons.downloadIcon.svg(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.blackColor,
            ),
          ),
        ],
      ),
      body: Obx(
        () => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // bar chart
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: ctrl.getPerformances,
                  child: ctrl.loading.value == LoadingState.loading
                      ? PChartRedactWidget(loadingState: ctrl.loading.value)
                      : PCustomCardWidget(
                          height: PDeviceUtil.getDeviceHeight(context) * 0.40,
                          padding: EdgeInsets.all(PAppSize.s16),
                          child: ctrl.performances.isEmpty
                              ? PEmptyStateWidget(message: 'no_data_found'.tr)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // PAppSize.s22.verticalSpace,
                                    Text(
                                          '${'performance_since'.tr} ($lowestYear - $highestYear)',
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        )
                                        .symmetric(horizontal: PAppSize.s10)
                                        .redacted(
                                          context: context,
                                          redact:
                                              ctrl.loading.value ==
                                                  LoadingState.loading
                                              ? true
                                              : false,
                                        ),
                                    PAppSize.s8.verticalSpace,
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          PCustomLineChartNew(
                                            data: ctrl.performances,
                                          ),
                                          Positioned(
                                            left:
                                                PDeviceUtil.getDeviceWidth(
                                                  context,
                                                ) *
                                                0.1,
                                            right: PAppSize.s0,
                                            bottom: -3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Assets.icons.anchorIcon
                                                        .svg(),
                                                    PAppSize.s3.horizontalSpace,
                                                    Text(
                                                      getSchemeType
                                                          .toUpperCase(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                PAppSize.s10,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                PAppSize.s20.horizontalSpace,
                                                Row(
                                                  children: [
                                                    Assets.icons.benchmarkIcon
                                                        .svg(),
                                                    PAppSize.s3.horizontalSpace,
                                                    Text(
                                                      'benchmark'.tr
                                                          .toUpperCase(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                PAppSize.s10,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                ),
              ),

              PAppSize.s16.verticalSpace,

              /// Performance Summary
              // PCustomCardWidget(
              //   padding: EdgeInsets.all(PAppSize.s16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'performance_summary'.tr,
              //         textAlign: TextAlign.start,
              //         style: Theme.of(context).textTheme.bodyLarge
              //             ?.copyWith(
              //               fontWeight: FontWeight.w600,
              //               // fontSize: PAppSize.s10,
              //             ),
              //       ),
              //       PAppSize.s10.verticalSpace,
              //       _buildSummaryWidget(
              //         title: 'best_performing_month'.tr,
              //         trailing: '${ctrl.bestPerformingYear}',
              //       ),
              //       PAppSize.s8.verticalSpace,
              //       _buildSummaryWidget(
              //         title: 'ag_monthly_growth'.tr,
              //         trailing: '${ctrl.averageGrowth}',
              //         color: PAppColor.successMedium,
              //       ),
              //       PAppSize.s8.verticalSpace,
              //       _buildSummaryWidget(
              //         title: 'year_to_date_return'.tr,
              //         trailing: '${ctrl.yearToDateReturn}',
              //         color: PAppColor.successMedium,
              //       ),
              //     ],
              //   ),
              // ),
              // PAppSize.s16.verticalSpace,

              /// Annual Growth & Interest Rate
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     /// Annual Growth
              //     Expanded(
              //       child: _buildStatsWidget(
              //         icon: Assets.icons.stack.svg(),
              //         title: '+12.5%',
              //         subTitle: 'annual_growth'.tr,
              //       ),
              //     ),

              //     PAppSize.s16.horizontalSpace,

              //     /// Interest Rate
              //     Expanded(
              //       child: _buildStatsWidget(
              //         icon: Assets.icons.stackedLineChart.svg(),
              //         title: '+8.2%',
              //         subTitle: 'interest_rate'.tr,
              //       ),
              //     ),
              //   ],
              // ),
              // PAppSize.s16.verticalSpace,

              // bar chart
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: ctrl.getFundComposition,
                  child: ctrl.loading.value == LoadingState.loading
                      ? PChartRedactWidget(loadingState: ctrl.loading.value)
                      : PCustomCardWidget(
                          height: PDeviceUtil.getDeviceHeight(context) * 0.40,
                          padding: EdgeInsets.all(PAppSize.s16),
                          child: ctrl.compositions.isEmpty
                              ? PEmptyStateWidget(message: 'no_data_found'.tr)
                              : PCustomBarChart(data: ctrl.compositions),
                        ),
                ),
              ),
            ],
          ).all(PAppSize.s20),
          //.scrollable(),
        ),
      ),
    );
  }

  Widget _buildSummaryWidget({
    Color? color,
    required String title,
    required String trailing,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,

              // fontSize: PAppSize.s10,
            ),
          ),
        ),
        PAppSize.s8.horizontalSpace,
        Text(
          trailing,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
            // fontSize: PAppSize.s10,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsWidget({
    required SvgPicture icon,
    required String title,
    required String subTitle,
  }) {
    return PCustomCardWidget(
      useBorder: false,
      padding: EdgeInsets.all(PAppSize.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,

          PAppSize.s4.verticalSpace,
          Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              // fontSize: PAppSize.s10,
            ),
          ),
          PAppSize.s4.verticalSpace,
          Text(
            subTitle,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              // fontSize: PAppSize.s10,
            ),
          ),
        ],
      ),
    );
  }
}
