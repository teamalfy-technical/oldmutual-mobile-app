import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.filled.textfield.dart';

class PPortingPage extends StatelessWidget {
  PPortingPage({super.key});

  final ctrl = Get.put(PRedemptionVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('porting'.tr)),
      body: Column(
        children: [
          PPageTagWidget(
            tag: 'porting_hint_tag'.tr,
            textAlign: TextAlign.center,
          ),

          PAppSize.s25.verticalSpace,
          // Filter
          Obx(
            () =>
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: PCustomFilledTextfield(
                            label: 'receiving_scheme_name'.tr,
                            hint: '',
                            textInputType: TextInputType.multiline,
                            controller: ctrl.amountTEC,
                          ),
                        ),
                        PAppSize.s25.horizontalSpace,
                        Expanded(
                          child: PCustomFilledTextfield(
                            label: 'amount_to_port'.tr,
                            hint: '',
                            textInputType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            controller: ctrl.reasonTEC,
                          ),
                        ),
                      ],
                    ),
                    PAppSize.s25.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: PCustomFilledTextfield(
                            label: 'reason_for_porting'.tr,
                            hint: '',
                            textInputType: TextInputType.multiline,
                            controller: ctrl.bankNameTEC,
                          ),
                        ),
                        PAppSize.s25.horizontalSpace,
                        Expanded(
                          child: PCustomFilledTextfield(
                            label: 'scheme_id_hint'.tr,
                            hint: '',
                            textInputType: TextInputType.text,
                            controller: ctrl.accountNumberTEC,
                          ),
                        ),
                      ],
                    ),

                    PAppSize.s20.verticalSpace,

                    PCustomCheckbox(
                      value: ctrl.agree.value,
                      onChanged: ctrl.onAgreeChanged,
                      checkboxDirection: Direction.left,
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return PAppColor.primary;
                        } else {
                          return Color(
                            0xFFD9D9D9,
                          ).withOpacityExt(PAppSize.s0_6);
                        }
                      }),
                      child: Text(
                        'porting_confirm_msg'.tr,
                        // style: Theme.of(context).textTheme.bodySmall
                        //     ?.copyWith(fontSize: PAppSize.s14),
                      ),
                    ),

                    (PDeviceUtil.getDeviceHeight(context) * 0.1).verticalSpace,

                    PGradientButton(
                      label: 'submit_request'.tr,
                      width: PDeviceUtil.getDeviceWidth(context) * 0.50,
                      onTap: () => ctrl.portPensionScheme(),
                    ),
                  ],
                ).symmetric(horizontal: PAppSize.s22).scrollable(),
          ),
        ],
      ),
    );
  }
}
