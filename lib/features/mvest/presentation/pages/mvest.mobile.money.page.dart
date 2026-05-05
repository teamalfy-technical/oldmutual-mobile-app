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
  final PMVestVm ctrl = Get.isRegistered<PMVestVm>()
      ? Get.find<PMVestVm>()
      : Get.put(PMVestVm());

  final PClaimsVm claimsCtrl = Get.isRegistered<PClaimsVm>()
      ? Get.find<PClaimsVm>()
      : Get.put(PClaimsVm());

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

  /// Replaces the webview with the MVest success page once the payment
  /// gateway reports success. Captures the contribution amount up front
  /// because the success-page close handler resets the flow state.
  void _onMVestPaymentSuccess(PClaimsVm claimsCtrl) {
    final amount = double.tryParse(ctrl.contributionAmountTEC.text.trim()) ?? 0;
    final formattedAmount = PFormatter.formatCurrency(amount: amount);
    PHelperFunction.switchScreen(
      destination: Routes.mvestSuccessPage,
      popAndPush: true,
      args: [
        'payment_success_title'.tr,
        'payment_success_msg'.trParams({'amount': '**$formattedAmount**'}),
        () {
          ctrl.resetInvestmentFlow();
          claimsCtrl.onPaymentMethodChanged(null);
          Get.until((route) => route.settings.name == Routes.mvestPage);
        },
      ],
    );
  }

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
                    Obx(
                      () => PGradientButton(
                        label: 'continue'.tr,
                        showIcon: true,
                        iconDirection: IconDirection.right,
                        textColor: PAppColor.whiteColor,
                        width: PDeviceUtil.getDeviceWidth(context),
                        loading: ctrl.submitting.value,
                        onTap: _canContinue
                            ? () async {
                                final ok = await ctrl
                                    .submitAndInitiatePayment();
                                if (!ok) return;
                                final checkoutUrl =
                                    ctrl.paymentResponse.value?.checkoutUrl;
                                if (checkoutUrl == null ||
                                    checkoutUrl.isEmpty) {
                                  return;
                                }
                                PHelperFunction.switchScreen(
                                  destination: Routes.webviewPage,
                                  args: [
                                    'make_payment'.tr,
                                    checkoutUrl,
                                    () => _onMVestPaymentSuccess(claimsCtrl),
                                  ],
                                );
                              }
                            : null,
                      ),
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
