import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';

final AffluentRepo affluentRepo = Get.put(AffluentRepoImpl());

class AffluentRepoImpl implements AffluentRepo {
  @override
  Future<Either<PFailure, ApiResponse<List<ContentCategory>>>>
  getContentCategories() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.getContentCategories(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<ContentCategory>>> getContentCategory({
    required int id,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.getContentCategory(id: id),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<dynamic>>> deleteContentCategory({
    required int id,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.deleteContentCategory(id: id),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Content>>>> getContents({
    String? title,
    String? categoryName,
    String? slug,
    String? contentType,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.getContents(
        title: title,
        categoryName: categoryName,
        slug: slug,
        contentType: contentType,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Content>>> getContentById({
    required int id,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.getContentById(id: id),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Content>>> getContentBySlug({
    required String slug,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.getContentBySlug(slug: slug),
    );
  }

  @override
  Future<Either<PFailure, PaginatedResponse<BookmarkedContent>>>
  getBookmarkedContents({int page = 1}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await affluentDs.getBookmarkedContents(page: page),
    );
  }

  @override
  Future<Either<PFailure, PaginatedResponse<BookmarkedContent>>>
  bookmarkContent({required int id}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.bookmarkContent(id: id),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<BookmarkedContent>>>
  getBookmarkedContent({required int id}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.getBookmarkedContent(id: id),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<int>>> getBookmarkedContentCount() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.getBookmarkedContentCount(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<dynamic>>> deleteBookedContent({
    required int id,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.deleteBookedContent(id: id),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<dynamic>>>
  clearBookmarkedContents() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await affluentDs.clearBookmarkedContents(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<RelationshipOfficer>>>
  getAffluentRelationshipOfficer() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await affluentDs.getAffluentRelationshipOfficer(),
    );
  }
}
