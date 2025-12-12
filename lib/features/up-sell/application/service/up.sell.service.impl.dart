import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/up-sell/domain/up.sell.model.dart';
import 'package:oldmutual_pensions_app/features/up-sell/up.sell.dart';

final UpsellService upsellService = Get.put(UpsellServiceImpl());

class UpsellServiceImpl implements UpsellService {
  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> dismissRecommendation({
    required int id,
  }) {
    return upsellRepo.dismissRecommendation(id: id);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Upsell>>>>
  getAcceptedRecommendations({
    String? filterChannel,
    String? filterAcceptedAt,
  }) async {
    return upsellRepo.getAcceptedRecommendations(
      filterAcceptedAt: filterAcceptedAt,
      filterChannel: filterChannel,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Upsell>>>>
  getUpsellRecommendations() {
    return upsellRepo.getUpsellRecommendations();
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> upgradeRecommendation({
    required int id,
  }) {
    return upsellRepo.upgradeRecommendation(id: id);
  }
}
