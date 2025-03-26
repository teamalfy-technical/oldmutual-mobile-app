import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';

abstract class BeneficiaryDs {
  Future<ApiResponse<List<Beneficiary>>> getBeneficiaries();
}
