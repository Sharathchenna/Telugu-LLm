import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:swaram_ai/app/app.bottomsheets.dart';
import 'package:swaram_ai/app/app.dialogs.dart';
import 'package:swaram_ai/app/app.hive.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
// import 'package:swaram_ai/services/background_task_service/background_service.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';

// @pragma("vm:entry-point")
// void onStart(ServiceInstance serviceInstance) async {
//   DartPluginRegistrant.ensureInitialized();
//   await setupHive();
//   await setupLocator();
//   BackgroundService().init();
// }

// @pragma("vm:entry-point")
// Future<bool> onIosBackground(ServiceInstance serviceInstance) async {
//   DartPluginRegistrant.ensureInitialized();
//   return false;
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  await setupHive();
  locator.registerLazySingleton<GlobalKey<ScaffoldMessengerState>>(
      () => GlobalKey<ScaffoldMessengerState>());

  // await FlutterBackgroundService().configure(
  //   iosConfiguration: IosConfiguration(
  //       autoStart: true, onForeground: onStart, onBackground: onIosBackground),
  //   androidConfiguration: AndroidConfiguration(
  //       onStart: onStart, isForegroundMode: false, autoStart: true),
  // );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      scaffoldMessengerKey: locator<GlobalKey<ScaffoldMessengerState>>(),
      theme: ThemeData(
        scaffoldBackgroundColor: kcBackgroundColor,
        primaryColor: kcPrimaryBlueColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kcBackgroundColor,
          centerTitle: true,
          elevation: 5,
        ),
      ),
      initialRoute: Routes.startupView,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
