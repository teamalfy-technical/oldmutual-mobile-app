import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/policy/presentation/vm/policy.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PClaimPage extends StatelessWidget {
  PClaimPage({super.key});

  final ctrl = Get.put(PPolicyVm());

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

                PCustomTextField(
                  labelText: 'amount'.tr,
                  hintText: '5000',
                  controller: ctrl.amountTEC,
                  textInputType: TextInputType.number,
                  validator: PValidator.validateText,
                ),

                PAppSize.s20.verticalSpace,

                Obx(
                  () => PGradientButton(
                    label: 'continue'.tr,
                    showIcon: true,
                    loading: ctrl.loading.value,
                    iconDirection: IconDirection.right,
                    textColor: PAppColor.whiteColor,
                    width: PDeviceUtil.getDeviceWidth(context),
                    onTap: () {
                      if (ctrl.claimFormKey.currentState!.validate()) {
                        ctrl.submitWithdrawalRequest();
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
