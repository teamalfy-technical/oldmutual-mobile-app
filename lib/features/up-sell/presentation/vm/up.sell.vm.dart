import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/up-sell/domain/up.sell.model.dart';
import 'package:oldmutual_pensions_app/features/up-sell/up.sell.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PUpsellVm extends GetxController {
  static PUpsellVm get instance => Get.find();

  final context = Get.context!;

  var recommendations = <Upsell>[].obs;

  var loading = LoadingState.completed.obs;
  var submitting = LoadingState.completed.obs;

  @override
  void onInit() {
    getRecommendations();
    super.onInit();
  }

  /// [Function] get all recommendations
  Future<void> getRecommendations() async {
    loading(LoadingState.loading);
    final result = await upsellService.getUpsellRecommendations();
    result.fold(
      (err) {
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        recommendations.value = res.data ?? [];
      },
    );
  }

  /// [Function] upgrade a recommendation
  Future<void> upgradeRecommendation({required int id}) async {
    submitting(LoadingState.loading);
    final result = await upsellService.upgradeRecommendation(id: id);
    result.fold(
      (err) {
        submitting(LoadingState.error);
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        submitting(LoadingState.completed);
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'congratulations'.tr, message: res.message ?? '');
      },
    );
  }

  /// [Function] dismiss a recommendation
  Future<void> dismissRecommendation({required int id}) async {
    submitting(LoadingState.loading);
    final result = await upsellService.dismissRecommendation(id: id);
    result.fold(
      (err) {
        submitting(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        submitting(LoadingState.completed);

        // recommendations.clear();

        await getRecommendations();

        PPopupDialog(
          context,
        ).errorMessage(title: 'success'.tr, message: res.message ?? '');
      },
    );
  }
}
