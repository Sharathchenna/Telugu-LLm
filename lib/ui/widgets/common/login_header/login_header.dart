import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'login_header_model.dart';

class LoginHeader extends StackedView<LoginHeaderModel> {
  final String headerText;
  const LoginHeader({required this.headerText, super.key});

  @override
  Widget builder(
    BuildContext context,
    LoginHeaderModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/ai_logo.png',
              width: screenWidthFraction(context, dividedBy: 3),
              height: screenHeightFraction(context, dividedBy: 5),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                headerText,
                style: GoogleFonts.montserrat(
                    color: kcTextDarkColor,
                    fontSize: getResponsiveFontSize(context, fontSize: 48),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  LoginHeaderModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginHeaderModel();
}
