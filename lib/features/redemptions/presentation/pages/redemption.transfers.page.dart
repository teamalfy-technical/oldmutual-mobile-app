import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PRedemptionTransferPage extends StatelessWidget {
  PRedemptionTransferPage({super.key});

  final ctrl = Get.put(PRedemptionVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('redemption_and_transfer'.tr)),
      body: Column(
        children: [
          PPageTagWidget(
            tag: 'redemption_transfer_hint_tag'.tr,
            textAlign: TextAlign.center,
          ),

          PAppSize.s25.verticalSpace,

          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'redemption_ques_tag'.tr,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ).symmetric(horizontal: PAppSize.s6),
                PAppSize.s14.verticalSpace,
                PRadioListTileWidget(
                  label: 'withdrawal_channel'.tr,
                  value: 'withdraw',
                  groupValue: ctrl.selectedRedemptionOption.value,
                  onChanged: ctrl.onRedemptionOptionChanged,
                ),
                PAppSize.s4.verticalSpace,
                PRadioListTileWidget(
                  label: 'port_scheme_channel'.tr,
                  value: 'port',
                  groupValue: ctrl.selectedRedemptionOption.value,
                  onChanged: ctrl.onRedemptionOptionChanged,
                ),
              ],
            ).symmetric(horizontal: PAppSize.s22),
          ),

          PAppSize.s100.verticalSpace,
          // Filter
          Column(
            children: [
              (PDeviceUtil.getDeviceHeight(context) * 0.05).verticalSpace,
              PGradientButton(
                label: 'continue'.tr,
                width: PDeviceUtil.getDeviceWidth(context) * 0.50,
                onTap: () {
                  if (ctrl.selectedRedemptionOption.value == 'withdraw') {
                    PHelperFunction.switchScreen(
                      destination: Routes.redemptionPage,
                    );
                  } else {}
                },
              ),
            ],
          ).symmetric(horizontal: PAppSize.s22),
        ],
      ),
    );
  }
}
