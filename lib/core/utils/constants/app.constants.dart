class PAppConstant {
  PAppConstant._();

  static const String privacyPolicyLink =
      'https://matchesy.com/privacy-policy.html';

  static const String termsOfServiceLink =
      'https://matchesy.com/terms-of-service.html';

  // static const String unifiedAppLink = 'https://www.onelink.to/matchesy/';
  static const String unifiedAppLink = 'https://matchesy.com';
  static const String inviteFriendsMsg =
      'Hello friend, I found this useful which can help us connect better. Download it here ${PAppConstant.unifiedAppLink} and join me have a chat.';
  static const String placeHolderUrl =
      'https://surgassociates.com/wp-content/uploads/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.jpg';

  static const String video = 'video';
  static const String image = 'image';

  static const int media = 1;
  static const int text = 2;
  static const int pageNumber = 1;
  static const int pageSize = 10;
  static const String chatType = 'chat';
  static const String postType = 'post';
  // static const goldTitle = 'Gold';
  // static const silverTitle = 'Silver';
  // static const bronzeTitle = 'Bronze';

  static int notificationChannelId = 001;
  static String notificationChannelKey = "Hubchat";
  static String notificationChannelName = "Hubchat notifications";
  static String notificationChannelDescription =
      "Notification channel to receive notifications on Hubchat app";

  // Go router state keys
  static const String fromNumber = 'from_number';
  static const String toNumber = 'to_number';
  static const String message = 'message';
  static const String messages = 'messages';
  static const String chats = 'chat_messages';
}
