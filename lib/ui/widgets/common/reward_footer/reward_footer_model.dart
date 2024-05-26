import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/services/timer_service.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/reward_container/reward_container.dart';
import 'package:swaram_ai/ui/widgets/common/timer_small/timer_small.dart';

class RewardFooterModel extends ReactiveViewModel {
  final _categoryService = locator<CategoryService>();
  final _timerService = locator<TimerService>();
  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_categoryService, _timerService];

  Widget getFooterWidget() {
    if (!_categoryService.showFront && _timerService.isRecordingStarted) {
      return const TimerSmall();
    } else {
      return const Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RewardContainer(
              iconData: Icons.favorite_outlined,
              reward: "23",
              footeText: "Hours of voice"),
          horizontalSpaceSmall,
          RewardContainer(
              iconData: Icons.stars_rounded,
              reward: "234",
              footeText: "Credit score"),
        ],
      );
    }
  }

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}
