import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/recording/recording_model.dart';

class RecordingAction extends StackedView<RecordingModel> {
  const RecordingAction({
    super.key,
  });

  @override
  Widget builder(
      BuildContext context, RecordingModel viewModel, Widget? child) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpaceTiny,
          GestureDetector(
            onTap: () => viewModel
                .toggleRecording(context), // Wrap in an anonymous function
            child: AvatarGlow(
              glowColor: kcBlueLightColor,
              duration: const Duration(milliseconds: 2000),
              animate: !viewModel.isRecordStarted,
              repeat: true,
              child: CircleAvatar(
                backgroundColor: viewModel.isRecordStarted
                    ? kcErrorColor
                    : kcPrimaryBlueColor,
                radius: screenWidthFraction(context, dividedBy: 10),
                child: viewModel.isRecordStarted
                    ? const Icon(
                        Icons.stop,
                        color: kcBackgroundColor,
                        size: 40,
                      )
                    : const Icon(
                        Icons.mic_none_outlined,
                        color: kcBackgroundColor,
                        size: 40,
                      ),
              ),
            ),
          ),
          Text(
            viewModel.isRecordStarted
                ? AppLocalizations.of(context)!.recordFooterStop
                : AppLocalizations.of(context)!.recordFooterSpeak,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w300,
            ),
          ),
          // SizedBox(
          //   height: screenHeightFraction(context, dividedBy: 60),
          // ),
          // const RewardFooter(),
        ],
      ),
    );
  }

  @override
  RecordingModel viewModelBuilder(BuildContext context) => RecordingModel();
}
