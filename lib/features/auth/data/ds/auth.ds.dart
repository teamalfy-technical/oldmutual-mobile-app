import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

abstract class AuthDs {
  Future<ApiResponse<List<Member>>> signup({
    required String terms,
    required String phone,
  });

  Future<ApiResponse<List<Member>>> verifyOTP({
    required String phone,
    required String otp,
  });

  Future<ApiResponse<List<Member>>> addPassword({
    required String phone,
    required String password,
    required String confirmPassword,
  });

  Future<ApiResponse<List<BioData>>> getBioData({
    required String employerNumber,
    required String staffNumber,
  });

  Future<ApiResponse<Member>> signIn({
    required String phone,
    required String password,
    required String deviceToken,
  });

  Future<ApiResponse<List<Member>>> forgotPassword({required String email});

  Future<ApiResponse<List<Member>>> resetPassword({
    required String otp,
    required String email,
    required String password,
    required String confirmPassword,
  });
}
