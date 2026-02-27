import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPayNowPage extends StatefulWidget {
  final Object product;
  // final PaymentType paymentType;

  const PPayNowPage({
    super.key,

    required this.product,
    // this.paymentType = PaymentType.policy,
  });

  @override
  State<PPayNowPage> createState() => _PPayNowPageState();
}

class _PPayNowPageState extends State<PPayNowPage> {
  late final PPaymentVm ctrl;
  bool _isFullPayment = true;
  final FocusNode _amountFocusNode = FocusNode();

  double get _totalAmount => widget.product is Scheme
      ? (widget.product as Scheme).monthlyContribution ?? 0.0
      : (widget.product as Policy).modalPrem ?? 0.0;

  @override
  void initState() {
    super.initState();
    ctrl = Get.put(PPaymentVm());

    // Set payment context based on type
    if (widget.product is Policy) {
      final policy = widget.product as Policy;
      ctrl.setPaymentContextForPolicy(
        policyNumber: policy.policyNo ?? '',
        product: policy.planDescription ?? '',
      );
    } else {
      ctrl.setPaymentContextForPensions();
    }

    // Default to full payment amount
    ctrl.amountTEC.text = _totalAmount.toStringAsFixed(2);
    ctrl.onAmountChanged(ctrl.amountTEC.text);
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('pay_now'.tr)),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              PAppSize.s4.verticalSpace,
              ListTile(
                title: Text(
                  'pay_now'.tr,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'pay_now_hint'.trParams({
                    'name': widget.product is Policy
                        ? 'life_policy'.tr
                        : 'pension_scheme'.tr,
                  }),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: PCustomCardWidget(
                  borderRadius: BorderRadius.circular(PAppSize.s0),
                  useBorder: false,
                  padding: EdgeInsets.symmetric(
                    horizontal: PAppSize.s20,
                    vertical: PAppSize.s20,
                  ),
                  child: Form(
                    key: ctrl.paymentFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Policy/Product info if available
                        if (widget.product is Policy) ...[
                          _buildInfoRow(
                            context,
                            label: 'policy_number'.tr,
                            value: (widget.product as Policy).policyNo ?? '',
                          ),
                          PAppSize.s8.verticalSpace,
                          _buildInfoRow(
                            context,
                            label: 'policy_name'.tr,
                            value:
                                (widget.product as Policy).planDescription ??
                                '',
                          ),
                          PAppSize.s12.verticalSpace,
                          Divider(),
                          PAppSize.s12.verticalSpace,
                        ],
                        if (widget.product is Scheme) ...[
                          _buildInfoRow(
                            context,
                            label: 'scheme_name'.tr,
                            value:
                                (widget.product as Scheme).penTypeDescription ??
                                '',
                          ),
                          PAppSize.s8.verticalSpace,
                          _buildInfoRow(
                            context,
                            label: 'scheme_type'.tr,
                            value:
                                (widget.product as Scheme)
                                    .masterSchemeDescription ??
                                '',
                          ),
                          PAppSize.s12.verticalSpace,
                          Divider(),
                          PAppSize.s12.verticalSpace,
                        ],

                        _buildPaymentOptionTile(
                          context,
                          title: 'total_amount_due'.tr,
                          subtitle: PFormatter.formatCurrency(
                            amount: _totalAmount,
                          ),
                          isSelected: _isFullPayment,
                          bgColor: PHelperFunction.isDarkMode(context)
                              ? PAppColor.cardDarkColor
                              : PAppColor.fillColor,
                          borderColor: PHelperFunction.isDarkMode(context)
                              ? PAppColor.cardDarkColor
                              : PAppColor.fillColor,
                        ),

                        PAppSize.s16.verticalSpace,

                        Text(
                          'select_payment_type'.tr,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),

                        PAppSize.s10.verticalSpace,

                        // Full Payment option
                        _buildPaymentOptionTile(
                          context,
                          title: 'full_payment'.tr,
                          subtitle: 'full_payment_hint'.trParams({
                            'amount': PFormatter.formatCurrency(
                              amount: _totalAmount,
                            ),
                          }),
                          isSelected: _isFullPayment,
                          onTap: () {
                            setState(() {
                              _isFullPayment = true;
                              ctrl.amountTEC.text = _totalAmount
                                  .toStringAsFixed(2);
                              ctrl.onAmountChanged(ctrl.amountTEC.text);
                            });
                          },
                        ),

                        PAppSize.s16.verticalSpace,

                        // Partial Payment option
                        _buildPaymentOptionTile(
                          context,
                          title: 'partial_payment'.tr,
                          subtitle: 'partial_payment_hint'.trParams({
                            'amount': PFormatter.formatCurrency(amount: 1.0),
                          }),
                          isSelected: !_isFullPayment,
                          onTap: () {
                            setState(() {
                              _isFullPayment = false;
                              ctrl.amountTEC.clear();
                              ctrl.onAmountChanged('');
                            });
                            Future.delayed(Duration(milliseconds: 300), () {
                              _amountFocusNode.requestFocus();
                            });
                          },
                        ),

                        PAppSize.s16.verticalSpace,

                        // Show text field only for partial payment
                        if (!_isFullPayment) ...[
                          PKeyboardActions(
                            focusNode: _amountFocusNode,
                            child: PCustomTextField(
                              labelText: 'enter_amount'.tr,
                              hintText: '100.00',
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
                          PAppSize.s16.verticalSpace,
                        ],

                        Divider(),

                        PAppSize.s12.verticalSpace,

                        // Currency info
                        Container(
                          width: PDeviceUtil.getDeviceWidth(context),
                          padding: EdgeInsets.symmetric(
                            vertical: PAppSize.s16,
                            horizontal: PAppSize.s16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(PAppSize.s8),
                            color: PHelperFunction.isDarkMode(context)
                                ? PAppColor.cardDarkColor
                                : PAppColor.lightBlueColor,
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${'total_payment_amount'.tr}: ',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: PFormatter.formatCurrency(
                                    amount: _totalAmount,
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // PAppSize.s20.verticalSpace,

                        // Obx(
                        //   () => PGradientButton(
                        //     label: 'continue'.tr,
                        //     showIcon: true,
                        //     loading: ctrl.submitting.value,
                        //     iconDirection: IconDirection.right,
                        //     textColor: PAppColor.whiteColor,
                        //     width: PDeviceUtil.getDeviceWidth(context),
                        //     onTap: () => ctrl.initiatePayment(),
                        //   ),
                        // ),
                      ],
                    ).scrollable(),
                  ),
                ),
              ),
              Obx(
                () =>
                    PGradientButton(
                      label: 'continue'.tr,
                      showIcon: true,
                      loading: ctrl.submitting.value,
                      iconDirection: IconDirection.right,
                      textColor: PAppColor.whiteColor,
                      width: PDeviceUtil.getDeviceWidth(context),
                      onTap: () => ctrl.initiatePayment(),
                    ).only(
                      left: PAppSize.s20,
                      right: PAppSize.s20,
                      top: PAppSize.s20,
                      bottom: PAppSize.s20,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptionTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isSelected,
    Color? bgColor,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(PAppSize.s16),
        decoration: BoxDecoration(
          color:
              bgColor ??
              (isSelected
                  ? PHelperFunction.isDarkMode(context)
                        ? PAppColor.primaryBorderColor.withOpacityExt(
                            PAppSize.s0_1,
                          )
                        : PAppColor.primaryBorderLight
                  : PAppColor.transparentColor),
          border: Border.all(
            color:
                borderColor ??
                (isSelected
                    ? PAppColor.primaryBorderColor
                    : PAppColor.fillColor2),
            width: PAppSize.s1,
          ),
          borderRadius: BorderRadius.circular(PAppSize.s8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: PAppColor.greyColor,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected
                    ? PAppColor.primaryBorderColor
                    : PAppColor.fillColor2,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: PAppColor.greyColor,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
