import 'package:flutter/material.dart';
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
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return PProductRedactedWidget(
                  loading: vm.loading.value,
                  secondaryLoading: pensionVm.loading.value,
                );
              },
            )
          : vm.policies.isEmpty
          ? PEmptyStateWidget(message: 'no_results_found'.tr)
          : ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
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
