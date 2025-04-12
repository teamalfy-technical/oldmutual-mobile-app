// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(obfuscate: true)
//@Envied(path: '.env.dev')
abstract class Env {
  @EnviedField(
    // defaultValue: 'http://pensions.teamalfy.co.uk/api',
    defaultValue: 'https://old-mutual-api-production.up.railway.app/api',
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
  static final String signin = _Env.signin;

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

  /// [VerifyForgotPasswordOTP] endpoint
  @EnviedField(defaultValue: '/verify/reset-password/otp', obfuscate: true)
  static final String verifyForgotPasswordOTP = _Env.verifyForgotPasswordOTP;

  /// [ResetPassword] endpoint
  @EnviedField(defaultValue: '/reset-password', obfuscate: true)
  static final String resetPassword = _Env.resetPassword;

  /// -------------------- Authentication Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- User Endpoints Starts Here ------------------------- ///

  /// [UpdateFcmToken] endpoint
  @EnviedField(defaultValue: '/store/fcm-token', obfuscate: true)
  static final String updateFcmToken = _Env.updateFcmToken;

  /// [Logout] endpoint
  @EnviedField(defaultValue: '/logout', obfuscate: true)
  static final String logout = _Env.logout;

  /// [Profile] endpoint
  @EnviedField(defaultValue: '/profile', obfuscate: true)
  static final String getUserProfile = _Env.getUserProfile;

  /// [ChangePassword] endpoint
  @EnviedField(defaultValue: '/change-password', obfuscate: true)
  static final String changePassword = _Env.changePassword;

  /// [DeleteAccount] endpoint
  @EnviedField(defaultValue: '/delete-account', obfuscate: true)
  static final String deleteAccount = _Env.deleteAccount;

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

  /// [GetContributedYears] endpoint
  @EnviedField(defaultValue: '/contributed/years', obfuscate: true)
  static final String getContributedYears = _Env.getContributedYears;

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
  @EnviedField(defaultValue: '/Enable-notifications', obfuscate: true)
  static final String enableNotifications = _Env.enableNotifications;

  /// [DisableNotifications] endpoint
  @EnviedField(defaultValue: '/Disable-notifications', obfuscate: true)
  static final String disableNotifications = _Env.disableNotifications;

  /// [GetNotifications] endpoint
  @EnviedField(defaultValue: '/notifications', obfuscate: true)
  static final String getNotifications = _Env.getNotifications;

  /// [GetReadNotification] endpoint
  @EnviedField(
    defaultValue: '/notifications/read-notification',
    obfuscate: true,
  )
  static final String getReadNotification = _Env.getReadNotification;

  /// [MarkNotificationAsRead] endpoint
  @EnviedField(defaultValue: '/notifications/mark-as-read', obfuscate: true)
  static final String markNotificationAsRead = _Env.markNotificationAsRead;

  /// [MarkNotificationAsRead] endpoint
  @EnviedField(
    defaultValue: '/notifications/mark-selected-as-read',
    obfuscate: true,
  )
  static final String markNotificationsAsRead = _Env.markNotificationsAsRead;

  /// [GetUnreadNotificationCount] endpoint
  @EnviedField(defaultValue: '/notifications/unread-count', obfuscate: true)
  static final String getUnreadNotificationCount =
      _Env.getUnreadNotificationCount;

  /// -------------------- Notifications Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- Scheme Endpoints Starts Here ------------------------- ///

  /// [GetMemberSchemes] endpoint
  @EnviedField(defaultValue: '/member/scheme', obfuscate: true)
  static final String getMemberSchemes = _Env.getMemberSchemes;

  /// [SelectedMemberSchemes] endpoint
  @EnviedField(defaultValue: '/member/select-scheme', obfuscate: true)
  static final String getSelectedMemberScheme = _Env.getSelectedMemberScheme;

  /// -------------------- Scheme Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- Performance Endpoints Starts Here ------------------------- ///

  /// [GetPerformances] endpoint
  @EnviedField(defaultValue: '/all/performances', obfuscate: true)
  static final String getPerformances = _Env.getPerformances;

  /// [AddStorePerformance] endpoint
  @EnviedField(defaultValue: '/store/performance', obfuscate: true)
  static final String addPerformance = _Env.addPerformance;

  /// [UpdateStorePerformance] endpoint
  @EnviedField(defaultValue: '/update/performance', obfuscate: true)
  static final String updatePerformance = _Env.updatePerformance;

  /// [DeleteStorePerformance] endpoint
  @EnviedField(defaultValue: '/delete/performance', obfuscate: true)
  static final String deletePerformance = _Env.deletePerformance;

  /// -------------------- Performance Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- Fund-Composition Endpoints Starts Here ------------------------- ///

  /// [GetFundComposition] endpoint
  @EnviedField(defaultValue: '/all/fund-composition', obfuscate: true)
  static final String getFundComposition = _Env.getFundComposition;

  /// [AddFundComposition] endpoint
  @EnviedField(defaultValue: '/store/fund-composition', obfuscate: true)
  static final String addFundComposition = _Env.addFundComposition;

  /// [UpdateFundComposition ] endpoint
  @EnviedField(defaultValue: '/update/fund-composition', obfuscate: true)
  static final String updateFundComposition = _Env.updateFundComposition;

  /// [DeleteFundComposition] endpoint
  @EnviedField(defaultValue: '/delete/fund-composition', obfuscate: true)
  static final String deleteFundComposition = _Env.deleteFundComposition;

  /// -------------------- Fund-Composition Endpoints Ends Here ------------------------- ///
}
