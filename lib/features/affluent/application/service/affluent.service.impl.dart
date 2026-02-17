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
}
