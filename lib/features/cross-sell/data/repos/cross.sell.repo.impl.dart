import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/cross.sell.dart';

final CrossSellRepo crossSellRepo = Get.put(CrossSellRepoImpl());

class CrossSellRepoImpl implements CrossSellRepo {
  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> applyForRecommendation({
    required String recommendation,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await crossSellDs.applyForRecommendation(
        recommendation: recommendation,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<String>>>>
  getRecommendations() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await crossSellDs.getRecommendations(),
    );
  }
}
