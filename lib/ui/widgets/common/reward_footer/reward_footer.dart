import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/reward_container/reward_container.dart';

import 'reward_footer_model.dart';

class RewardFooter extends StackedView<RewardFooterModel> {
  const RewardFooter({super.key});

  @override
  Widget builder(
    BuildContext context,
    RewardFooterModel viewModel,
    Widget? child,
  ) {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RewardContainer(
            iconData: FontAwesomeIcons.crown,
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

  @override
  RewardFooterModel viewModelBuilder(
    BuildContext context,
  ) =>
      RewardFooterModel();
}
