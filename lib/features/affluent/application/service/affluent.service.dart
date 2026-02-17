import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/domain/models/content.category.model.dart';

abstract class AffluentService {
  Future<Either<PFailure, ApiResponse<List<ContentCategory>>>>
  getContentCategories();
  Future<Either<PFailure, ApiResponse<ContentCategory>>> getContentCategory({
    required int id,
  });
  Future<Either<PFailure, ApiResponse<dynamic>>> deleteContentCategory({
    required int id,
  });
}
