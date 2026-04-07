import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PClaimPage extends StatefulWidget {
  const PClaimPage({super.key});

  @override
  State<PClaimPage> createState() => _PClaimPageState();
}

class _PClaimPageState extends State<PClaimPage> {
  final ctrl = Get.put(PPolicyVm());

  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _accountNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getPaymentMethods();
      ctrl.getWithdrawalReasons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('withdrawal'.tr)),
      body: SafeArea(
        child: PCustomCardWidget(
          padding: EdgeInsets.symmetric(
            horizontal: PAppSize.s20,
            vertical: PAppSize.s22,
          ),
          child: Form(
            key: ctrl.claimFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'claim_hint'.tr,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: PAppSize.s15,
                    // fontWeight: FontWeight.w600,
                  ),
                ),

                PAppSize.s10.verticalSpace,

                GetBuilder<PPolicyVm>(
                  builder: (ctrl) {
                    // Remove duplicates and skip placeholder
                    final uniqueMethods = ctrl.paymentMethods
                        .skip(1) // Skip the first placeholder item
                        .toSet()
                        .toList();

                    return PCustomDropdownField<PaymentMethod>(
                      labelText: 'payment_method'.tr,
                      initialValue: ctrl.selectedPaymentMethod,
                      onChanged: ctrl.onPaymentMethodChanged,
                      items: uniqueMethods
                          .map(
                            (method) => DropdownMenuItem<PaymentMethod>(
                              value: method,
                              child: Text(method.name ?? ''),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),

                PAppSize.s20.verticalSpace,

                GetBuilder<PPolicyVm>(
                  builder: (ctrl) {
                    return PCustomDropdownField<WithdrawalReason>(
                      labelText: 'withdrawal_purpose'.tr,
                      initialValue: ctrl.selectedWithdrawalReason,
                      onChanged: ctrl.onWithdrawalReasonChanged,
                      items: ctrl.withdrawalReasons
                          .map(
                            (reason) => DropdownMenuItem<WithdrawalReason>(
                              value: reason,
                              child: Text(reason.description ?? ''),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),

                PAppSize.s20.verticalSpace,

                PKeyboardActions(
                  focusNode: _amountFocusNode,
                  child: PCustomTextField(
                    labelText: 'withdrawal_amount'.tr,
                    hintText: 'claim_amount_hint'.tr,
                    controller: ctrl.amountTEC,
                    focusNode: _amountFocusNode,
                    textInputType: TextInputType.number,
                    validator: PValidator.validateClaimAmount(
                      ctrl.selectedPolicy?.availableBalance ?? 0,
                    ),
                  ),
                ),

                PAppSize.s20.verticalSpace,

                PKeyboardActions(
                  focusNode: _accountNumberFocusNode,
                  child: PCustomTextField(
                    labelText: 'momo_wallet_number'.tr,
                    hintText: 'momo_wallet_hint'.tr,
                    focusNode: _accountNumberFocusNode,
                    controller: ctrl.accountNumberTEC,
                    textInputType: TextInputType.number,
                    validator: PValidator.validateText,
                  ),
                ),

                PAppSize.s25.verticalSpace,

                Obx(
                  () => PGradientButton(
                    label: 'continue'.tr,
                    showIcon: true,
                    loading: ctrl.submitting.value,
                    iconDirection: IconDirection.right,
                    textColor: PAppColor.whiteColor,
                    width: PDeviceUtil.getDeviceWidth(context),
                    onTap: () {
                      if (ctrl.claimFormKey.currentState!.validate()) {
                        ctrl.submitInstantClaimRequest();
                      }
                    },
                  ),
                ),

                PAppSize.s32.verticalSpace,
              ],
            ).scrollable(),
          ),
        ).all(PAppSize.s20),
      ),
    );
  }
}
