import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/future.value.calculator/presentation/vm/future.value.calc.vm.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.bar.chart.new.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.line.chart.new.dart';

class PFactSheetPage extends StatelessWidget {
  PFactSheetPage({super.key});

  final ctrl = Get.put(PFutureValueCalcVm());

  List<BarChartGroupData> getBarGroups() {
    return [
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            width: PAppSize.s18,
            borderRadius: BorderRadius.zero,
            toY: 8,
            color: Colors.blue,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            width: PAppSize.s18,
            borderRadius: BorderRadius.zero,
            toY: 10,
            color: PAppColor.orangeColor,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            width: PAppSize.s18,
            borderRadius: BorderRadius.zero,
            toY: 2,
            color: PAppColor.primaryTextColor,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            width: PAppSize.s18,
            borderRadius: BorderRadius.zero,
            toY: 12,
            color: PAppColor.primary,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('your_results'.tr)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PAppSize.s8.verticalSpace,
            // Text(
            //   'In 2028 when you retire you will have a pension worth of',
            //   textAlign: TextAlign.start,
            //   style: Theme.of(context).textTheme.bodyMedium,
            // ),
            // PAppSize.s8.verticalSpace,
            // Text(
            //   'GHS 1,000,000,000',
            //   textAlign: TextAlign.start,
            //   style: Theme.of(
            //     context,
            //   ).textTheme.headlineLarge?.copyWith(color: PAppColor.primary),
            // ),
            // PAppSize.s80.verticalSpace,
            // SizedBox(
            //   height: 200,
            //   child: PCustomBarChart(
            //     bottomTitles: [
            //       'Poor returns',
            //       'Expected returns',
            //       'Good returns',
            //     ],
            //     topTitles: ['700000000', '1000000000', '3000000000'],
            //     showLeftTitles: false,
            //     showTopTitles: true,
            //     showGridData: false,
            //     data: [
            //       BarChartGroupData(
            //         x: 0,
            //         barRods: [
            //           BarChartRodData(
            //             toY: 2,
            //             borderRadius: borderRadius,
            //             gradient: gradient,
            //             width: PAppSize.s45,
            //           ),
            //         ],
            //       ),
            //       BarChartGroupData(
            //         x: 1,
            //         barRods: [
            //           BarChartRodData(
            //             toY: 4,
            //             borderRadius: borderRadius,
            //             gradient: gradient,
            //             width: PAppSize.s45,
            //           ),
            //         ],
            //       ),
            //       BarChartGroupData(
            //         x: 2,
            //         barRods: [
            //           BarChartRodData(
            //             toY: 6,
            //             borderRadius: borderRadius,
            //             gradient: gradient,
            //             width: PAppSize.s45,
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // PAppSize.s50.verticalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PAppSize.s22.verticalSpace,
                  Text(
                    '${'performance_since'.tr} ${DateTime.now().year - 6}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ).symmetric(horizontal: PAppSize.s10),
                  PAppSize.s16.verticalSpace,
                  // bar chart
                  Expanded(
                    // width: PDeviceUtil.getDeviceWidth(context),
                    // height: PDeviceUtil.getDeviceHeight(context) * 0.35,
                    child: PCustomLineChartNew(
                      data: [
                        FlSpot(19, 3.8),
                        FlSpot(20, 2.5),
                        FlSpot(21, 8),
                        FlSpot(22, 6),
                        FlSpot(23, 6),
                      ],
                    ),
                  ),
                  PAppSize.s22.verticalSpace,
                  Text(
                    'fund_composition'.tr,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ).symmetric(horizontal: PAppSize.s16),
                  PAppSize.s8.verticalSpace,
                  Text(
                    'asset_allocation'.tr,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: PAppColor.primaryTextColor,
                    ),
                  ).symmetric(horizontal: PAppSize.s16),
                  PAppSize.s16.verticalSpace,
                  // bar chart
                  Expanded(
                    // width: PDeviceUtil.getDeviceWidth(context),
                    // height: PDeviceUtil.getDeviceHeight(context) * 0.35,
                    child: PCustomBarChartNew(
                      bottomTitles: [
                        'CASH',
                        'EQUITIES',
                        'FD',
                        'CORP DEPT',
                        'CIS',
                        'GOG',
                      ],
                      topTitles: [
                        '4.17',
                        '3.78',
                        '14.92',
                        '2.19',
                        '7.8',
                        '60.7',
                      ],
                      showLeftTitles: false,
                      showTopTitles: true,
                      showGridData: false,
                      showBorderData: true,
                      showRightTitles: true,
                      data: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 2,
                              borderRadius: BorderRadius.zero,
                              color: PAppColor.orangeColor,
                              width: PAppSize.s18,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 4,
                              borderRadius: BorderRadius.zero,
                              color: PAppColor.redColor,
                              width: PAppSize.s18,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 3,
                              borderRadius: BorderRadius.zero,
                              color: PAppColor.primaryTextColor,
                              width: PAppSize.s18,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 19,
                              borderRadius: BorderRadius.zero,
                              color: PAppColor.primary,
                              width: PAppSize.s18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // PAppSize.s22.verticalSpace,

            // Text(
            //   'download_as_pdf'.tr,
            //   textAlign: TextAlign.start,
            //   style: Theme.of(context).textTheme.headlineSmall,
            // ).centered(),
            // PAppSize.s12.verticalSpace,
            // PGradientButton(
            //   label: 'reset_calculator'.tr,
            //   width: PDeviceUtil.getDeviceWidth(context) * 0.55,
            //   onTap: ctrl.resetCalculator,
            // ).centered(),
            PAppSize.s8.verticalSpace,
          ],
        ).symmetric(horizontal: PAppSize.s20),
      ),
    );
  }
}
