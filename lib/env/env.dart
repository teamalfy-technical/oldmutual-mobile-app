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
      defaultValue: 'https://matchesy001.bsite.net/api',
      obfuscate: true)
  static final String baseUrl = _Env.baseUrl;

  ///              All endpoints for [Matchesy]
  /// ------------------------------------------------------------
  /// ============================================================
  ///

  /// -------------------- User Endpoints Starts Here ------------------------- ///

  /// [Login] user endpoint
  @EnviedField(defaultValue: '/User/Login', obfuscate: true)
  static final String loginUser = _Env.loginUser;

  /// [CreateUser] endpoint
  @EnviedField(defaultValue: '/User/CreateUser', obfuscate: true)
  static final String createUser = _Env.createUser;

  /// [VerifyPinAsync] endpoint
  @EnviedField(defaultValue: '/User/VerifyPinAsync', obfuscate: true)
  static final String verifyPinAsync = _Env.verifyPinAsync;

  /// [ResendPin] endpoint
  @EnviedField(defaultValue: '/User/ResendCode', obfuscate: true)
  static final String resendPin = _Env.resendPin;

  /// [GetAllUsers] endpoint
  @EnviedField(defaultValue: '/User/GetAllUsers', obfuscate: true)
  static final String getAllUsers = _Env.getAllUsers;

  /// [GetUserById] endpoint
  @EnviedField(defaultValue: '/User/GetUserById', obfuscate: true)
  static final String getUserById = _Env.getUserById;

  /// [ForgotPassword] endpoint
  @EnviedField(defaultValue: '/User/ForgotPassword', obfuscate: true)
  static final String forgotPassword = _Env.forgotPassword;

  /// [UpdatePassword] endpoint
  @EnviedField(defaultValue: '/User/UpdatePassword', obfuscate: true)
  static final String updatePassword = _Env.updatePassword;

  /// [IsUsernameAvailable] endpoint
  @EnviedField(defaultValue: '/User/IsUsernameAvailable', obfuscate: true)
  static final String isUsernameAvailable = _Env.isUsernameAvailable;

  /// [GetAllCategories] endpoint
  @EnviedField(defaultValue: '/User/GetAllCategories', obfuscate: true)
  static final String getAllCategories = _Env.getAllCategories;

  /// [OnboardUser] endpoint
  @EnviedField(defaultValue: '/User/OnboardUser', obfuscate: true)
  static final String onboardUser = _Env.onboardUser;

  /// [UploadProfilePicture] endpoint
  @EnviedField(defaultValue: '/User/UploadProfilePicture', obfuscate: true)
  static final String uploadProfilePicture = _Env.uploadProfilePicture;

  /// [ConfirmDeleteAccount] endpoint
  @EnviedField(defaultValue: '/User/ConfirmDeleteAccount', obfuscate: true)
  static final String confirmDeleteAccount = _Env.confirmDeleteAccount;

  /// [VerifyPinAndDeleteAccount] endpoint
  @EnviedField(defaultValue: '/User/VerifyPinAndDeleteAccount', obfuscate: true)
  static final String verifyPinAndDeleteAccount =
      _Env.verifyPinAndDeleteAccount;

  /// -------------------- User Endpoints Ends Here ------------------------- ///

  /// [GetListOfDefaultAttributes] endpoint
  @EnviedField(
      defaultValue: '/User/GetListOfDefaultAttributes', obfuscate: true)
  static final String getListOfDefaultAttributes =
      _Env.getListOfDefaultAttributes;

  /// [SubmitAttributes] endpoint
  @EnviedField(defaultValue: '/User/SubmitAttributes', obfuscate: true)
  static final String submitAttributes = _Env.submitAttributes;

  /// [GetCurrentUser] endpoint
  @EnviedField(defaultValue: '/User/GetCurrentUser', obfuscate: true)
  static final String getCurrentUser = _Env.getCurrentUser;

  /// [GetSuggestedUsers] endpoint
  @EnviedField(defaultValue: '/User/GetSuggestedUsers', obfuscate: true)
  static final String getSuggestedUsers = _Env.getSuggestedUsers;

  /// [UpdateFcmToken] endpoint
  @EnviedField(defaultValue: '/User/UpdateFcmToken', obfuscate: true)
  static final String updateFcmToken = _Env.updateFcmToken;

  /// [GetAllUsersICanMessage] endpoint
  @EnviedField(defaultValue: '/User/GetAllUsersICanMessage', obfuscate: true)
  static final String getAllUsersICanMessage = _Env.getAllUsersICanMessage;

  /// -------------------- Profile Endpoints Starts Here ------------------------- ///
  /// [FollowUser] endpoint
  @EnviedField(defaultValue: '/Profile/FollowUser', obfuscate: true)
  static final String followUser = _Env.followUser;

  /// [UnfollowUser] endpoint
  @EnviedField(defaultValue: '/Profile/UnfollowUser', obfuscate: true)
  static final String unfollowUser = _Env.unfollowUser;

  /// [ViewMyProfile] endpoint
  @EnviedField(defaultValue: '/Profile/ViewMyProfile', obfuscate: true)
  static final String viewMyProfile = _Env.viewMyProfile;

  /// [ViewProfile] endpoint
  @EnviedField(defaultValue: '/Profile/ViewProfile', obfuscate: true)
  static final String viewProfile = _Env.viewProfile;

  /// [EditProfile] endpoint
  @EnviedField(defaultValue: '/Profile/EditProfile', obfuscate: true)
  static final String editProfile = _Env.editProfile;

  /// [BlockUser] endpoint
  @EnviedField(defaultValue: '/Profile/BlockUser', obfuscate: true)
  static final String blockUser = _Env.blockUser;

  /// [UnBlockUser] endpoint
  @EnviedField(defaultValue: '/Profile/UnBlockUser', obfuscate: true)
  static final String unBlockUser = _Env.unBlockUser;

  /// [TogglePushNotification] endpoint
  @EnviedField(defaultValue: '/Profile/TogglePushNotification', obfuscate: true)
  static final String togglePushNotification = _Env.togglePushNotification;

  /// [ToggleEmailNotification] endpoint
  @EnviedField(
      defaultValue: '/Profile/ToggleEmailNotification', obfuscate: true)
  static final String toggleEmailNotification = _Env.toggleEmailNotification;

  /// -------------------- Profile Endpoints Ends Here -------------------------///

  /// -------------------- Post Endpoints Starts Here -------------------------///

  /// [CreateTextMatch] endpoint
  @EnviedField(defaultValue: '/Post/CreateTextMatch', obfuscate: true)
  static final String createTextMatch = _Env.createTextMatch;

  /// [CreateMediaMatch] endpoint
  @EnviedField(defaultValue: '/Post/CreateMediaMatch', obfuscate: true)
  static final String createMediaMatch = _Env.createMediaMatch;

  /// [VotePreferredMatchEntity] endpoint
  @EnviedField(defaultValue: '/Post/VotePreferredMatchEntity', obfuscate: true)
  static final String votePreferredMatchEntity = _Env.votePreferredMatchEntity;

  /// [UnVoteMatchEntity] endpoint
  @EnviedField(defaultValue: '/Post/UnVoteMatchEntity', obfuscate: true)
  static final String unVoteMatchEntity = _Env.unVoteMatchEntity;

  /// [CreateOpinion] endpoint
  @EnviedField(defaultValue: '/Post/CreateOpinion', obfuscate: true)
  static final String createOpinion = _Env.createOpinion;

  /// [CreateSubComment] endpoint
  @EnviedField(defaultValue: '/Post/CreateSubComment', obfuscate: true)
  static final String createSubComment = _Env.createSubComment;

  /// [LikeMatch] endpoint
  @EnviedField(defaultValue: '/Post/LikeMatch', obfuscate: true)
  static final String likeMatch = _Env.likeMatch;

  /// [UnLikeMatch] endpoint
  @EnviedField(defaultValue: '/Post/UnLikeMatch', obfuscate: true)
  static final String unLikeMatch = _Env.unLikeMatch;

  /// [LikeOpinion] endpoint
  @EnviedField(defaultValue: '/Post/LikeOpinion', obfuscate: true)
  static final String likeOpinion = _Env.likeOpinion;

  /// [UnLikeOpinion] endpoint
  @EnviedField(defaultValue: '/Post/UnLikeOpinion', obfuscate: true)
  static final String unLikeOpinion = _Env.unLikeOpinion;

  /// [LikeSubComment] endpoint
  @EnviedField(defaultValue: '/Post/LikeSubComment', obfuscate: true)
  static final String likeSubComment = _Env.likeSubComment;

  /// [UnLikeSubComment] endpoint
  @EnviedField(defaultValue: '/Post/UnLikeSubComment', obfuscate: true)
  static final String unLikeSubComment = _Env.unLikeSubComment;

  /// [GetPosts] endpoint
  @EnviedField(defaultValue: '/Post/GetPosts', obfuscate: true)
  static final String getPosts = _Env.getPosts;

  /// [NotInterested] endpoint
  @EnviedField(defaultValue: '/Post/NotInterested', obfuscate: true)
  static final String notInterested = _Env.notInterested;

  /// [DeletePost] endpoint
  @EnviedField(defaultValue: '/Post/DeletePost', obfuscate: true)
  static final String deletePost = _Env.deletePost;

  /// [DeleteOpinion] endpoint
  @EnviedField(defaultValue: '/Post/DeleteOpinion', obfuscate: true)
  static final String deleteOpinion = _Env.deleteOpinion;

  /// [DeleteSubComment] endpoint
  @EnviedField(defaultValue: '/Post/DeleteSubComment', obfuscate: true)
  static final String deleteSubComment = _Env.deleteSubComment;

  /// [GetPostById] endpoint
  @EnviedField(defaultValue: '/Post/GetPostById', obfuscate: true)
  static final String getPostById = _Env.getPostById;

  /// [GetOpinionById] endpoint
  @EnviedField(defaultValue: '/Post/GetOpinionById', obfuscate: true)
  static final String getOpinionById = _Env.getOpinionById;

  /// [ReportPost] endpoint
  @EnviedField(defaultValue: '/Post/ReportPost', obfuscate: true)
  static final String reportPost = _Env.reportPost;

  /// -------------------- Post Endpoints Ends Here -------------------------///

  /// -------------------- Notification Endpoints Starts Here -------------------------///

  /// [GetNotificationsForUser] endpoint
  @EnviedField(
      defaultValue: '/Notification/GetNotificationsForUser', obfuscate: true)
  static final String getNotificationsForUser = _Env.getNotificationsForUser;

  /// [ReadNotificationsForUser] endpoint
  @EnviedField(defaultValue: '/Notification/ReadNotification', obfuscate: true)
  static final String readNotificationsForUser = _Env.readNotificationsForUser;

  /// -------------------- Notification Endpoints Ends Here -------------------------///

  /// -------------------- Search Endpoints Starts Here -------------------------///

  /// [GetTrendingPosts] endpoint
  @EnviedField(defaultValue: '/Search/GetTrendingPosts', obfuscate: true)
  static final String getTrendingPosts = _Env.getTrendingPosts;

  /// [SearchUsers] endpoint
  @EnviedField(defaultValue: '/Search/SearchUsers', obfuscate: true)
  static final String searchUsers = _Env.searchUsers;

  /// -------------------- Search Endpoints Ends Here -------------------------///
  ///
  ///
  /// -------------------- Gym Buddy Endpoints Starts Here -------------------------///

  /// [UpdateIPAddress] endpoint
  @EnviedField(defaultValue: '/GymBuddy/UpdateIPAddress', obfuscate: true)
  static final String updateIPAddress = _Env.updateIPAddress;

  /// [UpdateGeolocation] endpoint
  @EnviedField(defaultValue: '/GymBuddy/UpdateGeoLocation', obfuscate: true)
  static final String updateGeolocation = _Env.updateGeolocation;

  /// [GetNearbyGymBuddies] endpoint
  @EnviedField(defaultValue: '/GymBuddy/GetNearbyGymBuddies', obfuscate: true)
  static final String getNearbyGymBuddies = _Env.getNearbyGymBuddies;

  /// [SendGymBuddyRequest] endpoint
  @EnviedField(defaultValue: '/GymBuddy/SendGymBuddyRequest', obfuscate: true)
  static final String sendGymBuddyRequest = _Env.sendGymBuddyRequest;

  /// [AcceptGymBuddyRequest] endpoint
  @EnviedField(defaultValue: '/GymBuddy/AcceptGymBuddyRequest', obfuscate: true)
  static final String acceptGymBuddyRequest = _Env.acceptGymBuddyRequest;

  /// [DeclineGymBuddyRequest] endpoint
  @EnviedField(
      defaultValue: '/GymBuddy/DeclineGymBuddyRequest', obfuscate: true)
  static final String declineGymBuddyRequest = _Env.declineGymBuddyRequest;

  /// [ToggleGymBuddyVisibility] endpoint
  @EnviedField(
      defaultValue: '/GymBuddy/ToggleGymBuddyVisibility', obfuscate: true)
  static final String toggleGymBuddyVisibility = _Env.toggleGymBuddyVisibility;

  /// -------------------- Gym Buddy Endpoints Ends Here -------------------------///

  /// -------------------- Chat Endpoints Starts Here -------------------------///

  /// [SendMessage] endpoint
  @EnviedField(defaultValue: '/DirectMessage/SendMessage', obfuscate: true)
  static final String sendMessage = _Env.sendMessage;

  /// [GetAllConversationsForCurrentUserAsync] endpoint
  @EnviedField(
      defaultValue: '/DirectMessage/GetAllConversationsForCurrentUserAsync',
      obfuscate: true)
  static final String getAllConversationsForCurrentUserAsync =
      _Env.getAllConversationsForCurrentUserAsync;

  /// [GetAllConversationsAsync] endpoint
  @EnviedField(
      defaultValue: '/DirectMessage/GetAllConversationsAsync', obfuscate: true)
  static final String getAllConversationsAsync = _Env.getAllConversationsAsync;

  /// [DeleteMessage] endpoint
  @EnviedField(defaultValue: '/DirectMessage/DeleteMessage', obfuscate: true)
  static final String deleteMessage = _Env.deleteMessage;

  /// -------------------- Chat Endpoints Ends Here -------------------------///

  /// [GetDeviceIPAddress] endpoint
  @EnviedField(defaultValue: 'https://api.ipify.org', obfuscate: true)
  static final String getDeviceIPAddress = _Env.getDeviceIPAddress;

  /// [GetCurrentCountryCode] endpoint
  @EnviedField(defaultValue: 'https://get.geojs.io/v1/ip/geo/', obfuscate: true)
  static final String getCurrentCountryCode = _Env.getCurrentCountryCode;
}
