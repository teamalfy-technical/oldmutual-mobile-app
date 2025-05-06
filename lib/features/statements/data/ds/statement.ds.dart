import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';

abstract class StatementDs {
  Future<GenerateReport> generateReport({required int year, required bool all});
  Future<ApiResponse<ReportDownload>> downloadReport({required int reportId});
  Future<ApiResponse<List<Statement>>> getReports();
  Future<ReportStatus> checkReportStatus({required int reportId});
}
