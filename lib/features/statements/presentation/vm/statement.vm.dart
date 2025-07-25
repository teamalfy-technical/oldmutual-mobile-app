import 'dart:io';
import 'dart:math';

// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PStatementVm extends GetxController {
  static PStatementVm get instance => Get.find();

  var all = false.obs;

  onAllChanged(bool? value) => all.value = value ?? false;

  var contributionYears = <ContributedYear>[].obs;

  ContributedYear? selectedYear;

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
  var statements = <Statement>[].obs;

  onYearChanged(value) {
    selectedYear = value;
    generatedReport.value = GenerateReport();
    update();
  }

  @override
  void onInit() {
    getAllGeneratedReports();
    super.onInit();
  }

  /// Function to get all generated reports
  Future<void> getAllGeneratedReports() async {
    updateLoadingState(LoadingState.loading);
    final result = await statementService.getReports();
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
        pensionAppLogger.i('DownloadUrl: ${statements.first.downloadUrl}');
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

  resetFilters() {
    selectedYear =
        contributionYears.isEmpty
            ? defaultContributionYear
            : contributionYears.first;
  }

  ContributedYear get defaultContributionYear => ContributedYear(
    fundYear: 'none'.tr,
    employeeContribution: 0.0,
    totalContribution: 0.0,
  );

  @override
  onClose() {
    resetFilters();
    super.onClose();
  }

  /// Function to generate report (V2)
  Future<void> generateReportV2() async {
    if (all.value == false) {
      if (selectedYear == null || selectedYear?.fundYear == 'none'.tr) {
        PPopupDialog(context).informationMessage(
          title: 'action_required'.tr,
          message: 'Select a year to proceed',
        );
        return;
      }
    }
    updateGeneratingState(LoadingState.loading);
    final result = await statementService.generateReportV2(
      all: all.value,
      year:
          selectedYear?.fundYear == 'none'.tr
              ? DateTime.now().year
              : int.parse(
                selectedYear?.fundYear ?? DateTime.now().year.toString(),
              ),
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
        Future.delayed(Duration(seconds: 6), () => getAllGeneratedReports());
      },
    );
  }

  /// Function to generate report
  Future<void> generateReport() async {
    if (all.value == false) {
      if (selectedYear == null || selectedYear?.fundYear == 'none'.tr) {
        PPopupDialog(context).informationMessage(
          title: 'action_required'.tr,
          message: 'Select a year to proceed',
        );
        return;
      }
    }
    updateGeneratingState(LoadingState.loading);
    final result = await statementService.generateReport(
      all: all.value,
      year:
          selectedYear?.fundYear == 'none'.tr
              ? DateTime.now().year
              : int.parse(
                selectedYear?.fundYear ?? DateTime.now().year.toString(),
              ),
    );
    result.fold(
      (err) {
        updateGeneratingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        // updateGeneratingState(LoadingState.completed);
        // PPopupDialog(
        //   context,
        // ).successMessage(title: 'success'.tr, message: res.data ?? '');
        generatedReport.value = res;
        Future.delayed(Duration(seconds: 6), () {
          downloadGeneratedReport(res);
        });
      },
    );
  }

  /// Function to get report status
  Future<void> downloadGeneratedReport(GenerateReport report) async {
    updateGeneratingState(LoadingState.loading);
    final result = await statementService.downloadReport(
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
        // PPopupDialog(
        //   context,
        // ).successMessage(title: 'success'.tr, message: res.message ?? '');
        final base = ReportDownload.fromJson(res.data!.toJson());

        final updatedReport = base.copyWith(
          period: all.value ? 'All' : selectedYear?.fundYear ?? '',
          createdAt: DateTime.now().toIso8601String(),
        );
        final statement = Statement(
          id: Random().nextInt(1000),
          userId: Random().nextInt(10000),
          filters: Filters(year: updatedReport.period ?? ''),
          downloadUrl: updatedReport.downloadUrl,
          createdAt: updatedReport.createdAt,
          updatedAt: updatedReport.createdAt,
        );
        statements.insert(0, statement);
        pensionAppLogger.e(statements.map((e) => e.toJson()).toList());
        // PPopupDialog(
        //   context,
        // ).successMessage(title: 'success'.tr, message: report.data ?? '');
        // openFile(
        //   url: res.data?.downloadUrl ?? '',
        //   // "https://example.com/sample.pdf",
        //   fileName: "contributions_report_3_1746207518.pdf",
        //   // fileName: "intro98.pdf",
        // );
        // reportStatus.value = res;
      },
    );
  }

  /// Function to check report status
  Future<void> checkReportStatus() async {
    // updateGeneratingState(LoadingState.loading);
    final result = await statementService.checkReportStatus(
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
        // reportStatus.value = res;
        // reportStatus.value.copyWith(period: selectedYear?.fundYear ?? '');
        // reports.add(reportStatus.value);
        PPopupDialog(context).successMessage(
          title: res.status ?? '',
          message: 'report_downloaded_msg'.trParams({
            'year': selectedYear?.fundYear ?? '',
          }),
        );
      },
    );
  }

  openFile({required String url, required String fileName}) async {
    pensionAppLogger.e(url);
    final file = await downloadFile(url, fileName);
    if (file == null) return;
    OpenFile.open(file.path);
  }

  // Download file into private folder not visible to user
  Future<File?> downloadFile(String url, String fileName) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/$fileName");
    String? token = PSecureStorage().getAuthResponse()?.token;
    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          // headers: PHelperFunction.appTokenHeader(),
          followRedirects: false,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/pdf",
          },
        ),
      );

      pensionAppLogger.e(
        "Response content-type: ${response.headers['content-type']}",
      );
      pensionAppLogger.e("Response status: ${response.statusCode}");

      // Decode bytes to string (just to check what's inside)
      pensionAppLogger.e(String.fromCharCodes(response.data!));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (err) {
      // if (err is DioException) {
      //   if (err.response?.statusCode == 404) {
      //     // PPopupDialog(context).errorMessage(
      //     //   title: 'error'.tr,
      //     //   message: err.response?.data['message'],
      //     // );
      //     pensionAppLogger.i(err.response?.data);
      //   }
      // }
      pensionAppLogger.e("Error: $err");
      return null;
    }
  }

  /// Function to download report file
  // Future<void> downloadFile(String url) async {
  //   Directory? directory;

  //   if (Platform.isAndroid) {
  //     directory =
  //         await getExternalStorageDirectory(); // e.g. /storage/emulated/0/Android/data/<package>/files
  //   } else if (Platform.isIOS) {
  //     directory =
  //         await getApplicationDocumentsDirectory(); // e.g. /var/mobile/Containers/Data/Application/<uuid>/Documents
  //   }

  //   final saveDir = directory?.path;

  //   if (saveDir != null) {
  //     final taskId = await FlutterDownloader.enqueue(
  //       url: url,
  //       headers: {}, // optional headers
  //       savedDir: saveDir,
  //       showNotification:
  //           true, // show download progress in status bar (for Android)
  //       openFileFromNotification:
  //           true, // click on notification to open downloaded file (for Android)
  //     );
  //   }
  // }
}
