import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/dashboard/presentation/widgets/pension.tier.widget.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PDashboardPage extends StatelessWidget {
  const PDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final schemes = [
      {'title': 'Pension Tier 1', 'amount': 'GHS 48,000', 'date': '12-05-2023'},
      {'title': 'Pension Tier 2', 'amount': 'GHS 57,000', 'date': '12-06-2023'},
      {'title': 'Pension Tier 3', 'amount': 'GHS 70,000', 'date': '12-06-2023'},
    ];
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: PDeviceUtil.getDeviceWidth(context),
                height: PDeviceUtil.getDeviceHeight(context) / 3.5,
                decoration: BoxDecoration(color: PAppColor.blackColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${'welcome'.tr}, Angela',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: PAppColor.whiteColor,
                      ),
                    ),
                    PAppSize.s6.verticalSpace,
                    Text(
                      'Your Schemes',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: PAppColor.whiteColor,
                      ),
                    ),
                  ],
                ).only(bottom: PDeviceUtil.getDeviceWidth(context) * 0.19),
              ),
              Image.asset(
                Assets.images.dashboardBg.path,
                fit: BoxFit.cover,
                width: PDeviceUtil.getDeviceWidth(context),
                height: PDeviceUtil.getDeviceHeight(context) / 2.75,
              ),
            ],
          ),

          Positioned(
            top: PDeviceUtil.getDeviceHeight(context) / 6,
            left: PAppSize.s16,
            right: PAppSize.s16,
            child: ListView.builder(
              itemCount: schemes.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final scheme = schemes[index];
                return PensionTierWidget(
                  scheme: scheme,
                  onTap: () {
                    PHelperFunction.switchScreen(destination: Routes.homePage);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
