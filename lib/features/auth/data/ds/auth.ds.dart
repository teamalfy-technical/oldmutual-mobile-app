import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

abstract class AuthDs {
  // Future<ApiResponse<List<Message>>> signup({
  //   required String terms,
  //   required String phone,
  // });

  // Future<ApiResponse<Member>> verifyOTP({
  //   required String phone,
  //   required String otp,
  // });

  Future<ApiResponse<List<Message>>> addPassword({
    required String phone,
    required String password,
    required String confirmPassword,
  });

  Future<ApiResponse<List<Message>>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<ApiResponse<List<BioData>>> getBioData();

  // Future<ApiResponse<Member>> signIn({
  //   required String phone,
  //   required String password,
  // });

  Future<ApiResponse<Member>> signIn({
    required String emailOrPhone,
    required String password,
  });

  Future<ApiResponse<Member>> signUp({
    required String email,
    required String phone,
    required String verificationToken,
    required String password,
    required String confirmPassword,
  });

  Future<ApiResponse<List<Message>>> verifySignupOtp({
    required String otp,
    required String otpRef,
  });

  Future<ApiResponse<Member>> resendOtp({required String otpRef});

  Future<ApiResponse<String>> verifyGhanaCard({required String cardNumber});

  Future<ApiResponse<String>> checkCardVerificationStatus({
    required String sessionId,
  });

  Future<ApiResponse<List<Message>>> updateFcmToken({required String token});

  Future<ApiResponse<Member>> forgotPassword({
    required String emailOrPhone,
  });

  Future<ApiResponse<Member>> verifyForgotPasswordOTP({
    required String otp,
    required String otpRef,
  });

  Future<ApiResponse<List<Message>>> resetPassword({
    required String password,
    required String confirmPassword,
  });
}
