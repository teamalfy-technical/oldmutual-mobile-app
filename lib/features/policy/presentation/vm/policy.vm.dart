import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

final activeStatuses = {
  "INFORCE POLICY",
  "MATURITY RESERVE",
  "PAIDUP",
  "MOVED TO DAS",
  "SURRENDER NOTIFIED",
  "ACTIVE",
  "DORMANT",
};

class PPolicyVm extends GetxController {
  static PPolicyVm get instance => Get.find();

  var policies = <Policy>[].obs;
  var activePolicies = <Policy>[].obs;
  var inactivePolicies = <Policy>[].obs;
  // var lapsedPolicies = <Policy>[].obs;

  final claimFormKey = GlobalKey<FormState>();

  final amountTEC = TextEditingController();
  final accountNumberTEC = TextEditingController();

  // var schemes = <Scheme>[].obs;
  var products = <Map<String, dynamic>>[].obs;

  var paymentMethods = <PaymentMethod>[].obs;

  PaymentMethod? selectedPaymentMethod;
  Policy? selectedPolicy;

  var summary = PolicySummary().obs;
  // var pensionSummary = PensionSummary().obs;

  var loading = LoadingState.completed.obs;
  var submitting = LoadingState.completed.obs;

  /// Flag to track if policies have been fetched at least once
  var _hasFetchedPolicies = false;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  var currentIndex = 0.obs;

  onSelectedPolicy(Policy val) {
    selectedPolicy = val;
    update();
    pensionAppLogger.e(selectedPolicy?.toJson());
  }

  onPageChanged(int val) {
    currentIndex.value = val;
  }

  @override
  void onInit() {
    getPolicySummary();
    super.onInit();
  }

  onPaymentMethodChanged(value) {
    selectedPaymentMethod = value;
    update();
  }

  /// Function to get all schemes or retail
  Future<void> getPolicySummary() async {
    updateLoadingState(LoadingState.loading);
    final result = await policyService.getPolicySummary();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        summary.value =
            res.data ??
            PolicySummary(
              totalClaimAmount: 0,
              totalLifeInvestment: 0,
              totalPolicies: 0,
              expiredPolicies: 0,
              pendingClaims: 0,
              availableBalance: 0.0,
              lastUpdated: '',
            );
        getProducts();
      },
    );
  }

  /// Function to get all payment methods
  Future<void> getPaymentMethods() async {
    updateLoadingState(LoadingState.loading);
    final result = await policyService.getPaymentMethods();
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
        pensionAppLogger.d(paymentMethods.map((e) => e.toJson()));
        update();
      },
    );
  }

  /// Function to get all schemes or retail
  Future<void> submitClaimRequest() async {
    submitting(LoadingState.loading);

    final result = await policyService.submitClaimRequest(
      claimAmount: amountTEC.text.trim().isEmpty
          ? 0.0
          : double.parse(amountTEC.text),
      claimDefaultMomoWallet: accountNumberTEC.text,
      claimDefaultTelcomethod: selectedPaymentMethod?.code ?? '',
      currentCashValue: selectedPolicy?.cashValue ?? 0,
      policyNumber: selectedPolicy?.policyNo ?? '',
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

        /// Navigate to success page
        navigateToSuccessPage();
      },
    );
  }

  /// Function to get summary for pensions
  // Future<void> getPensionSummary() async {
  //   updateLoadingState(LoadingState.loading);
  //   final result = await pensionService.getPensionSummary();
  //   result.fold(
  //     (err) {
  //       updateLoadingState(LoadingState.error);
  //       PPopupDialog(
  //         context,
  //       ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
  //     },
  //     (res) async {
  //       updateLoadingState(LoadingState.completed);
  //       pensionSummary.value =
  //           res.data ?? PensionSummary(totalInvestment: 0, totalPensions: 0);
  //       await getAllPolices();
  //     },
  //   );
  // }

  // /// Function to get all schemes or retail
  // Future<void> getMemberSchemes() async {
  //   updateLoadingState(LoadingState.loading);
  //   final result = await pensionService.getMemberSchemes();
  //   result.fold(
  //     (err) {
  //       updateLoadingState(LoadingState.error);
  //       PPopupDialog(
  //         context,
  //       ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
  //     },
  //     (res) {
  //       updateLoadingState(LoadingState.completed);
  //       schemes.value = res.data ?? [];
  //       // getProducts();
  //     },
  //   );
  // }

  /// Fetches policies only on first load, subsequent calls are ignored
  /// Use this when navigating to the policy overview page
  Future<void> fetchPoliciesOnFirstLoad() async {
    if (_hasFetchedPolicies) return;
    await getAllPolicies();
  }

  /// Function to fetch all policies or products
  Future<void> getAllPolicies() async {
    updateLoadingState(LoadingState.loading);

    final result = await policyService.getPolicies(status: '');
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        _hasFetchedPolicies = true;
        policies.value = res.data?.policyDetails ?? [];
        activePolicies.value = policies
            .where((p) => activeStatuses.contains(p.status ?? ""))
            .toList();
        inactivePolicies.value = policies
            .where((p) => !activeStatuses.contains(p.status ?? ""))
            .toList();

        // activePolicies.value = policies
        //     .where(
        //       (p) =>
        //           p.status!.contains(PolicyStatus.inforce.name.toUpperCase()),
        //     )
        //     .toList();
        // inactivePolicies.value = policies
        //     .where((p) => p.status == PolicyStatus.expired.name.toUpperCase())
        //     .toList();
        // lapsedPolicies.value = policies
        //     .where(
        //       (p) => p.status!.contains(PolicyStatus.lapsed.name.toUpperCase()),
        //     )
        //     .toList();
        // await getMemberSchemes();
        // getProducts();
        // pensionAppLogger.i(policies);
      },
    );
  }

  /// Function to get all schemes or retail
  // Future<void> getMemberSchemes() async {
  //   updateLoadingState(LoadingState.loading);
  //   final result = await dashboardService.getMemberSchemes();
  //   result.fold(
  //     (err) {
  //       updateLoadingState(LoadingState.error);
  //       PPopupDialog(
  //         context,
  //       ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
  //     },
  //     (res) {
  //       updateLoadingState(LoadingState.completed);
  //       schemes.value = res.data ?? [];
  //       getProducts();
  //     },
  //   );
  // }

  List<Map<String, dynamic>> getProducts() {
    final vm = Get.find<PPensionVm>();

    final items = [
      {
        'name': 'Life Insurance',
        'type': ProductType.insurance,
        'num_of_account': summary.value.totalPolicies ?? policies.length,
        'contribution': summary.value.totalLifeInvestment == null
            ? 0.00
            : summary.value.totalLifeInvestment ?? 0.0,
      },
      {
        'name': 'Pensions',
        'type': ProductType.pensions,
        'num_of_account':
            vm.summary.value.totalPensions ?? 0, //vm.schemes.length,
        'contribution': vm.summary.value.totalInvestment?.toDouble() ?? 0.00,
      },
      // {
      //   'name': 'corporate_account'.tr,
      //   'type': ProductType.corporate,
      //   'num_of_account': 0,
      //   'description': 'corporate_account_hint'.tr,
      // },
      // {
      //   'name': 'Solutions for you',
      //   'type': 'Corporate',
      //   'num_of_account': 0,
      //   'contribution': 25000.00,
      // },
    ];

    products.value = items;
    return products;
  }

  // Future<void> submitWithdrawalRequest() async {
  //   amountTEC.clear();
  //   navigateToSuccessPage();
  // }

  /// Function to navigate user to success screen after report has been generated
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
