import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PMVestMobileMoneyPage extends StatefulWidget {
  const PMVestMobileMoneyPage({super.key});

  @override
  State<PMVestMobileMoneyPage> createState() => _PMVestMobileMoneyPageState();
}

class _PMVestMobileMoneyPageState extends State<PMVestMobileMoneyPage> {
  final FocusNode _momoNumberFocusNode = FocusNode();
  final PMVestVm ctrl = Get.find<PMVestVm>();
  final PClaimsVm claimsCtrl = Get.put(PClaimsVm());

  int _maxLength = 10;

  @override
  void initState() {
    super.initState();
    ctrl.momoNumberTEC.addListener(_onFormChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      claimsCtrl.getPaymentMethods();
    });
  }

  @override
  void dispose() {
    ctrl.momoNumberTEC.removeListener(_onFormChanged);
    _momoNumberFocusNode.dispose();
    super.dispose();
  }

  void _onFormChanged() => setState(() {});

  bool get _canContinue =>
      claimsCtrl.selectedPaymentMethod != null &&
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
                      builder: (cCtrl) {
                        final uniqueMethods = cCtrl.paymentMethods
                            .skip(1)
                            .toSet()
                            .toList();
                        return PCustomDropdownField<PaymentMethod>(
                          labelText: 'select_telco_operator'.tr,
                          initialValue: cCtrl.selectedPaymentMethod,
                          onChanged: (value) {
                            cCtrl.onPaymentMethodChanged(value);
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
                        maxLength: _maxLength,
                        validator: PValidator.validatePhoneNumber,
                        onChanged: (value) {
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
                      iconDirection: IconDirection.right,
                      textColor: PAppColor.whiteColor,
                      width: PDeviceUtil.getDeviceWidth(context),
                      onTap: _canContinue
                          ? () => PHelperFunction.switchScreen(
                              destination: Routes.mvestSuccessPage,
                              args: [
                                'investment_created'.tr,
                                'payment_processed_hubtel'.tr,
                                () {
                                  ctrl.resetInvestmentFlow();
                                  claimsCtrl.onPaymentMethodChanged(null);
                                  PHelperFunction.switchScreen(
                                    destination: Routes.dashboardPage,
                                    replace: true,
                                  );
                                },
                              ],
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
