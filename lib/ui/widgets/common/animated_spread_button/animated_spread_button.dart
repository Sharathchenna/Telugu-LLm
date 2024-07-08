import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'animated_spread_button_model.dart';

class AnimatedSpreadButton extends StackedView<AnimatedSpreadButtonModel> {
  final Color glowColor;
  final Color buttonBackgroundColor;
  final IconData iconData;
  final Color? iconColor;
  final bool isRecordingStarted;
  const AnimatedSpreadButton({
    required this.glowColor,
    required this.buttonBackgroundColor,
    required this.iconData,
    this.iconColor,
    this.isRecordingStarted = false,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    AnimatedSpreadButtonModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () {},
      child: AvatarGlow(
        glowColor: glowColor,
        duration: const Duration(milliseconds: 2000),
        animate: !isRecordingStarted,
        repeat: true,
        child: CircleAvatar(
          backgroundColor: buttonBackgroundColor,
          radius: screenWidthFraction(context, dividedBy: 10),
          child: Icon(
            iconData,
            color: iconColor,
            size: 40,
          ),
        ),
      ),
    );
  }

  @override
  AnimatedSpreadButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      AnimatedSpreadButtonModel();
}
