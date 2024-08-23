import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/input_with_field/input_with_field.dart';
import 'package:swaram_ai/ui/widgets/common/keypad_close_widget.dart';
import 'package:swaram_ai/ui/widgets/common/login_header/login_header.dart';
import 'package:swaram_ai/ui/widgets/common/primary_submit_button/primary_submit_button.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CloseKeyPadWidget(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const LoginHeader(
                          headerText: "Profile",
                        ),
                        InputWithField(
                          labelName: "Name*",
                          fieldLabel: "Enter your name",
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
                              color: kcErrorColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        verticalSpaceMedium,
                        InputWithField(
                          labelName: "Phone number*",
                          fieldLabel: "Enter your phone number",
                          textController: viewModel.phoneNumberController,
                          focusNode: viewModel.phoneNumberFocusNode,
                          textInputType: TextInputType.number,
                        ),
                        if (viewModel.isFormSubmitted &&
                            viewModel.phoneNumberController.text.isEmpty) ...[
                          verticalSpaceTiny,
                          Text(
                            "Phone number is required.",
                            style: GoogleFonts.montserrat(
                              color: kcErrorColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        verticalSpaceMedium,
                        InputWithField(
                          labelName: "Email",
                          fieldLabel: "Enter your email",
                          textController: viewModel.emailController,
                          focusNode: viewModel.emailFocusNode,
                          textInputType: TextInputType.emailAddress,
                        ),
                        if (viewModel.isFormSubmitted &&
                            viewModel.hasEmailValidationMessage) ...[
                          verticalSpaceTiny,
                          Text(
                            viewModel.emailValidationMessage!,
                            style: GoogleFonts.montserrat(
                              color: kcErrorColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        verticalSpaceMedium,
                        InputWithField(
                          labelName: "Address",
                          fieldLabel: "Enter your address",
                          textController: viewModel.addressController,
                          focusNode: viewModel.addressFocusNode,
                        ),
                        verticalSpaceMedium,
                        PrimarySubmitButton(
                          isLoading: viewModel.isLoading,
                          buttonText: "Update",
                          onTap: viewModel.saveProfile,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
