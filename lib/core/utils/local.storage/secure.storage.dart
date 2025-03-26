import 'package:get_storage/get_storage.dart';
import 'package:oldmutual_pensions_app/features/auth/domain/models/member.model.dart';

class PSecureStorage {
  static final PSecureStorage _instance = PSecureStorage._internal();

  factory PSecureStorage() => _instance;

  PSecureStorage._internal();

  final _storage = GetStorage();

  final String onboardingKey = 'onboarding';
  final String authResKey = 'auth_res_key';
  final String businessProfileKey = 'business_profile_key';

  /// Generic function to save data into [GetStorage]
  Future<void> saveData<T>(String key, T value) async =>
      await _storage.write(key, value);

  /// Generic function to read data from [GetStorage]
  T? readData<T>(String key) => _storage.read<T>(key);

  /// Generic function to save auth response into [GetStorage]
  Future<void> saveAuthResponse<T>(T value) async =>
      await _storage.write(authResKey, value);

  /// Generic function to save auth response into [GetStorage]
  // Future<void> saveBusinessProfile<T>(T value) async =>
  //     await _storage.write(businessProfileKey, value);

  // /// Non-generic function to read auth response data from [GetStorage]
  // BusinessProfile? getBusinessProfile() {
  //   if (_storage.read(businessProfileKey) == null) {
  //     return null;
  //   }
  //   return BusinessProfile.fromJson(
  //       _storage.read(businessProfileKey) as Map<String, dynamic>);
  // }

  // /// Non-generic function to read auth response data from [GetStorage]
  Member? getAuthResponse() {
    if (_storage.read(authResKey) == null) {
      return null;
    }
    return Member.fromJson(_storage.read(authResKey) as Map<String, dynamic>);
  }

  /// Generic function to remove data from [GetStorage]
  Future<void> removeData(String key) async => await _storage.remove(key);

  /// Generic function to clear all data from [GetStorage]
  Future<void> clearAll() async => await _storage.erase();
}
