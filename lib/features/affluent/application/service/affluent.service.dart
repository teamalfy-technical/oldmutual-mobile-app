import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';

abstract class AffluentService {
  Future<Either<PFailure, ApiResponse<List<ContentCategory>>>>
  getContentCategories();
  Future<Either<PFailure, ApiResponse<ContentCategory>>> getContentCategory({
    required int id,
  });
  Future<Either<PFailure, ApiResponse<dynamic>>> deleteContentCategory({
    required int id,
  });
  Future<Either<PFailure, ApiResponse<List<Content>>>> getContents({
    String? title,
    String? categoryName,
    String? slug,
    String? contentType,
  });
  Future<Either<PFailure, ApiResponse<Content>>> getContentById({
    required int id,
  });
  Future<Either<PFailure, ApiResponse<Content>>> getContentBySlug({
    required String slug,
  });
  Future<Either<PFailure, PaginatedResponse<BookmarkedContent>>>
  getBookmarkedContents({int page = 1});
  Future<Either<PFailure, PaginatedResponse<BookmarkedContent>>>
  bookmarkContent({required int id});
  Future<Either<PFailure, ApiResponse<BookmarkedContent>>>
  getBookmarkedContent({required int id});
  Future<Either<PFailure, ApiResponse<int>>> getBookmarkedContentCount();
  Future<Either<PFailure, ApiResponse<dynamic>>> deleteBookedContent({
    required int id,
  });
  Future<Either<PFailure, ApiResponse<dynamic>>> clearBookmarkedContents();
  Future<Either<PFailure, ApiResponse<RelationshipOfficer>>>
  getAffluentRelationshipOfficer({required String agentNo});
}
