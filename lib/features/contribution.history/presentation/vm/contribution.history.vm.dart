import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PContributionHistoryVm extends GetxController {
  static PContributionHistoryVm get instance => Get.find();

  var all = false.obs;

  onAllChanged(bool? value) => all.value = value ?? false;

  var summmary = ContributionSummary().obs;
  var history = ContributionHistory().obs;
  var contributionYears = <ContributedYear>[].obs;
  var contributionMonths =
      [
        'none'.tr,
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
      ].obs;
  ContributedYear? selectedYear;
  String? selectedMonth;

  var loading = LoadingState.completed.obs;
  var generating = LoadingState.completed.obs;

  final context = Get.context!;

  final bioData = PSecureStorage().getBioData();

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;
  updateGeneratingState(LoadingState loadingState) =>
      generating.value = loadingState;

  // Reports variables
  var generatedReport = GenerateReport().obs;
  var reportStatus = ReportStatus().obs;

  onYearChanged(value) {
    selectedYear = value;
    update();
  }

  onMonthChanged(value) {
    selectedMonth = value;
    update();
  }

  /// Function to get all contribution summary
  Future<void> getContributionsSummary() async {
    if (summmary.value.isEmpty) {
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
        },
      );
    }
    await getAllContributions();
  }

  /// Function to get all contribution years
  Future<void> getContributedYears() async {
    //updateLoadingState(LoadingState.loading);
    final result = await contributionHistoryService.getContributionYears();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        // updateLoadingState(LoadingState.completed);

        res.data?.insert(
          0,
          ContributedYear(
            fundYear: 'none'.tr,
            employeeContribution: 0.0,
            totalContribution: 0.0,
          ),
        );

        selectedYear = res.data?.first;
        selectedMonth = contributionMonths.first;
        contributionYears.value = res.data ?? [];
      },
    );
  }

  resetFilters() {
    selectedMonth = contributionMonths.first;
    selectedYear = contributionYears.first;
    getAllContributions();
  }

  @override
  void onInit() {
    if (summmary.value.isEmpty) {
      updateLoadingState(LoadingState.loading);
    }
    super.onInit();
  }

  @override
  onClose() {
    summmary.value = ContributionSummary();
    history.value = ContributionHistory();
    resetFilters();
    super.onClose();
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
      (res) async {
        updateLoadingState(LoadingState.completed);

        history.value = res.data ?? ContributionHistory();
        await getContributedYears();
      },
    );
  }

  /// Function to filter all contributions
  Future<void> filterContributions() async {
    if (selectedMonth == null || selectedYear == null) {
      PPopupDialog(context).informationMessage(
        title: 'action_required'.tr,
        message: 'Choose year and month to filter',
      );
      return;
    }
    updateLoadingState(LoadingState.loading);
    final result = await contributionHistoryService.filterContributions(
      year: selectedYear?.fundYear.toString() ?? DateTime.now().year.toString(),
      month: selectedMonth ?? DateTime.now().month.toString(),
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

  /// Function to generate report
  Future<void> generateReport() async {
    updateGeneratingState(LoadingState.loading);
    final result = await contributionHistoryService.generateReport(
      year: int.parse(selectedYear?.fundYear ?? DateTime.now().year.toString()),
    );
    result.fold(
      (err) {
        updateGeneratingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateGeneratingState(LoadingState.completed);
        generatedReport.value = res;
      },
    );
  }

  /// Function to get report status
  Future<void> getReportStatus() async {
    updateGeneratingState(LoadingState.loading);
    final result = await contributionHistoryService.getReport(
      reportId: generatedReport.value.message?.reportId ?? 0,
    );
    result.fold(
      (err) {
        updateGeneratingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateGeneratingState(LoadingState.completed);
        PPopupDialog(
          context,
        ).errorMessage(title: 'success'.tr, message: res.message ?? '');
        // reportStatus.value = res;
      },
    );
  }

  /// Function to check report status
  Future<void> checkReportStatus() async {
    updateGeneratingState(LoadingState.loading);
    final result = await contributionHistoryService.checkReportStatus(
      reportId: generatedReport.value.message?.reportId ?? 0,
    );
    result.fold(
      (err) {
        updateGeneratingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateGeneratingState(LoadingState.completed);
        reportStatus.value = res;
        PPopupDialog(context).errorMessage(
          title: res.status ?? '',
          message: 'report_downloaded_msg'.trParams({
            'year': selectedYear?.fundYear ?? '',
          }),
        );
      },
    );
  }
}
