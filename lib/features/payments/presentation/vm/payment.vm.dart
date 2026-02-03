import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

enum PaymentType { pensions, policy }

class PPaymentVm extends GetxController {
  static PPaymentVm get instance => Get.find();

  final paymentFormKey = GlobalKey<FormState>();

  final amountTEC = TextEditingController();

  var pensionsPayments = <Payment>[].obs;
  var policyPayments = <Payment>[].obs;

  var paymentMethods = <PaymentMethod>[].obs;
  PaymentMethod? selectedPaymentMethod;

  var loading = LoadingState.completed.obs;
  var submitting = LoadingState.completed.obs;

  /// Flag to track if payments have been fetched
  var _hasFetchedPensionsPayments = false;
  var _hasFetchedPolicyPayments = false;

  final context = Get.context!;

  /// Current payment type being processed
  PaymentType currentPaymentType = PaymentType.policy;

  /// Selected policy number and product for payment
  String? selectedPolicyNumber;
  String? selectedProduct;
  var amount = 0.0.obs;

  /// Currency for payment (default GHS)
  String currency = 'GHS';

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  onPaymentMethodChanged(PaymentMethod? value) {
    selectedPaymentMethod = value;
    update();
  }

  onAmountChanged(String value) {
    amount.value = double.tryParse(value) ?? 0.0;
  }

  /// Set the payment context for policy payment
  void setPaymentContextForPolicy({
    required String policyNumber,
    required String product,
  }) {
    currentPaymentType = PaymentType.policy;
    selectedPolicyNumber = policyNumber;
    selectedProduct = product;
    update();
  }

  /// Set the payment context for pensions payment
  void setPaymentContextForPensions() {
    currentPaymentType = PaymentType.pensions;
    selectedPolicyNumber = null;
    selectedProduct = null;
    update();
  }

  /// Clear form fields
  void clearForm() {
    amountTEC.clear();
    selectedPaymentMethod = null;
    update();
  }

  /// Fetch pensions payments on first load
  Future<void> fetchPensionsPaymentsOnFirstLoad() async {
    if (_hasFetchedPensionsPayments) return;
    await getPensionsPayments();
  }

  /// Fetch policy payments on first load
  Future<void> fetchPolicyPaymentsOnFirstLoad() async {
    if (_hasFetchedPolicyPayments) return;
    await getPolicyPayments();
  }

  /// Get pensions payment history
  Future<void> getPensionsPayments() async {
    updateLoadingState(LoadingState.loading);
    final result = await paymentService.getPensionsPayments();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        _hasFetchedPensionsPayments = true;
        pensionsPayments.value = res.data ?? [];
        pensionAppLogger.d('Pensions Payments: ${pensionsPayments.length}');
      },
    );
  }

  /// Get policy payment history
  Future<void> getPolicyPayments() async {
    updateLoadingState(LoadingState.loading);
    final result = await paymentService.getPolicyPayments();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        _hasFetchedPolicyPayments = true;
        policyPayments.value = res.data ?? [];
        pensionAppLogger.d('Policy Payments: ${policyPayments.length}');
      },
    );
  }

  /// Initiate a payment based on current payment type
  Future<void> initiatePayment() async {
    if (!paymentFormKey.currentState!.validate()) return;

    submitting(LoadingState.loading);

    final amount = double.tryParse(amountTEC.text.trim()) ?? 0.0;

    if (currentPaymentType == PaymentType.pensions) {
      await _initiatePensionsPayment(amount: amount, currency: currency);
    } else {
      await _initiatePolicyPayment(
        amount: amount,
        policyNumber: selectedPolicyNumber ?? '',
        product: selectedProduct ?? '',
        currency: currency,
      );
    }
  }

  /// Initiate pensions payment
  Future<void> _initiatePensionsPayment({
    required double amount,
    required String currency,
  }) async {
    final result = await paymentService.initiatePensionsPayment(
      amount: amount,
      currency: currency,
    );

    result.fold(
      (err) {
        submitting(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        submitting(LoadingState.completed);
        pensionAppLogger.i('Pensions Payment Response: ${res.data?.toJson()}');

        // Open checkout URL if available
        final checkoutUrl = res.data?.checkoutUrl;

        PHelperFunction.switchScreen(
          destination: Routes.webviewPage,
          args: ['make_payment'.tr, checkoutUrl],
        );

        // Refresh payment history
        _hasFetchedPensionsPayments = false;
        clearForm();
      },
    );
  }

  /// Initiate policy payment
  Future<void> _initiatePolicyPayment({
    required double amount,
    required String policyNumber,
    required String product,
    required String currency,
  }) async {
    final result = await paymentService.initiatePolicyPayment(
      amount: amount,
      policyNumber: policyNumber,
      product: product,
      currency: currency,
    );

    result.fold(
      (err) {
        submitting(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        submitting(LoadingState.completed);
        pensionAppLogger.i('Policy Payment Response: ${res.data?.toJson()}');

        // Open checkout URL if available
        final checkoutUrl = res.data?.checkoutUrl;
        PHelperFunction.switchScreen(
          destination: Routes.webviewPage,
          args: ['make_payment'.tr, checkoutUrl],
        );

        // Refresh payment history
        _hasFetchedPolicyPayments = false;
        clearForm();
      },
    );
  }

  /// Launch checkout URL in browser
  // Future<void> _launchCheckoutUrl(String url) async {
  //   try {
  //     final uri = Uri.parse(url);
  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(uri, mode: LaunchMode.externalApplication);
  //     } else {
  //       PPopupDialog(context).errorMessage(
  //         title: 'error'.tr,
  //         message: 'Could not open payment page',
  //       );
  //     }
  //   } catch (e) {
  //     pensionAppLogger.e('Error launching checkout URL: $e');
  //     PPopupDialog(
  //       context,
  //     ).errorMessage(title: 'error'.tr, message: 'Could not open payment page');
  //   }
  // }

  /// Navigate to success page after payment initiation
  void navigateToSuccessPage() {
    clearForm();
    PHelperFunction.switchScreen(
      destination: Routes.settingsSuccessPage,
      args: [
        'payment_success_msg'.trParams({
          'amount': '**${PFormatter.formatCurrency(amount: amount.value)}**',
        }),
        'payment_success_title'.tr,
        'done'.tr.toUpperCase(),
        () {
          PHelperFunction.pop();
          PHelperFunction.pop();
          PHelperFunction.pop();
        },
      ],
    );
  }
}
