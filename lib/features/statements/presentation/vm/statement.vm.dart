import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PStatementVm extends GetxController {
  static PStatementVm get instance => Get.find();

  var all = false.obs;

  onAllChanged(bool? value) => all.value = value ?? false;

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
  }

  @override
  onClose() {
    resetFilters();
    super.onClose();
  }

  /// Function to generate report
  Future<void> generateReport() async {
    updateGeneratingState(LoadingState.loading);
    final result = await statementRepo.generateReport(
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
    final result = await statementRepo.getReport(
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
    final result = await statementRepo.checkReportStatus(
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
