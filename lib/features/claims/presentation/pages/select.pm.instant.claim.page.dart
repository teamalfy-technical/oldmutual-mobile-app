import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PSelectPMInstantClaimPage extends StatefulWidget {
  const PSelectPMInstantClaimPage({super.key});

  @override
  State<PSelectPMInstantClaimPage> createState() =>
      _PSelectPMInstantClaimPageState();
}

class _PSelectPMInstantClaimPageState extends State<PSelectPMInstantClaimPage> {
  final FocusNode _momoNumberFocusNode = FocusNode();

  final PClaimsVm ctrl = Get.put(PClaimsVm());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getPaymentMethods();
      ctrl.getWithdrawalReasons();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('mobile_money'.tr)),
      body: Column(
        children: [
          Expanded(
            child: PCustomCardWidget(
              borderRadius: BorderRadius.circular(PAppSize.s0),
              useBorder: false,
              padding: EdgeInsets.symmetric(
                horizontal: PAppSize.s20,
                vertical: PAppSize.s25,
              ),
              child: Form(
                child: Column(
                  children: [
                    PAppSize.s10.verticalSpace,
                    GetBuilder<PClaimsVm>(
                      builder: (ctrl) {
                        final uniqueMethods = ctrl.paymentMethods
                            .skip(1)
                            .toSet()
                            .toList();
                        return PCustomDropdownField<PaymentMethod>(
                          labelText: 'select_telco_operator'.tr,
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
                    GetBuilder<PClaimsVm>(
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
                      focusNode: _momoNumberFocusNode,
                      child: PCustomTextField(
                        labelText: 'registered_phone_number'.tr,
                        hintText: 'registered_phone_number'.tr,
                        focusNode: _momoNumberFocusNode,
                        controller: ctrl.momoNumberTEC,
                        textInputType: TextInputType.number,
                        validator: PValidator.validateText,
                      ),
                    ),

                    PAppSize.s20.verticalSpace,

                    NoteWidget(
                      borderRadius: BorderRadius.circular(PAppSize.s16),
                      color: Color(0xFFFEEFCD),
                      borderColor: Color(0xFF913C08),
                      description: 'hubtel_identity_validation_note'.tr,
                    ),

                    PAppSize.s40.verticalSpace,

                    PGradientButton(
                      label: 'continue'.tr,
                      showIcon: true,
                      loading: ctrl.submitting.value,
                      iconDirection: IconDirection.right,
                      textColor: PAppColor.whiteColor,
                      width: PDeviceUtil.getDeviceWidth(context),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: PDeviceUtil.getDeviceHeight(context) * 0.25),
        ],
      ),
    );
  }
}
