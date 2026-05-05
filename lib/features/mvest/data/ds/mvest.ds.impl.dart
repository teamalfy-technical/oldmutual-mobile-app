import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';

final MVestDs mvestDs = Get.put(MVestDsImpl());

class MVestDsImpl implements MVestDs {
  @override
  Future<ApiResponse<MVestAccount>> createMVestAccount({
    required String mvestPlan,
    required double monthlyContribution,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'mvest_plan': mvestPlan,
        'monthly_contribution': monthlyContribution,
      });

      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.createMVestAccount,
      );

      pensionAppLogger.i(res);
      return ApiResponse<MVestAccount>.fromJson(
        res,
        (data) => MVestAccount.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<MVestAccount>> addMVestBeneficiary({
    required String firstname,
    required String othername,
    required String beneficiaryContact,
    required double percentageAllocation,
    required String birthDate,
    required String relation,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'firstname': firstname,
        'othername': othername,
        'beneficiaryContact': beneficiaryContact,
        'percentageAllocation': percentageAllocation,
        'birth_date': birthDate,
        'relation': relation,
      });

      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.addMVestBeneficiary,
      );

      pensionAppLogger.i(res);
      return ApiResponse<MVestAccount>.fromJson(
        res,
        (data) => MVestAccount.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<MVestAccount>> deleteMVestBeneficiary({
    required String beneficiaryContact,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.delete,
        endPoint: '${Env.deleteMVestBeneficiary}/$beneficiaryContact',
      );

      pensionAppLogger.i(res);
      return ApiResponse<MVestAccount>.fromJson(
        res,
        (data) => MVestAccount.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<List<Beneficiary>>> getMVestBeneficiaries() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getMVestBeneficiaries,
      );

      pensionAppLogger.i(res);
      return ApiResponse<List<Beneficiary>>.fromJson(
        res,
        (data) => (data as List).map((e) => Beneficiary.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<MVestAccount>> updateMVestBeneficiary({
    required int id,
    required String firstname,
    required String othername,
    required String beneficiaryContact,
    required double percentageAllocation,
    required String birthDate,
    required String relation,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'firstname': firstname,
        'othername': othername,
        'beneficiaryContact': beneficiaryContact,
        'percentageAllocation': percentageAllocation,
        'birth_date': birthDate,
        'relation': relation,
      });

      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: '${Env.updateMVestBeneficiary}/$id',
      );

      pensionAppLogger.i(res);
      return ApiResponse<MVestAccount>.fromJson(
        res,
        (data) => MVestAccount.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<InitiatePaymentResponse>> initiateMVestPayment({
    required double amount,
    String? currency,
    String platform = 'mobile',
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final body = <String, dynamic>{
        'amount': amount,
        'platform': platform,
      };
      if (currency != null) body['currency'] = currency;
      final payload = dio.FormData.fromMap(body);

      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.initiateMVestPayment,
      );

      pensionAppLogger.i(res);
      return ApiResponse<InitiatePaymentResponse>.fromJson(
        res,
        (data) => InitiatePaymentResponse.fromJson(data),
      );
    });
  }
}
