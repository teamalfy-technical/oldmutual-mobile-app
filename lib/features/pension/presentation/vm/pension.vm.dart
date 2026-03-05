import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPensionVm extends GetxController {
  static PPensionVm get instance => Get.find();

  var schemes = <Scheme>[].obs;
  var activeSchemes = <Scheme>[].obs;
  var inactiveSchemes = <Scheme>[].obs;
  var summary = PensionSummary().obs;
  var selectedScheme = Scheme().obs;
  // var selectedScheme = SelectedScheme().obs;
  var products = <Map<String, dynamic>>[].obs;

  var loading = LoadingState.completed.obs;

  /// Flag to track if schemes have been fetched at least once
  var _hasFetchedSchemes = false;

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
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        summary.value =
            res.data ?? PensionSummary(totalInvestment: 0, totalPensions: 0);
        // Update products to reflect pension summary data
        if (Get.isRegistered<PPolicyVm>()) {
          Get.find<PPolicyVm>().getProducts();
        }
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
  //       ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
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

  /// Fetches schemes only on first load, subsequent calls are ignored
  /// Use this when navigating to the pension overview page
  Future<void> fetchSchemesOnFirstLoad() async {
    if (_hasFetchedSchemes) return;
    await getMemberSchemes();
  }

  /// Function to get all schemes or retail
  Future<void> getMemberSchemes() async {
    updateLoadingState(LoadingState.loading);
    final result = await pensionService.getMemberSchemes();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        _hasFetchedSchemes = true;
        schemes.value = res.data ?? [];
        activeSchemes.value = schemes
            .where((p) => activeStatuses.contains(p.status ?? ""))
            .toList();
        inactiveSchemes.value = schemes
            .where((p) => !activeStatuses.contains(p.status ?? ""))
            .toList();
      },
    );
  }

  /// Function to get pension certificate
  Future<void> downloadPensionCertificate() async {
    showDownloadLoader(context);
    try {
      final result = await pensionService.downloadPensionCertificate(
        employerNumber: selectedScheme.value.employerNumber ?? '',
        staffNumber: (await PSecureStorage().getBioData())?.staffNumber ?? '',
      );
      result.fold(
        (err) {
          PHelperFunction.pop();
          PPopupDialog(
            context,
          ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
        },
        (res) async {
          if (res.data!['success'] == false) {
            PHelperFunction.pop();
            PPopupDialog(context).errorMessage(
              title: 'error'.tr,
              message: res.data?['message'] ?? 'download_failed'.tr,
            );
            return;
          }
          PHelperFunction.pop();
          PPopupDialog(context).successMessage(
            title: 'success'.tr,
            message: 'download_complete'.tr,
          );
          await Future.delayed(Duration(milliseconds: 1000));
          await PHelperFunction.openFileWithData(
            pdfData: res.data ?? Map<String, dynamic>.from({}),
            name: selectedScheme.value.penTypeDescription ?? '',
          );
        },
      );
    } catch (e) {
      PHelperFunction.pop();
      PPopupDialog(
        context,
      ).errorMessage(title: 'error'.tr, message: 'error_occurred_msg'.tr);
    }
  }

  /// Function to get all selected scheme
  Future<void> getMemberSelectedScheme({required Scheme scheme}) async {
    if (selectedScheme.value != scheme) {
      updateLoadingState(LoadingState.loading);
      final result = await pensionService.getSelectedMemberScheme(
        employerName: scheme.employerName ?? '',
        employerNumber: scheme.employerNumber ?? '',
        memberName: scheme.memberName ?? '',
        memberNumber: scheme.memberNumber ?? '',
        ssnitNumber: scheme.ssnitNumber ?? '',
        masterScheme: scheme.masterSchemeDescription ?? '',
        schemeType: scheme.penTypeDescription ?? '',
        email: scheme.email ?? '',
        dob: scheme.dob ?? '',
        dateJoined: scheme.dateJoined ?? '',
        sex: scheme.sex ?? '',
        nationality: scheme.nationality ?? '',
      );
      result.fold(
        (err) {
          updateLoadingState(LoadingState.error);
          // updateSelectingState(LoadingState.error);
          PPopupDialog(
            context,
          ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
        },
        (res) async {
          selectedScheme(scheme);
          final authRes = await PSecureStorage().getAuthResponse();
          // selectedScheme.value = res.data ?? SelectedScheme();
          final updatedMember = authRes?.copyWith(
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
          PSecureStorage().saveAuthResponse(updatedMember?.toJson() ?? {});
          await Get.put(PContributionHistoryVm()).getContributionsSummary();
          updateLoadingState(LoadingState.completed);
          // await Get.put(
          //   PAuthVm(),
          // ).getBioData(); // get bio data after selecting scheme
        },
      );
    } else {
      await Get.put(PContributionHistoryVm()).getContributionsSummary();
    }
    // get bio data after selecting scheme
    await Get.put(PAuthVm()).getBioData();
  }
}
