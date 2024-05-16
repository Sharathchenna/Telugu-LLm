import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/category/category.dart';
import 'package:swaram_ai/ui/widgets/common/category_detail/category_detail.dart';
import 'package:swaram_ai/ui/widgets/common/dashboard_header/dashboard_header.dart';
import 'package:swaram_ai/ui/widgets/common/my_app_bar/my_app_bar.dart';
import 'package:swaram_ai/ui/widgets/common/recording/recording.dart';
import 'package:swaram_ai/ui/widgets/common/timer/timer.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({super.key});

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        top: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: screenWidth(context),
          height: screenHeight(context),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: AnimatedSwitcher(
                  key: const ValueKey(false),
                  duration: const Duration(seconds: 2),
                  child: (viewModel.isRecordStarted &&
                          !viewModel.isCategoryPressed)
                      ? const Timer()
                      : const DashboardHeader(
                          frontWidget: Category(),
                          rearWidget: CategoryDetail(),
                        ),
                ),
              ),
              const Expanded(
                flex: 3,
                child: Recording(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DashboardViewModel();
}
