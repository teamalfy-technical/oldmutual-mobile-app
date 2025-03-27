import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';

abstract class ContributionHistoryRepo {
  Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  getAllContributions();
  Future<Either<PFailure, ApiResponse<ContributionHistory>>> getContributions({
    required String employerNumber,
    required String staffNumber,
  });
  Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  filterContributions({required String month, required String year});
  Future<Either<PFailure, ApiResponse<ContributionSummary>>>
  getContributionSummary();
  Future<Either<PFailure, ApiResponse<List<ContributionYear>>>>
  getContributionYears();
}
