import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PFutureValueCalcVm extends GetxController {
  static PFutureValueCalcVm get instance => Get.find();

  final contributionRateTEC = TextEditingController();
  final currentAgeTEC = TextEditingController();
  final retirementAgeTEC = TextEditingController();
  final interestRateTEC = TextEditingController();

  var all = false.obs;

  onAllChanged(bool? value) => all.value = value ?? false;

  void resetCalculator() {
    contributionRateTEC.clear();
    currentAgeTEC.clear();
    retirementAgeTEC.clear();
    interestRateTEC.clear();
    PHelperFunction.pop();
  }
}
