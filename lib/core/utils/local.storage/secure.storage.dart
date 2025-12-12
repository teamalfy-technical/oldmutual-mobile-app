import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

/// Hybrid secure storage that uses:
/// - FlutterSecureStorage for sensitive data (encrypted)
/// - GetStorage for non-sensitive data (fast, unencrypted)
class PSecureStorage {
  static final PSecureStorage _instance = PSecureStorage._internal();

  factory PSecureStorage() => _instance;

  PSecureStorage._internal();

  // GetStorage for non-sensitive data
  final _storage = GetStorage();

  // FlutterSecureStorage for sensitive data
  final _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // Storage keys
  // Non-sensitive data (stored in GetStorage)
  final String onboardingKey = 'onboarding';
  final String biometricKey = 'enabled_biometric_key';

  // Sensitive data (stored in FlutterSecureStorage)
  final String authResKey = 'secure_auth_res_key';
  final String tokenResKey = 'secure_token_res_key';
  final String bioDataKey = 'secure_bio_data_key';
  final String emailKey = 'secure_email_key';
  final String firstNameKey = 'secure_first_name_key';
  final String deviceTokenKey = 'secure_device_token_key';
  final String biometricPasswordKey = 'secure_biometric_password_key';

  bool _migrationCompleted = false;

  /// Initialize storage and perform migration if needed
  Future<void> init() async {
    // await _migrateToSecureStorage();
  }

  /// Migrate existing data from GetStorage to FlutterSecureStorage
  /// This ensures existing users don't lose their data
  Future<void> _migrateToSecureStorage() async {
    if (_migrationCompleted) return;

    try {
      final oldKeys = {
        'auth_res_key': authResKey,
        'bio_data_key': bioDataKey,
        'email_key': emailKey,
        'device_token_key': deviceTokenKey,
        'enabled_face_id_key': biometricKey,
      };

      for (final entry in oldKeys.entries) {
        final oldKey = entry.key;
        final newKey = entry.value;

        // Check if data exists in old storage
        final oldValue = _storage.read(oldKey);
        if (oldValue != null) {
          // Migrate to new storage
          if (oldKey == 'enabled_face_id_key') {
            // This stays in GetStorage but with new key
            await _storage.write(biometricKey, oldValue);
          } else {
            // Migrate to FlutterSecureStorage
            if (oldValue is Map || oldValue is List) {
              await _secureStorage.write(
                key: newKey,
                value: jsonEncode(oldValue),
              );
            } else {
              await _secureStorage.write(
                key: newKey,
                value: oldValue.toString(),
              );
            }
          }

          // Remove old data
          await _storage.remove(oldKey);
          pensionAppLogger.i('Migrated $oldKey to $newKey');
        }
      }

      _migrationCompleted = true;
      pensionAppLogger.i('Storage migration completed successfully');
    } catch (e) {
      pensionAppLogger.e('Error during storage migration: $e');
    }
  }

  // ========== NON-SENSITIVE DATA METHODS (GetStorage) ==========

  /// Generic function to save non-sensitive data into GetStorage
  Future<void> saveData<T>(String key, T value) async =>
      await _storage.write(key, value);

  /// Generic function to read non-sensitive data from GetStorage
  T? readData<T>(String key) => _storage.read<T>(key);

  /// Save biometric enabled/disabled flag
  Future<void> saveBiometric<T>(T value) async =>
      await _storage.write(biometricKey, value);

  /// Check if biometric authentication is enabled
  bool get isBiometricEnabled {
    return _storage.read(biometricKey) ?? false;
  }

  // ========== SENSITIVE DATA METHODS (FlutterSecureStorage) ==========

  /// Save auth response securely
  Future<void> saveAuthResponse(Map<String, dynamic> value) async {
    await _secureStorage.write(key: authResKey, value: jsonEncode(value));
  }

  /// Save bio data securely
  Future<void> saveBioData(Map<String, dynamic> value) async {
    await _secureStorage.write(key: bioDataKey, value: jsonEncode(value));
  }

  /// Save user email securely
  Future<void> saveUserEmail(String value) async {
    await _secureStorage.write(key: emailKey, value: value);
  }

  /// Save user first name securely
  Future<void> saveUserFirstName(String value) async {
    await _secureStorage.write(key: firstNameKey, value: value);
  }

  /// Save device token securely
  Future<void> saveDeviceToken(String value) async {
    await _secureStorage.write(key: deviceTokenKey, value: value);
  }

  /// Save password securely for biometric authentication
  Future<void> saveBiometricPassword(String password) async {
    await _secureStorage.write(key: biometricPasswordKey, value: password);
  }

  // ========== READ METHODS (FlutterSecureStorage) ==========

  /// Get user email from secure storage
  Future<String?> getUserEmail() async {
    return await _secureStorage.read(key: emailKey);
  }

  /// Get user first name from secure storage
  Future<String?> getUserFirstName() async {
    return await _secureStorage.read(key: firstNameKey);
  }

  /// Get auth response from secure storage
  Future<Member?> getAuthResponse() async {
    try {
      final data = await _secureStorage.read(key: authResKey);
      if (data == null) return null;
      return Member.fromJson(jsonDecode(data) as Map<String, dynamic>);
    } catch (e) {
      pensionAppLogger.e('Error reading auth response: $e');
      return null;
    }
  }

  /// Get bio data from secure storage
  Future<BioData?> getBioData() async {
    try {
      final data = await _secureStorage.read(key: bioDataKey);
      if (data == null) return null;
      return BioData.fromJson(jsonDecode(data) as Map<String, dynamic>);
    } catch (e) {
      pensionAppLogger.e('Error reading bio data: $e');
      return null;
    }
  }

  /// Get biometric password from secure storage
  Future<String?> getBiometricPassword() async {
    return await _secureStorage.read(key: biometricPasswordKey);
  }

  /// Get device token from secure storage
  Future<String?> getDeviceToken() async {
    return await _secureStorage.read(key: deviceTokenKey);
  }

  // ========== DELETE/REMOVE METHODS ==========

  /// Remove non-sensitive data from GetStorage
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Remove sensitive data from FlutterSecureStorage
  Future<void> removeSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  /// Delete biometric password
  Future<void> deleteBiometricPassword() async {
    await _secureStorage.delete(key: biometricPasswordKey);
  }

  /// Clear all data from both storages
  Future<void> clearAll() async {
    await _storage.erase();
    await _secureStorage.deleteAll();
  }
}
