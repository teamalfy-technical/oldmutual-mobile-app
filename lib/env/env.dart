// lib/env/env.dart
import 'package:envied/envied.dart';
import 'package:oldmutual_pensions_app/flavor.config.dart';

part 'env.g.dart';

class ApiConfig {
  late EnvironmentType currentEnv;
  static Future<EnvironmentType> get baseUrl async =>
      await Environment.current();
}

@Envied(obfuscate: true)
//@Envied(path: '.env.dev')
abstract class Env {
  static late String baseUrl;

  static Future<void> init() async {
    baseUrl = (await Environment.current()).apiBaseUrl;
  }

  // @EnviedField(
  //   // defaultValue: 'http://pensions.teamalfy.co.uk/api',
  //   defaultValue: currentEnv.apiBaseUrl,
  //   obfuscate: true,
  // )
  // static final String baseUrl = _Env.baseUrl;

  ///              All endpoints for [Pensions App]
  /// ------------------------------------------------------------
  /// ============================================================
  ///
  ///
  /// -------------------- Self-Service Endpoints Starts Here ------------------------- ///
  ///
  ///

  /// [PensionBaseUrl] user endpoint
  @EnviedField(
    defaultValue: 'https://app.oldmutual.com.gh/api',
    obfuscate: true,
  )
  static final String pensionsBaseUrl = _Env.pensionsBaseUrl;

  /// [SelfServiceBaseUrl] user endpoint
  @EnviedField(
    defaultValue:
        'https://omself-service-dev-api.up.railway.app/api/self-service',
    obfuscate: true,
  )
  static final String selfServiceBaseUrl = _Env.selfServiceBaseUrl;

  /// -------------------- Self-Service  Endpoints Ends Here ------------------------- ///

  /// -------------------- Authentication Endpoints Starts Here ------------------------- ///

  // /// [Login] user endpoint
  // @EnviedField(defaultValue: '/login', obfuscate: true)
  // static final String signin = _Env.signin;

  // /// [Signup] endpoint
  // @EnviedField(defaultValue: '/signup', obfuscate: true)
  // static final String signup = _Env.signup;

  // /// [VerifyOTP] endpoint
  // @EnviedField(defaultValue: '/verify-otp', obfuscate: true)
  // static final String verifyOTP = _Env.verifyOTP;
  /// [SelfServiceLogin] user endpoint
  @EnviedField(defaultValue: '/self-service/login', obfuscate: true)
  static final String login = _Env.login;

  /// [CreateAccount] user endpoint
  @EnviedField(defaultValue: '/self-service/create-account', obfuscate: true)
  static final String createAccount = _Env.createAccount;

  /// [VerifyOtp] user endpoint
  @EnviedField(defaultValue: '/self-service/verify-otp', obfuscate: true)
  static final String verifyOtp = _Env.verifyOtp;

  /// [ResendOtp] user endpoint
  @EnviedField(defaultValue: '/self-service/resend-otp', obfuscate: true)
  static final String resendOtp = _Env.resendOtp;

  /// [VerifyResetOtp] user endpoint
  @EnviedField(defaultValue: '/self-service/verify-reset-otp', obfuscate: true)
  static final String verifyResetOtp = _Env.verifyResetOtp;

  /// [ForgotPassword] user endpoint
  @EnviedField(defaultValue: '/self-service/forgot-password', obfuscate: true)
  static final String forgotPassword = _Env.forgotPassword;

  /// [VerifyGhanaCard] user endpoint
  @EnviedField(
    defaultValue: '/self-service/mobile-verify-ghanacard',
    obfuscate: true,
  )
  static final String verifyGhanaCard = _Env.verifyGhanaCard;

  /// [CheckCardVerificationStatus] user endpoint
  @EnviedField(
    defaultValue: '/self-service/mobile/check-verification-status',
    obfuscate: true,
  )
  static final String checkGhanaCardVerificationStatus =
      _Env.checkGhanaCardVerificationStatus;

  /// [ResetPassword] endpoint
  @EnviedField(defaultValue: '/reset-password', obfuscate: true)
  static final String resetPassword = _Env.resetPassword;

  /// [AddPassword] endpoint
  @EnviedField(defaultValue: '/add-password', obfuscate: true)
  static final String addPassword = _Env.addPassword;

  // /// [ForgotPassword] endpoint
  // @EnviedField(defaultValue: '/forgot-password', obfuscate: true)
  // static final String forgotPassword = _Env.forgotPassword;

  // /// [VerifyForgotPasswordOTP] endpoint
  // @EnviedField(defaultValue: '/verify-reset-otp', obfuscate: true)
  // static final String verifyForgotPasswordOTP = _Env.verifyForgotPasswordOTP;

  // /// [ResetPassword] endpoint
  // @EnviedField(defaultValue: '/reset-password', obfuscate: true)
  // static final String resetPassword = _Env.resetPassword;

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

  /// [UpdateBeneficiary] endpoint
  @EnviedField(defaultValue: '/beneficiary/update', obfuscate: true)
  static final String updateBeneficiary = _Env.updateBeneficiary;

  /// [DeleteBeneficiary] endpoint
  @EnviedField(defaultValue: '/delete/beneficiary', obfuscate: true)
  static final String deleteBeneficiary = _Env.deleteBeneficiary;

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

  /// [GetContributionsMonthly] endpoint
  @EnviedField(defaultValue: '/contributions/monthly', obfuscate: true)
  static final String getMonthlyContributions = _Env.getMonthlyContributions;

  /// [GetLatestContribution] endpoint
  @EnviedField(defaultValue: '/contributions/latest', obfuscate: true)
  static final String getLatestContribution = _Env.getLatestContribution;

  /// [GenerateReport] endpoint
  @EnviedField(defaultValue: '/generate/report-pdf', obfuscate: true)
  static final String generateReport = _Env.generateReport;

  /// [GenerateReportsV2] endpoint
  @EnviedField(defaultValue: '/reports', obfuscate: true)
  static final String generateReportsV2 = _Env.generateReportsV2;

  /// [DownloadReport] endpoint
  @EnviedField(defaultValue: '/reports/download', obfuscate: true)
  static final String downloadReport = _Env.downloadReport;

  /// [CheckReportStatus] endpoint
  @EnviedField(defaultValue: '/reports/check-status', obfuscate: true)
  static final String checkReportStatus = _Env.checkReportStatus;

  /// [GetReport] endpoint
  @EnviedField(defaultValue: '/reports', obfuscate: true)
  static final String getReports = _Env.getReports;

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
  /// -------------------- Pension Endpoints Starts Here ------------------------- ///
  ///

  @EnviedField(defaultValue: '/pensions-summary', obfuscate: true)
  static final String getPensionSummary = _Env.getPensionSummary;

  /// [GetMemberSchemes] endpoint
  @EnviedField(defaultValue: '/member/schemes', obfuscate: true)
  static final String getMemberSchemes = _Env.getMemberSchemes;

  /// [SelectedMemberSchemes] endpoint
  @EnviedField(defaultValue: '/member/select-scheme', obfuscate: true)
  static final String getSelectedMemberScheme = _Env.getSelectedMemberScheme;

  /// [DownloadPensionCertificate] endpoint
  @EnviedField(defaultValue: '/pensions/get-certificate', obfuscate: true)
  static final String downloadPensionCertificate =
      _Env.downloadPensionCertificate;

  /// -------------------- Pension Endpoints Ends Here ------------------------- ///
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

  /// [DownloadFactsheet] endpoint
  @EnviedField(defaultValue: '/factsheets', obfuscate: true)
  static final String downloadFactsheet = _Env.downloadFactsheet;

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
  ///
  ///
  /// -------------------- Redemptions & Transfers Endpoints Starts Here ------------------------- ///

  /// [CreateRedemptionRequest] endpoint
  @EnviedField(defaultValue: '/redemption/request', obfuscate: true)
  static final String createRedemptionRequest = _Env.createRedemptionRequest;

  /// [GetRedemptions] endpoint
  @EnviedField(defaultValue: '/redemptions', obfuscate: true)
  static final String getRedemptions = _Env.getRedemptions;

  /// [CreatePortingRequest] endpoint
  @EnviedField(defaultValue: '/porting/requests', obfuscate: true)
  static final String createPortingRequest = _Env.createPortingRequest;

  /// -------------------- Redemptions & Transfers Endpoints Ends Here ------------------------- ///
  ///
  ///
  /// -------------------- Policies Endpoints Starts Here ------------------------- ///

  /// [GetPolicies] endpoint
  @EnviedField(defaultValue: '/policies', obfuscate: true)
  static final String getPolicies = _Env.getPolicies;

  /// [GetPolicySummary] endpoint
  @EnviedField(defaultValue: '/policy-summary', obfuscate: true)
  static final String getPolicySummary = _Env.getPolicySummary;

  /// [GetPolicy] endpoint
  @EnviedField(defaultValue: '/policy/policy-details', obfuscate: true)
  static final String getPolicy = _Env.getPolicy;

  /// [GetPolicyBeneficiaries] endpoint
  @EnviedField(defaultValue: '/policy-beneficiaries', obfuscate: true)
  static final String getPolicyBeneficiaries = _Env.getPolicyBeneficiaries;

  /// [GetPolicyTransaction] endpoint
  @EnviedField(defaultValue: '/policy-transaction', obfuscate: true)
  static final String getPolicyTransaction = _Env.getPolicyTransaction;

  /// [GeneratePolicyReport] endpoint
  @EnviedField(defaultValue: '/policy-reports', obfuscate: true)
  static final String generatePolicyReport = _Env.generatePolicyReport;

  /// [GetPolicyReports] endpoint
  @EnviedField(defaultValue: '/generated-policy-reports', obfuscate: true)
  static final String getPolicyReports = _Env.getPolicyReports;

  /// [InvestmentStatementDownload] endpoint
  @EnviedField(defaultValue: '/life/investment-report', obfuscate: true)
  static final String downloadInvestmentStatement =
      _Env.downloadInvestmentStatement;

  /// [PremiumStatementDownload] endpoint
  @EnviedField(defaultValue: '/life/premium-statement', obfuscate: true)
  static final String downloadPremiumStatement = _Env.downloadPremiumStatement;

  /// [PolicyDocumentDownload] endpoint
  @EnviedField(defaultValue: '/life/policy-document', obfuscate: true)
  static final String downloadPolicyDocument = _Env.downloadPolicyDocument;

  /// [GetPaymentMethods] endpoint
  @EnviedField(defaultValue: '/policy/telco/pay-methods', obfuscate: true)
  static final String getPaymentMethods = _Env.getPaymentMethods;

  /// [SubmitClaimRequest] endpoint
  @EnviedField(defaultValue: '/policy/claim-request', obfuscate: true)
  static final String submitClaimRequest = _Env.submitClaimRequest;

  /// -------------------- Policies Endpoints Ends Here ------------------------- ///
  ///
  /// -------------------- Upsell Endpoints Starts Here ------------------------- ///

  /// [GetUpsellRecommendations] endpoint
  @EnviedField(defaultValue: '/upsell/member-recommendations', obfuscate: true)
  static final String getUpsellRecommendations = _Env.getUpsellRecommendations;

  /// [UpgradeRecommendation] endpoint
  @EnviedField(defaultValue: '/upsell/upgrade-product', obfuscate: true)
  static final String upgradeRecommendation = _Env.upgradeRecommendation;

  /// [DismissRecommendation] endpoint
  @EnviedField(defaultValue: '/upsell/dismise-recommendation', obfuscate: true)
  static final String dismissRecommendation = _Env.dismissRecommendation;

  /// [GetAcceptedRecommendations] endpoint
  @EnviedField(
    defaultValue: '/upsell/accepted-recommendations',
    obfuscate: true,
  )
  static final String getAcceptedRecommendations =
      _Env.getAcceptedRecommendations;

  /// -------------------- Upsell Endpoints Ends Here ------------------------- ///
  ///
  /// -------------------- Cross-Sell Endpoints Starts Here ------------------------- ///

  /// [GetRecommendations] endpoint
  @EnviedField(
    defaultValue: '/cross-sell/member-recommendations',
    obfuscate: true,
  )
  static final String getRecommendations = _Env.getRecommendations;

  /// [ApplyRecommendations] endpoint
  @EnviedField(
    defaultValue: '/cross-sell/apply-recommendation',
    obfuscate: true,
  )
  static final String applyRecommendation = _Env.applyRecommendation;

  /// -------------------- Cross-Sell Endpoints Ends Here ------------------------- ///
  ///
  /// -------------------- Pay Now Endpoints Starts Here ------------------------- ///

  /// [InitiatePensionsPayment] endpoint
  @EnviedField(defaultValue: '/initiate/pensions-payment', obfuscate: true)
  static final String initiatePensionsPayment = _Env.initiatePensionsPayment;

  /// [InitiatePolicyPayment] endpoint
  @EnviedField(
    defaultValue: '/initiate/life-insurance-payment',
    obfuscate: true,
  )
  static final String initiatePolicyPayment = _Env.initiatePolicyPayment;

  /// [GetPensionsPayment] endpoint
  @EnviedField(defaultValue: '/payment/pensions-payments', obfuscate: true)
  static final String getPensionsPayment = _Env.getPensionsPayment;

  /// [GetPolicyPayment] endpoint
  @EnviedField(defaultValue: '/payment/life-payments', obfuscate: true)
  static final String getPolicyPayment = _Env.getPolicyPayment;

  /// -------------------- Pay Now Endpoints Ends Here ------------------------- ///
  ///
  /// -------------------- Affluent Endpoints Starts Here ------------------------- ///

  /// [GetAffluentRelationshipOfficer] endpoint
  @EnviedField(defaultValue: '/affluent/relationship-officer', obfuscate: true)
  static final String getAffluentRelationshipOfficer =
      _Env.getAffluentRelationshipOfficer;

  /// [GetContentCategories] endpoint
  @EnviedField(defaultValue: '/affluent/content-categories', obfuscate: true)
  static final String getContentCategories = _Env.getContentCategories;

  /// [GetContentCategory] endpoint
  @EnviedField(defaultValue: '/affluent/content-category', obfuscate: true)
  static final String getContentCategory = _Env.getContentCategory;

  /// [DeleteContentCategory] endpoint
  @EnviedField(
    defaultValue: '/affluent/content-category/delete',
    obfuscate: true,
  )
  static final String deleteContentCategory = _Env.deleteContentCategory;

  /// [GetContents] endpoint
  @EnviedField(defaultValue: '/affluent/contents', obfuscate: true)
  static final String getContents = _Env.getContents;

  /// [GetContentById] endpoint
  @EnviedField(defaultValue: '/affluent/content', obfuscate: true)
  static final String getContentById = _Env.getContentById;

  /// [GetContentBySlug] endpoint
  @EnviedField(defaultValue: '/affluent/content/slug', obfuscate: true)
  static final String getContentBySlug = _Env.getContentBySlug;

  /// [GetBookmarkedContents] endpoint
  @EnviedField(defaultValue: '/affluent/bookmarks', obfuscate: true)
  static final String getBookmarkedContents = _Env.getBookmarkedContents;

  /// [BookmarkContents] endpoint
  @EnviedField(defaultValue: '/affluent/bookmark', obfuscate: true)
  static final String bookmarkContent = _Env.bookmarkContent;

  /// [GetBookmarkContents] endpoint
  @EnviedField(defaultValue: '/affluent/bookmark', obfuscate: true)
  static final String getBookmarkedContent = _Env.getBookmarkedContent;

  /// [GetBookmarkedContentCount] endpoint
  @EnviedField(defaultValue: '/affluent/bookmark/count', obfuscate: true)
  static final String getBookmarkedContentCount =
      _Env.getBookmarkedContentCount;

  /// [DeleteBookedContent] endpoint
  @EnviedField(defaultValue: '/affluent/bookmark/delete', obfuscate: true)
  static final String deleteBookedContent = _Env.deleteBookedContent;

  /// [ClearBookmarkedContents] endpoint
  @EnviedField(defaultValue: '/affluent/bookmarks/clear', obfuscate: true)
  static final String clearBookmarkedContents = _Env.clearBookmarkedContents;

  /// -------------------- Affluent Endpoints Ends Here ------------------------- ///
}
