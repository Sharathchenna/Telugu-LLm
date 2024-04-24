import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swaram_ai/app/app.bottomsheets.dart';
import 'package:swaram_ai/app/app.dialogs.dart';
import 'package:swaram_ai/app/app.hive.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  await setupHive();
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
