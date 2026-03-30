import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPremiumStatementPage extends StatelessWidget {
  PPremiumStatementPage({super.key});

  final vm = Get.put(PPolicyStatementVm());
  final policyVm = Get.find<PPolicyVm>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('premium_statement'.tr)),
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PPageTagWidget(
              //   tag: 'statements_hint_tag'.tr,
              //   textAlign: TextAlign.center,
              // ),
              Text(
                'generate_premium_hint'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  // fontSize: PAppSize.s10,
                ),
              ),

              PAppSize.s10.verticalSpace,

              // Statements Filter Options
              PCustomCardWidget(
                padding: EdgeInsets.symmetric(
                  horizontal: PAppSize.s20,
                  vertical: PAppSize.s28,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${'policy'.tr}: ${vm.selectedPolicy?.planDescription ?? policyVm.selectedPolicy?.planDescription ?? 'not_applicable'.tr}',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          // fontSize: PAppSize.s10,
                        ),
                      ),
                    ),
                    PAppSize.s20.verticalSpace,
                    PCustomDropdownField<ContributedYear>(
                      labelText: 'select_year'.tr,
                      initialValue: vm.selectedYear,
                      items: vm.contributionYears
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.fundYear ?? ''),
                            ),
                          )
                          .toList(),
                      onChanged: vm.onYearChanged,
                    ),

                    // PAppSize.s16.verticalSpace,

                    // PCustomDropdownField<Policy>(
                    //   labelText: 'select_policy'.tr,
                    //   initialValue: vm.matchedSelectedPolicy,
                    //   items: vm.policyOptions
                    //       .map(
                    //         (e) => DropdownMenuItem(
                    //           value: e,
                    //           child: Text(e.planDescription ?? ''),
                    //         ),
                    //       )
                    //       .toList(),
                    //   onChanged: vm.onSelectedPolicyReport,
                    // ),
                    PAppSize.s20.verticalSpace,
                    PGradientButton(
                      label: 'generate_statement'.tr,
                      showIcon: false,
                      textColor: PAppColor.whiteColor,
                      radius: PAppSize.s20,
                      loading: vm.generating.value,
                      width: double.infinity,
                      height: PAppSize.s44,
                      onTap: () {
                        vm.generatePremiumStatement();
                      },
                    ),
                  ],
                ),
              ),

              PAppSize.s10.verticalSpace,

              Text(
                'premium_generated_hint'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  // fontSize: PAppSize.s10,
                ),
              ),
              PAppSize.s10.verticalSpace,

              Expanded(
                child: PCustomCardWidget(
                  padding: EdgeInsets.symmetric(
                    vertical: PAppSize.s16,
                    horizontal: PAppSize.s4,
                  ),

                  child: RefreshIndicator.adaptive(
                    onRefresh: () => vm.getAllGeneratedReports(),
                    child: vm.loading.value == LoadingState.loading
                        ? PShimmerListView<PolicyReport>(
                            loading: true,
                            items: const [],
                            separatorBuilder: (context, index) =>
                                PAppSize.s16.verticalSpace,
                            scrollDirection: Axis.vertical,
                            placeholderItem: PolicyReport(
                              id: 0,
                              type: 'Sample Scheme Name',
                              createdAt: "2026-03-12T23:30:57.000000Z",
                              filePath:
                                  "reports/2026/03/policy-trans-statement_2001OMEP194287_20260312_233057.pdf",
                              filters: Filters(year: "2026"),
                              downloadUrl:
                                  "https://test-app.oldmutual.com.gh/api/reports/378?token=ewqNJj5qYYo6KmPlx6vx7l0R1Pbtt8jC4W9PTEFA&download=true",
                            ),
                            itemBuilder: (context, index, statement) {
                              return PPremiumStatementWidget(
                                statement: statement,
                              );
                            },
                          )
                        : vm.statements.isEmpty
                        ? PEmptyStateWidget(message: 'no_results_found'.tr)
                        : PAnimatedListView<PolicyReport>(
                            shrinkWrap: true,
                            items: vm.statements, // limits to 4 safely
                            itemBuilder: (index, statement) {
                              return PPremiumStatementWidget(
                                statement: statement,
                                selectedYear: vm.selectedYear,
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              height: 0,
                            ).symmetric(horizontal: PAppSize.s20),
                          ),
                  ),
                ),
              ),
            ],
          ).all(PAppSize.s20),
        ),
      ),
    );
  }
}
