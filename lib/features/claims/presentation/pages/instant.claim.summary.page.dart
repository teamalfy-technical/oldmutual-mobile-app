import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PInstantClaimSummaryPage extends StatelessWidget {
  PInstantClaimSummaryPage({super.key});

  final PClaimsVm ctrl = Get.put(PClaimsVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('summary'.tr)),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: PAppSize.s2),
        padding: EdgeInsets.symmetric(
          horizontal: PAppSize.s20,
          vertical: PAppSize.s20,
        ),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkBgColor
            : PAppColor.whiteColor,
        child: Column(
          children: [
            PAppSize.s8.verticalSpace,
            PCustomCardWidget(
              borderRadius: BorderRadius.circular(PAppSize.s8),
              useBorder: false,
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.cardDarkColor.withOpacityExt(PAppSize.s0_5)
                  : PAppColor.fillColor5,
              padding: EdgeInsets.symmetric(
                horizontal: PAppSize.s20,
                vertical: PAppSize.s25,
              ),
              child: PAnimatedColumnWidget(
                animateType: AnimateType.slideRight,
                children: [
                  PSummaryRowWidget(
                    label: 'Policy'.tr,
                    value:
                        ctrl.selectedPolicy?.planDescription ??
                        ctrl.selectedPolicy?.policyNo ??
                        '',
                  ),
                  PAppSize.s14.verticalSpace,
                  PSummaryRowWidget(
                    label: 'claim_type'.tr,
                    value:
                        '${ctrl.selectedClaimType?.label} — ${ctrl.selectedWithdrawalClaimType?.name.capitalizeFirst ?? ''}',
                  ),
                  PAppSize.s14.verticalSpace,
                  PSummaryRowWidget(
                    label: 'Claim Amount'.tr,
                    value: PFormatter.formatCurrency(
                      amount: ctrl.amountTEC.text.trim().isEmpty
                          ? 0.0
                          : double.parse(ctrl.amountTEC.text),
                    ),
                  ),

                  PAppSize.s14.verticalSpace,
                  PSummaryRowWidget(
                    label: 'Charge (2%)'.tr,
                    value:
                        '- ${PFormatter.formatCurrency(amount: ctrl.charge)}',
                  ),
                  PAppSize.s14.verticalSpace,
                  PSummaryRowWidget(
                    label: 'Net Amount'.tr,
                    value: PFormatter.formatCurrency(
                      amount: ctrl.amountReceivable,
                    ),
                    valueColor: PAppColor.primary,
                  ),
                  PAppSize.s14.verticalSpace,
                  PSummaryRowWidget(
                    label: 'Payment'.tr,
                    value:
                        '${ctrl.selectedPaymentMethod?.name ?? ''} — ${PHelperFunction.formatPhoneNumber(ctrl.selectedWithdrawalClaimType == ClaimType.instant ? ctrl.momoNumberTEC.text.trim() : '')}',
                  ),
                ],
              ),
            ),
            PAppSize.s16.verticalSpace,
            // Agreement
            Text(
              'By submitting, your claim will be processed immediately through Hubtel and a reference generated via SLAMS.',
              textAlign: TextAlign.start,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
            ),

            PAppSize.s32.verticalSpace,

            Obx(() {
              return PGradientButton(
                label: 'Process Claim'.tr,
                showIcon: true,
                loading: ctrl.submitting.value,
                iconDirection: IconDirection.right,

                textColor: PAppColor.whiteColor,
                width: PDeviceUtil.getDeviceWidth(context),
                onTap: () {
                  ctrl.navigateToSuccessPage();
                },
                // onTap: ctrl.submitInstantClaimRequest,
              );
            }),

            PAppSize.s32.verticalSpace,
          ],
        ).scrollable(),
      ),
    );
  }
}
