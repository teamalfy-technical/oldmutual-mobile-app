import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PAffluentVm extends GetxController {
  var affluentStatus = Affluent().obs;
  var loading = LoadingState.completed.obs;

  var benefitReminders = <BenefitReminder>[].obs;
  var exclusiveAnnouncements = <BenefitReminder>[].obs;

  // Content Categories
  var contentCategories = <ContentCategory>[].obs;
  var selectedContentCategory = ContentCategory().obs;
  var contentCategoriesLoading = LoadingState.completed.obs;

  final context = Get.context!;

  bool get isAffluent => affluentStatus.value.isAffluent ?? false;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  updateContentCategoriesLoading(LoadingState loadingState) =>
      contentCategoriesLoading.value = loadingState;

  @override
  void onInit() {
    super.onInit();
    // getAffluentStatus();

    getExclusiveAnnouncements();
    getBenefitReminders();
    // getContentCategories();
  }

  Future<void> getExclusiveAnnouncements() async {
    exclusiveAnnouncements.value = [
      BenefitReminder(
        title: 'New Premium Wellness Program',
        description:
            'Access to exclusive wellness retreats and personalized...',
        createdAt: DateTime.now().subtract(Duration(days: 20)),
      ),

      BenefitReminder(
        title: 'Global Coverage Expansion',
        description:
            'Your coverage now extends to 50+ new international destinations...',
        createdAt: DateTime.now().subtract(Duration(days: 10)),
      ),
    ];
  }

  Future<void> getBenefitReminders() async {
    benefitReminders.value = [
      BenefitReminder(
        title: 'Airport Lounge Access',
        description:
            'You have 12 complimentary lounge visits remaining this year...',
        createdAt: DateTime.now().add(Duration(days: 7)),
      ),

      BenefitReminder(
        title: 'Annual Health Screening',
        description:
            'Your complimentary screening health benefit expires on ${PFormatter.formatDate(dateFormat: DateFormat('MMMM dd, yyyy'), date: DateTime.now().add(Duration(days: 3)))}...',
        createdAt: DateTime.now().add(Duration(days: 3)),
      ),
    ];
  }

  /// Get all content categories
  Future<void> getContentCategories() async {
    updateContentCategoriesLoading(LoadingState.loading);
    final result = await affluentService.getContentCategories();
    result.fold(
      (err) {
        updateContentCategoriesLoading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateContentCategoriesLoading(LoadingState.completed);
        contentCategories.value = res.data ?? [];
      },
    );
  }

  /// Get a single content category by id
  Future<void> getContentCategory({required int id}) async {
    updateContentCategoriesLoading(LoadingState.loading);
    final result = await affluentService.getContentCategory(id: id);
    result.fold(
      (err) {
        updateContentCategoriesLoading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateContentCategoriesLoading(LoadingState.completed);
        selectedContentCategory.value = res.data ?? ContentCategory();
      },
    );
  }

  /// Delete a content category by id
  Future<void> deleteContentCategory({required int id}) async {
    updateContentCategoriesLoading(LoadingState.loading);
    final result = await affluentService.deleteContentCategory(id: id);
    result.fold(
      (err) {
        updateContentCategoriesLoading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateContentCategoriesLoading(LoadingState.completed);
        // Remove the deleted category from the list
        contentCategories.removeWhere((category) => category.id == id);
        PPopupDialog(context).successMessage(
          title: 'success'.tr,
          message: res.message ?? 'Content category deleted successfully',
        );
      },
    );
  }
}
