import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

final AuthDs authDs = Get.put(AuthDsImpl());

class AuthDsImpl implements AuthDs {
  @override
  Future<ApiResponse<List<Member>>> addPassword({
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
    required String? email,
    required String? phone,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({'email': email, 'phone': phone});
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
  Future<ApiResponse<List<Member>>> resetPassword({
    required String otp,
    required String? email,
    required String? phone,
    required String password,
    required String confirmPassword,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'otp': otp,
        'email': email,
        'phone': phone,
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
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'phone': phone,
        'password': password,
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
  Future<ApiResponse<List<Member>>> signup({
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
      return ApiResponse<List<Member>>.fromJson(
        res,
        (data) => (data as List).map((e) => Member.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<Member>> verifyOTP({
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
      return ApiResponse<Member>.fromJson(res, (data) => Member.fromJson(data));
    });
  }
}
