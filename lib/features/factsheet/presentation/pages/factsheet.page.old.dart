import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PFactSheetPage1 extends StatelessWidget {
  const PFactSheetPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text('factsheet_title'.tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PPageTagWidget(tag: 'factsheet_hint'.tr),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PAppSize.s22.verticalSpace,
                Text(
                  'percentage_growth'.tr,
                  textAlign: TextAlign.start,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ).symmetric(horizontal: PAppSize.s16),
                PAppSize.s16.verticalSpace,
                // bar chart
                Expanded(
                  // width: PDeviceUtil.getDeviceWidth(context),
                  // height: PDeviceUtil.getDeviceHeight(context) * 0.35,
                  child: PCustomLineChart(
                    data: [
                      FlSpot(1, 1),
                      FlSpot(2, 2),
                      FlSpot(3, 4),
                      FlSpot(4, 6),
                    ],
                    interval: 1,
                  ),
                ),
                PAppSize.s22.verticalSpace,
                Text(
                  'current_margin_average'.tr,
                  textAlign: TextAlign.start,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ).symmetric(horizontal: PAppSize.s16),
                PAppSize.s16.verticalSpace,
                Expanded(
                  //width: PDeviceUtil.getDeviceWidth(context),
                  // height: PDeviceUtil.getDeviceHeight(context) * 0.35,
                  child: PCustomBarChartOld(
                    showBottomTitles: false,
                    data: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: 4,
                            borderRadius: borderRadius,
                            gradient: gradient,
                            width: PAppSize.s36,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: 6,
                            borderRadius: borderRadius,
                            gradient: gradient,
                            width: PAppSize.s36,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: 3,
                            borderRadius: borderRadius,
                            gradient: gradient,
                            width: PAppSize.s36,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(
                            toY: 5,
                            borderRadius: borderRadius,
                            gradient: gradient,
                            width: PAppSize.s36,
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
    );
  }
}
