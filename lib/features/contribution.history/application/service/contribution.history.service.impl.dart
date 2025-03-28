import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';

final ContributionHistoryService contributionHistoryService = Get.put(
  ContributionHistoryServiceImpl(),
);

class ContributionHistoryServiceImpl implements ContributionHistoryService {
  @override
  Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  filterContributions({required String month, required String year}) {
    return contributionHistoryRepo.filterContributions(
      month: month,
      year: year,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  getAllContributions() {
    return contributionHistoryRepo.getAllContributions();
  }

  @override
  Future<Either<PFailure, ApiResponse<ContributionSummary>>>
  getContributionSummary() {
    return contributionHistoryRepo.getContributionSummary();
  }

  @override
  Future<Either<PFailure, ApiResponse<List<ContributedYear>>>>
  getContributionYears() {
    return contributionHistoryRepo.getContributionYears();
  }

  @override
  Future<Either<PFailure, ApiResponse<ContributionHistory>>> getContributions({
    required String employerNumber,
    required String staffNumber,
  }) async {
    return contributionHistoryRepo.getContributions(
      employerNumber: employerNumber,
      staffNumber: staffNumber,
    );
  }
}
