import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/up-sell/domain/up.sell.model.dart';

abstract class UpsellDs {
  Future<ApiResponse<List<Upsell>>> getUpsellRecommendations();
  Future<ApiResponse<List<Message>>> upgradeRecommendation({
    required int id,
  });
  Future<ApiResponse<List<Message>>> dismissRecommendation({
    required int id,
  });
  Future<ApiResponse<List<Upsell>>> getAcceptedRecommendations({
    String? filterChannel,
    String? filterAcceptedAt,
  });
}
