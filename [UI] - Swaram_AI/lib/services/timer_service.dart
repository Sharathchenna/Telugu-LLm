import 'dart:async';

import 'package:stacked/stacked.dart';

class TimerService with ListenableServiceMixin {
  final _recordingStarted = ReactiveValue<bool>(false);
  final _recordingHours = ReactiveValue<int>(0);
  final _recordingMinutes = ReactiveValue<int>(0);
  final _recordingSeconds = ReactiveValue<int>(0);

  Timer? _timer;

  bool get isRecordingStarted => _recordingStarted.value;
  int get getRecordedHours => _recordingHours.value;
  int get getRecordedMinutes => _recordingMinutes.value;
  int get getRecordedSeconds => _recordingSeconds.value;

  TimerService() {
    listenToReactiveValues([
      _recordingStarted,
      _recordingHours,
      _recordingMinutes,
      _recordingSeconds
    ]);
  }

  void _stopRecording() {
    _timer!.cancel();
    _recordingSeconds.value = 0;
    _recordingMinutes.value = 0;
    _recordingHours.value = 0;
    _recordingStarted.value = false;

    notifyListeners();
  }

  void _startRecording() {
    _recordingStarted.value = true;
    _recordingSeconds.value = 1;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      int localSeconds = _recordingSeconds.value + 1;
      int localMinutes = _recordingMinutes.value;
      int localHours = _recordingHours.value;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }

      _recordingSeconds.value = localSeconds;
      _recordingMinutes.value = localMinutes;
      _recordingHours.value = localHours;
    });
    notifyListeners();
  }

  startOrStopRecording() {
    isRecordingStarted ? _stopRecording() : _startRecording();
  }
}
