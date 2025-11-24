import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/cross.sell.dart';

final CrossSellDs crossSellDs = Get.put(CrossSellDsImpl());

class CrossSellDsImpl implements CrossSellDs {
  @override
  Future<ApiResponse<List<Message>>> applyForRecommendation({
    required String recommendation,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.applyRecommendation}/$recommendation',
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<String>>> getRecommendations() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getRecommendations,
      );
      return ApiResponse<List<String>>.fromJson(
        res,
        // res['recommendations'],
        (data) => (data as List).map((e) => e.toString()).toList(),
      );
    });
  }
}
