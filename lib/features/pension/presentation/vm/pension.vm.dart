import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPensionVm extends GetxController {
  static PPensionVm get instance => Get.find();

  var policies = <Policy>[].obs;
  var inforcePolicies = <Policy>[].obs;
  var expiredPolicies = <Policy>[].obs;
  var lapsedPolicies = <Policy>[].obs;

  var schemes = <Scheme>[].obs;
  var summary = PensionSummary().obs;
  var selectedScheme = SelectedScheme().obs;
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
    getPensionSummary();
    super.onInit();
  }

  /// Function to get summary for pensions
  Future<void> getPensionSummary() async {
    updateLoadingState(LoadingState.loading);
    final result = await pensionService.getPensionSummary();
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
            res.data ?? PensionSummary(totalInvestment: 0, totalPensions: 0);
        // await Get.put(PContributionHistoryVm()).getContributionsSummary();
        await getMemberSchemes();
      },
    );
  }

  /// Function to fetch all policies or products
  // Future<void> getAllPolices() async {
  //   updateLoadingState(LoadingState.loading);
  //   final result = await policyService.getPolicies(status: '');
  //   result.fold(
  //     (err) {
  //       updateLoadingState(LoadingState.error);
  //       PPopupDialog(
  //         context,
  //       ).errorMessage(title: 'error'.tr, message: err.message);
  //     },
  //     (res) async {
  //       updateLoadingState(LoadingState.completed);
  //       policies.value = res.data?.policyDetails ?? [];
  //       inforcePolicies.value = policies
  //           .where(
  //             (p) =>
  //                 p.status!.contains(PolicyStatus.inforce.name.toUpperCase()),
  //           )
  //           .toList();
  //       expiredPolicies.value = policies
  //           .where((p) => p.status == PolicyStatus.expired.name.toUpperCase())
  //           .toList();
  //       lapsedPolicies.value = policies
  //           .where(
  //             (p) => p.status!.contains(PolicyStatus.lapsed.name.toUpperCase()),
  //           )
  //           .toList();
  //       await getMemberSchemes();
  //       pensionAppLogger.i(policies);
  //     },
  //   );
  // }

  /// Function to get all schemes or retail
  Future<void> getMemberSchemes() async {
    updateLoadingState(LoadingState.loading);
    final result = await pensionService.getMemberSchemes();
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
        // getProducts();
      },
    );
  }

  /// Function to get all selected scheme
  Future<void> getMemberSelectedScheme({
    required String employerName,
    required String employerNumber,
    required String ssnitNumber,
    required String memberName,
    required String memberNumber,
    required String masterScheme,
    required String schemeType,
    required String email,
    required String dob,
    required String dateJoined,
    required String sex,
    required String nationality,
  }) async {
    updateLoadingState(LoadingState.error);
    final result = await pensionService.getSelectedMemberScheme(
      employerName: employerName,
      employerNumber: employerNumber,
      memberName: memberName,
      memberNumber: memberNumber,
      ssnitNumber: ssnitNumber,
      masterScheme: masterScheme,
      schemeType: schemeType,
      email: email,
      dob: dob,
      dateJoined: dateJoined,
      sex: sex,
      nationality: nationality,
    );
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        // updateSelectingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        selectedScheme.value = res.data ?? SelectedScheme();
        final updatedMember = PSecureStorage().getAuthResponse()?.copyWith(
          masterScheme: res.data?.masterScheme ?? '',
          schemeType: res.data?.schemeType ?? '',
          name: res.data?.name ?? '',
          emailVerifiedAt: res.data?.emailVerifiedAt ?? '',
          avatar: res.data?.avatar ?? '',
          phone: res.data?.phone ?? '',
          email: res.data?.email ?? '',
          sex: res.data?.sex ?? '',
          ssnitNumber: res.data?.ssnitNumber ?? '',
          memberNumber: res.data?.memberNumber ?? '',
          dob: res.data?.dob ?? '',
          role: res.data?.role ?? '',
          nationality: res.data?.nationality ?? '',
          dateJoined: res.data?.dateJoined ?? '',
          employerName: res.data?.employerName ?? '',
          employerNumber: res.data?.employerNumber ?? '',
          updatedAt: res.data?.updatedAt ?? '',
        );
        pensionAppLogger.e(res.data?.toJson());
        PSecureStorage().saveAuthResponse(updatedMember?.toJson());
        pensionAppLogger.e(PSecureStorage().getAuthResponse()?.toJson());
        await Get.put(PContributionHistoryVm()).getContributionsSummary();

        // await Get.put(PContributionHistoryVm()).getAllContributions();
        updateLoadingState(LoadingState.completed);
        // updateSelectingState(LoadingState.completed);
        // PHelperFunction.pop();
        // PHelperFunction.switchScreen(
        //   destination: Routes.homePage,

        // );
        // await Get.put(PAuthVm()).getBioData();
      },
    );
  }
}
