import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';

final BeneficiaryRepo beneficiaryRepo = Get.put(BeneficiaryRepoImpl());

class BeneficiaryRepoImpl implements BeneficiaryRepo {
  @override
  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>>
  getBeneficiaries() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await beneficiaryDs.getBeneficiaries(),
    );
  }
}
