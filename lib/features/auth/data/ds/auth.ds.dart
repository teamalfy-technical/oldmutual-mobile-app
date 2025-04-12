import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

abstract class AuthDs {
  Future<ApiResponse<List<Message>>> signup({
    required String terms,
    required String phone,
  });

  Future<ApiResponse<Member>> verifyOTP({
    required String phone,
    required String otp,
  });

  Future<ApiResponse<List<Message>>> addPassword({
    required String phone,
    required String password,
    required String confirmPassword,
  });

  Future<ApiResponse<List<BioData>>> getBioData();

  Future<ApiResponse<Member>> signIn({
    required String phone,
    required String password,
  });

  Future<ApiResponse<List<Message>>> updateFcmToken({required String token});

  Future<ApiResponse<List<Message>>> forgotPassword({required String email});

  Future<ApiResponse<Member>> verifyForgotPasswordOTP({
    required String otp,
    required String email,
  });

  Future<ApiResponse<List<Message>>> resetPassword({
    required String password,
    required String confirmPassword,
  });
}
