import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
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

  int _maxLength = 10;

  @override
  void initState() {
    super.initState();
    ctrl.momoNumberTEC.addListener(_onFormChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getPaymentMethods();
      ctrl.getWithdrawalReasons();
    });
  }

  @override
  void dispose() {
    ctrl.momoNumberTEC.removeListener(_onFormChanged);
    super.dispose();
  }

  void _onFormChanged() => setState(() {});

  bool get _canContinue =>
      ctrl.selectedPaymentMethod != null &&
      // ctrl.selectedWithdrawalReason != null &&
      ctrl.momoNumberTEC.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: PAnimatedColumnWidget(
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
                          onChanged: (value) {
                            ctrl.onPaymentMethodChanged(value);
                            _onFormChanged();
                          },
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

                    // PAppSize.s20.verticalSpace,
                    // GetBuilder<PClaimsVm>(
                    //   builder: (ctrl) {
                    //     return PCustomDropdownField<WithdrawalReason>(
                    //       labelText: 'withdrawal_purpose'.tr,
                    //       initialValue: ctrl.selectedWithdrawalReason,
                    //       onChanged: (value) {
                    //         ctrl.onWithdrawalReasonChanged(value);
                    //         _onFormChanged();
                    //       },
                    //       items: ctrl.withdrawalReasons
                    //           .map(
                    //             (reason) => DropdownMenuItem<WithdrawalReason>(
                    //               value: reason,
                    //               child: Text(reason.description ?? ''),
                    //             ),
                    //           )
                    //           .toList(),
                    //     );
                    //   },
                    // ),
                    PAppSize.s20.verticalSpace,
                    PKeyboardActions(
                      focusNode: _momoNumberFocusNode,
                      child: PCustomTextField(
                        prefixText: '233 ',
                        labelText: 'registered_phone_number'.tr,
                        hintText: '240xxxx08'.tr,
                        focusNode: _momoNumberFocusNode,
                        controller: ctrl.momoNumberTEC,
                        textInputType: TextInputType.phone,
                        maxLength:
                            _maxLength, // Dynamically set max length based on input
                        validator: PValidator.validatePhoneNumber,
                        onChanged: (value) {
                          // Dynamically switch max length
                          if (value.isNotEmpty) {
                            if (value.startsWith('0')) {
                              if (_maxLength != 10) {
                                setState(() => _maxLength = 10);
                              }
                            } else {
                              if (_maxLength != 9) {
                                setState(() => _maxLength = 9);
                              }
                            }
                          }
                        },
                      ),
                    ),

                    PAppSize.s20.verticalSpace,

                    NoteWidget(
                      borderRadius: BorderRadius.circular(PAppSize.s16),
                      color: PAppColor.warningNoteFill,
                      borderColor: PAppColor.warningNoteBorder,
                      textColor: PAppColor.warningNoteBorder,
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
                      onTap: _canContinue
                          ? () => PHelperFunction.switchScreen(
                              destination: Routes.instantClaimSummaryPage,
                            )
                          : null,
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
