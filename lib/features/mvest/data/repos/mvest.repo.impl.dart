import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';

final MVestRepo mvestRepo = Get.put(MVestRepoImpl());

class MVestRepoImpl implements MVestRepo {
  @override
  Future<Either<PFailure, ApiResponse<MVestAccount>>> createMVestAccount({
    required String mvestPlan,
    required double monthlyContribution,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await mvestDs.createMVestAccount(
        mvestPlan: mvestPlan,
        monthlyContribution: monthlyContribution,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<MVestAccount>>> addMVestBeneficiary({
    required String firstname,
    required String othername,
    required String beneficiaryContact,
    required double percentageAllocation,
    required String birthDate,
    required String relation,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await mvestDs.addMVestBeneficiary(
        firstname: firstname,
        othername: othername,
        beneficiaryContact: beneficiaryContact,
        percentageAllocation: percentageAllocation,
        birthDate: birthDate,
        relation: relation,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<MVestAccount>>> deleteMVestBeneficiary({
    required String beneficiaryContact,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await mvestDs.deleteMVestBeneficiary(
        beneficiaryContact: beneficiaryContact,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>>
  getMVestBeneficiaries() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await mvestDs.getMVestBeneficiaries(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<MVestAccount>>> updateMVestBeneficiary({
    required int id,
    required String firstname,
    required String othername,
    required String beneficiaryContact,
    required double percentageAllocation,
    required String birthDate,
    required String relation,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await mvestDs.updateMVestBeneficiary(
        id: id,
        firstname: firstname,
        othername: othername,
        beneficiaryContact: beneficiaryContact,
        percentageAllocation: percentageAllocation,
        birthDate: birthDate,
        relation: relation,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<InitiatePaymentResponse>>>
  initiateMVestPayment({
    required double amount,
    String? currency,
    String platform = 'mobile',
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await mvestDs.initiateMVestPayment(
        amount: amount,
        currency: currency,
        platform: platform,
      ),
    );
  }
}
