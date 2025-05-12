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

  Future<ApiResponse<List<Contribution>>> getMonthlyContributions();
  Future<ApiResponse<Contribution>> getLatestContribution();
}
