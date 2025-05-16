import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';

final FactsheetService factsheetService = Get.put(FactsheetServiceImpl());

class FactsheetServiceImpl implements FactsheetService {
  @override
  Future<Either<PFailure, ApiResponse<FundCompositionModel>>>
  addFundComposition({required String asset, required double percentage}) {
    return factsheetRepo.addFundComposition(
      asset: asset,
      percentage: percentage,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PerformanceModel>>> addPerformance({
    required int year,
    required double anchor,
    required double benchmark,
  }) {
    return factsheetRepo.addPerformance(
      year: year,
      anchor: anchor,
      benchmark: benchmark,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<FundCompositionModel>>>>
  deleteFundComposition({required int id}) {
    return factsheetRepo.deleteFundComposition(id: id);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<PerformanceModel>>>>
  deletePerformance({required int id}) {
    return factsheetRepo.deletePerformance(id: id);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<FundCompositionModel>>>>
  getFundComposition() {
    return factsheetRepo.getFundComposition();
  }

  @override
  Future<Either<PFailure, ApiResponse<List<PerformanceModel>>>>
  getPerformances() {
    return factsheetRepo.getPerformances();
  }

  @override
  Future<Either<PFailure, ApiResponse<FundCompositionModel>>>
  updateFundComposition({
    required int id,
    required String asset,
    required double percentage,
  }) {
    return factsheetRepo.updateFundComposition(
      id: id,
      asset: asset,
      percentage: percentage,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PerformanceModel>>> updatePerformance({
    required int id,
    required int year,
    required double anchor,
    required double benchmark,
  }) {
    return factsheetRepo.updatePerformance(
      id: id,
      year: year,
      anchor: anchor,
      benchmark: benchmark,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Factsheet>>> downloadFactsheet() {
    return factsheetRepo.downloadFactsheet();
  }
}
