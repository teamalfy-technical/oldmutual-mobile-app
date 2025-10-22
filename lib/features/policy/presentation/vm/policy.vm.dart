import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPolicyVm extends GetxController {
  static PPolicyVm get instance => Get.find();

  var policies = <Policy>[].obs;
  var inforcePolicies = <Policy>[].obs;
  var expiredPolicies = <Policy>[].obs;
  var lapsedPolicies = <Policy>[].obs;

  // var schemes = <Scheme>[].obs;
  var products = <Map<String, dynamic>>[].obs;

  var summary = PolicySummary().obs;
  // var pensionSummary = PensionSummary().obs;

  var loading = LoadingState.completed.obs;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  var currentIndex = 0.obs;

  onPageChanged(int val) {
    currentIndex.value = val;
  }

  @override
  void onInit() {
    getPolicySummary();
    super.onInit();
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
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        summary.value =
            res.data ??
            PolicySummary(
              totalClaimAmount: 0,
              totalCover: 0,
              totalPolicies: 0,
              expiredPolicies: 0,
              pendingClaims: 0,
              availableBalance: 0.0,
              lastUpdated: '',
            );
        await getAllPolices();
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
  //       ).errorMessage(title: 'error'.tr, message: err.message);
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
  //       ).errorMessage(title: 'error'.tr, message: err.message);
  //     },
  //     (res) {
  //       updateLoadingState(LoadingState.completed);
  //       schemes.value = res.data ?? [];
  //       // getProducts();
  //     },
  //   );
  // }

  /// Function to fetch all policies or products
  Future<void> getAllPolices() async {
    updateLoadingState(LoadingState.loading);

    final result = await policyService.getPolicies(status: '');
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        policies.value = res.data?.policyDetails ?? [];
        inforcePolicies.value = policies
            .where(
              (p) =>
                  p.status!.contains(PolicyStatus.inforce.name.toUpperCase()),
            )
            .toList();
        expiredPolicies.value = policies
            .where((p) => p.status == PolicyStatus.expired.name.toUpperCase())
            .toList();
        lapsedPolicies.value = policies
            .where(
              (p) => p.status!.contains(PolicyStatus.lapsed.name.toUpperCase()),
            )
            .toList();
        // await getMemberSchemes();
        getProducts();
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
  //       ).errorMessage(title: 'error'.tr, message: err.message);
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
        'num_of_account':
            //summary.value.totalPolicies ?? 0,
            policies.length,
        'contribution': summary.value.availableBalance == null
            ? 0.00
            : summary.value.availableBalance ?? 0.0,
      },
      {
        'name': 'Pensions',
        'type': ProductType.pensions,
        'num_of_account':
            vm.summary.value.totalPensions ?? 0, //vm.schemes.length,
        'contribution': vm.summary.value.totalInvestment?.toDouble() ?? 0.00,
      },
      // {
      //   'name': 'Corporate',
      //   'type': ProductType.corporate,
      //   'num_of_account': 0,
      //   'contribution': 0.00,
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
}
