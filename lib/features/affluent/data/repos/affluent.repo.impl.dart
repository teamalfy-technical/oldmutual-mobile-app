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
}
