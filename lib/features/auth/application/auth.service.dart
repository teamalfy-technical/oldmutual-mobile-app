import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

abstract class AuthService {
  Future<Either<PFailure, ApiResponse<List<Member>>>> signup({
    required String terms,
    required String phone,
  });

  Future<Either<PFailure, ApiResponse<List<Member>>>> verifyOTP({
    required String phone,
    required String otp,
  });

  Future<Either<PFailure, ApiResponse<List<Member>>>> addPassword({
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

  Future<Either<PFailure, ApiResponse<List<Member>>>> forgotPassword({
    required String email,
  });

  Future<Either<PFailure, ApiResponse<List<Member>>>> resetPassword({
    required String otp,
    required String email,
    required String password,
    required String confirmPassword,
  });
}
