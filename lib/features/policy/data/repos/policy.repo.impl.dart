import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';

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
  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>>
  getPolicyBeneficiaries({required String policyNumber}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await policyDs.getPolicyBeneficiaries(policyNumber: policyNumber),
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
  getPolicyTransaction({
    required String policyNumber,
    required String year,
    String month = '',
    String amount = '',
    String reference = '',
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await policyDs.getPolicyTransaction(
        policyNumber: policyNumber,
        year: year,
        month: month,
        amount: amount,
        reference: reference,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PolicyReport>>>
  checkPolicyReportDownloadStatus({required String reportId}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await policyDs.checkPolicyReportDownloadStatus(reportId: reportId),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PolicyReport>>> generatePolicyReports({
    required String policyNumber,
    required int year,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await policyDs.generatePolicyReports(
        policyNumber: policyNumber,
        year: year,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<PolicyReport>>>> getPolicyReports({
    String? policyNumber,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await policyDs.getPolicyReports(policyNumber: policyNumber),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadInvestmentStatement({required String policyNumber}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await policyDs.downloadInvestmentStatement(
        policyNumber: policyNumber,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadPremiumStatement({required String policyNumber}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await policyDs.downloadPremiumStatement(policyNumber: policyNumber),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadPolicyStatement({required String policyNumber}) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await policyDs.downloadPolicyStatement(policyNumber: policyNumber),
    );
  }

}
