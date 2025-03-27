import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/domain/models/member.model.dart';
import 'package:oldmutual_pensions_app/features/profile/data/repos/profile.repo.dart';
import 'package:oldmutual_pensions_app/features/profile/profile.dart';

final ProfileRepo profileRepo = Get.put(ProfileRepoImpl());

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<Either<PFailure, ApiResponse<Message>>> changePassword() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await profileDs.changePassword(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Message>>> deleteAccount() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await profileDs.deleteAccount(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Member>>> getProfile() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await profileDs.getProfile(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Message>>> logout() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await profileDs.logout(),
    );
  }
}
