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
    required String employerNumber,
    required String memberNumber,
    required String ssnitNumber,
    required String masterScheme,
  }) async {
    // updateLoadingState(LoadingState.loading);
    final result = await dashboardService.getSelectedMemberScheme(
      employerNumber: employerNumber,
      memberNumber: memberNumber,
      ssnitNumber: ssnitNumber,
      masterScheme: masterScheme,
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

        await Get.put(PContributionHistoryVm()).getContributionsSummary();
      },
    );
  }
}
