import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PContributionHistoryVm extends GetxController {
  static PContributionHistoryVm get instance => Get.find();

  // final List<Map<String, dynamic>> histories = [
  //   {
  //     'title': 'Contribution received',
  //     'amount': 200,
  //     'date': DateTime.now().subtract(Duration(days: 3)).toIso8601String(),
  //     'status': true,
  //   },
  //   {
  //     'title': 'Contribution received',
  //     'amount': 400,
  //     'date': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
  //     'status': true,
  //   },
  //   {
  //     'title': 'Contribution received',
  //     'amount': 300,
  //     'date': DateTime.now().subtract(Duration(days: 8)).toIso8601String(),
  //     'status': false,
  //   },
  //   {
  //     'title': 'Contribution received',
  //     'amount': 500,
  //     'date': DateTime.now().subtract(Duration(days: 10)).toIso8601String(),
  //     'status': true,
  //   },
  // ];

  final yearTEC = TextEditingController();

  var all = false.obs;

  onAllChanged(bool? value) => all.value = value ?? false;

  var summmary = ContributionSummary().obs;
  var history = ContributionHistory().obs;
  var contributionYears = <ContributionYear>[].obs;

  var loading = LoadingState.completed.obs;

  final context = Get.context!;

  final bioData = PSecureStorage().getBioData();

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  @override
  void onInit() {
    super.onInit();
    getContributionsSummary();
  }

  /// Function to get all contribution summary
  Future<void> getContributionsSummary() async {
    updateLoadingState(LoadingState.loading);
    final result = await contributionHistoryService.getContributionSummary();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        summmary.value = res.data ?? ContributionSummary();
        await getAllContributions();
      },
    );
  }

  /// Function to get all contribution years
  Future<void> getContributionsYears() async {
    updateLoadingState(LoadingState.loading);
    final result = await contributionHistoryService.getContributionYears();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        contributionYears.value = res.data ?? [];
      },
    );
  }

  /// Function to get all contributions
  Future<void> getAllContributions() async {
    updateLoadingState(LoadingState.loading);
    final result = await contributionHistoryService.getAllContributions();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        history.value = res.data ?? ContributionHistory();
      },
    );
  }

  /// Function to get all contributions
  Future<void> getContributions() async {
    updateLoadingState(LoadingState.loading);
    final result = await contributionHistoryService.getContributions(
      employerNumber: bioData?.employerNumber ?? '',
      staffNumber: bioData?.memberNo ?? '',
    );
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        history.value = res.data ?? ContributionHistory();
      },
    );
  }

  /// Function to filter all contributions
  Future<void> filterContributions() async {
    updateLoadingState(LoadingState.loading);
    final result = await contributionHistoryService.filterContributions(
      month: '',
      year: '',
    );
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        history.value = res.data ?? ContributionHistory();
      },
    );
  }
}
