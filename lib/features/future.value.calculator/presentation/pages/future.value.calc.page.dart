import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/future.value.calculator/presentation/vm/future.value.calc.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PFutureValueCalcPage extends StatefulWidget {
  const PFutureValueCalcPage({super.key});

  @override
  State<PFutureValueCalcPage> createState() => _PFutureValueCalcPageState();
}

class _PFutureValueCalcPageState extends State<PFutureValueCalcPage> {
  final vm = Get.put(PFutureValueCalcVm());

  Future showParametersModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(PAppSize.s24),
          topRight: Radius.circular(PAppSize.s24),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(PAppSize.s20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PAppSize.s20),
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.darkBgColor
                : PAppColor.fillColor,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PAppSize.s10.verticalSpace,
                PDialogTitleWidget(
                  title: 'parameters'.tr,
                  onClose: () => PHelperFunction.pop(),
                ),

                PAppSize.s14.verticalSpace,
                Divider(),

                PAppSize.s6.verticalSpace,
                Expanded(
                  child: ListView.separated(
                    itemCount: vm.fvDescriptions.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final description = vm.fvDescriptions[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          description['title'],
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: PAppSize.s16,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        subtitle: Text(
                          description['description'],
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: PAppSize.s14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildKeyboardToolbar() {
    return Container(
      // height: 44,
      decoration: BoxDecoration(
        color: PHelperFunction.isDarkMode(context)
            ? CupertinoColors.secondaryLabel
            : CupertinoColors.systemGrey4,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(PAppSize.s8),
          topLeft: Radius.circular(PAppSize.s8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 16),
            onPressed: () => FocusScope.of(context).unfocus(),
            child: Text(
              'done'.tr,
              style: TextStyle(
                color: CupertinoColors.activeBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkBgColor
            : PAppColor.fillColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text('future_value_calculator'.tr)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'fvc_hint'.tr,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: PAppSize.s13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    /// Calculation section
                    Container(
                      margin: EdgeInsets.symmetric(vertical: PAppSize.s14),
                      padding: EdgeInsets.symmetric(
                        vertical: PAppSize.s25,
                        horizontal: PAppSize.s20,
                      ),
                      decoration: BoxDecoration(
                        border: PHelperFunction.isDarkMode(context)
                            ? null
                            : Border.all(
                                width: PAppSize.s1,
                                color: PAppColor.fillColor2,
                              ),
                        borderRadius: BorderRadius.circular(PAppSize.s20),
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.darkAppBarColor
                            : PAppColor.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PCustomTextField(
                            controller: vm.initialLumpSumTEC,
                            prefixText: 'GH₵',
                            labelText: 'initial_lump_sum'.tr,
                            textInputType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                          PAppSize.s16.verticalSpace,
                          PCustomTextField(
                            controller: vm.monthlyContributionTEC,
                            prefixText: 'GH₵',
                            labelText: 'monthly_contribution'.tr,
                            textInputType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                          PAppSize.s16.verticalSpace,
                          PCustomTextField(
                            controller: vm.numOfYearsRateTEC,
                            labelText: 'years_to_retirement'.tr,
                            textInputType: TextInputType.number,
                          ),
                          PAppSize.s16.verticalSpace,
                          PCustomTextField(
                            controller: vm.annualInterestRateTEC,
                            labelText: 'annual_interest_rate'.tr,
                            textInputType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                          PAppSize.s8.verticalSpace,
                          Text(
                            'see_parameter_explanation'.tr,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s15,
                                  color: PAppColor.successMedium,
                                  fontWeight: FontWeight.w500,
                                ),
                          ).onPressed(
                            onTap: () => showParametersModal(context),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: PAppSize.s14),
                      padding: EdgeInsets.symmetric(
                        vertical: PAppSize.s25,
                        horizontal: PAppSize.s20,
                      ),
                      decoration: BoxDecoration(
                        border: PHelperFunction.isDarkMode(context)
                            ? null
                            : Border.all(
                                width: PAppSize.s1,
                                color: PAppColor.fillColor2,
                              ),
                        borderRadius: BorderRadius.circular(PAppSize.s20),
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.darkAppBarColor
                            : PAppColor.whiteColor,
                      ),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'breakdown'.tr,
                              textAlign: TextAlign.start,
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s18,

                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            PAppSize.s10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'total_contributions'.tr,
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontSize: PAppSize.s16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                                Text(
                                  PFormatter.formatCurrency(
                                    amount: vm.total.value,
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontSize: PAppSize.s16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            PAppSize.s10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'interest_earned'.tr,
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontSize: PAppSize.s16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                                Text(
                                  PFormatter.formatCurrency(
                                    amount: vm.interest.value,
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontSize: PAppSize.s16,
                                        color: PAppColor.successMedium,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).all(PAppSize.s20),
              ),
            ),
            // Show keyboard toolbar only on iOS when keyboard is visible
            if (Platform.isIOS && MediaQuery.of(context).viewInsets.bottom > 0)
              _buildKeyboardToolbar(),
          ],
        ),
      ),
    );
  }
}
