import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPayNowPage extends StatefulWidget {
  final String? policyNumber;
  final String? product;
  final PaymentType paymentType;

  const PPayNowPage({
    super.key,
    this.policyNumber,
    this.product,
    this.paymentType = PaymentType.policy,
  });

  @override
  State<PPayNowPage> createState() => _PPayNowPageState();
}

class _PPayNowPageState extends State<PPayNowPage> {
  late final PPaymentVm ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = Get.put(PPaymentVm());

    // Set payment context based on type
    if (widget.paymentType == PaymentType.policy) {
      ctrl.setPaymentContextForPolicy(
        policyNumber: widget.policyNumber ?? '',
        product: widget.product ?? '',
      );
    } else {
      ctrl.setPaymentContextForPensions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('pay_now'.tr)),
      body: SafeArea(
        child: Column(
          children: [
            PAppSize.s4.verticalSpace,
            ListTile(
              title: Text(
                'pay_now'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                'pay_now_hint'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            PCustomCardWidget(
              borderRadius: BorderRadius.circular(PAppSize.s0),
              useBorder: false,
              padding: EdgeInsets.symmetric(
                horizontal: PAppSize.s20,
                vertical: PAppSize.s28,
              ),
              child: Form(
                key: ctrl.paymentFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Policy/Product info if available
                    if (widget.policyNumber != null &&
                        widget.policyNumber!.isNotEmpty) ...[
                      _buildInfoRow(
                        context,
                        label: 'policy_number'.tr,
                        value: widget.policyNumber!,
                      ),
                      PAppSize.s8.verticalSpace,
                    ],
                    if (widget.product != null &&
                        widget.product!.isNotEmpty) ...[
                      _buildInfoRow(
                        context,
                        label: 'product'.tr,
                        value: widget.product!,
                      ),
                      PAppSize.s16.verticalSpace,
                      Divider(),
                      PAppSize.s16.verticalSpace,
                    ],

                    PCustomTextField(
                      labelText: 'enter_amount'.tr,
                      hintText: '100.00',
                      controller: ctrl.amountTEC,
                      textInputType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'amount_required'.tr;
                        }
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'enter_valid_amount'.tr;
                        }
                        return null;
                      },
                    ),

                    PAppSize.s16.verticalSpace,

                    Divider(),

                    PAppSize.s16.verticalSpace,

                    // Currency info
                    Container(
                      width: PDeviceUtil.getDeviceWidth(context),
                      padding: EdgeInsets.symmetric(
                        vertical: PAppSize.s16,
                        horizontal: PAppSize.s16,
                      ),
                      decoration: BoxDecoration(
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.darkBgColor
                            : PAppColor.lightBlueColor,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${'currency'.tr}: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: ctrl.currency,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),

                    PAppSize.s20.verticalSpace,

                    Obx(
                      () => PGradientButton(
                        label: 'continue'.tr,
                        showIcon: true,
                        loading: ctrl.submitting.value,
                        iconDirection: IconDirection.right,
                        textColor: PAppColor.whiteColor,
                        width: PDeviceUtil.getDeviceWidth(context),
                        onTap: () => ctrl.initiatePayment(),
                      ),
                    ),
                  ],
                ).scrollable(),
              ),
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
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: PAppColor.greyColor,
              ),
        ),
        Flexible(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
