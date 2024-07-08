import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';

import 'primary_button_model.dart';

class PrimaryButton extends StackedView<PrimaryButtonModel> {
  final Function onTapHandler;
  final IconData iconData;
  const PrimaryButton(
      {required this.onTapHandler, required this.iconData, super.key});

  @override
  Widget builder(
    BuildContext context,
    PrimaryButtonModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => onTapHandler(),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 32, maxWidth: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kcBlueVeryLightColor,
        ),
        child: Center(
          child: Icon(
            iconData,
            size: 16,
            color: kcPrimaryBlueColor,
          ),
        ),
      ),
    );
  }

  @override
  PrimaryButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      PrimaryButtonModel();
}
