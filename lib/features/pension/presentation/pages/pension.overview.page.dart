import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart'
    hide PPolicyWidget;
import 'package:oldmutual_pensions_app/features/policy/presentation/widgets/product.redacted.widget.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPensionOverviewPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const PPensionOverviewPage({super.key, required this.product});

  @override
  State<PPensionOverviewPage> createState() => _PPensionOverviewPageState();
}

class _PPensionOverviewPageState extends State<PPensionOverviewPage> {
  final vm = Get.find<PPensionVm>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.fetchSchemesOnFirstLoad();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('${widget.product['name']}')),
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
                Text(
                  PFormatter.formatCurrency(
                    amount: vm.summary.value.totalInvestment?.toDouble() ?? 0,
                  ),
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

                Expanded(
                  child: Obx(
                    () => RefreshIndicator.adaptive(
                      onRefresh: vm.getMemberSchemes,
                      color: PAppColor.primary,
                      child: vm.loading.value == LoadingState.loading
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return PProductRedactedWidget(
                                  loading: vm.loading.value,
                                );
                              },
                            )
                          : vm.schemes.isEmpty
                          ? PEmptyStateWidget(message: 'no_results_found'.tr)
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: vm.schemes.length,
                              itemBuilder: (context, index) {
                                final scheme = vm.schemes[index];
                                return PPensionWidget(
                                  scheme: vm.schemes[index],
                                  onTap: () {
                                    PHelperFunction.switchScreen(
                                      destination: Routes.pensionDetailPage,
                                      args: scheme,
                                    );
                                  },
                                );
                              },
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
