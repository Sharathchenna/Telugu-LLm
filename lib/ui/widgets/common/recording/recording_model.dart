import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/services/timer_service.dart';

class RecordingModel extends ReactiveViewModel {
  final _timerService = locator<TimerService>();
  final _categoryService = locator<CategoryService>();
  bool get isRecordStarted => _timerService.isRecordingStarted;
  bool showProgress = false;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_timerService, _categoryService];

  toggleRecording() async {
    toggleProgress();
    await _timerService.startOrStopRecording();
    toggleProgress();
  }

  toggleProgress() {
    showProgress = !showProgress;
    rebuildUi();
  }

  int volume0to(int maxVolumeToDisplay) {
    return (_timerService.getVolume * maxVolumeToDisplay).round().abs();
  }

  String get headerText => _categoryService.showFront
      ? "Say something, start recording."
      : "Start narrating a fables now!";

  String get subTitleText => _categoryService.showFront
      ? "Already know what to speak, just go ahead and record!"
      : "";

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}
