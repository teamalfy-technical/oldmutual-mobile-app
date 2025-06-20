import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

final AuthService authService = Get.put(AuthServiceImpl());

class AuthServiceImpl implements AuthService {
  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> addPassword({
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
  Future<Either<PFailure, ApiResponse<List<Message>>>> forgotPassword({
    required String email,
  }) {
    return authRepo.forgotPassword(email: email);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> resetPassword({
    required String password,
    required String confirmPassword,
  }) {
    return authRepo.resetPassword(
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
  Future<Either<PFailure, ApiResponse<List<Message>>>> signup({
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

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> updateFcmToken({
    required String token,
  }) {
    return authRepo.updateFcmToken(token: token);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<BioData>>>> getBioData() {
    return authRepo.getBioData();
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> verifyForgotPasswordOTP({
    required String email,
    required String otp,
  }) {
    return authRepo.verifyForgotPasswordOTP(email: email, otp: otp);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return authRepo.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
