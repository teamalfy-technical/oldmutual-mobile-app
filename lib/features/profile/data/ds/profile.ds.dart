import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

abstract class ProfileDs {
  Future<ApiResponse<Member>> getProfile();
  Future<ApiResponse<Message>> changePassword();
  Future<ApiResponse<Message>> deleteAccount();
  Future<ApiResponse<Message>> logout();
}
