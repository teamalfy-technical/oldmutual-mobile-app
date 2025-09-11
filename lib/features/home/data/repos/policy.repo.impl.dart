import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

final PolicyRepo policyRepo = Get.put(PolicyRepoImpl());

class PolicyRepoImpl implements PolicyRepo {
  @override
  Future<Either<PFailure, ApiResponse<PolicyResponse>>> getPolicies({
    required String status,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await policyDs.getPolicies(status: status),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Policy>>> getPolicy({
    required String policyNumber,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await policyDs.getPolicy(policyNumber: policyNumber),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Beneficiaries>>>>
  getPolicyBeneficiaries({required String policyNumber}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await policyDs.getPolicyBeneficiaries(policyNumber: policyNumber),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PolicyReport>>> getPolicyReport({
    required String policyNumber,
    required String year,
    String month = '',
    String amount = '',
    String reference = '',
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await policyDs.getPolicyReport(
        policyNumber: policyNumber,
        year: year,
        month: month,
        amount: amount,
        reference: reference,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PolicySummary>>>
  getPolicySummary() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await policyDs.getPolicySummary(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PolicyTransaction>>>
  getPolicyTransaction({required String policyNumber}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await policyDs.getPolicyTransaction(policyNumber: policyNumber),
    );
  }
}
