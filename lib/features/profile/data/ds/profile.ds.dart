import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

abstract class ProfileDs {
  Future<ApiResponse<Member>> getProfile();
  Future<ApiResponse<List<Message>>> changePassword();
  Future<ApiResponse<List<Message>>> deleteAccount();
  Future<ApiResponse<List<Message>>> logout();
}
