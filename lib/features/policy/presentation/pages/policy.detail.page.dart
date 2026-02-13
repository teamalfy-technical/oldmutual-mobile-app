import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPolicyDetailPage extends StatelessWidget {
  final Policy policy;
  PPolicyDetailPage({super.key, required this.policy});

  final vm = Get.put(PPolicyVm());
  final policyStatementVm = Get.find<PPolicyStatementVm>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text(policy.planDescription ?? '')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PAppSize.s2.verticalSpace,
            // Cover Amount
            Text(
              'available_balance'.tr,
              // 'cover_amount'.tr,
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              PFormatter.formatCurrency(amount: policy.availableBalance ?? 0),
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

            PAppSize.s6.verticalSpace,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InvestmentWidget(
                  title: 'monthly_premium'.tr,
                  value: PFormatter.formatCurrency(
                    amount: policy.modalPrem?.toDouble() ?? 0,
                  ),
                ),
                InvestmentWidget(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  title: 'status'.tr,
                  value: activeStatuses.contains(policy.status)
                      ? 'active'.tr
                      : 'inactive'.tr,
                ),
              ],
            ),

            PAppSize.s18.verticalSpace,

            /// Quick Actions
            Row(
              children: [
                if (activeStatuses.contains(policy.status)) ...[
                  QuickActionWidget(
                    label: 'pay_premium'.tr,
                    icon: Assets.icons.payIcon.svg(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.successLight
                          : PAppColor.successDark,
                    ),
                    onTap: () {
                      showPayModal(context: context, product: policy);
                      // PPopupDialog(context).warningMessage(
                      //   title: 'coming_soon_title'.tr,
                      //   message: 'coming_soon_msg'.tr,
                      // );
                    },
                  ),
                  PAppSize.s8.horizontalSpace,
                ],

                QuickActionWidget(
                  label: 'policy_document'.tr,
                  icon: Assets.icons.downloadIcon.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.successLight
                        : PAppColor.successDark,
                  ),
                  onTap: () {
                    // download policy document
                    policyStatementVm.downloadPolicyDocument();
                    // PPopupDialog(context).warningMessage(
                    //   title: 'Coming Soon',
                    //   message: 'This feature will be available soon',
                    // );
                  },
                ),
                PAppSize.s8.horizontalSpace,
                QuickActionWidget(
                  label: 'premium_statement'.tr,
                  icon: Assets.icons.downloadIcon.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.successLight
                        : PAppColor.successDark,
                  ),
                  onTap: () => PHelperFunction.switchScreen(
                    destination: Routes.premiumStatementPage,
                  ),
                ),
                if ((policy.availableBalance ?? 0) > 0) ...[
                  PAppSize.s8.horizontalSpace,
                  QuickActionWidget(
                    label: 'investment_statement'.tr,
                    icon: Assets.icons.downloadIcon.svg(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.successLight
                          : PAppColor.successDark,
                    ),
                    onTap: () {
                      // download investment statement
                      policyStatementVm.downloadInvestmentStatement();
                    },
                  ),
                ],

                PAppSize.s8.horizontalSpace,
                QuickActionWidget(
                  label: 'claim'.tr,
                  icon: Assets.icons.withdrawIcon.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.successLight
                        : PAppColor.successDark,
                  ),
                  onTap: () => PHelperFunction.switchScreen(
                    destination: Routes.policyClaimPage,
                  ),
                ),
              ],
            ).scrollable(scrollDirection: Axis.horizontal),

            PAppSize.s14.verticalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Policy
                  // PCustomCardWidget(
                  //   useBorder: false,
                  //   child: Column(
                  //     children: [
                  //       buildListTile(
                  //         context,
                  //         'policy_number'.tr,
                  //         '${policy.policyNo}',
                  //       ),
                  //       Divider(height: PAppSize.s1),
                  //       buildListTile(
                  //         context,
                  //         'investment_term'.tr,
                  //         '${PFormatter.calculateDateDiff(policy.maturityDate!, DateDiffUnit.years)} years',
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // PAppSize.s18.verticalSpace,
                  PAppSize.s16.verticalSpace,

                  /// Policy Details
                  Text(
                    'policy_detail'.tr,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: PAppSize.s16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  PAppSize.s14.verticalSpace,
                  PCustomCardWidget(
                    useBorder: false,
                    child: Column(
                      children: [
                        buildListTile(
                          context,
                          'policy_number'.tr,
                          policy.policyNo ?? '',
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'policy_description'.tr,
                          '${policy.planDescription}',
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'payment_mode_description'.tr,
                          '${policy.paymentModeDescription}',
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'modal_premium'.tr,
                          PFormatter.formatCurrency(
                            amount: policy.modalPrem ?? 0,
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'sum_assured'.tr,
                          PFormatter.formatCurrency(
                            amount: policy.sumAssured ?? 0,
                            symbol:
                                policy.planDescription ==
                                    PAppConstant.internationalTravel
                                ? '€'
                                : '₵',
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'cash_value'.tr,
                          PFormatter.formatCurrency(
                            amount: policy.availableBalance ?? 0,
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'total_benefit'.tr,
                          PFormatter.formatCurrency(
                            amount:
                                ((policy.availableBalance ?? 0) +
                                (policy.sumAssured ?? 0)),
                            symbol:
                                policy.planDescription ==
                                    PAppConstant.internationalTravel
                                ? '€'
                                : '₵',
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'premium_frequency'.tr,
                          policy.paymentFrequency ?? '',
                        ),

                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'premium_due_date'.tr,
                          PFormatter.formatDate(
                            dateFormat: DateFormat('d MMMM y'),
                            date: DateTime.parse(
                              policy.premDueDate ??
                                  DateTime.now().toIso8601String(),
                            ),
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'last_premium_date'.tr,
                          PFormatter.formatDate(
                            dateFormat: DateFormat('d MMMM y'),
                            date: DateTime.parse(
                              policy.lastPremDate ??
                                  DateTime.now().toIso8601String(),
                            ),
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'premium_issued_date'.tr,
                          PFormatter.formatDate(
                            dateFormat: DateFormat('d MMMM y'),
                            date: DateTime.parse(
                              policy.issuedDate ??
                                  DateTime.now().toIso8601String(),
                            ),
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        buildListTile(
                          context,
                          'premium_maturity_date'.tr,
                          PFormatter.formatDate(
                            dateFormat: DateFormat('d MMMM y'),
                            date: DateTime.parse(
                              policy.maturityDate ??
                                  DateTime.now().toIso8601String(),
                            ),
                          ),
                        ),
                        // Divider(height: PAppSize.s1),
                        // buildListTile(
                        //   context,
                        //   'policy_term'.tr,
                        //   '${policy.termOfPolicy ?? 0}',
                        // ),
                      ],
                    ),
                  ),

                  PAppSize.s16.verticalSpace,

                  /// Premium upgrade (Upsell)
                  // PPremiumUpgradeWidget(policy: policy),

                  // PAppSize.s16.verticalSpace,

                  // if (title == 'investments'.tr) ...[
                  //   /// Products
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'bank_details'.tr,
                  //         textAlign: TextAlign.center,
                  //         softWrap: true,
                  //         style: Theme.of(context).textTheme.titleMedium
                  //             ?.copyWith(
                  //               fontSize: PAppSize.s16,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //       ),
                  //       Text(
                  //         'edit'.tr,
                  //         textAlign: TextAlign.center,
                  //         softWrap: true,
                  //         style: Theme.of(context).textTheme.titleMedium
                  //             ?.copyWith(
                  //               fontSize: PAppSize.s14,
                  //               color: PAppColor.successDark,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //       ).onPressed(onTap: () {}),
                  //     ],
                  //   ),

                  //   PAppSize.s16.verticalSpace,

                  //   Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(PAppSize.s20),
                  //       color: PHelperFunction.isDarkMode(context)
                  //           ? PAppColor.darkAppBarColor
                  //           : PAppColor.whiteColor,
                  //     ),
                  //     child: _buildListTile(
                  //       context,
                  //       '00678940900',
                  //       'Standard bank',
                  //     ),
                  //   ),
                  //   PAppSize.s16.verticalSpace,

                  //   /// Products
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'beneficiaries'.tr,
                  //         textAlign: TextAlign.center,
                  //         softWrap: true,
                  //         style: Theme.of(context).textTheme.titleMedium
                  //             ?.copyWith(
                  //               fontSize: PAppSize.s16,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //       ),
                  //       Text(
                  //         'add_new'.tr,
                  //         textAlign: TextAlign.center,
                  //         softWrap: true,
                  //         style: Theme.of(context).textTheme.titleMedium
                  //             ?.copyWith(
                  //               fontSize: PAppSize.s14,
                  //               color: PAppColor.successDark,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //       ).onPressed(onTap: () {}),
                  //     ],
                  //   ),

                  //   PAppSize.s16.verticalSpace,

                  //   // Beneficiaries section
                  //   Container(
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         width: PAppSize.s1,
                  //         color: PAppColor.fillColor2,
                  //       ),
                  //       borderRadius: BorderRadius.circular(PAppSize.s20),
                  //       color: PHelperFunction.isDarkMode(context)
                  //           ? PAppColor.darkAppBarColor
                  //           : PAppColor.whiteColor,
                  //     ),
                  //     child: ListView.separated(
                  //       shrinkWrap: true,
                  //       itemCount: 2,
                  //       itemBuilder: (context, index) {
                  //         return ListTile(
                  //           leading: CircleAvatar(
                  //             radius: PAppSize.s24,
                  //             backgroundImage: AssetImage(
                  //               Assets.images.placeholderImg.path,
                  //             ),
                  //           ),
                  //           title: Text(
                  //             'Obiajulu Anayo',
                  //             style: Theme.of(context).textTheme.bodyLarge
                  //                 ?.copyWith(
                  //                   fontSize: PAppSize.s15,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //           ),
                  //           subtitle: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 '50% Split',
                  //                 style: Theme.of(context).textTheme.bodyLarge
                  //                     ?.copyWith(
                  //                       fontSize: PAppSize.s14,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //               ),

                  //               Text(
                  //                 'Brother - ${PFormatter.formatDate(dateFormat: DateFormat('d MMMM y'), date: DateTime.now().subtract(Duration(days: 5150)))}',
                  //                 style: Theme.of(context).textTheme.bodyLarge
                  //                     ?.copyWith(
                  //                       fontSize: PAppSize.s13,
                  //                       fontWeight: FontWeight.w400,
                  //                     ),
                  //               ),
                  //             ],
                  //           ),
                  //           trailing: Assets.icons.arrowRightBlack.svg(
                  //             color: PHelperFunction.isDarkMode(context)
                  //                 ? PAppColor.whiteColor
                  //                 : PAppColor.blackColor,
                  //           ),
                  //         );
                  //       },
                  //       separatorBuilder: (context, index) =>
                  //           Divider().symmetric(horizontal: PAppSize.s20),
                  //     ),
                  //   ),
                  // ],

                  // Beneficiaries section
                  if (policy.beneficiaries!.isNotEmpty) ...[
                    PCustomCardWidget(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: policy.beneficiaries!.length,
                        itemBuilder: (context, index) {
                          final beneficiary = policy.beneficiaries![index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: PAppSize.s24,
                              backgroundColor:
                                  PHelperFunction.isDarkMode(context)
                                  ? PAppColor.whiteColor
                                  : PAppColor.darkAppBarColor2,
                              // backgroundImage: AssetImage(
                              //   Assets.images.placeholderImg.path,
                              // ),
                              child: Text(
                                (beneficiary.fullName ?? '').substring(0, 1),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: PHelperFunction.isDarkMode(context)
                                          ? PAppColor.darkBgColor
                                          : PAppColor.whiteColor,
                                      fontSize: PAppSize.s20,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            onTap: () => showBeneficiaryDetailModal(
                              context,
                              beneficiary,
                            ),
                            title: Text(
                              beneficiary.fullName ?? '',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s15,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  beneficiary.percAlloc == 100
                                      ? '${beneficiary.percAlloc}%'
                                      : '${beneficiary.percAlloc}% Split',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontSize: PAppSize.s14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),

                                Text(
                                  '${beneficiary.relationship}',
                                  // '${beneficiary.relationship} - ${PFormatter.formatDate(dateFormat: DateFormat('d MMMM y'), date: DateTime.now().subtract(Duration(days: 5150)))}',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontSize: PAppSize.s13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                            trailing: Assets.icons.arrowRightBlack.svg(
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.whiteColor
                                  : PAppColor.blackColor,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider().symmetric(horizontal: PAppSize.s20),
                      ),
                    ),
                  ],
                ],
              ).scrollable(),
            ),
          ],
        ).symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s10),
      ),
    );
  }

  Future showBeneficiaryDetailModal(
    BuildContext context,
    Beneficiary beneficiary,
  ) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(PAppSize.s24),
          topRight: Radius.circular(PAppSize.s24),
        ),
      ),
      builder: (context) {
        return PBeneficiaryDetailWidget(beneficiary: beneficiary);
      },
    );
  }
}

Widget buildListTile(BuildContext context, String title, String subTitle) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: PAppSize.s16),
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: PAppSize.s14,
        fontWeight: FontWeight.w400,
      ),
    ),
    subtitle: Text(
      subTitle,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: PAppSize.s18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
