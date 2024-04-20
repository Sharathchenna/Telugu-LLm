import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/views/sign_in/sign_in_view.form.dart';
import 'package:swaram_ai/ui/widgets/common/info_message/info_message.dart';
import 'package:swaram_ai/ui/widgets/common/input_with_field/input_with_field.dart';
import 'package:swaram_ai/ui/widgets/common/login_header/login_header.dart';
import 'package:swaram_ai/ui/widgets/common/primary_submit_button/primary_submit_button.dart';
import 'package:swaram_ai/ui/widgets/common/swecha_footer/swecha_footer.dart';

import 'sign_in_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'userName'),
  FormTextField(name: 'phoneNumber')
])
class SignInView extends StackedView<SignInViewModel> with $SignInView {
  const SignInView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(SignInViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    SignInViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: kcBackgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 24.0,
              top: 12.0,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                color: kcVeryBlueLightColor,
                child: IconButton(
                  icon: SvgPicture.asset(
                    colorFilter: const ColorFilter.mode(
                        kcPrimaryBlueColor, BlendMode.srcIn),
                    'assets/icons/help_doc_ext.svg',
                    width: 32,
                    height: 32,
                  ), // Example icon, adjust as needed
                  iconSize: 32, // Adjust icon size as needed
                  padding: const EdgeInsets.all(8), // Adjust padding as needed
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const LoginHeader(
                      headerText: "Sign in to your account",
                    ),
                    InputWithField(
                      labelName: "Name",
                      fieldLabel: "Enter a name for your profile",
                      textController: userNameController,
                      focusNode: userNameFocusNode,
                    ),
                    verticalSpaceMedium,
                    InputWithField(
                      labelName: "Phone number",
                      fieldLabel: "Enter your phone number here",
                      textController: phoneNumberController,
                      focusNode: phoneNumberFocusNode,
                    ),
                    verticalSpaceMedium,
                    PrimarySubmitButton(
                      buttonText: "Sign In",
                      onTap: viewModel.navigateToOtpView,
                    ),
                    const InfoMessage(
                        infoText: "No account yet?",
                        actionString: "Sign up now"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom:
                      screenHeightFraction(context, dividedBy: 40, max: 10.0)),
              child: const SwechaFooter(),
            )
          ],
        ),
      ),
    );
  }

  @override
  SignInViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignInViewModel();

  @override
  void onDispose(SignInViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
