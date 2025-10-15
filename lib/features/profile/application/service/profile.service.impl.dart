import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/domain/models/member.model.dart';
import 'package:oldmutual_pensions_app/features/profile/profile.dart';

final ProfileService profileService = Get.put(ProfileServiceImpl());

class ProfileServiceImpl implements ProfileService {
  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> changePassword() {
    return profileRepo.changePassword();
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> deleteAccount() {
    return profileRepo.deleteAccount();
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> getProfile() {
    return profileRepo.getProfile();
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> logout() {
    return profileRepo.logout();
  }
}
