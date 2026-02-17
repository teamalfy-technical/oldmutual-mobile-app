import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';

final AffluentDs affluentDs = Get.put(AffluentDsImpl());

class AffluentDsImpl implements AffluentDs {
  @override
  Future<ApiResponse<List<ContentCategory>>> getContentCategories() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getContentCategories,
      );
      return ApiResponse<List<ContentCategory>>.fromJson(
        res,
        (data) =>
            (data as List).map((e) => ContentCategory.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<ContentCategory>> getContentCategory({
    required int id,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        queryParams: {'id': id},
        endPoint: Env.getContentCategory,
      );
      return ApiResponse<ContentCategory>.fromJson(
        res,
        (data) => ContentCategory.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<dynamic>> deleteContentCategory({required int id}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.delete,
        queryParams: {'id': id},
        endPoint: Env.deleteContentCategory,
      );
      return ApiResponse<dynamic>.fromJson(res, (data) => data);
    });
  }
}
