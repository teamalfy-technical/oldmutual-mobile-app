import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/shared/widgets/popup.dialog.dart';

class PBeneficiaryVm extends GetxController {
  static PBeneficiaryVm get instance => Get.find();

  var beneficiaries = <Beneficiary>[].obs;

  var loading = LoadingState.completed.obs;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  @override
  void onInit() {
    super.onInit();
    getBeneficiaries();
  }

  /// Function to get all beneficiaries
  Future<void> getBeneficiaries() async {
    updateLoadingState(LoadingState.loading);
    final result = await beneficiaryService.getBeneficiaries();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        beneficiaries.value = res.data ?? [];
      },
    );
  }
}
