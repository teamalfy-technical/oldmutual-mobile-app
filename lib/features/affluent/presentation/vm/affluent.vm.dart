import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PAffluentVm extends GetxController {
  var affluentStatus = Affluent().obs;
  var loading = LoadingState.completed.obs;

  final context = Get.context!;

  bool get isAffluent => affluentStatus.value.isAffluent ?? false;

  updateLoadingState(LoadingState loadingState) =>
      loading.value = loadingState;

  @override
  void onInit() {
    super.onInit();
    getAffluentStatus();
  }

  Future<void> getAffluentStatus() async {
    updateLoadingState(LoadingState.loading);
    final result = await affluentService.getAffluentStatus();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        affluentStatus.value = res.data ?? Affluent();
      },
    );
  }
}
