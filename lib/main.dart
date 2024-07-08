import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:swaram_ai/app/app.bottomsheets.dart';
import 'package:swaram_ai/app/app.dialogs.dart';
import 'package:swaram_ai/app/app.hive.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/services/background_task_service/background_service.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@pragma("vm:entry-point")
void onStart(ServiceInstance serviceInstance) async {
  DartPluginRegistrant.ensureInitialized();
  await setupHive();
  await setupLocator();
  BackgroundService().init();
}

@pragma("vm:entry-point")
Future<bool> onIosBackground(ServiceInstance serviceInstance) async {
  DartPluginRegistrant.ensureInitialized();
  return false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  await setupHive();
  locator.registerLazySingleton<GlobalKey<ScaffoldMessengerState>>(
      () => GlobalKey<ScaffoldMessengerState>());

  await FlutterBackgroundService().configure(
    iosConfiguration: IosConfiguration(
        autoStart: true, onForeground: onStart, onBackground: onIosBackground),
    androidConfiguration: AndroidConfiguration(
        onStart: onStart, isForegroundMode: false, autoStart: true),
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state!.setLocale(locale: locale);
  }

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    final box = Hive.box('settings');
    final languageCode = box.get('language_code', defaultValue: 'en');
    _locale = Locale(languageCode);
  }

  setLocale({required Locale locale}) {
    final box = Hive.box('settings');
    box.put('language_code', locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
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
