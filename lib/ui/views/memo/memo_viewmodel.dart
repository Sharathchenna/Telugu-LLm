import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/services/hive_service.dart';

class MemoViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _hiveService = locator<HiveService>();

  void navigateBack() => _navigationService.back();

  Future<Iterable<Recording>> getRecordings() async =>
      _hiveService.getSavedRecordings();

  Future<void> refreshItems() async {
    await getRecordings();
    rebuildUi();
  }
}
