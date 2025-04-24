import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/shared/widgets/popup.dialog.dart';

class PBeneficiaryVm extends GetxController {
  static PBeneficiaryVm get instance => Get.find();

  var beneficiaries = <Beneficiary>[].obs;

  var loading = LoadingState.completed.obs;

  final nameTEC = TextEditingController();
  final dobTEC = TextEditingController();
  final relationTEC = TextEditingController();
  final benefitPercentageTEC = TextEditingController();
  final contactTEC = TextEditingController();

  var split = true.obs;

  onSplitChanged(bool? value) => split.value = value ?? false;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  @override
  void onInit() {
    super.onInit();
    getBeneficiaries();
  }

  /// Function to get all beneficiaries
  Future<void> getBeneficiaries() async {
    updateLoadingState(LoadingState.loading);
    final result = await beneficiaryService.getBeneficiaries();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        if (res.data!.isNotEmpty) {
          res.data?.first.show = true;
        }
        updateLoadingState(LoadingState.completed);
        beneficiaries.value = res.data ?? [];
      },
    );
  }

  /// Function to edit a beneficiary
  Future<void> editBeneficiary() async {
    showSucccessdialog(
      context: context,
      mainAxisAlignment: MainAxisAlignment.center,
      title: '${'success'.tr}!',
      subtitle: Text(
        'save_beneficiary_changes_msg'.tr,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: PAppColor.text700),
      ),
    );
    Future.delayed(Duration(milliseconds: 3000), () {
      PHelperFunction.pop();
    });
  }

  /// Function to add a beneficiary
  Future<void> addBeneficiary() async {
    showSucccessdialog(
      context: context,
      mainAxisAlignment: MainAxisAlignment.center,
      title: '${'success'.tr}!',
      subtitle: Text(
        'save_beneficiary_changes_msg'.tr,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: PAppColor.text700),
      ),
    );
    Future.delayed(Duration(milliseconds: 3000), () {
      PHelperFunction.pop();
    });
  }

  /// Function to delete a beneficiary
  Future<void> deleteBeneficiary() async {
    PHelperFunction.pop();
  }
}
