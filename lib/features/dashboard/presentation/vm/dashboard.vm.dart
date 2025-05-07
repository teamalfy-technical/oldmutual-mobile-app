import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/dashboard/dashboard.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PDashboardVm extends GetxController {
  static PDashboardVm get instance => Get.find();

  var schemes = <Scheme>[].obs;

  var selectedScheme = SelectedScheme().obs;

  var loading = LoadingState.completed.obs;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  @override
  void onInit() {
    super.onInit();
    getMemberSchemes();
  }

  /// Function to get all schemes
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
    // updateLoadingState(LoadingState.loading);
    final result = await dashboardService.getSelectedMemberScheme(
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
        // updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        // updateLoadingState(LoadingState.completed);
        selectedScheme.value = res.data ?? SelectedScheme();
        final updatedMember = PSecureStorage().getAuthResponse()?.copyWith(
          masterScheme: res.data?.masterScheme ?? '',
          schemeType: res.data?.schemeType ?? '',
          id: res.data?.id ?? 0,
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
        PSecureStorage().saveAuthResponse(updatedMember?.toJson());
        pensionAppLogger.e(PSecureStorage().getAuthResponse()?.toJson());
        await Get.put(PContributionHistoryVm()).getContributionsSummary();
        // await Get.put(PAuthVm()).getBioData();
      },
    );
  }
}
