import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

abstract class AuthRepo {
  Future<Either<PFailure, ApiResponse<List<Message>>>> signup({
    required String terms,
    required String phone,
  });

<<<<<<< HEAD
  Future<Either<PFailure, ApiResponse<Message>>> verifyOTP({
=======
  Future<Either<PFailure, ApiResponse<List<Member>>>> verifyOTP({
>>>>>>> dev
    required String phone,
    required String otp,
  });

  Future<Either<PFailure, ApiResponse<List<Message>>>> addPassword({
    required String phone,
    required String password,
    required String confirmPassword,
  });

  Future<Either<PFailure, ApiResponse<Member>>> signIn({
    required String phone,
    required String password,
    required String deviceToken,
  });

  Future<Either<PFailure, ApiResponse<List<BioData>>>> getBioData({
    required String employerNumber,
    required String staffNumber,
  });

<<<<<<< HEAD
  Future<Either<PFailure, ApiResponse<List<Message>>>> updateFcmToken({
    required String token,
  });

  Future<Either<PFailure, ApiResponse<List<Message>>>> forgotPassword({
    required String? email,
    required String? phone,
=======
  Future<Either<PFailure, ApiResponse<List<Member>>>> forgotPassword({
    required String email,
>>>>>>> dev
  });

  Future<Either<PFailure, ApiResponse<List<Message>>>> resetPassword({
    required String otp,
    required String email,
    required String password,
    required String confirmPassword,
  });
}
