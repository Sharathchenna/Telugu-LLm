import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/input_with_field/input_with_field.dart';
import 'package:swaram_ai/ui/widgets/common/keypad_close_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'recorded_info_viewmodel.dart';

class RecordedInfoView extends StatelessWidget {
  const RecordedInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecordedInfoViewModel>.reactive(
      viewModelBuilder: () => RecordedInfoViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Recording Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CloseKeyPadWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InputWithField(
                          labelName: "Name of the person speaking",
                          fieldLabel: "Enter person name",
                          textController: viewModel.userNameController,
                          focusNode: viewModel.userNameFocusNode,
                        ),
                        if (viewModel.isFormSubmitted &&
                            viewModel.userNameController.text.isEmpty) ...[
                          verticalSpaceTiny,
                          Text(
                            "Name is required.",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        verticalSpaceMedium,
                        InputWithField(
                          labelName: "Conversation Topic*",
                          fieldLabel: "Enter conversation topic",
                          textController: viewModel.conversationTopicController,
                          focusNode: viewModel.conversationTopicFocusNode,
                        ),
                        if (viewModel.isFormSubmitted &&
                            viewModel
                                .conversationTopicController.text.isEmpty) ...[
                          verticalSpaceTiny,
                          Text(
                            "Conversation topic is required.",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        verticalSpaceMedium,
                        InputWithField(
                          labelName: "Geo Location",
                          fieldLabel: "user current location",
                          textController: viewModel.geoLocationController,
                          focusNode: viewModel.geoLocationFocusNode,
                          enabled: false,
                        ),
                        if (viewModel.isFormSubmitted &&
                            viewModel.geoLocationController.text.isEmpty) ...[
                          verticalSpaceTiny,
                          Text(
                            "Geo location is required.",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        verticalSpaceMedium,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
