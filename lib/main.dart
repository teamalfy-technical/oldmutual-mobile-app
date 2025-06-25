import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oldmutual_pensions_app/core/bindings/bindings.dart';
import 'package:oldmutual_pensions_app/core/l10n/l10n.dart';
import 'package:oldmutual_pensions_app/core/theme/app.theme.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart'
    show PInactivityService;
import 'package:oldmutual_pensions_app/firebase_options_dev.dart' as dev;
import 'package:oldmutual_pensions_app/firebase_options_prod.dart' as prod;
import 'package:oldmutual_pensions_app/flavor.config.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

import 'features/notification/presentation/vm/notification.service.dart';

Future<void> main() async {
  // runZonedGuarded(() async {

  await initDependencies();
  //   runApp(MyApp());
  // }, FirebaseCrashlytics.instance.recordError);
  runApp(MyApp());
}

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();
  final currentEnv = await Environment.current();
  pensionAppLogger.e("Connecting to ${currentEnv.apiBaseUrl}");
  await GetStorage.init();
  //🔐 Initialize Firebase first
  await initFirebaseApp();

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
    !kDebugMode,
  );

  // Optional: capture Flutter errors automatically
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => PInactivityService.instance.resetTimer(),
      // GestureDetector(
      //   onTap: () => PInactivityService.instance.resetTimer(),
      //   onPanDown: (_) => PInactivityService.instance.resetTimer(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My OldMutual GH',
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
