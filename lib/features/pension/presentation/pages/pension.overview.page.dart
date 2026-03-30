import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart'
    hide PPolicyWidget;
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPensionOverviewPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const PPensionOverviewPage({super.key, required this.product});

  @override
  State<PPensionOverviewPage> createState() => _PPensionOverviewPageState();
}

class _PPensionOverviewPageState extends State<PPensionOverviewPage>
    with SingleTickerProviderStateMixin {
  final vm = Get.find<PPensionVm>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.fetchSchemesOnFirstLoad();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(
        title: Hero(
          tag: 'product-hero-${widget.product['name']}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              '${widget.product['name']}',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
        ),
      ),
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
                  'overview'.tr,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                PCountUpText(
                  amount: vm.summary.value.totalInvestment?.toDouble() ?? 0,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                PCustomTabBarWidget(
                  controller: _tabController,
                  horizontalPadding: PAppSize.s0,
                  tabs: [
                    Tab(text: 'active'.tr),
                    Tab(text: 'inactive'.tr),
                  ],
                ),

                // PAppSize.s5.verticalSpace,

                // InvestmentWidget(title: 'status'.tr, value: 'active'.tr),
                PAppSize.s16.verticalSpace,
                Expanded(
                  child: Obx(
                    () => RefreshIndicator.adaptive(
                      onRefresh: vm.getMemberSchemes,
                      color: PAppColor.primary,
                      child: vm.loading.value == LoadingState.loading
                          ? PShimmerListView<Scheme>(
                              loading: true,
                              items: const [],
                              separatorBuilder: (context, index) =>
                                  PAppSize.s16.verticalSpace,
                              scrollDirection: Axis.vertical,
                              placeholderItem: Scheme(
                                masterSchemeDescription: 'Sample Scheme Name',
                                employerName: 'Sample Employer',
                                schemeCurrentValue: 50000,
                              ),
                              itemBuilder: (context, index, scheme) {
                                return PPensionWidget(
                                  loading: true,
                                  scheme: scheme,
                                );
                              },
                            )
                          : vm.schemes.isEmpty
                          ? PEmptyStateWidget(message: 'no_results_found'.tr)
                          : TabBarView(
                              controller: _tabController,
                              children: [
                                // PAllProductTab(),
                                PRetailTab(
                                  products: vm.activeSchemes,
                                  type: PolicyStatus.active,
                                ),
                                PRetailTab(
                                  products: vm.inactiveSchemes,
                                  type: PolicyStatus.inactive,
                                ),
                                // PRetailTab(policies: vm.lapsedPolicies, type: PolicyStatus.lapsed),
                              ],
                            ),

                      // ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount: vm.schemes.length,
                      //     itemBuilder: (context, index) {
                      //       final scheme = vm.schemes[index];
                      //       return PPensionWidget(
                      //         scheme: vm.schemes[index],
                      //         onTap: () {
                      //           PHelperFunction.switchScreen(
                      //             destination: Routes.pensionDetailPage,
                      //             args: scheme,
                      //           );
                      //         },
                      //       );
                      //     },
                      //   ),
                    ),
                  ),
                ),
              ],
            ).symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s10),
          ),
        ],
      ),
    );
  }
}
