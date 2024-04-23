import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/info_message/info_message.dart';
import 'package:swaram_ai/ui/widgets/common/login_header/login_header.dart';
import 'package:swaram_ai/ui/widgets/common/primary_submit_button/primary_submit_button.dart';
import 'package:swaram_ai/ui/widgets/common/swecha_footer/swecha_footer.dart';

import 'otp_viewmodel.dart';

class OtpView extends StackedView<OtpViewModel> {
  const OtpView({super.key});

  @override
  Widget builder(
    BuildContext context,
    OtpViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 24.0,
              top: 12.0,
            ),
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
        ],
      ),
      backgroundColor: kcBackgroundColor,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const LoginHeader(
                  headerText: "Create your account",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "  Enter OTP",
                            style: GoogleFonts.montserrat(
                                color: kcTextDark2,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                      OTPTextField(
                        length: 5,
                        width: screenWidth(context),
                        fieldWidth: 54,
                        style: const TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.box,
                        otpFieldStyle: OtpFieldStyle(
                            backgroundColor: Colors.white,
                            borderColor: kcMediumGrey),
                        spaceBetween: 12.0,
                        onCompleted: (pin) {
                          viewModel.logger.i("Completed: $pin");
                        },
                        onChanged: (pin) {
                          viewModel.logger.i("On Change: $pin");
                        },
                      ),
                    ],
                  ),
                ),
                verticalSpaceMedium,
                PrimarySubmitButton(
                  buttonText: "Verify number",
                  onTap: viewModel.navigateToDashboardView,
                ),
                const InfoMessage(
                  infoText: "Already a memeber?",
                  actionString: "Sign in here",
                ),
              ],
            ),
            const SwechaFooter()
          ],
        ),
      ),
    );
  }

  @override
  OtpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OtpViewModel();
}
