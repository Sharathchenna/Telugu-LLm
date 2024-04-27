import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'input_with_field_model.dart';

class InputWithField extends StackedView<InputWithFieldModel> {
  final String fieldLabel;
  final String labelName;
  final TextEditingController textController;
  final FocusNode focusNode;
  const InputWithField(
      {required this.labelName,
      required this.fieldLabel,
      required this.textController,
      required this.focusNode,
      super.key});

  @override
  Widget builder(
    BuildContext context,
    InputWithFieldModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                labelName,
                style: GoogleFonts.montserrat(
                    color: kcTextDark2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          verticalSpaceTiny,
          TextFormField(
            controller: textController,
            focusNode: focusNode,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: fieldLabel,
              fillColor: Colors.white,
              filled: true,
              labelStyle: GoogleFonts.montserrat(
                  color: kcDarkGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              hintStyle: GoogleFonts.montserrat(
                  color: kcTextDarkColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kcLightGrey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kcMediumGrey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kcErrorColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kcErrorColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: null,
          ),
        ],
      ),
    );
  }

  @override
  InputWithFieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      InputWithFieldModel();
}
