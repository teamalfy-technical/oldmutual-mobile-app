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
      function: () async => await authDs.addPassword(
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> forgotPassword({
    required String emailOrPhone,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async =>
          await authDs.forgotPassword(emailOrPhone: emailOrPhone),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> resetPassword({
    required String password,
    required String confirmPassword,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await authDs.resetPassword(
        password: password,
        confirmPassword: confirmPassword,
      ),
    );
  }

  // @override
  // Future<Either<PFailure, ApiResponse<Member>>> signIn({
  //   required String phone,
  //   required String password,
  // }) async {
  //   return await customRepositoryWrapper.wrapRepositoryFunction(
  //     function: () async {
  //       final res = await authDs.signIn(phone: phone, password: password);
  //       PSecureStorage().saveAuthResponse(res.data?.toJson());
  //       return res;
  //     },
  //   );
  // }

  // @override
  // Future<Either<PFailure, ApiResponse<List<Message>>>> signup({
  //   required String terms,
  //   required String phone,
  // }) async {
  //   return await customRepositoryWrapper.wrapRepositoryFunction(
  //     function: () async => await authDs.signup(terms: terms, phone: phone),
  //   );
  // }

  // @override
  // Future<Either<PFailure, ApiResponse<Member>>> verifyOTP({
  //   required String phone,
  //   required String otp,
  // }) async {
  //   return await customRepositoryWrapper.wrapRepositoryFunction(
  //     function: () async {
  //       final res = await authDs.verifyOTP(phone: phone, otp: otp);
  //       PSecureStorage().saveAuthResponse(res.data?.toJson());
  //       return res;
  //     },
  //   );
  // }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> updateFcmToken({
    required String token,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await authDs.updateFcmToken(token: token),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<BioData>>>> getBioData({
    String? employerNumber,
    String? staffNumber,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await authDs.getBioData(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> verifyForgotPasswordOTP({
    required String emailOrPhone,
    required String otp,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.verifyForgotPasswordOTP(
          emailOrPhone: emailOrPhone,
          otp: otp,
        );
        PSecureStorage().saveAuthResponse(res.data?.toJson());
        return res;
      },
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        );

        return res;
      },
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> signUp({
    required String email,
    required String phone,
    required String verificationToken,
    required String password,
    required String confirmPassword,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.signUp(
          email: email,
          phone: phone,
          verificationToken: verificationToken,
          password: password,
          confirmPassword: confirmPassword,
        );
        return res;
      },
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> resendOtp({
    required String phone,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.resendOtp(phone: phone);
        return res;
      },
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> signIn({
    required String emailOrPhone,
    required String password,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.signIn(
          emailOrPhone: emailOrPhone,
          password: password,
        );
        PSecureStorage().saveAuthResponse(res.data?.toJson());
        return res;
      },
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<String>>> verifyGhanaCard({
    required String cardNumber,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.verifyGhanaCard(cardNumber: cardNumber);
        return res;
      },
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> verifySignupOtp({
    required String phone,
    required String otp,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.verifySignupOtp(phone: phone, otp: otp);
        return res;
      },
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<String>>> checkCardVerificationStatus({
    required String sessionId,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async {
        final res = await authDs.checkCardVerificationStatus(
          sessionId: sessionId,
        );
        return res;
      },
    );
  }
}
