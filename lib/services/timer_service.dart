import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/services/hive_service.dart';
import 'package:swaram_ai/services/util_service.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';
import 'package:swaram_ai/ui/common/snack_bar.dart';

class TimerService with ListenableServiceMixin {
  final _recordingStarted = ReactiveValue<bool>(false);
  final _videoRecordingStarted = ReactiveValue<bool>(false);
  final _recorder = locator<AudioRecorder>();
  final _utilService = locator<UtilService>();

  String fileName = "";

  final _logger = getLogger("TimerService");
  final _hiveService = locator<HiveService>();

  bool get isRecordingStarted => _recordingStarted.value;
  get recordingReactiveValue => _recordingStarted;

  bool get isVideoRecordingStarted => _videoRecordingStarted.value;
  get videoReactiveValue => _videoRecordingStarted;

  set videoRecordingStarted(bool status) => _recordingStarted.value = status;

  TimerService() {
    listenToReactiveValues([_recordingStarted]);
  }

  Future<void> _stopRecording() async {
    String? path = await _recorder.stop();
    _logger.i("recording file: $path");
    try {
      _hiveService.saveRecordings(
        recording: Recording(
            id: fileName,
            path: path!,
            name: fileName,
            status: onDevice,
            isVideo: false,
            totalTime: ""),
      );

      SnackBarHelper.showSnackBar(
          title: "Audio Saved",
          message: "Your audio has been successfuly saved!",
          contentType: ContentType.success);
    } catch (e) {
      _logger.e("Saving the recording in local failed: ${e.toString()}");
      SnackBarHelper.showSnackBar(
          title: "Audio Failed",
          message: "There was an error saving audio. Please try again!",
          contentType: ContentType.failure);
    } finally {
      _recordingStarted.value = false;
      fileName = "";
      notifyListeners();
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _startRecording() async {
    _logger.i("Start recording is being called");
    final userBox = await Hive.openBox(authBox);
    try {
      if (await _recorder.hasPermission()) {
        _logger.i("User granted the microphone permission");
        if (!await _recorder.isRecording()) {
          _logger.i("Recording not started yet and going to start");
          final path = await _localPath;
          var userId = userBox.get("auth")["userId"];
          fileName = "Audio_${userId}_${_utilService.generateUniqueId()}";
          fileName = _utilService.sanitizeFileId(fileName);
          _logger.i("Recording $fileName");
          await _recorder.start(const RecordConfig(),
              path: "$path/$fileName.m4a");
          _recordingStarted.value = true;
        }
      }
    } catch (e) {
      _logger.e("Exception occurred: ${e.toString()}");
      _recordingStarted.value = false;
      SnackBarHelper.showSnackBar(
          title: "Recording start failed",
          message: "Unable to start the recording!",
          contentType: ContentType.failure);
    } finally {
      _logger.d("Recording Started value: ${_recordingStarted.value}");
      notifyListeners();
    }
  }

  Future<void> startOrStopRecording() async {
    _logger.i("Button pressed");
    isRecordingStarted ? await _stopRecording() : await _startRecording();
  }

  void dispose() {}
}
