import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/application/services/cross.sell.service.impl.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

/// ViewModel for managing cross-sell product recommendations
class PCrossSellVm extends GetxController {
  static PCrossSellVm get instance => Get.find();

  /// Observable list of recommendation items with title, subtitle, and image
  var recommendations = <Map<String, dynamic>>[].obs;

  /// Loading state to track fetch and apply operations
  var loading = LoadingState.completed.obs;

  final context = Get.context!;

  /// Update the current loading state
  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  @override
  void onInit() {
    fetchRecommendations();
    super.onInit();
  }

  /// Fetch recommendations from the API and map them to detailed objects
  /// This retrieves a list of recommendation strings from the backend and
  /// transforms them into full objects with titles, subtitles, and images
  Future<void> fetchRecommendations() async {
    updateLoadingState(LoadingState.loading);
    final result = await crossSellService.getRecommendations();
    result.fold(
      (err) {
        // Handle error case - show error dialog
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        // Handle success case - map API response strings to detailed recommendation objects
        updateLoadingState(LoadingState.completed);
        // recommendations.value = ['Digital Funeral', 'Educator Plan']
        //     .map((recommendation) => getRecommendationTitle(recommendation))
        //     .toList();
        recommendations.value =
            res.data
                ?.map(
                  (recommendation) => getRecommendationTitle(recommendation),
                )
                .toList() ??
            [];
      },
    );
  }

  /// Apply for a specific recommendation product
  /// [recommendation] - The name/title of the product to apply for
  Future<void> applyRecommendations(String recommendation) async {
    updateLoadingState(LoadingState.loading);
    final result = await crossSellService.applyForRecommendation(
      recommendation: recommendation,
    );
    result.fold(
      (err) {
        // Handle error case - show error dialog
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        // Handle success case - TODO: navigate to success view
        updateLoadingState(LoadingState.completed);
        // navigate to success view
      },
    );
  }

  /// Map recommendation title to full details (title, subtitle, image)
  /// Returns a map containing localized title, description, and asset path
  /// [recommendation] - The product name from the API
  Map<String, dynamic> getRecommendationTitle(String recommendation) {
    switch (recommendation) {
      // Education savings plan for children
      case 'Educator Plan':
        return {
          'title': 'educator_plan'.tr,
          'subTitle': 'An insurance policy structured to enable parents...',
          'image': Assets.images.educatorPlanImg.path,
        };
      // Funeral cost coverage plan
      case 'Cover funeral costs':
        return {
          'title': 'Cover funeral costs.',
          'subTitle': 'Give your loved ones a proper send-off without ...',
          'image': Assets.images.transitionPlusImg.path,
        };
      // Investment and savings plan
      case 'Special Investment Plan':
        return {
          'title': 'special_investments_plan'.tr,
          'subTitle':
              'Become self-sufficient and have more control over your life...',
          'image': Assets.images.specialInvestmentImg.path,
        };
      // Accident coverage insurance
      case 'Personal Accident':
        return {
          'title': 'personal_accident'.tr,
          'subTitle':
              'Once an accident has happened, it cannot be reversed, but its impact can be lessened.',
          'image': Assets.images.personalAccidentImg.path,
        };
      // Digital funeral services plan (Ekyire Asem)
      case 'Digital Funeral':
        return {
          'title': 'ekyire_asem'.tr,
          'subTitle':
              'An affordable funeral policy that provides all the necessary logistical services for a one-week funeral celebration, along with a cash benefit to cover additional expenses...',
          'image': Assets.images.ekyireAsemImg.path,
        };

      // Fallback for unknown recommendation types
      default:
        return {
          'title': recommendation,
          'subTitle': 'An insurance policy structured to enable parents...',
          'image': Assets.images.educatorPlanImg.path,
        };
    }
  }

  // List<Map<String, dynamic>> recommendations = [
  //   {
  //     'title': 'educator_plan'.tr,
  //     'subTitle': 'An insurance policy structured to enable parents...',
  //     'image': Assets.images.educatorPlanImg.path,
  //   },
  //   {
  //     'title': 'Cover funeral costs.',
  //     'subTitle': 'Give your loved ones a proper send-off without ...',
  //     'image': Assets.images.transitionPlusImg.path,
  //   },
  //   {
  //     'title': 'special_investments_plan'.tr,
  //     'subTitle':
  //         'Become self-sufficient and have more control over your life...',
  //     'image': Assets.images.specialInvestmentImg.path,
  //   },
  //   {
  //     'title': 'personal_accident'.tr,
  //     'subTitle':
  //         'Once an accident has happened, it cannot be reversed, but its impact can be lessened.',
  //     'image': Assets.images.personalAccidentImg.path,
  //   },
  //   {
  //     'title': 'ekyire_asem'.tr,
  //     'subTitle':
  //         'An affordable funeral policy that provides all the necessary logistical services for a one-week funeral celebration, along with a cash benefit to cover additional expenses...',
  //     'image': Assets.images.ekyireAsemImg.path,
  //   },
  // ];
}
