import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';

abstract class CrossSellService {
  Future<Either<PFailure, ApiResponse<List<String>>>> getRecommendations();
  Future<Either<PFailure, ApiResponse<List<Message>>>> applyForRecommendation({
    required String recommendation,
  });
}
