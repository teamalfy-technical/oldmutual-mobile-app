import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oldmutual_pensions_app/core/bindings/bindings.dart';
import 'package:oldmutual_pensions_app/core/l10n/l10n.dart';
import 'package:oldmutual_pensions_app/core/theme/app.theme.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

Future<void> main() async {
  await GetStorage.init();
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
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pensions App',
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
          themeMode: ThemeMode.system,
          scrollBehavior: const CupertinoScrollBehavior(),
        );
      },
    );
  }
}
