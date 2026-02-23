import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PAffluentVm extends GetxController {
  static PAffluentVm get instance => Get.find();

  var affluentStatus = Affluent().obs;
  var loading = LoadingState.completed.obs;

  var benefitReminders = <BenefitReminder>[].obs;
  var exclusiveAnnouncements = <BenefitReminder>[].obs;
  var bookmarkedArticles = <Content>[].obs;

  // Content Categories
  var contentCategories = <ContentCategory>[].obs;
  var selectedContentCategory = ContentCategory().obs;
  var contentCategoriesLoading = LoadingState.completed.obs;

  // Contents
  var contents = <Content>[].obs;
  var selectedContent = Content().obs;
  var contentsLoading = LoadingState.completed.obs;
  var bookmarkedContentCount = 0.obs;

  var selectedFCategoryIndex = 0.obs;
  var selectedCCategoryIndex = 0.obs;
  var selectedCCategory = ''.obs;
  var selectedFCategory = ''.obs;

  List<String> get fCategories => [
    'All',
    ...contentCategories.map((c) => c.name ?? ''),
  ];

  final List<String> cCategories = [
    'All',
    'Health & Fitness',
    'Travel',
    'Lifestyle',
    'Entertainment',
  ];

  final List<Map<String, dynamic>> claims = [
    {
      'title': 'Medical Claim',
      'submitDate': 'Ref: CLM-2025-0001142',
      'status': 'Review Ongoing',
      'currentStage': 0,
    },
    {
      'title': 'Policy Update',
      'submitDate': 'Ref: CLM-2025-0001142',
      'status': 'Completed',
      'currentStage': 3,
    },
    {
      'title': 'Document Request',
      'submitDate': 'Ref: CLM-2025-0001142',
      'status': 'Completed',
      'currentStage': 3,
    },
  ];

  final context = Get.context!;

  bool get isAffluent => affluentStatus.value.isAffluent ?? false;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  updateContentCategoriesLoading(LoadingState loadingState) =>
      contentCategoriesLoading.value = loadingState;

  updateContentsLoading(LoadingState loadingState) =>
      contentsLoading.value = loadingState;

  onSelectedFCategory(int index) {
    selectedFCategoryIndex.value = index;
    selectedFCategory.value = fCategories[selectedFCategoryIndex.value];
    // "All" (index 0) fetches without filter, otherwise filter by category name
    if (index == 0) {
      getContents();
    } else {
      getContents(categoryName: selectedFCategory.value);
    }
  }

  onSelectedCCategory(int index) {
    selectedCCategoryIndex.value = index;
    selectedCCategory.value = cCategories[selectedCCategoryIndex.value];
  }

  @override
  void onInit() {
    super.onInit();
    // getAffluentStatus();

    getExclusiveAnnouncements();
    getBenefitReminders();
    getBookmarkedArticles();
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

  Future<void> getBookmarkedArticles() async {
    bookmarkedArticles.value = [
      Content(
        duration: '6 mins',
        title: 'Income Protection Strategies',
        contentType: 'article',
        description:
            'Discover five essential ways to safeguard your income against unexpected events....',
        content: '''Safeguarding Your Income

Your income is your most valuable asset. Protecting it ensures financial stability for you and your family, regardless of life's uncertainties.

Five Essential Strategies
• Disability Insurance: Provides income if you're unable to work due to illness or injury.
• Critical Illness Cover: Lump sum payment upon diagnosis of serious conditions.
• Emergency Fund: Maintain 6-12 months of expenses in liquid savings.
• Multiple Income Streams: Develop passive income sources to reduce dependency on a single income.
• Professional Liability: Protect against claims related to your professional services.

Coverage Adequacy

Review your coverage annually to ensure it keeps pace with income increases and lifestyle changes. Affluent individuals often need higher coverage limits than standard policies offer.

Integration with Financial Plan

Income protection should be part of a comprehensive financial strategy that includes investments, retirement planning, and estate planning.''',
      ),
      Content(
        duration: '6 mins',
        title: 'Tax Planning Strategies for 2026',
        contentType: 'video',
        description:
            'Learn key tax optimization techniques from our financial experts to maximize your...',
        mediaUrl: 'https://www.youtube.com/watch?v=p7HKvqRI_Bo',
        content:
            '''In this video, our senior tax advisors discuss the latest tax planning strategies specifically tailored for high net worth individuals.

Topics Covered:
• New tax law changes for 2026
• Advanced deduction strategies
• Tax-efficient investment vehicles
• Charitable giving optimization
• Estate tax planning updates

Our experts break down complex tax concepts into actionable strategies you can implement immediately to reduce your tax liability while staying fully compliant.''',
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
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: err.message.isNotEmpty
              ? err.message
              : 'Failed to load content categories',
        );
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
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: err.message.isNotEmpty
              ? err.message
              : 'Failed to load content category',
        );
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
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: err.message.isNotEmpty
              ? err.message
              : 'Failed to delete content category',
        );
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

  /// Get all contents
  Future<void> getContents({
    String? title,
    String? categoryName,
    String? slug,
    String? contentType,
  }) async {
    updateContentsLoading(LoadingState.loading);
    final result = await affluentService.getContents(
      title: title,
      categoryName: categoryName,
      slug: slug,
      contentType: contentType,
    );
    result.fold(
      (err) {
        updateContentsLoading(LoadingState.error);
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message:
              err.message.isNotEmpty ? err.message : 'Failed to load contents',
        );
      },
      (res) {
        updateContentsLoading(LoadingState.completed);
        contents.value = res.data ?? [];
      },
    );
  }

  /// Get a single content by id
  Future<void> getContentById({required int id}) async {
    updateContentsLoading(LoadingState.loading);
    final result = await affluentService.getContentById(id: id);
    result.fold(
      (err) {
        updateContentsLoading(LoadingState.error);
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message:
              err.message.isNotEmpty ? err.message : 'Failed to load content',
        );
      },
      (res) {
        updateContentsLoading(LoadingState.completed);
        selectedContent.value = res.data ?? Content();
      },
    );
  }

  /// Get a single content by slug
  Future<void> getContentBySlug({required String slug}) async {
    updateContentsLoading(LoadingState.loading);
    final result = await affluentService.getContentBySlug(slug: slug);
    result.fold(
      (err) {
        updateContentsLoading(LoadingState.error);
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message:
              err.message.isNotEmpty ? err.message : 'Failed to load content',
        );
      },
      (res) {
        updateContentsLoading(LoadingState.completed);
        selectedContent.value = res.data ?? Content();
      },
    );
  }

  /// Get all bookmarked contents (paginated)
  Future<void> fetchBookmarkedContents() async {
    updateContentsLoading(LoadingState.loading);
    final result = await affluentService.getBookmarkedContents();
    result.fold(
      (err) {
        updateContentsLoading(LoadingState.error);
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: err.message.isNotEmpty
              ? err.message
              : 'Failed to load bookmarked contents',
        );
      },
      (res) {
        updateContentsLoading(LoadingState.completed);
        contents.value = res.data ?? [];
      },
    );
  }

  /// Bookmark a content by id
  Future<void> bookmarkContent({required int id}) async {
    final result = await affluentService.bookmarkContent(id: id);
    result.fold(
      (err) {
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: err.message.isNotEmpty
              ? err.message
              : 'Failed to bookmark content',
        );
      },
      (res) {
        PPopupDialog(context).successMessage(
          title: 'success'.tr,
          message: res.message ?? 'Content bookmarked successfully',
        );
      },
    );
  }

  /// Get a single bookmarked content by id
  Future<void> getBookmarkedContent({required int id}) async {
    updateContentsLoading(LoadingState.loading);
    final result = await affluentService.getBookmarkedContent(id: id);
    result.fold(
      (err) {
        updateContentsLoading(LoadingState.error);
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: err.message.isNotEmpty
              ? err.message
              : 'Failed to load bookmarked content',
        );
      },
      (res) {
        updateContentsLoading(LoadingState.completed);
        selectedContent.value = res.data ?? Content();
      },
    );
  }

  /// Get bookmarked content count
  Future<void> fetchBookmarkedContentCount() async {
    final result = await affluentService.getBookmarkedContentCount();
    result.fold(
      (err) {
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: err.message.isNotEmpty
              ? err.message
              : 'Failed to load bookmark count',
        );
      },
      (res) {
        bookmarkedContentCount.value = res.data ?? 0;
      },
    );
  }
}
