import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PInstantClaimPage extends StatelessWidget {
  PInstantClaimPage({super.key});
  final FocusNode _amountFocusNode = FocusNode();

  final PClaimsVm ctrl = Get.put(PClaimsVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('instant_claim'.tr)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PAppSize.s12.verticalSpace,
          Text(
            'enter_claim_amount_hint'.tr,
            textAlign: TextAlign.start,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ).paddingAll(PAppSize.s20),
          PAppSize.s8.verticalSpace,

          Expanded(
            child: PCustomCardWidget(
              borderRadius: BorderRadius.circular(PAppSize.s0),
              useBorder: false,
              padding: EdgeInsets.symmetric(
                horizontal: PAppSize.s20,
                vertical: PAppSize.s20,
              ),
              child: Form(
                child: PAnimatedColumnWidget(
                  children: [
                    PKeyboardActions(
                      focusNode: _amountFocusNode,
                      child: PCustomTextField(
                        labelText:
                            'Amount (e.g. max = ${PFormatter.formatCurrency(amount: 3000)})',
                        hintText: '',
                        controller: ctrl.amountTEC,
                        focusNode: _amountFocusNode,
                        textInputType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: ctrl.onAmountChanged,
                        validator: PValidator.validatePaymentAmount,
                        inputFormatters: [
                          MaxAmountFormatter(() => ctrl.maximumClaimable),
                        ],
                      ),
                    ),
                    PAppSize.s12.verticalSpace,
                    Divider(),
                    PAppSize.s12.verticalSpace,

                    Obx(() {
                      ctrl.amount.value;
                      return PBlueTagWidget(
                        child: Column(
                          children: [
                            PSummaryRowWidget(
                              label: 'charge'.tr,
                              value:
                                  '- ${PFormatter.formatCurrency(amount: ctrl.charge)}',
                            ),
                            PAppSize.s12.verticalSpace,
                            PSummaryRowWidget(
                              label: 'youll_receive'.tr,
                              value: PFormatter.formatCurrency(
                                amount: ctrl.amountReceivable,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    PAppSize.s20.verticalSpace,

                    /// Summary of Charges
                    PCustomCardWidget(
                      borderRadius: BorderRadius.circular(PAppSize.s8),
                      useBorder: false,
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.cardDarkColor.withOpacityExt(
                              PAppSize.s0_5,
                            )
                          : PAppColor.fillColor5,
                      padding: EdgeInsets.symmetric(
                        horizontal: PAppSize.s20,
                        vertical: PAppSize.s25,
                      ),
                      child: Column(
                        children: [
                          PSummaryRowWidget(
                            label: 'available_cash_value'.tr,
                            value: PFormatter.formatCurrency(
                              amount:
                                  ctrl.selectedPolicy?.availableBalance ?? 0,
                            ),
                          ),
                          PAppSize.s14.verticalSpace,
                          PSummaryRowWidget(
                            label: 'maximum_claimable'.tr,
                            value: PFormatter.formatCurrency(
                              amount: ctrl.maximumClaimable,
                            ),
                            valueColor: PAppColor.primary,
                          ),
                          PAppSize.s14.verticalSpace,
                          PSummaryRowWidget(
                            label: 'processing_charge'.tr,
                            value: 'processing_charge_value'.tr,
                          ),
                        ],
                      ),
                    ),

                    PAppSize.s20.verticalSpace,

                    Obx(() {
                      final isValid =
                          ctrl.amount.value > 0 &&
                          ctrl.amount.value <= ctrl.maximumClaimable;
                      return PGradientButton(
                        label: 'continue'.tr,
                        showIcon: true,
                        loading: ctrl.submitting.value,
                        iconDirection: IconDirection.right,
                        textColor: PAppColor.whiteColor,
                        width: PDeviceUtil.getDeviceWidth(context),
                        onTap: isValid
                            ? () {
                                PHelperFunction.switchScreen(
                                  destination: Routes.selectPMInstantClaimPage,
                                );
                              }
                            : null,
                      );
                    }),

                    PAppSize.s16.verticalSpace,

                    // PAppSize.s12.verticalSpace,
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(
            Get.context!,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
