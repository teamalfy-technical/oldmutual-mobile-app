import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/cross.sell.dart';

final CrossSellService crossSellService = Get.put(CrossSellServiceImpl());

class CrossSellServiceImpl implements CrossSellService {
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
