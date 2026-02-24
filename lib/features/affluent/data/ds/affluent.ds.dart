import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';

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
  Future<PaginatedResponse<BookmarkedContent>> getBookmarkedContents({
    int page = 1,
  });
  Future<PaginatedResponse<BookmarkedContent>> bookmarkContent({
    required int id,
  });
  Future<ApiResponse<BookmarkedContent>> getBookmarkedContent({
    required int id,
  });
  Future<ApiResponse<int>> getBookmarkedContentCount();
  Future<ApiResponse<dynamic>> deleteBookedContent({required int id});
  Future<ApiResponse<dynamic>> clearBookmarkedContents();
}
