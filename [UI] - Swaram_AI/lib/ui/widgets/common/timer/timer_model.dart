import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/timer_service.dart';

class TimerModel extends ReactiveViewModel {
  final _timerService = locator<TimerService>();
  bool isRecordStarted = false;

  @override
  List<ListenableServiceMixin> get listenableServices => [_timerService];

  String get getDigitHours =>
      _timerService.getRecordedHours.toString().padLeft(2, '0');
  String get getDigitMinutes =>
      _timerService.getRecordedMinutes.toString().padLeft(2, '0');
  String get getDigitSeconds =>
      _timerService.getRecordedSeconds.toString().padLeft(2, '0');
}
