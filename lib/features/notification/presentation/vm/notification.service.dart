// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// class TNotificationService {
//   TNotificationService._();

//   static initializeFCM() async {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: true,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       matchesyLogger.d('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       matchesyLogger.d('User granted provisional permission');
//     } else {
//       matchesyLogger.d('User declined or has not accepted permission');
//     }
//     final token = await messaging.getToken();
//     await messaging.setAutoInitEnabled(true);
//     matchesyLogger.d("FCM Token: $token");
//     // Store the token on your server for sending targeted messages
//   }

//   static configureFCMListeners() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Handle incoming data message when the app is in the foreground
//       matchesyLogger.d("Data message received: ${message.data}");
//       // Extract data and perform custom actions
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Handle incoming data message when the app is in the background or terminated
//       matchesyLogger.d("Data message opened: ${message.data}");
//       // Extract data and perform custom actions
//     });
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

int id = 0;

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform = MethodChannel(
  'oldmutual.com/oldmutual_notifications',
);

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  onSelectedNotification(notificationResponse);
  // if (notificationResponse.payload != null) {
  //   TNotificationService.handleNotificationClick(null,
  //       NotificationType.fromJson(jsonDecode(notificationResponse.payload!)));
  // }
}

onSelectedNotification(NotificationResponse notificationResponse) {
  switch (notificationResponse.notificationResponseType) {
    // triggers when the notification is tapped
    case NotificationResponseType.selectedNotification:
      if (notificationResponse.payload != null) {
        selectNotificationStream.add(notificationResponse.payload);
        // PNotificationService.handleNotificationClick(
        //   null,
        //   NotificationType.fromJson(jsonDecode(notificationResponse.payload!)),
        // );
      }
      break;
    case NotificationResponseType.selectedNotificationAction:
      if (notificationResponse.actionId == navigationActionId) {
        selectNotificationStream.add(notificationResponse.payload);
      }
      break;
  }
}

class PNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static final PNotificationService _instance =
      PNotificationService._internal();

  PNotificationService._internal();

  factory PNotificationService() {
    return _instance;
  }

  //instance of FlutterLocalNotificationsPlugin
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? _token;
  String get token => _token!;

  //static int id = 0;

  Future init() async {
    final settings = await _requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await initializePlatformSettings();
      _registerForegroundMessageHandler();
      _registerInteractionHandler();
    }

    // await getToken();
    // _firebaseMessaging.subscribeToTopic('test');
  }

  Future<String> getToken() async {
    String? token;
    if (Platform.isIOS) {
      // String? apnsToken = await _firebaseMessaging.getAPNSToken();
      String? apnsToken = await _firebaseMessaging.getToken();
      if (apnsToken != null) {
        token = apnsToken;
      } else {
        await Future<void>.delayed(const Duration(seconds: 3));
        //apnsToken = await _firebaseMessaging.getAPNSToken();
        apnsToken = await _firebaseMessaging.getToken();
        if (apnsToken != null) {
          token = apnsToken;
        }
      }
      pensionAppLogger.w("FCM Token (iOS): $token");
    } else {
      token = (await _firebaseMessaging.getToken());
      if (token != null) {
        token = token;
      } else {
        await Future.delayed(const Duration(seconds: 1));
        token = (await _firebaseMessaging.getToken())!;
        _firebaseMessaging.onTokenRefresh.listen(
          (token) {
            token = token;
          },
          onError: (err) {
            pensionAppLogger.e("Error FCM Token: $err");
          },
        );
      }
      pensionAppLogger.w("FCM Token (Android): $token");
    }

    pensionAppLogger.d("FCM Token: ${await _firebaseMessaging.getToken()}");
    return token!;
  }

  /// save token to backend server
  /// cache it on device
  Future<void> saveToken() async {
    final token = await getToken();
    PSecureStorage().saveData(PSecureStorage().deviceTokenKey, token);
    final result = await authService.updateFcmToken(token: await getToken());
    result.fold(
      (err) => pensionAppLogger.e(err.getMessage()),
      (res) => pensionAppLogger.d(res.data),
    );
  }

  requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> initializePlatformSettings() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final List<DarwinNotificationCategory> darwinNotificationCategories =
        <DarwinNotificationCategory>[
          DarwinNotificationCategory(
            darwinNotificationCategoryText,
            actions: <DarwinNotificationAction>[
              DarwinNotificationAction.text(
                'text_1',
                'Action 1',
                buttonTitle: 'Send',
                placeholder: 'Placeholder',
              ),
            ],
          ),
          DarwinNotificationCategory(
            darwinNotificationCategoryPlain,
            actions: <DarwinNotificationAction>[
              DarwinNotificationAction.plain('id_1', 'Action 1'),
              DarwinNotificationAction.plain(
                'id_2',
                'Action 2 (destructive)',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.destructive,
                },
              ),
              DarwinNotificationAction.plain(
                navigationActionId,
                'Action 3 (foreground)',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.foreground,
                },
              ),
              DarwinNotificationAction.plain(
                'id_4',
                'Action 4 (auth required)',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.authenticationRequired,
                },
              ),
            ],
            options: <DarwinNotificationCategoryOption>{
              DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
            },
          ),
        ];

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          // onDidReceiveLocalNotification: (
          //   int id,
          //   String? title,
          //   String? body,
          //   String? payload,
          // ) async {
          //   didReceiveLocalNotificationStream.add(
          //     ReceivedNotification(
          //       id: id,
          //       title: title,
          //       body: body,
          //       payload: payload,
          //     ),
          //   );
          // },
          notificationCategories: darwinNotificationCategories,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) {
        // debugPrint(
        //     '------foreground notification click payload------- ${jsonEncode(jsonDecode(notificationResponse.payload!))}');
        // handleNotificationClick(
        //     null,
        //     NotificationType.fromJson(
        //         notificationResponse.payload));
        onSelectedNotification(notificationResponse);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<NotificationSettings> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      announcement: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined permission');
    }

    return settings;
  }

  // setup and send notification
  static Future<void> showBigTextNotification({
    required String title,
    required String body,
    required Map<String, dynamic> payload,
  }) async {
    final BigTextStyleInformation bigTextStyleInformation =
        BigTextStyleInformation(
          body,
          htmlFormatBigText: true,
          contentTitle: title,
          htmlFormatContentTitle: true,
          summaryText: '',
          htmlFormatSummaryText: true,
        );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          PAppConstant.notificationChannelKey,
          PAppConstant.notificationChannelName,
          channelDescription: PAppConstant.notificationChannelDescription,
          playSound: true,
          enableVibration: true,
          //sound: const RawResourceAndroidNotificationSound('notification'),
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          // actions: [
          //   const AndroidNotificationAction('action_1', 'Action 1',
          //       showsUserInterface: true),
          //   const AndroidNotificationAction('action_2', 'Action 2',

          //       showsUserInterface: true),
          // ],
          styleInformation: bigTextStyleInformation,
        );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          //sound: 'notification.wav',
          presentBadge: true,
          presentSound: true,
          presentAlert: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
        );

    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id++,
      title,
      body,
      notificationDetails,
      payload: jsonEncode(payload),
    );
  }

  // // Navigate user to page when notification is tapped
  // Future<void> _messageOpenedHandler(RemoteMessage message) async {
  //   debugPrint("Handling message opened: ${message.data}");
  //   TNotificationService.handleNotificationClick(
  //       Get.context, NotificationType.fromJson(message.data));
  // }

  // register foreground notification handler
  void _registerForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(" -----foreground message received-----");
      debugPrint("Title: ${message.notification?.title}}");
      debugPrint("Body: ${message.notification?.body}");
      debugPrint("Data: ${message.data}");
      // TNotificationService.handleNotificationClick(
      //     Get.context, NotificationType.fromJson(message.data));
      if (message.notification?.title != null &&
          message.notification?.body != null) {
        showBigTextNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: message.data,
        );
      }
    });
  }

  Future<void> _registerInteractionHandler() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // handleNotificationClick(
      //   null,
      //   NotificationType.fromJson(initialMessage.data),
      // );
    }
    // when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //handleNotificationClick(null, NotificationType.fromJson(message.data));
    });
  }

  static void handleNotificationClick(
    BuildContext? context,
    //NotificationType notificationType,
  ) {
    // NotificationType notificationType = NotificationType.fromJson(message.data);
    // switch (notificationType.type) {
    //   case TAppConstant.chat:
    //     {
    //       THelperFunction.switchScreen(
    //           destination: Routes.chatMessagePage,
    //           args: [notificationType.fromUserId, null]);
    //       break;
    //     }

    //   case TAppConstant.opinion:
    //   case TAppConstant.post:
    //     {
    //       THelperFunction.switchScreen(
    //           destination: Routes.viewMatchPage, args: notificationType.postId);
    //       break;
    //     }

    //   case TAppConstant.subComment:
    //     {
    //       THelperFunction.switchScreen(
    //           destination: Routes.viewOpinionPage,
    //           args: [notificationType.postId, notificationType.opinionId]);
    //       break;
    //     }

    //   case TAppConstant.follow:
    //     {
    //       THelperFunction.switchScreen(
    //           destination: Routes.viewProfilePage,
    //           args: [true, notificationType.followerId]);
    //       break;
    //     }
    //   case TAppConstant.gymBuddy:
    //     {
    //       THelperFunction.switchScreen(destination: Routes.notificationPage);
    //       break;
    //     }
    // }
  }
}
