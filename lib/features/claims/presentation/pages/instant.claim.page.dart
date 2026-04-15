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
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('instant_claim'.tr)),
      body: PAnimatedColumnWidget(
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
                child: Column(
                  children: [
                    PKeyboardActions(
                      focusNode: _amountFocusNode,
                      child: PCustomTextField(
                        labelText: '3,000',
                        hintText: '',
                        controller: ctrl.amountTEC,
                        focusNode: _amountFocusNode,
                        textInputType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: ctrl.onAmountChanged,
                        validator: PValidator.validatePaymentAmount,
                      ),
                    ),
                    PAppSize.s12.verticalSpace,
                    Divider(),
                    PAppSize.s12.verticalSpace,

                    PBlueTagWidget(
                      child: Column(
                        children: [
                          _summaryRow(label: 'charge'.tr, value: '-GH₵ 40.00'),
                          PAppSize.s12.verticalSpace,
                          _summaryRow(
                            label: 'youll_receive'.tr,
                            value: 'GH₵ 1,960.00',
                          ),
                        ],
                      ),
                    ),

                    PAppSize.s20.verticalSpace,

                    /// Summary of Charges
                    PCustomCardWidget(
                      borderRadius: BorderRadius.circular(PAppSize.s8),
                      useBorder: false,
                      color: PAppColor.fillColor5,
                      padding: EdgeInsets.symmetric(
                        horizontal: PAppSize.s20,
                        vertical: PAppSize.s25,
                      ),
                      child: Column(
                        children: [
                          _summaryRow(
                            label: 'available_cash_value'.tr,
                            value: 'GH₵ 12,500.00',
                          ),
                          PAppSize.s14.verticalSpace,
                          _summaryRow(
                            label: 'maximum_claimable'.tr,
                            value: 'GH₵ 3,000.00',
                            valueColor: PAppColor.primary,
                          ),
                          PAppSize.s14.verticalSpace,
                          _summaryRow(
                            label: 'processing_charge'.tr,
                            value: 'processing_charge_value'.tr,
                          ),
                        ],
                      ),
                    ),

                    PAppSize.s20.verticalSpace,

                    PGradientButton(
                      label: 'continue'.tr,
                      showIcon: true,
                      loading: ctrl.submitting.value,
                      iconDirection: IconDirection.right,
                      textColor: PAppColor.whiteColor,
                      width: PDeviceUtil.getDeviceWidth(context),
                      onTap: () {
                        PHelperFunction.switchScreen(
                          destination: Routes.selectPMInstantClaimPage,
                        );
                      },
                    ),

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
