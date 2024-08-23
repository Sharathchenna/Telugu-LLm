import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'reward_footer_model.dart';

class RewardFooter extends StackedView<RewardFooterModel> {
  const RewardFooter({super.key});

  @override
  Widget builder(
    BuildContext context,
    RewardFooterModel viewModel,
    Widget? child,
  ) {
    return viewModel.getFooterWidget(context);
  }

  @override
  RewardFooterModel viewModelBuilder(
    BuildContext context,
  ) =>
      RewardFooterModel();
}
