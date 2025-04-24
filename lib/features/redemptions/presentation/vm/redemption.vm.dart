import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PRedemptionVm extends GetxController {
  static PRedemptionVm get instance => Get.find();

  var loading = LoadingState.completed.obs;

  final amountTEC = TextEditingController();
  final reasonTEC = TextEditingController();
  final bankNameTEC = TextEditingController();
  final accountNumberTEC = TextEditingController();

  var selectedRedemptionOption = 'withdraw'.obs;

  onRedemptionOptionChanged(val) {
    selectedRedemptionOption.value = val;
    pensionAppLogger.e(selectedRedemptionOption.value);
  }

  var agree = false.obs;

  onAgreeChanged(bool? value) => agree.value = value ?? false;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  /// Function to redeem pension
  Future<void> redeemPension() async {
    showSucccessdialog(
      context: context,
      mainAxisAlignment: MainAxisAlignment.center,
      title: '${'success'.tr}!',
      subtitle: Text(
        'redeem_pension_msg'.tr,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: PAppColor.text700),
      ),
    );
    Future.delayed(Duration(milliseconds: 5000), () {
      PHelperFunction.pop();
    });
  }

  /// Function to port pension scheme
  Future<void> portPensionScheme() async {
    showSucccessdialog(
      context: context,
      mainAxisAlignment: MainAxisAlignment.center,
      title: '${'success'.tr}!',
      subtitle: Text(
        'porting_msg'.tr,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: PAppColor.text700),
      ),
    );
    Future.delayed(Duration(milliseconds: 5000), () {
      PHelperFunction.pop();
    });
  }
}
