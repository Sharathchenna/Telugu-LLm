// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:record/src/record.dart';
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/auth_service.dart';
import '../services/category_service.dart';
import '../services/client_service.dart';
import '../services/hive_service.dart';
import '../services/network_service.dart';
import '../services/record_service.dart';
import '../services/stopwatch_service.dart';
import '../services/timer_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => TimerService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ClientService());
  locator.registerLazySingleton(() => RecordService());
  locator.registerLazySingleton(() => CategoryService());
  locator.registerLazySingleton(() => NetworkService());
  locator.registerLazySingleton(() => HiveService());
  locator.registerLazySingleton(() => StopwatchService());
  locator.registerLazySingleton(() => AudioRecorder());
}
