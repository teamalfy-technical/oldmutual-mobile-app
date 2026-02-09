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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ctrl.getPaymentMethods(),
    );
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

                PCustomTextField(
                  labelText: 'momo_wallet_number'.tr,
                  hintText: '024XXXXXXX',
                  controller: ctrl.accountNumberTEC,
                  textInputType: TextInputType.number,
                  validator: PValidator.validateText,
                ),

                PAppSize.s20.verticalSpace,

                PCustomTextField(
                  labelText: 'withdrawal_amount'.tr,
                  hintText: '5000',
                  controller: ctrl.amountTEC,
                  textInputType: TextInputType.number,
                  validator: PValidator.validateClaimAmount(
                    ctrl.selectedPolicy?.cashValue ?? 0,
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
                        ctrl.submitClaimRequest();
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
