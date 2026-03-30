import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/up-sell/domain/up.sell.model.dart';

abstract class UpsellRepo {
  Future<Either<PFailure, ApiResponse<List<Upsell>>>>
  getUpsellRecommendations();
  Future<Either<PFailure, ApiResponse<List<Message>>>> upgradeRecommendation({
    required int id,
  });
  Future<Either<PFailure, ApiResponse<List<Message>>>> dismissRecommendation({
    required int id,
  });
  Future<Either<PFailure, ApiResponse<List<Upsell>>>>
  getAcceptedRecommendations({String? filterChannel, String? filterAcceptedAt});
}
