import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PFactsheetVm extends GetxController {
  static PFactsheetVm get instance => Get.find();

  var loading = LoadingState.completed.obs;

  var performances = <PerformanceModel>[].obs;
  var compositions = <FundCompositionModel>[].obs;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  @override
  onInit() {
    if (performances.isEmpty && compositions.isEmpty) {
      getPerformances();
    }
    super.onInit();
  }

  /// Function that fetches all performance data
  Future<void> getPerformances() async {
    updateLoadingState(LoadingState.loading);
    final result = await factsheetService.getPerformances();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        performances.value = res.data ?? [];
        await getFundComposition();
      },
    );
  }

  /// Function that fetches all funds composition
  Future<void> getFundComposition() async {
    updateLoadingState(LoadingState.loading);
    final result = await factsheetService.getFundComposition();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        compositions.value = res.data ?? [];
      },
    );
  }
}
