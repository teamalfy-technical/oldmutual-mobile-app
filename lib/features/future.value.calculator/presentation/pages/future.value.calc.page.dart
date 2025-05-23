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
          Obx(
            () => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: PCustomFilledTextfield(
                        label: 'initial_lump_sum'.tr,
                        hint: '',
                        textInputType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        controller: ctrl.initialLumpSumTEC,
                      ),
                    ),
                    PAppSize.s25.horizontalSpace,
                    Expanded(
                      child: PCustomFilledTextfield(
                        label: 'monthly_contribution'.tr,
                        hint: '',
                        textInputType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
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
                        textInputType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        controller: ctrl.annualInterestRateTEC,
                      ),
                    ),
                    PAppSize.s25.horizontalSpace,
                    Expanded(
                      child: PCustomFilledTextfield(
                        label: 'number_of_years'.tr,
                        hint: '',
                        textInputType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        controller: ctrl.numOfYearstRateTEC,
                      ),
                    ),
                  ],
                ),

                (PDeviceUtil.getDeviceHeight(context) * 0.02).verticalSpace,

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    PFormatter.formatCurrency(amount: ctrl.total.value),
                    textAlign: TextAlign.start,
                    style:
                        Theme.of(context).textTheme.headlineMedium?.copyWith(),
                  ),
                ),

                (PDeviceUtil.getDeviceHeight(context) * 0.02).verticalSpace,

                Row(
                  children: [
                    Expanded(
                      child: PGradientButton(
                        label: 'calculate'.tr,
                        // width: PDeviceUtil.getDeviceWidth(context) * 0.55,
                        onTap: () => ctrl.calculateFutureValue(),
                      ),
                    ),
                    PAppSize.s20.horizontalSpace,
                    Expanded(
                      child: OutlinedButton(
                        onPressed: ctrl.resetCalculator,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: PAppColor.primary,
                          padding: EdgeInsets.zero,
                          minimumSize: Size(
                            PDeviceUtil.getDeviceWidth(context) * 0.55,
                            PAppSize.buttonHeight,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(PAppSize.s24),
                          ),
                        ),
                        child: Text('reset_calculator'.tr),
                      ),
                    ),
                  ],
                ),
              ],
            ).symmetric(horizontal: PAppSize.s22),
          ),
          (PDeviceUtil.getDeviceHeight(context) * 0.025).verticalSpace,

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: ctrl.fvDescriptions.length,
              itemBuilder: (context, index) {
                final description = ctrl.fvDescriptions[index];
                return RichText(
                  text: TextSpan(
                    text: '${description['title']}: ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: description['description'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          // fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ).only(bottom: PAppSize.s20);
              },
            ).symmetric(horizontal: PAppSize.s22),
          ),
        ],
      ),
    );
  }
}
