import 'package:local_auth/local_auth.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class LocalAuthService {
  LocalAuthService._();
  static final LocalAuthService _instance = LocalAuthService._();
  factory LocalAuthService() => _instance;

  final LocalAuthentication _auth = LocalAuthentication();

  /// Check if device supports biometrics (Face ID / Touch ID)
  Future<bool> isBiometricAvailable() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      return canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    } catch (err) {
      pensionAppLogger.e('"Error checking biometrics: ${err.toString()}');
      return false;
    }
  }

  /// Get available biometric types (Face ID / Touch ID / Fingerprint)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      pensionAppLogger.e("Error getting biometrics: $e");
      return [];
    }
  }

  /// Authenticate user with biometrics (Face ID / Touch ID)
  Future<bool> authenticateUser() async {
    final isAvailable = await isBiometricAvailable();
    if (!isAvailable) return false;

    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to securely login',
        options: AuthenticationOptions(
          biometricOnly: true, // 🔒 Only biometrics, no device PIN fallback
          stickyAuth: true, // Keep auth session active while switching apps
          useErrorDialogs: true,
        ),
      );
      return didAuthenticate;
    } catch (err) {
      pensionAppLogger.e("Authentication error: ${err.toString()}");
      return false;
    }
  }

  /// Cancel any ongoing authentication
  Future<void> stopAuthentication() async {
    try {
      await _auth.stopAuthentication();
    } catch (e) {
      pensionAppLogger.e("Error stopping authentication: $e");
    }
  }
}
