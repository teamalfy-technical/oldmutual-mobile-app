import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PFutureValueCalcVm extends GetxController {
  static PFutureValueCalcVm get instance => Get.find();

  var total = 0.0.obs;
  var interest = 0.0.obs;

  int n = 12;

  final _debounce = Debouncer(milliseconds: 500);

  final initialLumpSumTEC = TextEditingController();
  final monthlyContributionTEC = TextEditingController();
  final annualInterestRateTEC = TextEditingController();
  final numOfYearsRateTEC = TextEditingController();

  var all = false.obs;

  onAllChanged(bool? value) => all.value = value ?? false;

  final context = Get.context!;

  @override
  void onInit() {
    super.onInit();
    // Listen to changes in all fields
    initialLumpSumTEC.addListener(_onInputChange);
    monthlyContributionTEC.addListener(_onInputChange);
    numOfYearsRateTEC.addListener(_onInputChange);
    annualInterestRateTEC.addListener(_onInputChange);
  }

  @override
  void onClose() {
    initialLumpSumTEC.removeListener(_onInputChange);
    monthlyContributionTEC.removeListener(_onInputChange);
    numOfYearsRateTEC.removeListener(_onInputChange);
    annualInterestRateTEC.removeListener(_onInputChange);
    initialLumpSumTEC.dispose();
    monthlyContributionTEC.dispose();
    numOfYearsRateTEC.dispose();
    annualInterestRateTEC.dispose();
    super.onClose();
  }

  void calculateFutureValue() {}

  //  Descriptions of variables
  List<Map<String, dynamic>> fvDescriptions = [
    {
      "title": "Initial Lump Sum",
      "description":
          "Enter the amount you're starting with in your pension account. Example: If you already have GHS 10,000 saved, enter that here.",
    },
    {
      "title": "Monthly Contribution",
      "description":
          "Enter how much you plan to contribute every month going forward. This helps us project how your pension will grow with regular savings.",
    },
    {
      "title": "Annual Interest Rate",
      "description":
          "Enter the expected yearly interest rate (as a percentage). Example: If your expect fund to grow by 10% per year, enter “10”.",
    },
    {
      "title": "Years to Retirement",
      "description":
          "Enter how many years you plan to contribute before retirement. This helps us calculate how long your money will grow.",
    },
  ];

  void resetCalculator() {
    initialLumpSumTEC.clear();
    monthlyContributionTEC.clear();
    annualInterestRateTEC.clear();
    numOfYearsRateTEC.clear();
    total.value = 0.0;
  }

  void _onInputChange() {
    // quick debug - remove when confirmed
    // print('input changed: years=${yearsToRetirementController.text}, rate=${annualInterestRateController.text}');

    _debounce.run(_calculateTotalContribution);
  }

  void _calculateTotalContribution() {
    // if (!validateFields) {
    //   PPopupDialog(context).errorMessage(
    //     title: 'action_required'.tr,
    //     message: 'Please fill in all fields',
    //   );
    // } else {
    // final initialLumpSum = double.parse(initialLumpSumTEC.text.trim());
    final monthlyContribution =
        double.tryParse(monthlyContributionTEC.text.trim()) ?? 0;
    final annualInterestRate =
        double.tryParse(annualInterestRateTEC.text.trim()) ?? 1 / 100;
    final numOfYearsRate = double.tryParse(numOfYearsRateTEC.text.trim()) ?? 0;
    final initialLumpSum = double.tryParse(initialLumpSumTEC.text.trim()) ?? 1;

    final compoundInterest = calculateCompoundInterest(
      initialLumpSum,
      annualInterestRate,
      numOfYearsRate,
    );

    final recurring = calculateMonthlyContribution(
      monthlyContribution,
      annualInterestRate,
      numOfYearsRate,
    );

    final result = compoundInterest + recurring;

    final sum = (result * 100).truncateToDouble() / 100;

    pensionAppLogger.e(sum.toStringAsFixed(2));
    // total.value = 0;

    total.value = (result * 100).truncateToDouble() / 100;

    interest.value = compoundInterest;
    // }
  }

  bool get validateFields {
    if (
    //initialLumpSumTEC.text.trim().isEmpty ||
    monthlyContributionTEC.text.trim().isEmpty ||
        annualInterestRateTEC.text.trim().isEmpty ||
        numOfYearsRateTEC.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  /// [Formula 1]: Compound Interest
  /// A = P(1 + r/n)^(n * t)
  double calculateCompoundInterest(double P, double r, double t) {
    if (P <= 0 || r < 0 || t <= 0) return 0;

    // Convert rate to decimal if given as percent (e.g. 5 -> 0.05)
    final rate = r > 1 ? r / 100 : r;

    // Safe power computation
    final exponent = n * t;
    final base = 1 + (rate / n);

    double result;
    try {
      result = P * pow(base, exponent);
    } catch (_) {
      result = 0;
    }

    // Cap huge unrealistic values
    return result.isFinite && result < 1e12 ? result : 0;
  }

  /// [Formula 2]: Future Value of Monthly Contributions
  /// A = M * ((1 + r/n)^(n*t) - 1) / (r/n)
  double calculateMonthlyContribution(double M, double r, double l) {
    if (M <= 0 || r < 0 || l <= 0) return 0;

    final rate = r > 1 ? r / 100 : r;
    final ratePerPeriod = rate / n;
    final exponent = n * l;
    final compoundFactor = pow(1 + ratePerPeriod, exponent).toDouble();

    if (ratePerPeriod == 0) return M * n * l; // handle 0% interest

    final result = M * ((compoundFactor - 1) / ratePerPeriod);
    return result.isFinite && result < 1e12 ? result : 0;
  }

  // /// [Formula] 1 => P(1 + r/n)^(n * t)
  // /// P = Initial Lump Sum
  // /// r = Annual interest rate (as a decimal, e.g 5% = 0.05)
  // /// n = Number of times interest is compounded per year
  // /// t = Number of years
  // double calculateCompoundInterest(double P, double r, double t) {
  //   return P * pow((1 + r / n), n * t);
  // }

  // /// [Formula] 2 => M((1 + r/n)^(n*t) - 1) / (r/n)
  // /// M = Monthly Contribution
  // /// r = Annual interest rate (as a decimal, e.g 5% = 0.05)
  // /// n = Number of times interest is compounded per year (monthly compounding -> n = 12)
  // /// t = Number of years
  // double calculateMonthlyContribution(double M, double r, double l) {
  //   double ratePerPeriod = r / n;
  //   double exponent = n * l;
  //   double compoundFactor = pow(1 + ratePerPeriod, exponent).toDouble();
  //   return M * ((compoundFactor - 1) / ratePerPeriod);
  // }
}
