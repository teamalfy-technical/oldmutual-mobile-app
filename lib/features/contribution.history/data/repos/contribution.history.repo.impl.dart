import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';

final ContributionHistoryRepo contributionHistoryRepo = Get.put(
  ContributionHistoryRepoImpl(),
);

class ContributionHistoryRepoImpl implements ContributionHistoryRepo {
  @override
  Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  filterContributions({required String month, required String year}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await contributionHistoryDs.filterContributions(
            month: month,
            year: year,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  getAllContributions() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await contributionHistoryDs.getAllContributions(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<ContributionSummary>>>
  getContributionSummary() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await contributionHistoryDs.getContributionSummary(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<ContributedYear>>>>
  getContributionYears() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await contributionHistoryDs.getContributionYears(),
    );
  }

  @override
  Future<Either<PFailure, ReportStatus>> checkReportStatus({
    required int reportId,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async =>
              await contributionHistoryDs.checkReportStatus(reportId: reportId),
    );
  }

  @override
  Future<Either<PFailure, GenerateReport>> generateReport({
    required int year,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await contributionHistoryDs.generateReport(year: year),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Message>>> getReport({
    required int reportId,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await contributionHistoryDs.getReport(reportId: reportId),
    );
  }
}
