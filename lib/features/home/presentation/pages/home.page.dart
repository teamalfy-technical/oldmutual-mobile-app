import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/presentation/widgets/affluent.badge.widget.dart';
import 'package:oldmutual_pensions_app/features/affluent/presentation/widgets/relationship.officer.card.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/cross.sell.dart';
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
  final crossSellVm = Get.put(PCrossSellVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: PSecureStorage().getAuthResponse(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Column(
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
                child: Column(
                  children: [
                    // Affluent user profile
                    AffluentBadgeWidget(user: user),
                    // Dashboard Highlights
                    Row(
                          children: List.generate(vm.highlights.length, (
                            index,
                          ) {
                            return HighlightWidget(
                              index: index,
                              vm: vm,
                              highlight: vm.highlights[index],
                              onTap: () {
                                PHelperFunction.switchScreen(
                                  destination: Routes.dashboardHighlightPage,
                                  args: vm.highlights[index],
                                );
                              },
                            ).symmetric(horizontal: PAppSize.s16);
                          }),
                        )
                        .symmetric(horizontal: PAppSize.s16)
                        .scrollable(scrollDirection: Axis.horizontal),
                  ],
                ),
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
                        if (user?.affluent == true) ...[
                          // Relationship officer
                          PAppSize.s8.verticalSpace,

                          PRelationshipOfficerCard(user: user),
                        ] else ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PAppSize.s8.verticalSpace,
                              // Available Balance
                              Text(
                                'available_balance'.tr,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontSize: PAppSize.s13,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              Text(
                                PFormatter.formatCurrency(
                                  amount:
                                      policyVm.summary.value.availableBalance ==
                                          ''
                                      ? 0.0
                                      : policyVm
                                                .summary
                                                .value
                                                .availableBalance ??
                                            0.0,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
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
                            ],
                          ),
                        ],

                        PAppSize.s20.verticalSpace,

                        SizedBox(
                          height: PDeviceUtil.isIOS()
                              ? PDeviceUtil.getDeviceHeight(context) * 0.35
                              : PDeviceUtil.getDeviceHeight(context) * 0.38,
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
                              : ((policyVm.summary.value.totalPolicies ?? 0) ==
                                        0 &&
                                    (pensionVm.summary.value.totalPensions ??
                                            0) ==
                                        0)
                              ? PEmptyStateWidget(
                                  message: 'no_results_found'.tr,
                                )
                              : Column(
                                  children: [
                                    PSeeAllWidget(
                                      leadingText: 'products'.tr,
                                      trailing: Text(
                                        'see_all'.tr,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
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
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: policyVm.products.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final product =
                                              policyVm.products[index];
                                          return ProductWidget(
                                            product: product,
                                            onTap: () {
                                              if (product['type'] ==
                                                  ProductType.insurance) {
                                                PHelperFunction.switchScreen(
                                                  destination:
                                                      Routes.policyOverviewPage,
                                                  args: product,
                                                );
                                              } else if (product['type'] ==
                                                  ProductType.pensions) {
                                                PHelperFunction.switchScreen(
                                                  destination: Routes
                                                      .pensionOverviewPage,
                                                  args: product,
                                                );
                                              } else {
                                                // Link corporate account to show details
                                              }
                                            },
                                            onAddTap: () {},
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ),

                        if (user?.affluent == true) ...[
                          PAppSize.s16.verticalSpace,
                          // Quick Actions for Affluent Users
                          PSeeAllWidget(leadingText: 'quick_access'.tr),
                        ],

                        // Cross-Sell (Recommendations)
                        if (crossSellVm.recommendations.isNotEmpty)
                          Column(
                            children: [
                              PAppSize.s20.verticalSpace,

                              /// Recommended For You
                              PSeeAllWidget(
                                leadingText: 'recommended_for_you'.tr,
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
                                  destination: Routes.recommendationPage,
                                ),
                              ),

                              PAppSize.s20.verticalSpace,
                              SizedBox(
                                height: PDeviceUtil.isIOS()
                                    ? PDeviceUtil.getDeviceHeight(context) *
                                          0.30
                                    : PDeviceUtil.getDeviceHeight(context) *
                                          0.33,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: crossSellVm.recommendations
                                      .take(3)
                                      .toList()
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final recommendation =
                                        crossSellVm.recommendations[index];
                                    return RecommendationWidget(
                                      recommendation: recommendation,
                                      showArrowButton: false,
                                      width:
                                          PDeviceUtil.getDeviceWidth(context) *
                                          0.65,
                                      onTap: () => PHelperFunction.switchScreen(
                                        destination:
                                            Routes.recommendationHighlightPage,
                                        args: recommendation,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    ).symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s20).scrollable(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class InvestmentWidget extends StatelessWidget {
  const InvestmentWidget({
    super.key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.subTitleStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
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
          style:
              titleStyle ??
              Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s13,
                fontWeight: FontWeight.w400,
              ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          softWrap: true,
          style:
              subTitleStyle ??
              Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s15,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
