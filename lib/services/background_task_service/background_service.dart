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
    Timer.periodic(const Duration(seconds: 20), (timer) async {
      _logger.d("Background Service Running | ${timer.tick}");
      if (_networkService.hasConnection) {
        await _processRecordings();
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
      recordBox?.close();
    }
  }

  Future<void> _updateRecordingStatusAndUpload(
      Recording recording, Box<Recording> recordBox) async {
    try {
      _logger.d("Recorind status updated to on cloud: ${recording.id!}");
      _logger.d("Recording path: ${recording.path}");

      _updateValue(
          key: recording.key,
          status: uploading,
          recordBox: await checkBoxAndOpen(recordBox));

      await _recordService.uploadRecording(recording.path, recording.name,
          (progressStatus) async {
        var internalRecordBox = await Hive.openBox<Recording>(recordingBox);
        _logger.i("Map :${progressStatus.toMap()}");
        try {
          _updateValue(
              key: recording.key,
              status: uploading,
              progress: progressStatus.progress,
              recordBox: internalRecordBox);
          // Handle completion
          if (progressStatus.progress == 100.0) {
            _updateValue(
                key: recording.key,
                status: onCloud,
                progress: progressStatus.progress,
                recordBox: internalRecordBox);
          }
        } catch (e) {
          _logger.e("Failed to upload: ${e.toString()}");
          _updateValue(
              key: recording.key,
              status: onDevice,
              progress: progressStatus.progress,
              recordBox: recordBox);
        } finally {
          internalRecordBox.close();
        }
      });
      _updateValue(
          key: recording.key,
          status: onCloud,
          recordBox: await checkBoxAndOpen(recordBox));
    } catch (e) {
      _logger.e('Error updating recording status: $e');
      _updateValue(key: recording.key, status: onDevice, recordBox: recordBox);
    }
  }

  Future<Box<Recording>> checkBoxAndOpen(Box<Recording> recordbox) async {
    if (recordbox.isOpen) {
      return recordbox;
    }
    return await Hive.openBox<Recording>(recordingBox);
  }

  bool _updateValue(
      {required String key,
      required String status,
      double progress = 0.0,
      required Box<Recording> recordBox}) {
    Recording? recording = recordBox.get(key);
    if (recording != null) {
      recording.status = status;
      recording.progress = progress;
      recordBox.put(key, recording);
      return true;
    } else {
      _logger.d("Update failed: Key $key");
      return false;
    }
  }
}
