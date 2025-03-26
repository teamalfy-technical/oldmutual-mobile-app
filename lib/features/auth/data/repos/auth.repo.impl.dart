import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

final AuthRepo authRepo = Get.put(AuthRepoImpl());

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> addPassword({
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
<<<<<<< HEAD
  Future<Either<PFailure, ApiResponse<List<Message>>>> forgotPassword({
    required String? email,
    required String? phone,
=======
  Future<Either<PFailure, ApiResponse<List<Member>>>> forgotPassword({
    required String email,
>>>>>>> dev
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await authDs.forgotPassword(email: email),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> resetPassword({
    required String otp,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await authDs.resetPassword(
            otp: otp,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> signIn({
    required String phone,
    required String password,
    required String deviceToken,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.signIn(
          phone: phone,
          password: password,
          deviceToken: deviceToken,
        );
        pensionAppLogger.d(res);
        PSecureStorage().saveAuthResponse(res.data);
        return res;
      },
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> signup({
    required String terms,
    required String phone,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await authDs.signup(terms: terms, phone: phone),
    );
  }

  @override
<<<<<<< HEAD
  Future<Either<PFailure, ApiResponse<Message>>> verifyOTP({
=======
  Future<Either<PFailure, ApiResponse<List<Member>>>> verifyOTP({
>>>>>>> dev
    required String phone,
    required String otp,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await authDs.verifyOTP(phone: phone, otp: otp),
    );
  }

  @override
<<<<<<< HEAD
  Future<Either<PFailure, ApiResponse<List<Message>>>> updateFcmToken({
    required String token,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await authDs.updateFcmToken(token: token),
=======
  Future<Either<PFailure, ApiResponse<List<BioData>>>> getBioData({
    required String employerNumber,
    required String staffNumber,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await authDs.getBioData(
            employerNumber: employerNumber,
            staffNumber: staffNumber,
          ),
>>>>>>> dev
    );
  }
}
