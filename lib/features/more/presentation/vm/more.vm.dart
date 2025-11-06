import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PMoreVM extends GetxController {
  static PMoreVM instance = Get.find();

  final context = Get.context!;

  var loading = LoadingState.completed.obs;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;
}
