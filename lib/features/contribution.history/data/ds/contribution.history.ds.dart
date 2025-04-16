import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';

abstract class ContributionHistoryDs {
  Future<ApiResponse<ContributionHistory>> getAllContributions();

  Future<ApiResponse<ContributionHistory>> filterContributions({
    required String month,
    required String year,
  });
  Future<ApiResponse<ContributionSummary>> getContributionSummary();
  Future<ApiResponse<List<ContributedYear>>> getContributionYears();

  Future<GenerateReport> generateReport({required int year});
  Future<ApiResponse<Message>> getReport({required int reportId});
  Future<ReportStatus> checkReportStatus({required int reportId});
}
