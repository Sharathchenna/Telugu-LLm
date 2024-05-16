import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/services/stopwatch_service.dart';
import 'package:swaram_ai/services/timer_service.dart';

class TimerModel extends ReactiveViewModel {
  String seconds = "00", minutes = "00", hours = "00";
  Timer? _timer;
  final _logger = getLogger("Dashboard View Model");

  final _timerService = locator<TimerService>();
  final _stopWatchService = locator<StopwatchService>();

  ReactiveValue<bool> get recordingStartedReactiveValue =>
      _timerService.recordingReactiveValue;

  TimerModel() {
    recordingStartedReactiveValue.listen((v) {
      if (v) {
        _startwatch();
      } else {
        _stopwatch();
      }
    });
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_timerService];

  void _startwatch() {
    _logger.i("Start watch called");
    _stopWatchService.handleStartStop();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      Map<String, String> timingData = _stopWatchService.getTiming();
      seconds = timingData["seconds"]!;
      minutes = timingData["minutes"]!;
      hours = timingData["hours"]!;
      rebuildUi();
    });
  }

  void _stopwatch() {
    _stopWatchService.handleStartStop();
    _timer?.cancel();
    _resetTime();
  }

  void _resetTime() {
    seconds = "00";
    minutes = "00";
    hours = "00";
  }

  @override
  void dispose() {
    _timerService.dispose();
    _stopWatchService.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
