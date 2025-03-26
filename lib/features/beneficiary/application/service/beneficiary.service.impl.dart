import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';

final BeneficiaryService beneficiaryService = Get.put(BeneficiaryServiceImpl());

class BeneficiaryServiceImpl implements BeneficiaryService {
  @override
  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>> getBeneficiaries() =>
      beneficiaryRepo.getBeneficiaries();
}
