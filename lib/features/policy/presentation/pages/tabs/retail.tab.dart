import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PRetailTab extends StatelessWidget {
  final List<Object> products;
  final PolicyStatus type;
  PRetailTab({super.key, required this.products, required this.type});

  final policyVm = Get.put(PPolicyVm());
  final policyStatementVm = Get.put(PPolicyStatementVm());

  @override
  Widget build(BuildContext context) {
    return (products.isEmpty)
        ? PEmptyStateWidget(
            message: products is List<Scheme>
                ? 'no_scheme_found'.trParams({'name': type.name})
                : products is List<Policy>
                ? 'no_policy_found'.trParams({'name': type.name})
                : 'no_product_found'.trParams({'name': type.name}),
          )
        : PAnimatedListView<Object>(
            separatorBuilder: (context, index) => PAppSize.s16.verticalSpace,
            shrinkWrap: true,
            items: products,
            itemBuilder: (index, product) {
              final product = products[index];
              if (product is Policy) {
                return PPolicyWidget(
                  policy: product,
                  onTap: () {
                    policyVm.onSelectedPolicy(product); // keep selected policy
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
    // ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: policies.length,
    //     itemBuilder: (context, index) {
    //       final policy = policies[index];
    //       return RetailWidget(
    //         policy: policy,
    //         width: PDeviceUtil.getDeviceWidth(context),
    //         margin: EdgeInsets.only(bottom: PAppSize.s20),
    //         onTap: () {
    //           PHelperFunction.switchScreen(
    //             destination: Routes.policyDetailPage,
    //             args: policy,
    //           );
    //         },
    //       );
    //     },
    //   );
  }
}
