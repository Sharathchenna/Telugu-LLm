import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'package:swaram_ai/ui/widgets/common/draggable_sheet/draggable_sheet.dart';
import 'package:swaram_ai/ui/widgets/common/my_app_bar/my_app_bar.dart';
import 'package:swaram_ai/ui/widgets/common/primary_button/primary_button.dart';
import 'package:swaram_ai/ui/widgets/common/timer_small/timer_small.dart';

import 'video_recording_viewmodel.dart';

class VideoRecordingView extends StackedView<VideoRecordingViewModel> {
  const VideoRecordingView({super.key});

  @override
  Widget builder(
    BuildContext context,
    VideoRecordingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: kcTextDarkColor,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: screenHeight(context),
            child: !viewModel.isCameraInitialized
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(),
                      Text(
                        'Permission denied',
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: viewModel.getPermissionStatus,
                        child: Text(
                          'Give permission',
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      viewModel.isCameraInitialized
                          ? AspectRatio(
                              aspectRatio:
                                  1 / viewModel.controller!.value.aspectRatio,
                              child: CameraPreview(viewModel.controller!),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: kcPrimaryBlueColor,
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: DraggableSheet(
                          isOpen: viewModel.isOverlayOpen,
                          onClose: viewModel.toggleOverlay,
                          childWidget: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: viewModel.videoTapHandler,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            child: viewModel
                                                    .isRecordingInProgress
                                                ? const Icon(
                                                    Icons.circle,
                                                    color: kcBackgroundColor,
                                                    size: 80,
                                                  )
                                                : const Icon(
                                                    Icons.circle,
                                                    color: Colors.white38,
                                                    size: 80,
                                                  ),
                                          ),
                                          AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            child: viewModel
                                                    .isRecordingInProgress
                                                ? const Icon(
                                                    Icons.circle,
                                                    color: kcErrorColor,
                                                    size: 65,
                                                  )
                                                : const Icon(
                                                    Icons.circle,
                                                    color: kcBackgroundColor,
                                                    size: 65,
                                                  ),
                                          ),
                                          AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            child: viewModel
                                                    .isRecordingInProgress
                                                ? const Icon(
                                                    Icons.stop_rounded,
                                                    color: kcBackgroundColor,
                                                    size: 32,
                                                  )
                                                : Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    verticalSpaceTiny,
                                    Text(
                                      viewModel.isRecordingInProgress
                                          ? 'Tap to stop recording'
                                          : 'Tap to start recording',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w300,
                                          color: kcBackgroundColor),
                                    ),
                                  ],
                                ),
                                verticalSpace(screenHeight(context) * 0.032),
                                const TimerSmall()
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: PrimaryButton(
                          iconData: Icons.close_sharp,
                          onTapHandler: viewModel.closeTapHandler,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  @override
  VideoRecordingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      VideoRecordingViewModel();
}
