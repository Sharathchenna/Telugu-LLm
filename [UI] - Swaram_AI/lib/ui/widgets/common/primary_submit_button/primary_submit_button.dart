import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'primary_submit_button_model.dart';

class PrimarySubmitButton extends StackedView<PrimarySubmitButtonModel> {
  final String buttonText;
  final Function onTap;
  const PrimarySubmitButton(
      {required this.buttonText, required this.onTap, super.key});

  @override
  Widget builder(
    BuildContext context,
    PrimarySubmitButtonModel viewModel,
    Widget? child,
  ) {
    return Container(
      height: 44,
      width: screenWidth(context),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24.0),
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ElevatedButton.styleFrom(
          backgroundColor: kcPrimaryBlueColor,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          minimumSize: const Size(344, 36),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        child: Text(
          buttonText,
          style: GoogleFonts.montserrat(
              color: kcBackgroundColor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  PrimarySubmitButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      PrimarySubmitButtonModel();
}
