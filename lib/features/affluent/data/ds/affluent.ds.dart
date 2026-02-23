import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/domain/models/content.category.model.dart';
import 'package:oldmutual_pensions_app/features/affluent/domain/models/content.model.dart';

abstract class AffluentDs {
  Future<ApiResponse<List<ContentCategory>>> getContentCategories();
  Future<ApiResponse<ContentCategory>> getContentCategory({required int id});
  Future<ApiResponse<dynamic>> deleteContentCategory({required int id});
  Future<ApiResponse<List<Content>>> getContents({
    String? title,
    String? categoryName,
    String? slug,
    String? contentType,
  });
  Future<ApiResponse<Content>> getContentById({required int id});
  Future<ApiResponse<Content>> getContentBySlug({required String slug});
  Future<PaginatedResponse<Content>> getBookmarkedContents();
  Future<ApiResponse<Content>> bookmarkContent({required int id});
  Future<ApiResponse<Content>> getBookmarkedContent({required int id});
  Future<ApiResponse<int>> getBookmarkedContentCount();
}
