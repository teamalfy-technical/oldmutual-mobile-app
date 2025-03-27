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
        'phone': phone,
        'password': password,
        'c_password': confirmPassword,
      });
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.addPassword,
      );
      return ApiResponse<List<Member>>.fromJson(
        res,
        (data) => (data as List).map((e) => Member.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Member>>> forgotPassword({
    required String email,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'email': email});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.forgotPassword,
      );
      return ApiResponse<List<Member>>.fromJson(
        res,
        (data) => (data as List).map((e) => Member.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Message>>> resetPassword({
    required String otp,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'otp': otp,
        'email': email,
        'password': password,
        'c_password': confirmPassword,
      });
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.resetPassword,
      );
      return ApiResponse<List<Member>>.fromJson(
        res,
        (data) => (data as List).map((e) => Member.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<Member>> signIn({
    required String phone,
    required String password,
    required String deviceToken,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'phone': phone,
        'password': password,
        'device_token': deviceToken,
      });
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.signin,
      );
      return ApiResponse<Member>.fromJson(res, (data) => Member.fromJson(data));
    });
  }

  @override
  Future<ApiResponse<List<Message>>> signup({
    required String terms,
    required String phone,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'terms': terms, 'phone': phone});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.signup,
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Member>>> verifyOTP({
    required String phone,
    required String otp,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'phone': phone, 'otp': otp});
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.verifyOTP,
      );
      // return ApiResponse<Member>.fromJson(res, (data) => Member.fromJson(data));
      return ApiResponse<List<Member>>.fromJson(
        res,
        (data) => (data as List).map((e) => Member.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<BioData>>> getBioData({
    String? employerNumber,
    String? staffNumber,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final queryParams = {
        'employer_number': employerNumber,
        'staff_number': staffNumber,
      };
      final res = await apiService.callService(
        requestType: RequestType.get,
        // queryParams: queryParams,
        endPoint: Env.getBiodata,
      );
      // return ApiResponse<Member>.fromJson(res, (data) => Member.fromJson(data));

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
}
