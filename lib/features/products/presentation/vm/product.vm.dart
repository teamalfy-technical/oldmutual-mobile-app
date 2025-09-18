import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/dashboard/dashboard.dart';
import 'package:oldmutual_pensions_app/features/products/products.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PProductVm extends GetxController {
  static PProductVm get instance => Get.find();

  var policies = <Policy>[].obs;
  var inforcePolicies = <Policy>[].obs;
  var expiredPolicies = <Policy>[].obs;
  var lapsedPolicies = <Policy>[].obs;

  var schemes = <Scheme>[].obs;
  var products = <Map<String, dynamic>>[].obs;

  var loading = LoadingState.completed.obs;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  var currentIndex = 0.obs;

  onPageChanged(int val) {
    currentIndex.value = val;
  }

  @override
  void onInit() {
    getAllPolices();

    super.onInit();
  }

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
        await getMemberSchemes();
        pensionAppLogger.i(policies);
      },
    );
  }

  /// Function to get all schemes or retail
  Future<void> getMemberSchemes() async {
    updateLoadingState(LoadingState.loading);
    final result = await dashboardService.getMemberSchemes();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        schemes.value = res.data ?? [];
        getProducts();
      },
    );
  }

  List<Map<String, dynamic>> getProducts() {
    final totalPolicyBalance = policies.fold<double>(
      0.0,
      (sum, item) => sum + (item.sumAssured ?? 0),
    );
    final totalSchemeValue = schemes.fold<double>(
      0.0,
      (sum, item) => sum + (item.schemeCurrentValue ?? 0),
    );
    pensionAppLogger.i('Total Retail: $totalPolicyBalance');
    pensionAppLogger.i('Total Pension: $totalSchemeValue');
    final items = [
      {
        'name': 'Retail',
        'type': ProductType.retail,
        'num_of_account': policies.length,
        'contribution': totalPolicyBalance,
      },
      {
        'name': 'Pension',
        'type': ProductType.pensions,
        'num_of_account': schemes.length,
        'contribution': totalSchemeValue,
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
