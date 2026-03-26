import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/services/in.app.review.service.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/cross.sell.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PHomePage extends StatelessWidget {
  PHomePage({super.key});

  final vm = Get.put(PHomeVm());
  final policyVm = Get.put(PPolicyVm());
  final pensionVm = Get.put(PPensionVm());
  final crossSellVm = Get.put(PCrossSellVm());
  final affluentVm = Get.put(PAffluentVm());

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      PInAppReviewService().requestReviewIfEligible();
    });

    return Scaffold(
      body: Obx(() {
        final user = vm.user.value;
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
                        children: List.generate(vm.highlights.length, (index) {
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
                        Obx(
                          () => Column(
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
                              PCountUpText(
                                amount:
                                    policyVm.summary.value.availableBalance ??
                                    0.0,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
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
                        ),
                      ],

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

                      SizedBox(
                        height: PDeviceUtil.isIOS()
                            ? PDeviceUtil.getDeviceHeight(context) * 0.35
                            : PDeviceUtil.getDeviceHeight(context) * 0.38,
                        child: policyVm.loading.value == LoadingState.loading
                            ? Column(
                                children: [
                                  PShimmerWrapper(
                                    loading:
                                        policyVm.loading.value ==
                                        LoadingState.loading,
                                    child: PSeeAllWidget(
                                      leadingText: 'products'.tr,

                                      onTap: () {},
                                    ),
                                  ),
                                  PAppSize.s16.verticalSpace,
                                  Expanded(
                                    child:
                                        PShimmerListView<Map<String, dynamic>>(
                                          loading: true,
                                          items: const [],
                                          separatorBuilder: (context, index) =>
                                              PAppSize.s20.horizontalSpace,
                                          scrollDirection: Axis.horizontal,
                                          placeholderItem: {
                                            'name': 'Pensions',
                                            'type': ProductType.pensions,
                                            'num_of_account': 0,
                                            'contribution': 0.00,
                                          },
                                          itemBuilder:
                                              (context, index, product) {
                                                return ProductWidget(
                                                  loading: true,
                                                  product: product,
                                                );
                                              },
                                        ),
                                  ),
                                ],
                              )
                            : ((policyVm.summary.value.totalPolicies ?? 0) ==
                                      0 &&
                                  (pensionVm.summary.value.totalPensions ??
                                          0) ==
                                      0)
                            ? PEmptyStateWidget(message: 'no_products_found'.tr)
                            : Column(
                                children: [
                                  PSeeAllWidget(
                                    leadingText: 'products'.tr,

                                    onTap: () => PHelperFunction.switchScreen(
                                      destination: Routes.productsPage,
                                    ),
                                  ),
                                  PAppSize.s16.verticalSpace,
                                  Expanded(
                                    child: PAnimatedListView<Map<String, dynamic>>(
                                      separatorBuilder: (context, index) =>
                                          PAppSize.s20.horizontalSpace,
                                      animateType: AnimateType.slideLeft,
                                      shrinkWrap: true,
                                      items: policyVm.products,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (index, product) {
                                        // final product = policyVm.products[index];
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
                                                destination:
                                                    Routes.pensionOverviewPage,
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

                      PAppSize.s16.verticalSpace,

                      if (user?.affluent == true) ...[
                        PAppSize.s16.verticalSpace,
                        // Quick Actions for Affluent Users
                        PSeeAllWidget(
                          leadingText: 'quick_access'.tr,
                          showTrailing: false,
                        ),

                        PAppSize.s16.verticalSpace,

                        // Quick Access Grid
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: PAppSize.s20,
                          crossAxisSpacing: PAppSize.s20,
                          // childAspectRatio: 1.3,
                          children: [
                            QuickAccessCard(
                              icon: Assets.icons.financialInsight.svg(),
                              label: 'financial_insights'.tr,
                              onTap: () => PHelperFunction.switchScreen(
                                destination: Routes.financialInsightPage,
                              ),
                            ),
                            QuickAccessCard(
                              icon: Assets.icons.complimentaryServices.svg(),
                              label: 'complimentary_services'.tr,
                              onTap: () => PPopupDialog(context).warningMessage(
                                title: 'coming_soon_title'.tr,
                                message: 'coming_soon_msg'.tr,
                              ),
                              // onTap: () => PHelperFunction.switchScreen(
                              //   destination: Routes.complimentaryServicePage,
                              // ),
                            ),
                            QuickAccessCard(
                              icon: Assets.icons.affluentCard.svg(),
                              label: 'affluent_card'.tr,
                              onTap: () => PHelperFunction.switchScreen(
                                destination: Routes.affluentCardPage,
                                args: user,
                              ),
                            ),
                            QuickAccessCard(
                              icon: Assets.icons.trackClaims.svg(),
                              label: 'track_claims'.tr,
                              onTap: () => PHelperFunction.switchScreen(
                                destination: Routes.trackClaimsPage,
                              ),
                            ),
                          ],
                        ),

                        PAppSize.s16.verticalSpace,

                        // Exclusive Announcements for Affluent Users
                        PSeeAllWidget(
                          leadingText: 'exclusive_announcements'.tr,
                          showTrailing: false,
                        ),

                        PAppSize.s16.verticalSpace,

                        PAnimatedListView(
                          separatorBuilder: (context, index) =>
                              PAppSize.s20.verticalSpace,
                          items: affluentVm.exclusiveAnnouncements,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (index, announcement) {
                            final announcement =
                                affluentVm.exclusiveAnnouncements[index];
                            return PExclusiveWidget(announcement: announcement);
                          },
                        ),

                        PAppSize.s16.verticalSpace,

                        // Benefit Reminders for Affluent Users
                        PSeeAllWidget(
                          leadingText: 'benefit_reminders'.tr,
                          showTrailing: false,
                        ),

                        PAppSize.s16.verticalSpace,

                        PAnimatedListView(
                          separatorBuilder: (context, index) =>
                              PAppSize.s20.verticalSpace,
                          items: affluentVm.benefitReminders,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (index, reminder) {
                            // final reminder = affluentVm.benefitReminders[index];
                            return PBenefitRemindersWidget(reminder: reminder);
                          },
                        ),
                      ],

                      // Cross-Sell (Recommendations)
                      if (crossSellVm.recommendations.isNotEmpty)
                        Column(
                          children: [
                            PAppSize.s20.verticalSpace,

                            /// Recommended For You
                            PSeeAllWidget(
                              leadingText: 'recommended_for_you'.tr,
                              onTap: () => PHelperFunction.switchScreen(
                                destination: Routes.recommendationPage,
                              ),
                            ),

                            PAppSize.s20.verticalSpace,
                            SizedBox(
                              height: PDeviceUtil.isIOS()
                                  ? PDeviceUtil.getDeviceHeight(context) * 0.30
                                  : PDeviceUtil.getDeviceHeight(context) * 0.33,
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
      }),
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
