import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PFutureValueCalcVm extends GetxController {
  static PFutureValueCalcVm get instance => Get.find();

  var total = 0.0.obs;
  int n = 12;

  final initialLumpSumTEC = TextEditingController();
  final monthlyContributionTEC = TextEditingController();
  final annualInterestRateTEC = TextEditingController();
  final numOfYearstRateTEC = TextEditingController();

  var all = false.obs;

  onAllChanged(bool? value) => all.value = value ?? false;

  final context = Get.context!;

  void resetCalculator() {
    initialLumpSumTEC.clear();
    monthlyContributionTEC.clear();
    annualInterestRateTEC.clear();
    numOfYearstRateTEC.clear();
    PHelperFunction.pop();
  }

  void calculateFutureValue() {
    if (!validateFields) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message: 'Please fill in all fields',
      );
    } else {
      final initialLumpSum = double.parse(initialLumpSumTEC.text.trim());
      final monthlyContribution = double.parse(
        monthlyContributionTEC.text.trim(),
      );
      final annualInterestRate =
          double.parse(annualInterestRateTEC.text.trim()) / 100;
      final numOfYearstRate = double.parse(numOfYearstRateTEC.text.trim());

      total.value =
          calculateCompoundInterest(
            initialLumpSum,
            annualInterestRate,
            numOfYearstRate,
          ) +
          calculateMonthlyContribution(
            monthlyContribution,
            annualInterestRate,
            numOfYearstRate,
          );
    }
  }

  bool get validateFields {
    if (initialLumpSumTEC.text.trim().isEmpty ||
        monthlyContributionTEC.text.trim().isEmpty ||
        annualInterestRateTEC.text.trim().isEmpty ||
        numOfYearstRateTEC.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  double calculateMonthlyContribution(double M, double r, double l) {
    double ratePerPeriod = r / n;
    double exponent = n * l;
    double compoundFactor = pow(1 + ratePerPeriod, exponent).toDouble();
    return M * ((compoundFactor - 1) / ratePerPeriod);
  }

  // P(1+r/n)^(n*l)
  double calculateCompoundInterest(double P, double r, double l) {
    return P * pow((1 + r / n), n * l);
  }
}
