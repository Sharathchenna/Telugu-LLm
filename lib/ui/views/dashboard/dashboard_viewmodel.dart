import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/services/timer_service.dart';

class DashboardViewModel extends ReactiveViewModel {
  final _timerService = locator<TimerService>();
  final _categoryService = locator<CategoryService>();

  bool get isRecordStarted => _timerService.isRecordingStarted;
  bool get isCategoryPressed => !_categoryService.showFront;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_timerService, _categoryService];

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}
