import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';

abstract class FactsheetService {
  Future<Either<PFailure, ApiResponse<List<PerformanceModel>>>>
  getPerformances();
  Future<Either<PFailure, ApiResponse<PerformanceModel>>> addPerformance({
    required int year,
    required double anchor,
    required double benchmark,
  });
  Future<Either<PFailure, ApiResponse<PerformanceModel>>> updatePerformance({
    required int id,
    required int year,
    required double anchor,
    required double benchmark,
  });
  Future<Either<PFailure, ApiResponse<List<PerformanceModel>>>>
  deletePerformance({required int id});

  Future<Either<PFailure, ApiResponse<List<FundCompositionModel>>>>
  getFundComposition();
  Future<Either<PFailure, ApiResponse<FundCompositionModel>>>
  addFundComposition({required String asset, required double percentage});
  Future<Either<PFailure, ApiResponse<FundCompositionModel>>>
  updateFundComposition({
    required int id,
    required String asset,
    required double percentage,
  });
  Future<Either<PFailure, ApiResponse<List<FundCompositionModel>>>>
  deleteFundComposition({required int id});

  Future<Either<PFailure, ApiResponse<Factsheet>>> downloadFactsheet();
}
