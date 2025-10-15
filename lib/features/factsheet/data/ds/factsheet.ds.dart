import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';

abstract class FactsheetDs {
  Future<ApiResponse<List<PerformanceModel>>> getPerformances();
  Future<ApiResponse<PerformanceModel>> addPerformance({
    required int year,
    required double anchor,
    required double benchmark,
  });
  Future<ApiResponse<PerformanceModel>> updatePerformance({
    required int id,
    required int year,
    required double anchor,
    required double benchmark,
  });
  Future<ApiResponse<List<PerformanceModel>>> deletePerformance({
    required int id,
  });

  Future<ApiResponse<List<FundCompositionModel>>> getFundComposition();
  Future<ApiResponse<FundCompositionModel>> addFundComposition({
    required String asset,
    required double percentage,
  });
  Future<ApiResponse<FundCompositionModel>> updateFundComposition({
    required int id,
    required String asset,
    required double percentage,
  });
  Future<ApiResponse<List<FundCompositionModel>>> deleteFundComposition({
    required int id,
  });

  Future<ApiResponse<Factsheet>> downloadFactsheet();
}
