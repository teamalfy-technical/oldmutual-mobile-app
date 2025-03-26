import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

abstract class AuthDs {
  Future<ApiResponse<List<Message>>> signup({
    required String terms,
    required String phone,
  });

<<<<<<< HEAD
  Future<ApiResponse<Message>> verifyOTP({
=======
  Future<ApiResponse<List<Member>>> verifyOTP({
>>>>>>> dev
    required String phone,
    required String otp,
  });

  Future<ApiResponse<List<Message>>> addPassword({
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

<<<<<<< HEAD
  Future<ApiResponse<List<Message>>> updateFcmToken({required String token});

  Future<ApiResponse<List<Message>>> forgotPassword({
    required String? email,
    required String? phone,
  });
=======
  Future<ApiResponse<List<Member>>> forgotPassword({required String email});
>>>>>>> dev

  Future<ApiResponse<List<Message>>> resetPassword({
    required String otp,
    required String email,
    required String password,
    required String confirmPassword,
  });
}
