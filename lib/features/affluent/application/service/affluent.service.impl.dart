import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';

final AffluentService affluentService = Get.put(AffluentServiceImpl());

class AffluentServiceImpl implements AffluentService {
  @override
  Future<Either<PFailure, ApiResponse<List<ContentCategory>>>>
  getContentCategories() {
    return affluentRepo.getContentCategories();
  }

  @override
  Future<Either<PFailure, ApiResponse<ContentCategory>>> getContentCategory({
    required int id,
  }) {
    return affluentRepo.getContentCategory(id: id);
  }

  @override
  Future<Either<PFailure, ApiResponse<dynamic>>> deleteContentCategory({
    required int id,
  }) {
    return affluentRepo.deleteContentCategory(id: id);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Content>>>> getContents({
    String? title,
    String? categoryName,
    String? slug,
    String? contentType,
  }) {
    return affluentRepo.getContents(
      title: title,
      categoryName: categoryName,
      slug: slug,
      contentType: contentType,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Content>>> getContentById({
    required int id,
  }) {
    return affluentRepo.getContentById(id: id);
  }

  @override
  Future<Either<PFailure, ApiResponse<Content>>> getContentBySlug({
    required String slug,
  }) {
    return affluentRepo.getContentBySlug(slug: slug);
  }

  @override
  Future<Either<PFailure, PaginatedResponse<Content>>> getBookmarkedContents() {
    return affluentRepo.getBookmarkedContents();
  }

  @override
  Future<Either<PFailure, ApiResponse<Content>>> bookmarkContent({
    required int id,
  }) {
    return affluentRepo.bookmarkContent(id: id);
  }

  @override
  Future<Either<PFailure, ApiResponse<Content>>> getBookmarkedContent({
    required int id,
  }) {
    return affluentRepo.getBookmarkedContent(id: id);
  }

  @override
  Future<Either<PFailure, ApiResponse<int>>> getBookmarkedContentCount() {
    return affluentRepo.getBookmarkedContentCount();
  }
}
