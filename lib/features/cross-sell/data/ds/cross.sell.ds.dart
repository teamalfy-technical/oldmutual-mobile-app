import 'package:oldmutual_pensions_app/core/network/network.dart';

abstract class CrossSellDs {
  Future<ApiResponse<List<String>>> getRecommendations();
  Future<ApiResponse<List<Message>>> applyForRecommendation({
    required String recommendation,
  });
}
