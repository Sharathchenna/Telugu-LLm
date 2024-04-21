import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/timer_service.dart';

class RecordingModel extends ReactiveViewModel {
  final _timerService = locator<TimerService>();
  bool get isRecordStarted => _timerService.isRecordingStarted;

  @override
  List<ListenableServiceMixin> get listenableServices {
    return [_timerService];
  }

  toggleRecording() {
    _timerService.startOrStopRecording();
  }
}
