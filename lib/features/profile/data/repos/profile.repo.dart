import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

abstract class ProfileRepo {
  Future<Either<PFailure, ApiResponse<Member>>> getProfile();
  Future<Either<PFailure, ApiResponse<Message>>> changePassword();
  Future<Either<PFailure, ApiResponse<Message>>> deleteAccount();
  Future<Either<PFailure, ApiResponse<List<Message>>>> logout();
}
