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

  @override
  Future<ApiResponse<List<Content>>> getContents({
    String? title,
    String? categoryName,
    String? slug,
    String? contentType,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final queryParams = <String, dynamic>{
        if (title != null) 'filter[title]': title,
        if (categoryName != null) 'filter[category.name]': categoryName,
        if (slug != null) 'filter[slug]': slug,
        if (contentType != null) 'filter[content_type]': contentType,
      };
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getContents,
        queryParams: queryParams.isNotEmpty ? queryParams : null,
      );
      return ApiResponse<List<Content>>.fromJson(
        res,
        (data) => (data as List).map((e) => Content.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<Content>> getContentById({required int id}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.getContentById}/$id',
      );
      return ApiResponse<Content>.fromJson(
        res,
        (data) => Content.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<Content>> getContentBySlug({required String slug}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.getContentBySlug}/$slug',
      );
      return ApiResponse<Content>.fromJson(
        res,
        (data) => Content.fromJson(data),
      );
    });
  }

  @override
  Future<PaginatedResponse<Content>> getBookmarkedContents() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getBookmarkedContents,
      );
      return PaginatedResponse<Content>.fromJson(
        res,
        (data) => Content.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<Content>> bookmarkContent({required int id}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: '${Env.bookmarkContent}/$id',
      );
      return ApiResponse<Content>.fromJson(
        res,
        (data) => Content.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<Content>> getBookmarkedContent({required int id}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.getBookmarkedContent}/$id',
      );
      return ApiResponse<Content>.fromJson(
        res,
        (data) => Content.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<int>> getBookmarkedContentCount() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getBookmarkedContentCount,
      );
      return ApiResponse<int>.fromJson(res, (data) => data as int);
    });
  }
}
