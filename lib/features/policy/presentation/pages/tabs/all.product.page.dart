import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PAllProductTab extends StatelessWidget {
  PAllProductTab({super.key});

  final vm = Get.put(PPolicyVm());
  final pensionVm = Get.put(PPensionVm());
  final policyStatementVm = Get.put(PPolicyStatementVm());

  @override
  Widget build(BuildContext context) {
    final products = [...vm.policies, ...pensionVm.schemes];
    return ListView.builder(
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
    );
  }
}
