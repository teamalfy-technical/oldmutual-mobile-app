import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';

abstract class ContributionDs {
  Future<ApiResponse<List<Beneficiary>>> getContributions();
}
