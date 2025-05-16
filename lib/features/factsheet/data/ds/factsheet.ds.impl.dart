import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';

final FactsheetDs factsheetDs = Get.put(FactsheetDsImpl());

class FactsheetDsImpl implements FactsheetDs {
  @override
  Future<ApiResponse<FundCompositionModel>> addFundComposition({
    required String asset,
    required double percentage,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: Env.addFundComposition,
        payload: dio.FormData.fromMap({
          'asset': asset,
          'percentage': percentage,
        }),
      );
      return ApiResponse<FundCompositionModel>.fromJson(
        res,
        (data) => FundCompositionModel.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<PerformanceModel>> addPerformance({
    required int year,
    required double anchor,
    required double benchmark,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: Env.addPerformance,
        payload: dio.FormData.fromMap({
          'year': year,
          'anchor': anchor,
          'benchmark': benchmark,
        }),
      );
      return ApiResponse<PerformanceModel>.fromJson(
        res,
        (data) => PerformanceModel.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<List<FundCompositionModel>>> deleteFundComposition({
    required int id,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.delete,
        endPoint: '${Env.deleteFundComposition}/$id',
      );
      return ApiResponse<List<FundCompositionModel>>.fromJson(
        res,
        (data) =>
            (data as List)
                .map((e) => FundCompositionModel.fromJson(e))
                .toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<PerformanceModel>>> deletePerformance({
    required int id,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.delete,
        endPoint: '${Env.deletePerformance}/$id',
      );
      return ApiResponse<List<PerformanceModel>>.fromJson(
        res,
        (data) =>
            (data as List).map((e) => PerformanceModel.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<FundCompositionModel>>> getFundComposition() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getFundComposition,
      );
      return ApiResponse<List<FundCompositionModel>>.fromJson(
        res,
        (data) =>
            (data as List)
                .map((e) => FundCompositionModel.fromJson(e))
                .toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<PerformanceModel>>> getPerformances() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getPerformances,
      );
      return ApiResponse<List<PerformanceModel>>.fromJson(
        res,
        (data) =>
            (data as List).map((e) => PerformanceModel.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<FundCompositionModel>> updateFundComposition({
    required int id,
    required String asset,
    required double percentage,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: '${Env.updateFundComposition}/$id',
        payload: dio.FormData.fromMap({
          'asset': asset,
          'percentage': percentage,
        }),
      );
      return ApiResponse<FundCompositionModel>.fromJson(
        res,
        (data) => FundCompositionModel.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<PerformanceModel>> updatePerformance({
    required int id,
    required int year,
    required double anchor,
    required double benchmark,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: '${Env.updatePerformance}/$id',
        payload: dio.FormData.fromMap({
          'year': year,
          'anchor': anchor,
          'benchmark': benchmark,
        }),
      );
      return ApiResponse<PerformanceModel>.fromJson(
        res,
        (data) => PerformanceModel.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<Factsheet>> downloadFactsheet() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.downloadFactsheet,
      );
      return ApiResponse<Factsheet>.fromJson(
        res,
        (data) => Factsheet.fromJson(data),
      );
    });
  }
}
