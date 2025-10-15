import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PRetailTab extends StatelessWidget {
  final List<Policy> policies;
  final PolicyStatus type;
  const PRetailTab({super.key, required this.policies, required this.type});

  @override
  Widget build(BuildContext context) {
    return (policies.isEmpty)
        ? PEmptyStateWidget(
            message: 'no_policy_found'.trParams({'name': type.name}),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: policies.length,
            itemBuilder: (context, index) {
              final policy = policies[index];
              return RetailWidget(
                policy: policy,
                width: PDeviceUtil.getDeviceWidth(context),
                margin: EdgeInsets.only(bottom: PAppSize.s20),
                onTap: () {
                  PHelperFunction.switchScreen(
                    destination: Routes.policyDetailPage,
                    args: policy,
                  );
                },
              );
            },
          );
  }
}
