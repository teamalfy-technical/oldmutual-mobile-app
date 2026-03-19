import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPolicyOverviewPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const PPolicyOverviewPage({super.key, required this.product});

  @override
  State<PPolicyOverviewPage> createState() => _PPolicyOverviewPageState();
}

class _PPolicyOverviewPageState extends State<PPolicyOverviewPage>
    with SingleTickerProviderStateMixin {
  final vm = Get.find<PPolicyVm>();
  final pensionVm = Get.find<PPensionVm>();
  final policyStatementVm = Get.put(PPolicyStatementVm());
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
      vm.fetchPoliciesOnFirstLoad();
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
              widget.product['name'],
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
                  'available_balance'.tr,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                PCountUpText(
                  amount: widget.product['contribution'] ?? 0.0,
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

                // InvestmentWidget(title: 'status'.tr, value: 'active'.tr),
                // PAppSize.s12.verticalSpace,
                PCustomTabBarWidget(
                  controller: _tabController,
                  horizontalPadding: PAppSize.s0,
                  tabs: [
                    Tab(text: 'active'.tr),
                    Tab(text: 'inactive'.tr),
                  ],
                ),

                PAppSize.s16.verticalSpace,

                Expanded(
                  child: Obx(
                    () => RefreshIndicator.adaptive(
                      onRefresh: vm.getAllPolicies,
                      color: PAppColor.primary,
                      child: vm.loading.value == LoadingState.loading
                          ? PShimmerListView<Policy>(
                              loading: true,
                              items: const [],
                              separatorBuilder: (context, index) =>
                                  PAppSize.s16.verticalSpace,
                              placeholderItem: Policy(),
                              itemBuilder: (context, index, product) {
                                return PPolicyWidget(
                                  loading: true,
                                  policy: Policy(
                                    planDescription:
                                        'TRANSITION PLUS PLAN - RETAIL',
                                    sumAssured: 70000,
                                  ),
                                );
                              },
                            )
                          : vm.policies.isEmpty
                          ? PEmptyStateWidget(message: 'no_results_found'.tr)
                          : TabBarView(
                              controller: _tabController,
                              children: [
                                PRetailTab(
                                  products: vm.activePolicies,
                                  type: PolicyStatus.active,
                                ),
                                PRetailTab(
                                  products: vm.inactivePolicies,
                                  type: PolicyStatus.inactive,
                                ),
                              ],
                            ),
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
