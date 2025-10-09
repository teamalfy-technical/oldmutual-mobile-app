import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/dashboard/dashboard.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PHomePage extends StatelessWidget {
  PHomePage({super.key});

  final vm = Get.put(PHomeVm());
  final policyVm = Get.put(PPolicyVm());
  final pensionVm = Get.put(PPensionVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Highlight options
          Container(
            padding: EdgeInsets.symmetric(vertical: PAppSize.s12),
            decoration: BoxDecoration(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.cardDarkColor
                  : PAppColor.whiteColor,
            ),
            child:
                Row(
                      children: List.generate(vm.highlights.length, (index) {
                        return HighlightWidget(
                          index: index,
                          vm: vm,
                          highlight: vm.highlights[index],
                          onTap: () {
                            if (index != vm.highlights.length - 1) {
                              PHelperFunction.switchScreen(
                                destination: Routes.dashboardHighlightPage,
                                args: vm.highlights[index],
                              );
                            }
                          },
                        ).symmetric(horizontal: PAppSize.s16);
                      }),
                    )
                    .symmetric(horizontal: PAppSize.s16)
                    .scrollable(scrollDirection: Axis.horizontal),
          ),

          //body
          Expanded(
            child: Container(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.darkBgColor
                  : PAppColor.fillColor,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PAppSize.s8.verticalSpace,
                    // Available Balance
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
                      PFormatter.formatCurrency(
                        amount: policyVm.summary.value.availableBalance == ''
                            ? 0.0
                            : double.parse(
                                policyVm.summary.value.availableBalance ?? '0',
                              ),
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

                    // PAppSize.s2.verticalSpace,

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InvestmentWidget(
                    //       title: 'total_investments'.tr,
                    //       value: PFormatter.formatCurrency(
                    //         amount: pensionVm.summary.value.totalInvestment ?? 0,
                    //       ),
                    //     ),
                    //     InvestmentWidget(
                    //       crossAxisAlignment: CrossAxisAlignment.end,
                    //       title: 'total_cover'.tr,
                    //       value: PFormatter.formatCurrency(
                    //         amount: policyVm.summary.value.totalCover ?? 0,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    PAppSize.s20.verticalSpace,

                    /// Products
                    PSeeAllWidget(
                      leadingText: 'products'.tr,
                      trailing: Text(
                        'see_all'.tr,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontSize: PAppSize.s16,
                              color: PAppColor.successMedium,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      onTap: () => PHelperFunction.switchScreen(
                        destination: Routes.productsPage,
                      ),
                    ),

                    PAppSize.s16.verticalSpace,

                    SizedBox(
                      height: PDeviceUtil.getDeviceHeight(context) * 0.30,
                      child: policyVm.loading.value == LoadingState.loading
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return PensionTierRedactWidget(
                                  loading: policyVm.loading.value,
                                );
                              },
                            )
                          : (policyVm.policies.isEmpty &&
                                pensionVm.schemes.isEmpty)
                          ? PEmptyStateWidget(message: 'no_results_found'.tr)
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: policyVm.products.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final product = policyVm.products[index];
                                return ProductWidget(
                                  product: product,
                                  onTap: () {
                                    if (product['type'] == ProductType.retail) {
                                      PHelperFunction.switchScreen(
                                        destination: Routes.policyOverviewPage,
                                        args: product,
                                      );
                                    } else {
                                      PHelperFunction.switchScreen(
                                        destination: Routes.pensionOverviewPage,
                                        args: product,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                    ),
                    // PDeviceUtil.isAndroid()
                    //     ? (PDeviceUtil.getDeviceHeight(context) * 0.035)
                    //           .verticalSpace
                    //     : (PDeviceUtil.getDeviceHeight(context) * 0.065)
                    //           .verticalSpace,
                  ],
                ).symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvestmentWidget extends StatelessWidget {
  const InvestmentWidget({
    super.key,
    required this.title,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s13,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
