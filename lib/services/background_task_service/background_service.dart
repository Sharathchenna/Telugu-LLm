import 'dart:async';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/services/hive_service.dart';
import 'package:swaram_ai/services/network_service.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class BackgroundService {
  final _networkService = locator<NetworkService>();
  final _hiveService = locator<HiveService>();
  final _logger = getLogger("Background service");

  void init() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      // _logger.i("Running | Background Service | ${timer.tick}");
      if (_networkService.hasConnection) {
        _processRecordings();
      }
      _networkService.cancel();
    });
  }

  Future<void> _processRecordings() async {
    try {
      // _logger.i("Process Recording");
      List<Recording> recordingsToUpdate = _hiveService
          .getSavedRecordings()
          .where((element) => element.status == onDevice)
          .toList();
      // _logger.i("Fetched Recording: ${recordingsToUpdate.toString()}");

      for (var recording in recordingsToUpdate) {
        _logger.i("Recording: $recording");
        await _updateRecordingStatusAndUpload(recording);
      }
    } catch (e) {
      _logger.e('Error processing recordings: $e');
    }
  }

  Future<void> _updateRecordingStatusAndUpload(Recording recording) async {
    try {
      recording.status = uploading;
      _hiveService.updateValue(key: recording.key, updatedValue: recording);
      _logger.i("Recorind status updated to on cloud: ${recording.id!}");
      // Start the uploading process here
    } catch (e) {
      _logger.e('Error updating recording status: $e');
      recording.status = onDevice;
      _hiveService.updateValue(key: recording.key, updatedValue: recording);
    }
  }
}
