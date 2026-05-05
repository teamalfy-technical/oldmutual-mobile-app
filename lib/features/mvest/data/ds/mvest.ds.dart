import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';

abstract class MVestDs {
  /// Create an MVest account
  /// Request body: mvest_plan, monthly_contribution
  Future<ApiResponse<MVestAccount>> createMVestAccount({
    required String mvestPlan,
    required double monthlyContribution,
  });

  /// Add an MVest beneficiary
  /// Request body: firstname, othername, beneficiaryContact,
  /// percentageAllocation, birth_date, relation
  /// Returns the updated MVest account.
  Future<ApiResponse<MVestAccount>> addMVestBeneficiary({
    required String firstname,
    required String othername,
    required String beneficiaryContact,
    required double percentageAllocation,
    required String birthDate,
    required String relation,
  });

  /// Delete an MVest beneficiary by their contact.
  /// Returns the updated MVest account.
  Future<ApiResponse<MVestAccount>> deleteMVestBeneficiary({
    required String beneficiaryContact,
  });

  /// Get the list of MVest beneficiaries.
  Future<ApiResponse<List<Beneficiary>>> getMVestBeneficiaries();

  /// Update an MVest beneficiary by their id
  /// Request body: firstname, othername, beneficiaryContact,
  /// percentageAllocation, birth_date, relation
  /// Returns the updated MVest account.
  Future<ApiResponse<MVestAccount>> updateMVestBeneficiary({
    required int id,
    required String firstname,
    required String othername,
    required String beneficiaryContact,
    required double percentageAllocation,
    required String birthDate,
    required String relation,
  });

  /// Initiate an MVest payment
  /// Request body: amount, currency (nullable), platform (default: mobile)
  Future<ApiResponse<InitiatePaymentResponse>> initiateMVestPayment({
    required double amount,
    String? currency,
    String platform = 'mobile',
  });
}
