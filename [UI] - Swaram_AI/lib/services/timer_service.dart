import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';

class TimerService with ListenableServiceMixin {
  final _recordingStarted = ReactiveValue<bool>(false);
  final _recordingHours = ReactiveValue<int>(0);
  final _recordingMinutes = ReactiveValue<int>(0);
  final _recordingSeconds = ReactiveValue<int>(0);
  final _recorder = AudioRecorder();
  final _volume = ReactiveValue<double>(0.0);
  final _minVolume = -45.0;
  final _logger = getLogger("TimerService");
  final _bottomsheet = locator<BottomSheetService>();

  Timer? _timer;

  bool get isRecordingStarted => _recordingStarted.value;
  int get getRecordedHours => _recordingHours.value;
  int get getRecordedMinutes => _recordingMinutes.value;
  int get getRecordedSeconds => _recordingSeconds.value;
  double get getVolume => _volume.value;

  TimerService() {
    listenToReactiveValues([
      _recordingStarted,
      _recordingHours,
      _recordingMinutes,
      _recordingSeconds,
      _volume
    ]);
  }

  void _stopRecording() async {
    _timer!.cancel();
    String? path = await _recorder.stop();
    _logger.i("recording file: $path");
    _bottomsheet.showBottomSheet(
      title: "Recording file path",
      description: path,
    );
    _recordingSeconds.value = 0;
    _recordingMinutes.value = 0;
    _recordingHours.value = 0;
    _recordingStarted.value = false;

    notifyListeners();
  }

  void _updateVolume() async {
    Amplitude ampl = await _recorder.getAmplitude();
    if (ampl.current > _minVolume) {
      _volume.value = (ampl.current - _minVolume) / _minVolume;
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void _startRecording() async {
    _logger.i("Start recording is being called");
    if (await _recorder.hasPermission()) {
      _logger.i("User granted the microphone permission");
      if (!await _recorder.isRecording()) {
        final path = await _localPath;
        await _recorder.start(const RecordConfig(),
            path: "$path/my_recording.m4a");
      }
    }

    _recordingStarted.value = await _recorder.isRecording();
    _logger.d("Recording Started value: ${_recordingStarted.value}");
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
      _updateVolume();
    });
    notifyListeners();
  }

  startOrStopRecording() {
    isRecordingStarted ? _stopRecording() : _startRecording();
  }

  bool dispose() {
    _recorder.dispose();
    return true;
  }
}
