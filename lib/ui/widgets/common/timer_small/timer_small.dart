import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'timer_small_model.dart';

class TimerSmall extends StackedView<TimerSmallModel> {
  final String seconds, minutes, hours;
  const TimerSmall(
      {super.key,
      required this.seconds,
      required this.minutes,
      required this.hours});

  @override
  Widget builder(
    BuildContext context,
    TimerSmallModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
          horizontal: screenWidth(context) * 0.2),
      child: Container(
        decoration: BoxDecoration(
            color: kcBlueVeryLightColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 0, 10, 0),
                        child: Text(
                          hours,
                          style: GoogleFonts.montserrat(
                              fontSize: getResponsiveFontSize(context,
                                  fontSize: 40, max: 40),
                              fontWeight: FontWeight.w500,
                              color: kcTextDark2),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                    child: Text(
                      ':',
                      style: GoogleFonts.montserrat(
                          fontSize: getResponsiveFontSize(context,
                              fontSize: 30, max: 30),
                          fontWeight: FontWeight.w500,
                          color: kcTextDark2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 20, 0),
                    child: Text(minutes,
                        style: GoogleFonts.montserrat(
                            fontSize: getResponsiveFontSize(context,
                                fontSize: 40, max: 40),
                            fontWeight: FontWeight.w500,
                            color: kcTextDark2)),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                    child: Text(
                      ':',
                      style: GoogleFonts.montserrat(
                          fontSize: getResponsiveFontSize(context,
                              fontSize: 30, max: 30),
                          fontWeight: FontWeight.w500,
                          color: kcTextDark2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                    child: Text(seconds,
                        style: GoogleFonts.montserrat(
                            fontSize: getResponsiveFontSize(context,
                                fontSize: 40, max: 40),
                            fontWeight: FontWeight.w500,
                            color: kcTextDark2)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 7, 7),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Hh',
                      style: GoogleFonts.montserrat(
                          fontSize: getResponsiveFontSize(context,
                              fontSize: 30, max: 30),
                          fontWeight: FontWeight.w500,
                          color: kcTextDark2)),
                  Text('Mn',
                      style: GoogleFonts.montserrat(
                          fontSize: getResponsiveFontSize(context,
                              fontSize: 30, max: 30),
                          fontWeight: FontWeight.w500,
                          color: kcTextDark2)),
                  Text('Sc',
                      style: GoogleFonts.montserrat(
                          fontSize: getResponsiveFontSize(context,
                              fontSize: 30, max: 30),
                          fontWeight: FontWeight.w500,
                          color: kcTextDark2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  TimerSmallModel viewModelBuilder(
    BuildContext context,
  ) =>
      TimerSmallModel();
}
