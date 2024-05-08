import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/services/timer_service.dart';
import 'package:swaram_ai/ui/widgets/common/category/category.dart';
import 'package:swaram_ai/ui/widgets/common/category_detail/category_detail.dart';
import 'package:swaram_ai/ui/widgets/common/dashboard_header/dashboard_header.dart';
import 'package:swaram_ai/ui/widgets/common/timer/timer.dart';

class DashboardViewModel extends ReactiveViewModel {
  final _timerService = locator<TimerService>();
  final _categoryService = locator<CategoryService>();

  @override
  List<ListenableServiceMixin> get listenableServices {
    return [_timerService, _categoryService];
  }

  bool get isRecordStarted => _timerService.isRecordingStarted;
  bool get isCategoryPressed => !_categoryService.showFront;

  Widget getHeaderWidget() {
    if (isRecordStarted && !isCategoryPressed) {
      return const Timer();
    } else {
      return const DashboardHeader(
        frontWidget: Category(),
        rearWidget: CategoryDetail(),
      );
    }
  }

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}
