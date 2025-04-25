import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';

abstract class BeneficiaryDs {
  Future<ApiResponse<List<Beneficiary>>> getBeneficiaries();
  Future<ApiResponse<List<Beneficiary>>> updateBeneficiary({
    int? beneficiaryId,
    required String fullName,
    required String relationship,
    required String birthDate,
    required String percAlloc,
    required String address,
  });
  Future<ApiResponse<List<Beneficiary>>> deleteBeneficiary({
    required int beneficiaryId,
  });
}
