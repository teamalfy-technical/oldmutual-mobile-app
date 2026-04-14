import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PClaimsVm extends GetxController {
  static PClaimsVm get instance => Get.find();

  final claimFormKey = GlobalKey<FormState>();

  final amountTEC = TextEditingController();
  final accountNumberTEC = TextEditingController();
  var amount = 0.0.obs;

  var paymentMethods = <PaymentMethod>[].obs;
  var withdrawalReasons = <WithdrawalReason>[].obs;

  PaymentMethod? selectedPaymentMethod;
  WithdrawalReason? selectedWithdrawalReason;
  Policy? selectedPolicy;

  var loading = LoadingState.completed.obs;
  var submitting = LoadingState.completed.obs;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  onSelectedPolicy(Policy val) {
    selectedPolicy = val;
    update();
  }

  onPaymentMethodChanged(value) {
    selectedPaymentMethod = value;
    update();
  }

  onWithdrawalReasonChanged(value) {
    selectedWithdrawalReason = value;
    update();
  }

  onAmountChanged(String value) {
    amount.value = double.tryParse(value) ?? 0.0;
  }

  /// Function to get all payment methods
  Future<void> getPaymentMethods() async {
    updateLoadingState(LoadingState.loading);
    final result = await claimsService.getPaymentMethods();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        paymentMethods.value = res.data ?? [];
        pensionAppLogger.d(paymentMethods.map((e) => e.toJson()).toList());
        update();
      },
    );
  }

  /// Function to get all withdrawal reasons
  Future<void> getWithdrawalReasons() async {
    updateLoadingState(LoadingState.loading);
    final result = await claimsService.getWithdrawalReasons();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        withdrawalReasons.value = res.data ?? [];
        update();
      },
    );
  }

  /// Function to submit instant claim request
  Future<void> submitInstantClaimRequest() async {
    submitting(LoadingState.loading);

    final result = await claimsService.submitInstantClaimRequest(
      claimAmount: amountTEC.text.trim().isEmpty
          ? 0.0
          : double.parse(amountTEC.text),
      claimDefaultMomoWallet: accountNumberTEC.text,
      claimDefaultTelcomethod: selectedPaymentMethod?.code ?? '',
      currentCashValue: selectedPolicy?.availableBalance ?? 0,
      policyNumber: selectedPolicy?.policyNo ?? '',
      withdrawalPurpose: selectedWithdrawalReason?.id ?? 0,
    );
    result.fold(
      (err) {
        submitting(LoadingState.error);

        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        submitting(LoadingState.completed);

        /// Backend may wrap a failure inside a successful envelope:
        /// { success: true, data: { success: false, message: "..." } }
        if (res.data?.success == false) {
          PPopupDialog(context).warningMessage(
            title: 'sorry'.tr,
            message: res.data?.message ?? 'error_occurred_msg'.tr,
          );
          return;
        }

        /// Navigate to success page
        navigateToSuccessPage();
      },
    );
  }

  /// Function to navigate user to success screen after claim has been submitted
  navigateToSuccessPage() {
    PHelperFunction.switchScreen(
      destination: Routes.settingsSuccessPage,
      args: [
        'claim_req_success_subtitle'.tr,
        'claim_req_success_title'.tr,
        'done'.tr.toUpperCase(),
        () {
          PHelperFunction.pop();
          PHelperFunction.pop();
        },
      ],
    );
  }
}
