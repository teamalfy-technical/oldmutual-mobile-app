import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';

abstract class ContributionHistoryService {
  Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  getAllContributions();

  Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  filterContributions({required String month, required String year});
  Future<Either<PFailure, ApiResponse<ContributionSummary>>>
  getContributionSummary();
  Future<Either<PFailure, ApiResponse<List<ContributedYear>>>>
  getContributionYears();

  Future<Either<PFailure, ApiResponse<List<Contribution>>>>
  getMonthlyContributions();
  Future<Either<PFailure, ApiResponse<Contribution>>> getLatestContribution();
}
