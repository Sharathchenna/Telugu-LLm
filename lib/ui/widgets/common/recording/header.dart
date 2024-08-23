import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

class Header extends StatelessWidget {
  final String headerText;
  final String subTitleText;
  const Header({
    required this.headerText,
    this.subTitleText = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            headerText,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: kcTextDarkColor,
            ),
          ),
        ),
        verticalSpaceTiny,
        if (subTitleText != "")
          FittedBox(
            child: Text(
              subTitleText,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: kcTextDarkColor,
              ),
            ),
          ),
      ],
    );
  }
}
