import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/swecha_footer/swecha_footer.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/ai_logo.png",
                fit: BoxFit.cover,
              ),
              FittedBox(
                child: Text(
                  "తెలుగు భాషా సంపుటి",
                  style: GoogleFonts.montserrat(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: kcPrimaryBlueColor),
                ),
              ),
              verticalSpaceMedium,
              const SwechaFooter(),
              verticalSpaceLarge,
              const CircularProgressIndicator(
                color: kcPrimaryBlueColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
