import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import 'package:swaram_ai/ui/widgets/common/recording/header.dart';
import 'package:swaram_ai/ui/widgets/common/recording/recording_action.dart';
import 'package:swaram_ai/ui/widgets/common/recording/recording_model.dart';

class Recording extends StackedView<RecordingModel> {
  const Recording({super.key});

  @override
  Widget builder(
    BuildContext context,
    RecordingModel viewModel,
    Widget? child,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: viewModel.isRecordStarted
              ? SizedBox(
                  child: Lottie.asset("assets/lottie/wave_animation.json"),
                )
              : Header(
                  headerText: viewModel.headerText,
                  subTitleText: viewModel.subTitleText,
                ),
        ),
        const RecordingAction(),
      ],
    );
  }

  @override
  RecordingModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecordingModel();
}
