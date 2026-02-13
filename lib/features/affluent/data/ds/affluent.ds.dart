import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/domain/models/affluent.model.dart';

abstract class AffluentDs {
  Future<ApiResponse<Affluent>> getAffluentStatus();
}
