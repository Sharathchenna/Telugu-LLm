import 'dart:async';
import 'package:hive/hive.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/services/network_service.dart';
import 'package:swaram_ai/services/record_service.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class BackgroundService {
  final _networkService = locator<NetworkService>();
  final _recordService = locator<RecordService>();
  final _logger = getLogger("Background service");

  void init() async {
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      _logger.d("Background Service Running | ${timer.tick}");
      if (_networkService.hasConnection) {
        _processRecordings();
      }
      _networkService.cancel();
    });
  }

  Future<void> _processRecordings() async {
    Box<Recording>? recordBox;
    try {
      recordBox = await Hive.openBox<Recording>(recordingBox);
      // _logger.i("Process Recording");
      List<Recording> recordingsToUpdate = recordBox.values
          .where((element) => element.status == onDevice)
          .toList();

      for (var recording in recordingsToUpdate) {
        _logger.d("Recording: ${recording.name}");
        await _updateRecordingStatusAndUpload(recording, recordBox);
      }
    } catch (e) {
      _logger.e('Error processing recordings: $e');
    } finally {
      recordBox!.close();
    }
  }

  Future<void> _updateRecordingStatusAndUpload(
      Recording recording, Box<Recording> recordBox) async {
    try {
      recording.status = uploading;
      _updateValue(
          key: recording.key, updatedValue: recording, recordBox: recordBox);
      _logger.d("Recorind status updated to on cloud: ${recording.id!}");
      // Start the uploading process here
      await _recordService.uploadRecording(recording.path, recording.name);

      recording.status = onCloud;
      _updateValue(
          key: recording.key, updatedValue: recording, recordBox: recordBox);
    } catch (e) {
      _logger.e('Error updating recording status: $e');
      recording.status = onDevice;
      _updateValue(
          key: recording.key, updatedValue: recording, recordBox: recordBox);
    }
  }

  Future<bool> _updateValue(
      {required String key,
      required Recording updatedValue,
      required Box<Recording> recordBox}) async {
    Recording? recording = recordBox.get(key);
    if (recording != null) {
      recordBox.put(key, updatedValue);
      return true;
    } else {
      _logger.d("Update failed: Key $key");
      return false;
    }
  }
}
