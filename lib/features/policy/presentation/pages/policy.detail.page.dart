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
              'cover_amount'.tr,
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              PFormatter.formatCurrency(
                amount: vm.summary.value.totalLifeInvestment ?? 0,
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
                  value: 'active'.tr,
                ),
              ],
            ),

            PAppSize.s18.verticalSpace,

            /// Quick Actions
            Row(
              children: [
                QuickActionWidget(
                  label: 'pay'.tr,
                  icon: Assets.icons.payIcon.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.successLight
                        : PAppColor.successDark,
                  ),
                  onTap: () {},
                ),
                PAppSize.s8.horizontalSpace,
                QuickActionWidget(
                  label: 'generate_report'.tr,
                  icon: Assets.icons.document.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.successLight
                        : PAppColor.successDark,
                  ),
                  onTap: () => PHelperFunction.switchScreen(
                    destination: Routes.policyDocumentPage,
                  ),
                ),
                PAppSize.s8.horizontalSpace,
                QuickActionWidget(
                  label: 'policy_document'.tr,
                  icon: Assets.icons.factsheetIcon.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.successLight
                        : PAppColor.successDark,
                  ),
                  onTap: () {},
                ),
                PAppSize.s8.horizontalSpace,
                QuickActionWidget(
                  label: 'premium_statement'.tr,
                  icon: Assets.icons.article.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.successLight
                        : PAppColor.successDark,
                  ),
                  onTap: () {},
                ),
                PAppSize.s8.horizontalSpace,
                QuickActionWidget(
                  label: 'investment_statement'.tr,
                  icon: Assets.icons.calculate.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.successLight
                        : PAppColor.successDark,
                  ),
                  onTap: () {},
                ),
                PAppSize.s8.horizontalSpace,
                QuickActionWidget(
                  label: 'claim'.tr,
                  icon: Assets.icons.withdrawIcon.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.successLight
                        : PAppColor.successDark,
                  ),
                  onTap: () {},
                ),
              ],
            ).scrollable(scrollDirection: Axis.horizontal),

            PAppSize.s14.verticalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Policy
                  PCustomCardWidget(
                    useBorder: false,
                    child: Column(
                      children: [
                        _buildListTile(
                          context,
                          'policy_number'.tr,
                          '${policy.policyNo}',
                        ),
                        Divider(height: PAppSize.s1),
                        _buildListTile(
                          context,
                          'investment_term'.tr,
                          '${PFormatter.calculateDateDiff(policy.maturityDate!, DateDiffUnit.years)} years',
                        ),
                      ],
                    ),
                  ),

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
                        _buildListTile(
                          context,
                          'contract_number'.tr,
                          'OMG60338PO461',
                        ),
                        Divider(height: PAppSize.s1),
                        _buildListTile(
                          context,
                          'product_description'.tr,
                          '${policy.planDescription}',
                        ),
                        Divider(height: PAppSize.s1),
                        _buildListTile(
                          context,
                          'amount_savings_value'.tr,
                          PFormatter.formatCurrency(
                            amount: policy.premiumPaid ?? 0,
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        _buildListTile(
                          context,
                          'start_date'.tr,
                          PFormatter.formatDate(
                            dateFormat: DateFormat('d MMMM y'),
                            date: DateTime.parse(
                              policy.commencementDate ??
                                  policy.issuedDate ??
                                  '',
                            ),
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        _buildListTile(
                          context,
                          'end_date'.tr,
                          PFormatter.formatDate(
                            dateFormat: DateFormat('d MMMM y'),
                            date: DateTime.parse(
                              policy.maturityDate ?? policy.issuedDate ?? '',
                            ),
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        _buildListTile(
                          context,
                          'monthly_premium'.tr,
                          '${policy.paymentFrequency}',
                        ),
                        Divider(height: PAppSize.s1),
                        _buildListTile(
                          context,
                          'premium_amount'.tr,
                          PFormatter.formatCurrency(
                            amount: policy.modalPrem ?? 00,
                          ),
                        ),
                        Divider(height: PAppSize.s1),
                        _buildListTile(
                          context,
                          'total_redemption'.tr,
                          PFormatter.formatCurrency(
                            amount: policy.premiumPaid ?? 0,
                          ),
                          // PFormatter.formatCurrency(amount: 890.70),
                        ),
                      ],
                    ),
                  ),

                  PAppSize.s16.verticalSpace,

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
                              backgroundImage: AssetImage(
                                Assets.images.placeholderImg.path,
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

  Widget _buildListTile(BuildContext context, String title, String subTitle) {
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
}
