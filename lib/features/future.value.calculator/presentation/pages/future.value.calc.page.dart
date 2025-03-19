import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/future.value.calculator/future.value.calculator.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.filled.textfield.dart';

class PFutureValueCalcPage extends StatelessWidget {
  PFutureValueCalcPage({super.key});

  final ctrl = Get.put(PFutureValueCalcVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('future_value_calculator'.tr)),
      body: Column(
        children: [
          PPageTagWidget(
            tag: 'future_value_calculator_tag'.tr,
            textAlign: TextAlign.center,
          ),

          PAppSize.s25.verticalSpace,
          // Filter
          Expanded(
            child:
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: PCustomFilledTextfield(
                            label: 'contribution_rate'.tr,
                            hint: 'contribution_rate_hint'.tr,
                            controller: ctrl.contributionRateTEC,
                          ),
                        ),
                        PAppSize.s25.horizontalSpace,
                        Expanded(
                          child: PCustomFilledTextfield(
                            label: 'current_age'.tr,
                            hint: 'current_age_hint'.tr,
                            controller: ctrl.currentAgeTEC,
                          ),
                        ),
                      ],
                    ),
                    PAppSize.s25.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: PCustomFilledTextfield(
                            label: 'retirement_age'.tr,
                            hint: 'retirement_age_hint'.tr,
                            controller: ctrl.retirementAgeTEC,
                          ),
                        ),
                        PAppSize.s25.horizontalSpace,
                        Expanded(
                          child: PCustomFilledTextfield(
                            label: 'interest_rate'.tr,
                            hint: 'interest_rate_hint'.tr,
                            controller: ctrl.interestRateTEC,
                          ),
                        ),
                      ],
                    ),

                    (PDeviceUtil.getDeviceWidth(context) / 3).verticalSpace,
                    PGradientButton(
                      label: 'calculate'.tr,
                      width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                      onTap:
                          () => PHelperFunction.switchScreen(
                            destination: Routes.calculateResultPage,
                          ),
                    ),
                  ],
                ).symmetric(horizontal: PAppSize.s22).scrollable(),
          ),
        ],
      ),
    );
  }
}
