import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PFactsheetVm extends GetxController {
  static PFactsheetVm get instance => Get.find();

  var loading = LoadingState.completed.obs;
  var generating = LoadingState.completed.obs;

  var performances = <PerformanceModel>[].obs;
  var compositions = <FundCompositionModel>[].obs;

  var bestPerformingYear = ''.obs;
  var averageGrowth = ''.obs;
  var yearToDateReturn = ''.obs;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;
  updateGeneratingState(LoadingState loadingState) =>
      generating.value = loadingState;

  @override
  onInit() {
    if (performances.isEmpty && compositions.isEmpty) {
      getPerformances();
    }
    super.onInit();
  }

  /// Function that fetches all performance data
  Future<void> getPerformances() async {
    updateLoadingState(LoadingState.loading);
    final result = await factsheetService.getPerformances();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        updateLoadingState(LoadingState.completed);
        performances.value = res.data ?? [];
        await getFundComposition();
      },
    );
  }

  /// Function that fetches all funds composition
  Future<void> getFundComposition() async {
    updateLoadingState(LoadingState.loading);
    final result = await factsheetService.getFundComposition();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        compositions.value = res.data ?? [];
        // summarizePerformance();
      },
    );
  }

  void summarizePerformance() {
    final data = performances;
    // Sort by year descending
    data.sort((a, b) => (b.year ?? 2022).compareTo(a.year ?? 2020));

    // Convert to numeric list
    final yPerformances = data.map((e) {
      return {
        "year": e.year,
        "performance": double.tryParse(e.performance ?? "0") ?? 0.0,
        "created_at": e.createdAt,
      };
    }).toList();

    // Find best performing year
    yPerformances.sort(
      (a, b) =>
          (b["performance"] as double).compareTo(a["performance"] as double),
    );
    final best = yPerformances.first;

    // Calculate average annual growth
    final avgGrowth =
        yPerformances
            .map((e) => e["performance"] as double)
            .reduce((a, b) => a + b) /
        yPerformances.length;

    // Simulate Year-to-Date return (assuming partial year progress)
    final ytdReturn =
        (best["performance"] as double) * 0.5; // e.g. mid-year est.

    // Format final values
    bestPerformingYear.value =
        '${DateFormat('MMMM').format(DateTime.parse(best["created_at"].toString()))} (+${best["performance"]}%)';
    averageGrowth.value = PFormatter.formatCurrency(amount: avgGrowth);
    yearToDateReturn.value = '+${ytdReturn.toStringAsFixed(1)}%';
    // print("Best performing year: ${best["year"]} (+${best["performance"]}%)");
    // print("Avg. Annual Growth: GHS${avgGrowth.toStringAsFixed(2)}");
    // print("Year-to-Date Return: +${ytdReturn.toStringAsFixed(1)}%");
  }

  /// Function to get all generated reports
  Future<void> generateFactsheet() async {
    updateGeneratingState(LoadingState.loading);
    final result = await factsheetService.downloadFactsheet();
    result.fold(
      (err) {
        updateGeneratingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        updateGeneratingState(LoadingState.completed);
        await openFile(
          url: res.data?.downloadLink ?? '',
          fileName: 'Factsheet_${res.data?.year ?? ''}_doc.pdf',
        );
      },
    );
  }

  Future<void> openFile({required String url, required String fileName}) async {
    final file = await downloadFile(url, fileName);
    if (file == null) return;
    OpenFile.open(file.path);
  }

  // Download file into private folder not visible to user
  Future<File?> downloadFile(String url, String fileName) async {
    final appStorage = await getApplicationDocumentsDirectory();
    // final appStorage =
    //     Platform.isAndroid
    //         ? await getExternalStorageDirectory()
    //         : await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/$fileName");
    final authResponse = await PSecureStorage().getAuthResponse();
    String? token = authResponse?.token;
    String secureUrl = url.replaceFirst('http://', 'https://');
    pensionAppLogger.e(url);

    try {
      final response = await Dio().get(
        secureUrl,
        options: Options(
          responseType: ResponseType.bytes,
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
      pensionAppLogger.e(err.toString());
      return null;
    }
  }
}
