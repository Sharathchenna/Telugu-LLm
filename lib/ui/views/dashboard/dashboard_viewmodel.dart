import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/timer_service.dart';

class DashboardViewModel extends ReactiveViewModel {
  final _timerService = locator<TimerService>();

  @override
  List<ListenableServiceMixin> get listenableServices {
    return [_timerService];
  }

  bool get isRecordStarted => _timerService.isRecordingStarted;
}
