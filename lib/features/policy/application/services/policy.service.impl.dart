import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';

final PolicyService policyService = Get.put(PolicyServiceImpl());

class PolicyServiceImpl implements PolicyService {
  @override
  Future<Either<PFailure, ApiResponse<PolicyResponse>>> getPolicies({
    required String status,
  }) {
    return policyRepo.getPolicies(status: status);
  }

  @override
  Future<Either<PFailure, ApiResponse<Policy>>> getPolicy({
    required String policyNumber,
  }) {
    return policyRepo.getPolicy(policyNumber: policyNumber);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>>
  getPolicyBeneficiaries({required String policyNumber}) {
    return policyRepo.getPolicyBeneficiaries(policyNumber: policyNumber);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<PolicyReport>>>> getPolicyReports({
    String? policyNumber,
  }) {
    return policyRepo.getPolicyReports(policyNumber: policyNumber);
  }

  @override
  Future<Either<PFailure, ApiResponse<PolicySummary>>> getPolicySummary() {
    return policyRepo.getPolicySummary();
  }

  @override
  Future<Either<PFailure, ApiResponse<PolicyTransaction>>>
  getPolicyTransaction({
    required String policyNumber,
    String year = '',
    String month = '',
    String amount = '',
    String reference = '',
  }) {
    return policyRepo.getPolicyTransaction(
      policyNumber: policyNumber,
      year: year,
      month: month,
      amount: amount,
      reference: reference,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<PolicyReport>>>
  checkPolicyReportDownloadStatus({required String reportId}) {
    return policyRepo.checkPolicyReportDownloadStatus(reportId: reportId);
  }

  @override
  Future<Either<PFailure, ApiResponse<PolicyReport>>> generatePolicyReports({
    required String policyNumber,
    required int year,
  }) {
    return policyRepo.generatePolicyReports(
      policyNumber: policyNumber,
      year: year,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadInvestmentStatement({required String policyNumber}) {
    return policyRepo.downloadInvestmentStatement(policyNumber: policyNumber);
  }

  @override
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadPremiumStatement({required String policyNumber}) {
    return policyRepo.downloadPremiumStatement(policyNumber: policyNumber);
  }

  @override
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadPolicyStatement({required String policyNumber}) {
    return policyRepo.downloadPolicyStatement(policyNumber: policyNumber);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<PaymentMethod>>>>
  getPaymentMethods() {
    return policyRepo.getPaymentMethods();
  }

  @override
  Future<Either<PFailure, ApiResponse<List<WithdrawalReason>>>>
  getWithdrawalReasons() {
    return policyRepo.getWithdrawalReasons();
  }

  @override
  Future<Either<PFailure, ApiResponse<Message>>> submitInstantClaimRequest({
    required String policyNumber,
    required double currentCashValue,
    required double claimAmount,
    required String claimDefaultTelcomethod,
    required String claimDefaultMomoWallet,
    required int withdrawalPurpose,
  }) {
    return policyRepo.submitInstantClaimRequest(
      policyNumber: policyNumber,
      currentCashValue: currentCashValue,
      claimAmount: claimAmount,
      claimDefaultTelcomethod: claimDefaultTelcomethod,
      claimDefaultMomoWallet: claimDefaultMomoWallet,
      withdrawalPurpose: withdrawalPurpose,
    );
  }
}
