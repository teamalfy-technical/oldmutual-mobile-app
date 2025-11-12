import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPolicyOverviewPage extends StatelessWidget {
  final Map<String, dynamic> product;
  PPolicyOverviewPage({super.key, required this.product});

  final vm = Get.find<PPolicyVm>();
  final policyStatementVm = Get.put(PPolicyStatementVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text(product['name'])),
      body: Stack(
        children: [
          Positioned(top: -16, right: -0, child: Assets.icons.pictogram.svg()),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PAppSize.s2.verticalSpace,
                // Overview Balance
                Text(
                  'available_balance'.tr,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  PFormatter.formatCurrency(amount: product['contribution']),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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

                PAppSize.s5.verticalSpace,

                InvestmentWidget(title: 'status'.tr, value: 'active'.tr),

                PAppSize.s12.verticalSpace,

                RefreshIndicator.adaptive(
                  onRefresh: vm.getAllPolicies,
                  color: PAppColor.primary,
                  child: vm.policies.isEmpty
                      ? PEmptyStateWidget(message: 'no_results_found'.tr)
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: vm.policies.length,
                          itemBuilder: (context, index) {
                            final policy = vm.policies[index];
                            return PPolicyWidget(
                              policy: policy,
                              onTap: () {
                                policyStatementVm.onSelectedPolicyReport(
                                  policy,
                                );
                                PHelperFunction.switchScreen(
                                  destination: Routes.policyDetailPage,
                                  args: policy,
                                  // args: 'investments'.tr,
                                );
                              },
                            );
                          },
                        ),
                ),

                // RefreshIndicator.adaptive(
                //   onRefresh: vm.getMemberSchemes,
                //   color: PAppColor.primary,
                //   child: pensionVm.schemes.isEmpty
                //       ? PEmptyStateWidget(message: 'no_results_found'.tr)
                //       : ListView.builder(
                //           shrinkWrap: true,
                //           itemCount: pensionVm.schemes.length,
                //           itemBuilder: (context, index) {
                //             return PPensionWidget(
                //               scheme: pensionVm.schemes[index],
                //               onTap: () {},
                //             );
                //           },
                //         ),
                // ),
              ],
            ).symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s10),
          ),
        ],
      ),
    );
  }
}
