import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

final AuthRepo authRepo = Get.put(AuthRepoImpl());

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<PFailure, ApiResponse<List<Member>>>> addPassword({
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await authDs.addPassword(
            phone: phone,
            password: password,
            confirmPassword: confirmPassword,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Member>>>> forgotPassword({
    required String? email,
    required String? phone,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await authDs.forgotPassword(email: email, phone: phone),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Member>>>> resetPassword({
    required String otp,
    required String? email,
    required String? phone,
    required String password,
    required String confirmPassword,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await authDs.resetPassword(
            otp: otp,
            email: email,
            phone: phone,
            password: password,
            confirmPassword: confirmPassword,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> signIn({
    required String phone,
    required String password,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.signIn(phone: phone, password: password);
        pensionAppLogger.d(res);
        PSecureStorage().saveAuthResponse(res);
        return res;
      },
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Member>>>> signup({
    required String terms,
    required String phone,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await authDs.signup(terms: terms, phone: phone),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> verifyOTP({
    required String phone,
    required String otp,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await authDs.verifyOTP(phone: phone, otp: otp),
    );
  }
}
