import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/up-sell/domain/up.sell.model.dart';
import 'package:oldmutual_pensions_app/features/up-sell/up.sell.dart';

final UpsellDs upsellDs = Get.put(UpsellDsImpl());

class UpsellDsImpl implements UpsellDs {
  @override
  Future<ApiResponse<List<Message>>> dismissRecommendation({
    required int id,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: '${Env.dismissRecommendation}/$id',
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Upsell>>> getAcceptedRecommendations({
    String? filterChannel,
    String? filterAcceptedAt,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        queryParams: {
          'filter[channel]': filterChannel,
          'filter[accepted_at]': filterAcceptedAt,
        },
        endPoint: Env.getAcceptedRecommendations,
      );
      return ApiResponse<List<Upsell>>.fromJson(
        res,
        (data) => (data as List).map((e) => Upsell.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Upsell>>> getUpsellRecommendations() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,

        endPoint: Env.getUpsellRecommendations,
      );
      return ApiResponse<List<Upsell>>.fromJson(
        res,
        (data) => (data as List).map((e) => Upsell.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Message>>> upgradeRecommendation({
    required int id,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final formData = dio.FormData.fromMap({'channel': 'App'});
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: '${Env.upgradeRecommendation}/$id',
        payload: formData,
        // payload: {'channel': 'App'},
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }
}
