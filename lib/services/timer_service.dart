import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.bottomsheets.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/services/hive_service.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class TimerService with ListenableServiceMixin {
  final _recordingStarted = ReactiveValue<bool>(false);
  final _videoRecordigStarted = ReactiveValue<bool>(false);

  late final AudioRecorder _recorder;
  String fileName = "";

  final _logger = getLogger("TimerService");
  final _hiveService = locator<HiveService>();
  final _bottomSheetService = locator<BottomSheetService>();

  bool get isRecordingStarted => _recordingStarted.value;

  // void setRecordingStatus(bool status) => _recordingStarted.value = status;

  TimerService() {
    listenToReactiveValues([_recordingStarted]);
    _recorder = AudioRecorder();
  }

  Future<void> _stopRecording() async {
    startOrStopRecording();
    String? path = await _recorder.stop();
    _logger.i("recording file: $path");

    try {
      _hiveService.saveRecordings(
        recording: Recording(
            id: fileName,
            path: path!,
            name: fileName,
            status: onDevice,
            totalTime: ""),
      );

      _bottomSheetService.showCustomSheet(
          variant: BottomSheetType.success, description: "Your audio is saved");
    } catch (e) {
      _logger.e("Saving the recording in local failed: ${e.toString()}");
    }

    // var status = await _recordService.uploadRecording(
    //     path!, "MyRecording_${ID.unique()}");

    _recordingStarted.value = false;
    fileName = "";

    notifyListeners();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _startRecording() async {
    _logger.i("Start recording is being called");
    if (await _recorder.hasPermission()) {
      _logger.i("User granted the microphone permission");
      if (!await _recorder.isRecording()) {
        final path = await _localPath;
        fileName = "MyRecording_${DateTime.now().millisecondsSinceEpoch}";
        await _recorder.start(const RecordConfig(),
            path: "$path/$fileName.m4a");
      }

      _recordingStarted.value = await _recorder.isRecording();
      _logger.d("Recording Started value: ${_recordingStarted.value}");
      startOrStopRecording();
    }
    notifyListeners();
  }

  // void startOrStopTimer() {
  //   if (_timer!.isActive) {
  //     _timer!.cancel();
  //   } else {
  //     _recordingSeconds.value = 1;
  //     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         int localSeconds = _recordingSeconds.value + 1;
  //         int localMinutes = _recordingMinutes.value;
  //         int localHours = _recordingHours.value;

  //         if (localSeconds > 59) {
  //           if (localMinutes > 59) {
  //             localHours++;
  //             localMinutes = 0;
  //           } else {
  //             localMinutes++;
  //             localSeconds = 0;
  //           }
  //         }

  //         if (localSeconds != _recordingSeconds.value ||
  //             localMinutes != _recordingMinutes.value ||
  //             localHours != _recordingHours.value) {
  //           _recordingSeconds.value = localSeconds;
  //           _recordingMinutes.value = localMinutes;
  //           _recordingHours.value = localHours;
  //           // _updateVolume();
  //         }
  //       });
  //       // _updateVolume();
  //     });
  //   }
  //   notifyListeners();
  // }

  Future<void> startOrStopRecording() async {
    isRecordingStarted ? await _stopRecording() : await _startRecording();
  }

  bool dispose() {
    _recorder.dispose();
    return true;
  }
}
