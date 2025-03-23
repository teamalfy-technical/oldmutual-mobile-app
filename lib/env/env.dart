// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(obfuscate: true)
//@Envied(path: '.env.dev')
abstract class Env {
  /// App Base url for [Matchesy]
  /// https://55ac-102-89-47-237.ngrok-free.app/swagger/index.html
  @EnviedField(
    //defaultValue: 'https://3af3-102-88-69-24.ngrok-free.app/api',
    // defaultValue:
    //     'https://app-matchesy-api-sa-prod-001.azurewebsites.net/api',
    defaultValue: 'http://pensions.teamalfy.co.uk',
    obfuscate: true,
  )
  static final String baseUrl = _Env.baseUrl;

  ///              All endpoints for [Pensions App]
  /// ------------------------------------------------------------
  /// ============================================================
  ///

  /// -------------------- Authentication Endpoints Starts Here ------------------------- ///

  /// [Login] user endpoint
  @EnviedField(defaultValue: '/login', obfuscate: true)
  static final String login = _Env.login;

  /// [Signup] endpoint
  @EnviedField(defaultValue: '/signup', obfuscate: true)
  static final String signup = _Env.signup;

  /// [VerifyOTP] endpoint
  @EnviedField(defaultValue: '/verify-otp', obfuscate: true)
  static final String verifyOTP = _Env.verifyOTP;

  /// [AddPassword] endpoint
  @EnviedField(defaultValue: '/add-password', obfuscate: true)
  static final String addPassword = _Env.addPassword;

  /// [ForgotPassword] endpoint
  @EnviedField(defaultValue: '/forgot-password', obfuscate: true)
  static final String forgotPassword = _Env.forgotPassword;

  /// [ResetPassword] endpoint
  @EnviedField(defaultValue: '/reset-password', obfuscate: true)
  static final String resetPassword = _Env.resetPassword;

  /// -------------------- Authentication Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- User Endpoints Starts Here ------------------------- ///

  /// [Logout] endpoint
  @EnviedField(defaultValue: '/logout', obfuscate: true)
  static final String logout = _Env.logout;

  /// [Profile] endpoint
  @EnviedField(defaultValue: '/profile', obfuscate: true)
  static final String getUserProfile = _Env.getUserProfile;

  /// [ChangePassword] endpoint
  @EnviedField(defaultValue: '/change-password', obfuscate: true)
  static final String changePassword = _Env.changePassword;

  /// -------------------- User Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- Beneficiary Endpoints Starts Here ------------------------- ///

  /// [GetBeneficiaries] endpoint
  @EnviedField(defaultValue: '/beneficiaries', obfuscate: true)
  static final String getBeneficiaries = _Env.getBeneficiaries;

  /// -------------------- Beneficiary Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- Contribution Endpoints Starts Here ------------------------- ///

  /// [GetContributions] endpoint
  @EnviedField(defaultValue: '/contributions', obfuscate: true)
  static final String getContributions = _Env.getContributions;

  /// [GetContributionsSummary] endpoint
  @EnviedField(defaultValue: '/contributions/summary', obfuscate: true)
  static final String getContributionsSummary = _Env.getContributionsSummary;

  /// [GetContributionsYears] endpoint
  @EnviedField(defaultValue: '/contributions/years', obfuscate: true)
  static final String getContributionsYears = _Env.getContributionsYears;

  /// -------------------- Contribution Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- Biodata Endpoints Starts Here ------------------------- ///

  /// [GetBiodata] endpoint
  @EnviedField(defaultValue: '/biodata', obfuscate: true)
  static final String getBiodata = _Env.getBiodata;

  /// -------------------- Biodata Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- Notifications Endpoints Starts Here ------------------------- ///

  /// [EnableNotifications] endpoint
  @EnviedField(defaultValue: '/enable-notifications', obfuscate: true)
  static final String enableNotifications = _Env.enableNotifications;

  /// [DisableNotifications] endpoint
  @EnviedField(defaultValue: '/disable-notifications', obfuscate: true)
  static final String disableNotifications = _Env.disableNotifications;

  /// -------------------- Notifications Endpoints Ends Here ------------------------- ///
}
