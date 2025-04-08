import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/future.value.calculator/future.value.calculator.dart';
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
            child: Obx(
              () =>
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'initial_lump_sum'.tr,
                              hint: '',
                              textInputType: TextInputType.number,
                              controller: ctrl.initialLumpSumTEC,
                            ),
                          ),
                          PAppSize.s25.horizontalSpace,
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'monthly_contribution'.tr,
                              hint: '',
                              textInputType: TextInputType.number,
                              controller: ctrl.monthlyContributionTEC,
                            ),
                          ),
                        ],
                      ),
                      PAppSize.s25.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'annual_interest_rate'.tr,
                              hint: '',
                              textInputType: TextInputType.number,
                              controller: ctrl.annualInterestRateTEC,
                            ),
                          ),
                          PAppSize.s25.horizontalSpace,
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'number_of_years'.tr,
                              hint: '',
                              textInputType: TextInputType.number,
                              controller: ctrl.numOfYearstRateTEC,
                            ),
                          ),
                        ],
                      ),

                      (PDeviceUtil.getDeviceWidth(context) * 0.05)
                          .verticalSpace,

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${'fv'.tr.toUpperCase()} = GHS ${ctrl.total.value.toStringAsFixed(2)}',
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(
                                context,
                              ).textTheme.headlineMedium?.copyWith(),
                        ),
                      ),

                      (PDeviceUtil.getDeviceWidth(context) / 3).verticalSpace,
                      PGradientButton(
                        label: 'calculate'.tr,
                        width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                        onTap: () => ctrl.calculateFutureValue(),
                      ),
                    ],
                  ).symmetric(horizontal: PAppSize.s22).scrollable(),
            ),
          ),
        ],
      ),
    );
  }
}
