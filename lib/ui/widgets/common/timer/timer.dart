import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'timer_model.dart';

class Timer extends StackedView<TimerModel> {
  final double? topPadding;
  final double? leftPadding;
  final double? rightPadding;
  final double? bottomPadding;

  const Timer(
      {this.topPadding,
      this.bottomPadding,
      this.leftPadding,
      this.rightPadding,
      super.key});

  @override
  Widget builder(
    BuildContext context,
    TimerModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        leftPadding ?? screenWidthFraction(context, dividedBy: 20),
        topPadding ?? 50,
        rightPadding ?? screenWidthFraction(context, dividedBy: 20),
        bottomPadding ?? 10,
      ),
      child: FittedBox(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 160,
            maxWidth: screenWidth(context),
          ),
          color: kcBlueLightColor,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTimeText(context, viewModel.getDigitHours),
                  _buildSubHeadingText(context, "Hours")
                ],
              ),
              Text(
                ":",
                style: GoogleFonts.montserrat(
                    fontSize: getResponsiveFontSize(
                  context,
                  fontSize: 130,
                )),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeText(context, viewModel.getDigitMinutes),
                  _buildSubHeadingText(context, "Minutes")
                ],
              ),
              Text(
                ":",
                style: GoogleFonts.montserrat(
                    fontSize: getResponsiveFontSize(
                  context,
                  fontSize: 130,
                )),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeText(context, viewModel.getDigitSeconds),
                  _buildSubHeadingText(context, "Seconds")
                ],
              )
            ],
          )),
        ),
      ),
    );
  }

  @override
  TimerModel viewModelBuilder(
    BuildContext context,
  ) =>
      TimerModel();

  Widget _buildTimeText(BuildContext context, text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: getResponsiveFontSize(context, fontSize: 140, max: 140),
          fontWeight: FontWeight.w400,
          color: kcTextDark2),
    );
  }

  Widget _buildSubHeadingText(BuildContext context, String text) {
    return Text(
      text,
      softWrap: true,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: getResponsiveFontSize(context, fontSize: 36),
      ),
    );
  }
}
