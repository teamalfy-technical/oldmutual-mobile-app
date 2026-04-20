import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';

abstract class PolicyRepo {
  Future<Either<PFailure, ApiResponse<PolicyResponse>>> getPolicies({
    required String status,
  });

  Future<Either<PFailure, ApiResponse<PolicySummary>>> getPolicySummary();

  Future<Either<PFailure, ApiResponse<Policy>>> getPolicy({
    required String policyNumber,
  });

  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>>
  getPolicyBeneficiaries({required String policyNumber});
  Future<Either<PFailure, ApiResponse<PolicyTransaction>>>
  getPolicyTransaction({
    required String policyNumber,
    required String year,
    String month = '',
    String amount = '',
    String reference = '',
  });
  Future<Either<PFailure, ApiResponse<PolicyReport>>> generatePolicyReports({
    required String policyNumber,
    required String year,
  });
  Future<Either<PFailure, ApiResponse<PolicyReport>>>
  checkPolicyReportDownloadStatus({required String reportId});
  Future<Either<PFailure, ApiResponse<List<PolicyReport>>>> getPolicyReports({
    String? policyNumber,
  });
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadInvestmentStatement({required String policyNumber});
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadPremiumStatement({required String policyNumber});
  Future<Either<PFailure, ApiResponse<Map<String, dynamic>>>>
  downloadPolicyStatement({required String policyNumber});
}
