import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

final AuthDs authDs = Get.put(AuthDsImpl());

class AuthDsImpl implements AuthDs {
  @override
  Future<ApiResponse<List<Message>>> addPassword({
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        // 'phone': phone,
        'password': password,
        'c_password': confirmPassword,
      });
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.addPassword,
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<Member>> forgotPassword({
    required String emailOrPhone,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'email_or_phone': emailOrPhone});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.forgotPassword,
      );
      return ApiResponse<Member>.fromJson(
        res,
        (data) => data is Map<String, dynamic>
            ? Member.fromJson(data)
            : Member(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Message>>> verifySignupOtp({
    required String otp,
    required String otpRef,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'otp': otp, 'otp_ref': otpRef});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.verifyOtp,
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<Member>> verifyForgotPasswordOTP({
    required String otp,
    required String otpRef,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'otp': otp, 'otp_ref': otpRef});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.verifyResetOtp,
      );
      return ApiResponse<Member>.fromJson(res, (data) => Member.fromJson(data));
    });
  }

  @override
  Future<ApiResponse<List<Message>>> resetPassword({
    required String password,
    required String confirmPassword,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'password': password,
        'c_password': confirmPassword,
      });

      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.resetPassword,
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<BioData>>> getBioData() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getBiodata,
      );

      return ApiResponse<List<BioData>>.fromJson(
        res,
        (data) => (data as List).map((e) => BioData.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Message>>> updateFcmToken({
    required String token,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'device_token': token});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.updateFcmToken,
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Message>>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'old_password': oldPassword,
        'password': newPassword,
        'c_password': confirmPassword,
      });
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.changePassword,
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<Member>> signUp({
    required String email,
    required String phone,
    required String verificationToken,
    required String password,
    required String confirmPassword,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'email': email,
        'phone': phone,
        'password': password,
        'c_password': confirmPassword,
        'verification_token': verificationToken,
      });
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.createAccount,
      );
      return ApiResponse<Member>.fromJson(
        res,
        (data) =>
            data is Map<String, dynamic> ? Member.fromJson(data) : Member(),
      );
    });
  }

  @override
  Future<ApiResponse<Member>> resendOtp({required String otpRef}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'otp_ref': otpRef});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.resendOtp,
      );
      return ApiResponse<Member>.fromJson(
        res,
        (data) => data is Map<String, dynamic>
            ? Member.fromJson(data)
            : Member(),
      );
    });
  }

  @override
  Future<ApiResponse<Member>> signIn({
    required String emailOrPhone,
    required String password,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'email_or_phone': emailOrPhone,
        'password': password,
      });
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.login,
      );
      return ApiResponse<Member>.fromJson(res, (data) => Member.fromJson(data));
    });
  }

  @override
  Future<ApiResponse<String>> verifyGhanaCard({
    required String cardNumber,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'ghana_card_number': cardNumber});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.verifyGhanaCard,
      );
      return ApiResponse<String>.fromJson(res, (data) => data);
    });
  }

  @override
  Future<ApiResponse<String>> checkCardVerificationStatus({
    required String sessionId,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'session_id': sessionId});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.checkGhanaCardVerificationStatus,
      );
      return ApiResponse<String>.fromJson(res, (data) => data['status']);
    });
  }
}
