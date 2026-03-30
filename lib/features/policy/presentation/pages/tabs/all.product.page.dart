import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PAllProductTab extends StatefulWidget {
  const PAllProductTab({super.key});

  @override
  State<PAllProductTab> createState() => _PAllProductTabState();
}

class _PAllProductTabState extends State<PAllProductTab> {
  final vm = Get.put(PPolicyVm());

  final pensionVm = Get.put(PPensionVm());

  final policyStatementVm = Get.put(PPolicyStatementVm());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        vm.fetchPoliciesOnFirstLoad(),
        pensionVm.fetchSchemesOnFirstLoad(),
      ]);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = [...vm.policies, ...pensionVm.schemes];
    return Obx(
      () =>
          (vm.loading.value == LoadingState.loading ||
              pensionVm.loading.value == LoadingState.loading)
          ? PShimmerListView<Scheme>(
              loading: true,
              items: const [],
                   separatorBuilder: (context, index) =>
                          PAppSize.s16.verticalSpace,
              placeholderItem: Scheme(
                masterSchemeDescription: 'Sample Scheme Name',
                employerName: 'Sample Employer',
                schemeCurrentValue: 50000,
              ),
              itemBuilder: (context, index, scheme) {
                return PPensionWidget(loading: true, scheme: scheme);
              },
            )
          : vm.policies.isEmpty
          ? PEmptyStateWidget(message: 'no_results_found'.tr)
          : PAnimatedListView<Object>(
              separatorBuilder: (context, index) => PAppSize.s16.verticalSpace,
              shrinkWrap: true,
              items: products,
              itemBuilder: (index, product) {
                // final product = products[index];
                if (product is Policy) {
                  return PPolicyWidget(
                    policy: product,
                    onTap: () {
                      policyStatementVm.onSelectedPolicyReport(product);
                      PHelperFunction.switchScreen(
                        destination: Routes.policyDetailPage,
                        args: product,
                      );
                    },
                  );
                } else if (product is Scheme) {
                  return PPensionWidget(
                    scheme: product,
                    onTap: () {
                      PHelperFunction.switchScreen(
                        destination: Routes.pensionDetailPage,
                        args: product,
                      );
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
    );
  }
}
