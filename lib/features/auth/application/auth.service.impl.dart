import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/response/api.response.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

final AuthService authService = Get.put(AuthServiceImpl());

class AuthServiceImpl implements AuthService {
  @override
  Future<Either<PFailure, ApiResponse<List<Member>>>> addPassword({
    required String phone,
    required String password,
    required String confirmPassword,
  }) {
    return authRepo.addPassword(
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Member>>>> forgotPassword({
    required String? email,
    required String? phone,
  }) {
    return authRepo.forgotPassword(email: email, phone: phone);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Member>>>> resetPassword({
    required String otp,
    required String? email,
    required String? phone,
    required String password,
    required String confirmPassword,
  }) {
    return authRepo.resetPassword(
      otp: otp,
      email: email,
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> signIn({
    required String phone,
    required String password,
  }) {
    return authRepo.signIn(phone: phone, password: password);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Member>>>> signup({
    required String terms,
    required String phone,
  }) {
    return authRepo.signup(terms: terms, phone: phone);
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> verifyOTP({
    required String phone,
    required String otp,
  }) {
    return authRepo.verifyOTP(phone: phone, otp: otp);
  }
}
