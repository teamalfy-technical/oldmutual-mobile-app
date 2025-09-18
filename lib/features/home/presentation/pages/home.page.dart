import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/dashboard/dashboard.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/products/products.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PHomePage extends StatelessWidget {
  PHomePage({super.key});

  final vm = Get.put(PHomeVm());
  final productVm = Get.put(PProductVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(
        title: Text('Hi ${PSecureStorage().getAuthResponse()?.name}'),
        // title: Text('Hi Bongani'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Assets.icons.notificationIcon.svg(
              height: PAppSize.s28,
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.cardDarkColor,
            ),
          ),
        ],
      ),
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
                    '₵10 000.00',
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

                  PAppSize.s2.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InvestmentWidget(
                        title: 'total_investments'.tr,
                        value: '₵20 839.13',
                      ),
                      InvestmentWidget(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        title: 'total_cover'.tr,
                        value: '₵112 460.61',
                      ),
                    ],
                  ),

                  PAppSize.s24.verticalSpace,

                  /// Products
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'products'.tr,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontSize: PAppSize.s16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        'see_all'.tr,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontSize: PAppSize.s16,
                              color: PAppColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ).onPressed(
                        onTap: () => PHelperFunction.switchScreen(
                          destination: Routes.productsPage,
                        ),
                      ),
                    ],
                  ),

                  PAppSize.s16.verticalSpace,

                  Expanded(
                    child: productVm.loading.value == LoadingState.loading
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return PensionTierRedactWidget(
                                loading: productVm.loading.value,
                              );
                            },
                          )
                        : (productVm.policies.isEmpty &&
                              productVm.schemes.isEmpty)
                        ? PEmptyStateWidget(message: 'no_results_found'.tr)
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: productVm.products.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final product = productVm.products[index];
                              return ProductWidget(
                                product: product,
                                onTap: () {
                                  if (product['type'] == ProductType.retail) {
                                    PHelperFunction.switchScreen(
                                      destination: Routes.productDetailPage,
                                      args: product,
                                    );
                                  }
                                },
                              );
                            },
                          ),
                  ),
                  PDeviceUtil.isAndroid()
                      ? (PDeviceUtil.getDeviceHeight(context) * 0.035)
                            .verticalSpace
                      : (PDeviceUtil.getDeviceHeight(context) * 0.065)
                            .verticalSpace,
                ],
              ).symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s20),
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
