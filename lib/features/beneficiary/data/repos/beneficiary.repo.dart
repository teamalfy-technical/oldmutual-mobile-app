import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';

abstract class BeneficiaryRepo {
  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>> getBeneficiaries();
  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>> updateBeneficiary({
    int? beneficiaryId,
    required String fullName,
    required String relationship,
    required String birthDate,
    required String percAlloc,
    required String address,
  });
  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>> deleteBeneficiary({
    required int beneficiaryId,
  });
}
