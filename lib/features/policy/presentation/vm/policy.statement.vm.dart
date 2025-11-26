import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPolicyStatementVm extends GetxController {
  static PPolicyStatementVm get instance => Get.find();

  var contributionYears = <ContributedYear>[].obs;

  ContributedYear? selectedYear;
  Policy? selectedPolicy;

  var loading = LoadingState.completed.obs;
  var generating = LoadingState.completed.obs;

  final context = Get.context!;

  final bioData = PSecureStorage().getBioData();

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;
  updateGeneratingState(LoadingState loadingState) =>
      generating.value = loadingState;

  // Reports variables
  var generatedReport = GenerateReport().obs;
  var reportDownload = ReportDownload().obs;
  var statements = <PolicyReport>[].obs;

  onYearChanged(value) {
    selectedYear = value;
    generatedReport.value = GenerateReport();
    print(selectedYear?.fundYear);
    update();
  }

  onSelectedPolicyReport(Policy? value) {
    selectedPolicy = value;
    update();
  }

  @override
  void onInit() {
    getContributedYears();
    getAllGeneratedReports();
    super.onInit();
  }

  /// Function to get all generated reports
  Future<void> getAllGeneratedReports() async {
    updateLoadingState(LoadingState.loading);
    final result = await policyService.getPolicyReports();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        // if(res.data)
        res.data?.sort((a, b) => b.createdAt!.compareTo(a.createdAt ?? ''));
        statements.value = res.data ?? [];
        // pensionAppLogger.i('DownloadUrl: ${statements.first.downloadUrl}');
      },
    );
  }

  /// Function to get all contribution years
  Future<void> getContributedYears() async {
    //updateLoadingState(LoadingState.loading);
    final result = await contributionHistoryService.getContributionYears();
    result.fold(
      (err) {
        // updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        // updateLoadingState(LoadingState.completed);

        res.data?.insert(0, defaultContributionYear);
        res.data?.sort((a, b) => b.fundYear!.compareTo(a.fundYear ?? ''));

        selectedYear = res.data?.first;
        contributionYears.value = res.data ?? [];
        update();
      },
    );
  }

  /// Function to download policy investment statement
  Future<void> downloadInvestmentStatement() async {
    showDownloadLoader(context);
    final result = await policyService.downloadInvestmentStatement(
      policyNumber: selectedPolicy?.policyNo ?? '',
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: 'error_occurred_msg'.tr);
      },
      (res) async {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).successMessage(title: 'success'.tr, message: 'download_complete'.tr);
        await Future.delayed(Duration(milliseconds: 1000));
        // pensionAppLogger.e(res.data);
        await PHelperFunction.openFileWithData(
          pdfData: res.data ?? Map<String, dynamic>.from({}),
          name: selectedPolicy?.planDescription ?? '',
        );
      },
    );
  }

  /// Function to download policy premium statement
  Future<void> downloadPremiumStatement() async {
    showDownloadLoader(context);
    final result = await policyService.downloadPremiumStatement(
      policyNumber: selectedPolicy?.policyNo ?? '',
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: 'error_occurred_msg'.tr);
      },
      (res) async {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).successMessage(title: 'success'.tr, message: 'download_complete'.tr);
        pensionAppLogger.e(res.data);
        await PHelperFunction.openFileWithData(
          pdfData: res.data ?? Map<String, dynamic>.from({}),
          name: selectedPolicy?.planDescription ?? '',
        );
      },
    );
  }

  /// Function to download policy document / statement
  Future<void> downloadPolicyStatement() async {
    showDownloadLoader(context);
    final result = await policyService.downloadPolicyStatement(
      policyNumber: selectedPolicy?.policyNo ?? '',
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: 'error_occurred_msg'.tr);
      },
      (res) async {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).successMessage(title: 'success'.tr, message: 'download_complete'.tr);
        pensionAppLogger.e(res.data);
        // await PHelperFunction.openFileWithData(
        //   pdfData: res.data ?? Map<String, dynamic>.from({}),
        //   name: selectedPolicy?.planDescription ?? '',
        // );
        await PHelperFunction.openFileWithURl(
          url: res.data?['url'] ?? '',
          fileName: selectedPolicy?.planDescription ?? '',
        );
      },
    );
  }

  ContributedYear get defaultContributionYear => ContributedYear(
    fundYear: 'all'.tr,
    employeeContribution: 0.0,
    totalContribution: 0.0,
  );

  /// Function to generate policy report
  Future<void> generatePremiumStatement() async {
    if (selectedPolicy == null) {
      PPopupDialog(context).informationMessage(
        title: 'action_required'.tr,
        message: 'Select a policy to proceed',
      );
      return;
    }

    updateGeneratingState(LoadingState.loading);
    final result = await policyService.generatePolicyReports(
      policyNumber: selectedPolicy?.policyNo ?? '',
      year: selectedYear?.fundYear == 'all'.tr
          ? DateTime.now().year
          : int.parse(selectedYear?.fundYear ?? DateTime.now().year.toString()),
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
        ).successMessage(title: 'success'.tr, message: res.message ?? '');
        // statements.insert(0, res.data ?? Statement());
        navigateToSuccessPage();
        Future.delayed(Duration(seconds: 6), () => getAllGeneratedReports());
      },
    );
  }

  /// Function to navigate user to success screen after report has been generated
  navigateToSuccessPage() {
    PHelperFunction.switchScreen(
      destination: Routes.settingsSuccessPage,
      args: [
        'policy_statement_generated_msg'.tr,
        'success'.tr,
        'view_statement'.tr,
        () {
          PHelperFunction.pop();
        },
      ],
    );
  }
}
