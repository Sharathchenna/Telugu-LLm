import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'swecha_footer_model.dart';

class SwechaFooter extends StackedView<SwechaFooterModel> {
  const SwechaFooter({super.key});

  @override
  Widget builder(
    BuildContext context,
    SwechaFooterModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A product by ',
              style: GoogleFonts.montserrat(
                  color: kcTextDark2,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/swecha_logo.png',
                width: 55,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        GestureDetector(
          onTap: viewModel.launchInBrowser,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Privacy policy',
                style: GoogleFonts.montserrat(
                    color: kcPrimaryBlueColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  SwechaFooterModel viewModelBuilder(
    BuildContext context,
  ) =>
      SwechaFooterModel();
}
