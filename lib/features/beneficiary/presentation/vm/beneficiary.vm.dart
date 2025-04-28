import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/shared/widgets/popup.dialog.dart';

class PBeneficiaryVm extends GetxController {
  static PBeneficiaryVm get instance => Get.find();

  var beneficiaries = <Beneficiary>[].obs;

  var loading = LoadingState.completed.obs;
  var submitting = LoadingState.completed.obs;

  final formKey = GlobalKey<FormState>();

  final nameTEC = TextEditingController();
  final dobTEC = TextEditingController();
  final relationTEC = TextEditingController();
  final benefitPercentageTEC = TextEditingController();
  final contactTEC = TextEditingController();

  var split = false.obs;

  onSplitChanged(bool? value, bool isEdit) {
    split.value = value ?? false;
    splitPercentageContribution(isEdit);
  }

  splitPercentageContribution(bool isEdit) {
    if (split.value == true) {
      final splittedPercentage =
          isEdit
              ? 100 / beneficiaries.length
              : 100 / (beneficiaries.length + 1);
      benefitPercentageTEC.text = splittedPercentage.toStringAsFixed(2);
    } else {
      benefitPercentageTEC.clear();
    }
  }

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;
  updateSubmittingState(LoadingState loadingState) =>
      submitting.value = loadingState;

  @override
  void onInit() {
    super.onInit();
    getBeneficiaries();
  }

  updateEditFields(Beneficiary? beneficiary) {
    if (beneficiary != null) {
      nameTEC.text = beneficiary.fullName ?? '';
      dobTEC.text = PFormatter.formatDate(
        dateFormat: DateFormat('dd-MM-yyyy'),
        date: DateTime.parse(
          beneficiary.birthDate ?? DateTime.now().toIso8601String(),
        ),
      );
      relationTEC.text = beneficiary.relationship ?? '';
      benefitPercentageTEC.text = beneficiary.percAlloc.toString();
      contactTEC.text = beneficiary.address ?? '';
    }
  }

  clearFields() {
    nameTEC.clear();
    dobTEC.clear();
    relationTEC.clear();
    benefitPercentageTEC.clear();
    contactTEC.clear();
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

  // check to make sure the split percentage adds up to 100% when percentage is not splitted
  bool isSplitPercentageValid() {
    if (split.value == false) {
      final perAlloc = beneficiaries.map((e) => e.percAlloc ?? 0);
      final totalAlloc = perAlloc.reduce((a, b) => a + b);
      final total = totalAlloc + double.parse(benefitPercentageTEC.text.trim());
      if (total > 100) {
        PPopupDialog(context).errorMessage(
          title: 'action_required'.tr,
          message:
              'Total percentage can\'t be more than 100%. Your previous total benefit allocation is $totalAlloc%',
        );
        return false;
      }
    }
    return true;
  }

  /// Function to edit a beneficiary
  Future<void> editBeneficiary(Beneficiary beneficiary) async {
    // pensionAppLogger.d(date);
    showLoadingdialog(
      context: context,
      barrierDismissible: true,
      content: Text(
        'updating_beneficiary_msg'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    final result = await beneficiaryService.updateBeneficiary(
      beneficiaryId: beneficiary.beneficiaryId ?? 0,
      fullName: nameTEC.text.trim(),
      relationship: relationTEC.text.trim(),
      percAlloc: double.parse(benefitPercentageTEC.text.trim()),
      birthDate: PFormatter.formatDate(
        dateFormat: DateFormat('yyyy-MM-dd HH:mm:ss'),
        date: DateTime.parse(
          beneficiary.birthDate ?? DateTime.now().toIso8601String(),
        ),
      ),
      address: contactTEC.text.trim(),
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PHelperFunction.pop();
        showSuccessMessage('save_beneficiary_changes_msg'.tr);
        Future.delayed(Duration(seconds: PAppSize.s2.toInt()), () {
          PHelperFunction.pop();
        });
      },
    );
  }

  showSuccessMessage(String messge) {
    showSucccessdialog(
      context: context,
      mainAxisAlignment: MainAxisAlignment.center,
      title: '${'success'.tr}!',
      subtitle: Text(
        messge,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: PAppColor.text700),
      ),
    );
    Future.delayed(Duration(milliseconds: 3000), () {
      PHelperFunction.pop();
      PHelperFunction.pop();
    });
  }

  /// Function to add a beneficiary
  Future<void> addBeneficiary() async {
    //pensionAppLogger.d(formatBirthDate(dobTEC.text.trim()));
    showLoadingdialog(
      context: context,
      barrierDismissible: true,
      content: Text(
        'adding_beneficiary_msg'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    // updateSubmittingState(LoadingState.loading);
    final result = await beneficiaryService.updateBeneficiary(
      fullName: nameTEC.text.trim(),
      relationship: relationTEC.text.trim(),
      percAlloc: double.parse(benefitPercentageTEC.text.trim()),
      birthDate: PFormatter.formatDateStrict(
        dateFormat: DateFormat('dd-MM-yyyy'),
        date: dobTEC.text.trim(),
      ),
      address: contactTEC.text.trim(),
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        // updateSubmittingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        // updateSubmittingState(LoadingState.completed);
        PHelperFunction.pop();
        showSuccessMessage('save_beneficiary_changes_msg'.tr);
        Future.delayed(Duration(seconds: PAppSize.s2.toInt()), () {
          PHelperFunction.pop();
        });
      },
    );
  }

  /// Function to delete a beneficiary
  Future<void> deleteBeneficiary(Beneficiary beneficiary) async {
    showLoadingdialog(
      context: context,
      barrierDismissible: true,
      content: Text(
        'deleting_beneficiary'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    final result = await beneficiaryService.deleteBeneficiary(
      beneficiaryId: beneficiary.beneficiaryId ?? 0,
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PHelperFunction.pop();
        showSucccessdialog(context: context, title: res.message ?? '');
        Future.delayed(Duration(seconds: PAppSize.s2.toInt()), () {
          PHelperFunction.pop();
        });
      },
    );
  }
}
