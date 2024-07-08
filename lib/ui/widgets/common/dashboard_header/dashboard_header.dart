import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/animation/flip_animation.dart';
import 'package:swaram_ai/ui/widgets/common/dashboard_header/dashboard_header_model.dart';

class DashboardHeader extends StackedView<DashboardHeaderModel> {
  final Widget frontWidget;
  final Widget rearWidget;

  const DashboardHeader(
      {required this.frontWidget, required this.rearWidget, super.key});

  @override
  Widget builder(
    BuildContext context,
    DashboardHeaderModel viewModel,
    Widget? child,
  ) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 0),
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeOutBack,
      layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
      transitionBuilder: (child, value) {
        return FlipAnimation.flipTransitionBuilder(child, value,
            showFrontSide: viewModel.showFrontSide);
      },
      child: viewModel.showFrontSide ? frontWidget : rearWidget,
    );
  }

  @override
  DashboardHeaderModel viewModelBuilder(
    BuildContext context,
  ) =>
      DashboardHeaderModel();
}
