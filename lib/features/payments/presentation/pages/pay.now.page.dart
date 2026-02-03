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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('pay_now'.tr)),
      body: SafeArea(
        child: Obx(
          () => Column(
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
                  'pay_now_hint'.tr,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
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
                              (widget.product as Policy).planDescription ?? '',
                        ),
                        PAppSize.s16.verticalSpace,
                        Divider(),
                        PAppSize.s16.verticalSpace,
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
                        onChanged: ctrl.onAmountChanged,
                        validator: PValidator.validatePaymentAmount,
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
                                text: '${'total_payment_amount'.tr}: ',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: PFormatter.formatCurrency(
                                  amount: ctrl.amount.value,
                                ),
                                style: Theme.of(context).textTheme.bodyMedium
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
