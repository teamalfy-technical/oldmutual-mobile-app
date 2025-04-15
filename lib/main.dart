import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oldmutual_pensions_app/core/bindings/bindings.dart';
import 'package:oldmutual_pensions_app/core/l10n/l10n.dart';
import 'package:oldmutual_pensions_app/core/theme/app.theme.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/firebase_options_dev.dart' as dev;
import 'package:oldmutual_pensions_app/firebase_options_prod.dart' as prod;
import 'package:oldmutual_pensions_app/flavor.config.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

import 'features/notification/presentation/vm/notification.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();
  final currentEnv = await Environment.current();
  print("Connecting to ${currentEnv.apiBaseUrl}");
  await GetStorage.init();
  await initFirebaseApp();
  FirebaseMessaging.onBackgroundMessage(
    _backgroundHandler,
  ); // Set the background handler
  runApp(MyApp());
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PInactivityWrapper(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Old Mutual Pensions',
            useInheritedMediaQuery: true,
            locale: Get.deviceLocale,
            navigatorKey: appNavigatorKey,
            scaffoldMessengerKey: scaffoldMessengerKey,
            translations: AppTranslations(), // Add translations
            fallbackLocale: const Locale('en', 'US'), // Fallback language
            defaultTransition: Transition.native,
            // transitionDuration: const Duration(milliseconds: PAppSize.s700),
            enableLog: true,
            logWriterCallback: LocalLogger.write,
            initialRoute: AppPages.initial,
            initialBinding: InitialBinding(),
            getPages: AppPages.routes,
            theme: PAppTheme.lightTheme,
            darkTheme: PAppTheme.darkTheme,
            themeMode: ThemeMode.light,
            scrollBehavior: const CupertinoScrollBehavior(),
          );
        },
      ),
    );
  }
}

Future<void> initFirebaseApp() async {
  final currentEnv = await Environment.current();
  switch (currentEnv) {
    case EnvironmentType.dev:
      await Firebase.initializeApp(
        options: dev.DefaultFirebaseOptions.currentPlatform,
      );
      break;
    default:
      await Firebase.initializeApp(
        options: prod.DefaultFirebaseOptions.currentPlatform,
      );
  }
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseMessaging.instance.getInitialMessage();
  await PNotificationService().init();
}

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  debugPrint("Handling background message: ${message.data}");
  // Process the incoming message and perform appropriate actions
  debugPrint("Title: ${message.notification?.title}}");
  debugPrint("Body: ${message.notification?.body}");
  debugPrint("Data: ${message.data}");
  if (message.notification?.title != null &&
      message.notification?.body != null) {
    PNotificationService.showBigTextNotification(
      title: message.notification!.title!,
      body: message.notification!.body!,
      payload: message.data,
    );
  }
}
