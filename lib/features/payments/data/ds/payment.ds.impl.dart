import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';

final PaymentDs paymentDs = Get.put(PaymentDsImpl());

class PaymentDsImpl implements PaymentDs {
  @override
  Future<ApiResponse<InitiatePaymentResponse>> initiatePensionsPayment({
    required double amount,
    required String currency,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'amount': amount,
        'currency': currency,
        'platform': 'mobile',
      });

      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.initiatePensionsPayment,
      );

      pensionAppLogger.i(res);
      return ApiResponse<InitiatePaymentResponse>.fromJson(
        res,
        (data) => InitiatePaymentResponse.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<InitiatePaymentResponse>> initiatePolicyPayment({
    required double amount,
    required String policyNumber,
    required String product,
    required String currency,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'amount': amount,
        'policy_number': policyNumber,
        'product': product,
        'currency': currency,
        'platform': 'mobile',
      });

      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.initiatePolicyPayment,
      );

      pensionAppLogger.i(res);
      return ApiResponse<InitiatePaymentResponse>.fromJson(
        res,
        (data) => InitiatePaymentResponse.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<List<Payment>>> getPensionsPayments({
    String? amount,
    String? status,
    String? paymentReference,
    String? clientReference,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final Map<String, dynamic> queryParams = {};
      if (amount != null) queryParams['filter[amount]'] = amount;
      if (status != null) queryParams['filter[status]'] = status;
      if (paymentReference != null)
        queryParams['filter[payment_reference]'] = paymentReference;

      if (clientReference != null)
        queryParams['filter[client_reference]'] = clientReference;

      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getPensionsPayment,
        queryParams: queryParams.isNotEmpty ? queryParams : null,
      );

      pensionAppLogger.i(res);
      return ApiResponse<List<Payment>>.fromJson(
        res,
        (data) => (data as List).map((e) => Payment.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Payment>>> getPolicyPayments({
    String? amount,
    String? policyNumber,
    String? status,
    String? paymentReference,
    String? clientReference,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final Map<String, dynamic> queryParams = {};
      if (amount != null) queryParams['filter[amount]'] = amount;
      if (policyNumber != null)
        queryParams['filter[policy_number]'] = policyNumber;

      if (status != null) queryParams['filter[status]'] = status;
      if (paymentReference != null)
        queryParams['filter[payment_reference]'] = paymentReference;
      if (clientReference != null)
        queryParams['filter[client_reference]'] = clientReference;

      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getPolicyPayment,
        queryParams: queryParams.isNotEmpty ? queryParams : null,
      );

      pensionAppLogger.i(res);
      return ApiResponse<List<Payment>>.fromJson(
        res,
        (data) => (data as List).map((e) => Payment.fromJson(e)).toList(),
      );
    });
  }
}
