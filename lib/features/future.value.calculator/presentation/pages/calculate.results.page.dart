import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/future.value.calculator/presentation/vm/future.value.calc.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PCalculateResultsPage extends StatelessWidget {
  PCalculateResultsPage({super.key});

  final ctrl = Get.put(PFutureValueCalcVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('your_results'.tr)),
      body:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PAppSize.s8.verticalSpace,
              Text(
                'In 2028 when you retire you will have a pension worth of',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              PAppSize.s8.verticalSpace,
              Text(
                'GHS 1,000,000,000',
                textAlign: TextAlign.start,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: PAppColor.primary),
              ),
              PAppSize.s80.verticalSpace,
              SizedBox(
                height: 200,
                child: PCustomBarChart(
                  bottomTitles: [
                    'Poor returns',
                    'Expected returns',
                    'Good returns',
                  ],
                  topTitles: ['700000000', '1000000000', '3000000000'],
                  showLeftTitles: false,
                  showTopTitles: true,
                  showGridData: false,
                  data: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 2,
                          borderRadius: borderRadius,
                          gradient: gradient,
                          width: PAppSize.s45,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 4,
                          borderRadius: borderRadius,
                          gradient: gradient,
                          width: PAppSize.s45,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 6,
                          borderRadius: borderRadius,
                          gradient: gradient,
                          width: PAppSize.s45,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PAppSize.s50.verticalSpace,
              Text(
                'download_as_pdf'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineSmall,
              ).centered(),
              PAppSize.s12.verticalSpace,
              PGradientButton(
                label: 'reset_calculator'.tr,
                width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                onTap: ctrl.resetCalculator,
              ).centered(),
            ],
          ).symmetric(horizontal: PAppSize.s20).scrollable(),
    );
  }
}
