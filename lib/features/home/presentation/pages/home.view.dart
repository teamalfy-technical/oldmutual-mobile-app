import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/dashboard/dashboard.dart';
import 'package:oldmutual_pensions_app/features/home/presentation/widgets/home.stats.widget.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PHomeView extends StatelessWidget {
  const PHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: PDeviceUtil.getDeviceWidth(context),
              height: PDeviceUtil.getDeviceHeight(context) / 4.0,
              decoration: BoxDecoration(color: PAppColor.blackColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${'welcome'.tr}, Angela',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: PAppColor.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              Assets.images.dashboardBg.path,
              fit: BoxFit.cover,
              width: PDeviceUtil.getDeviceWidth(context),
              height: PDeviceUtil.getDeviceHeight(context) / 2,
            ),
          ],
        ),

        Positioned(
          top: PDeviceUtil.getDeviceHeight(context) / 6,
          left: PAppSize.s16,
          right: PAppSize.s16,
          child: Column(
            children: [
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
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: PAppColor.text50),
                    ),
                    PAppSize.s4.verticalSpace,
                    Text(
                      'GHS 40,000',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: PAppColor.whiteColor,
                        fontSize: PAppSize.s18,
                      ),
                    ),
                    PAppSize.s4.verticalSpace,
                    Text(
                      'Last contribution date 10/3/2024',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: PAppSize.s14,
                        color: PAppColor.text100,
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: PHomeStatsWidget(
                      title: 'Accrued Interest',
                      subTitle: 'GHS 20,000',
                      onTap: () {},
                    ),
                  ),
                  PAppSize.s16.horizontalSpace,
                  Expanded(
                    child: PHomeStatsWidget(
                      title: 'Total Redemptions',
                      subTitle: 'GHS 70,000',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              PAppSize.s6.verticalSpace,
              // line chart
              SizedBox(
                width: PDeviceUtil.getDeviceWidth(context),
                height: PDeviceUtil.getDeviceHeight(context) * 0.35,
                child: PCustomLineChart(
                  data: [
                    FlSpot(1, 1),
                    FlSpot(2, 2),
                    FlSpot(3, 4),
                    FlSpot(4, 6),
                    // FlSpot(100, 1),
                    // FlSpot(200, 2),
                    // FlSpot(400, 3),
                    // FlSpot(600, 4),
                    // FlSpot(700, 5),
                    // FlSpot(800, 6),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
