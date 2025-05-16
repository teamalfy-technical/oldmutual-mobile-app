import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';

final FactsheetRepo factsheetRepo = Get.put(FactsheetRepoImpl());

class FactsheetRepoImpl implements FactsheetRepo {
  // @override
  // Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  // filterContributions({required String month, required String year}) async {
  //   return await customRepositoryWrapper.wrapRepositoryFunction(
  //     function:
  //         () async => await contributionHistoryDs.filterContributions(
  //           month: month,
  //           year: year,
  //         ),
  //   );
  // }

  // @override
  // Future<Either<PFailure, ApiResponse<ContributionHistory>>>
  // getAllContributions() async {
  //   return await customRepositoryWrapper.wrapRepositoryFunction(
  //     function: () async => await contributionHistoryDs.getAllContributions(),
  //   );
  // }

  // @override
  // Future<Either<PFailure, ApiResponse<ContributionSummary>>>
  // getContributionSummary() async {
  //   return await customRepositoryWrapper.wrapRepositoryFunction(
  //     function:
  //         () async => await contributionHistoryDs.getContributionSummary(),
  //   );
  // }

  // @override
  // Future<Either<PFailure, ApiResponse<List<ContributedYear>>>>
  // getContributionYears() async {
  //   return await customRepositoryWrapper.wrapRepositoryFunction(
  //     function: () async => await contributionHistoryDs.getContributionYears(),
  //   );
  // }

  @override
  Future<Either<PFailure, ApiResponse<FundCompositionModel>>>
  addFundComposition({
    required String asset,
    required double percentage,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await factsheetDs.addFundComposition(
            asset: asset,
            percentage: percentage,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PerformanceModel>>> addPerformance({
    required int year,
    required double anchor,
    required double benchmark,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await factsheetDs.addPerformance(
            year: year,
            anchor: anchor,
            benchmark: benchmark,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<FundCompositionModel>>>>
  deleteFundComposition({required int id}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await factsheetDs.deleteFundComposition(id: id),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<PerformanceModel>>>>
  deletePerformance({required int id}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await factsheetDs.deletePerformance(id: id),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<FundCompositionModel>>>>
  getFundComposition() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await factsheetDs.getFundComposition(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<PerformanceModel>>>>
  getPerformances() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await factsheetDs.getPerformances(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<FundCompositionModel>>>
  updateFundComposition({
    required int id,
    required String asset,
    required double percentage,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await factsheetDs.updateFundComposition(
            id: id,
            asset: asset,
            percentage: percentage,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PerformanceModel>>> updatePerformance({
    required int id,
    required int year,
    required double anchor,
    required double benchmark,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await factsheetDs.updatePerformance(
            id: id,
            year: year,
            anchor: anchor,
            benchmark: benchmark,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Factsheet>>> downloadFactsheet() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await factsheetDs.downloadFactsheet(),
    );
  }
}
