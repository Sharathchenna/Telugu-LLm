import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';

import 'info_message_model.dart';

class InfoMessage extends StackedView<InfoMessageModel> {
  final String infoText;
  final String actionString;

  const InfoMessage(
      {required this.infoText, required this.actionString, super.key});

  @override
  Widget builder(
    BuildContext context,
    InfoMessageModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$infoText ',
            style: GoogleFonts.montserrat(
                color: kcTextDarkColor,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {},
            child: Text(
              actionString,
              style: GoogleFonts.montserrat(
                  color: kcPrimaryBlueColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  @override
  InfoMessageModel viewModelBuilder(
    BuildContext context,
  ) =>
      InfoMessageModel();
}
