import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/up-sell/domain/up.sell.model.dart';
import 'package:oldmutual_pensions_app/features/up-sell/up.sell.dart';

final UpsellRepo upsellRepo = Get.put(UpsellRepoImpl());

class UpsellRepoImpl implements UpsellRepo {
  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> dismissRecommendation({
    required int id,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await upsellDs.dismissRecommendation(id: id),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Upsell>>>>
  getAcceptedRecommendations({
    String? filterChannel,
    String? filterAcceptedAt,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await upsellDs.getAcceptedRecommendations(
        filterChannel: filterChannel,
        filterAcceptedAt: filterAcceptedAt,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Upsell>>>>
  getUpsellRecommendations() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await upsellDs.getUpsellRecommendations(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> upgradeRecommendation({
    required int id,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await upsellDs.upgradeRecommendation(id: id),
    );
  }
}
