import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/domain/models/content.category.model.dart';
import 'package:oldmutual_pensions_app/features/affluent/domain/models/content.model.dart';

abstract class AffluentRepo {
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
  Future<Either<PFailure, PaginatedResponse<Content>>> getBookmarkedContents();
  Future<Either<PFailure, ApiResponse<Content>>> bookmarkContent({
    required int id,
  });
  Future<Either<PFailure, ApiResponse<Content>>> getBookmarkedContent({
    required int id,
  });
  Future<Either<PFailure, ApiResponse<int>>> getBookmarkedContentCount();
}
