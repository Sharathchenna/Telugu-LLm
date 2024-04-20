import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/chip_item/chip_item.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.menu,
          color: kcPrimaryBlueColor,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
              child: Image.asset(
                'assets/images/ai_logo.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Swaram AI',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: kcPrimaryBlueColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.cloud_off_sharp,
                  ),
                ),
                const Text("Offline"),
              ],
            ),
          ),
          horizontalSpaceSmall,
          Container(
            color: kcVeryBlueLightColor,
            child: IconButton(
              icon: SvgPicture.asset(
                colorFilter:
                    const ColorFilter.mode(kcPrimaryBlueColor, BlendMode.srcIn),
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
          horizontalSpaceSmall,
        ],
      ),
      body: SafeArea(
        top: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: screenWidth(context),
          height: screenHeight(context),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'What do you want to speak about?',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Select a category to get topic ideas, and start recording',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: const Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Wrap(
                        spacing: 13,
                        runSpacing: 13,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: [
                          ChipItem(),
                          ChipItem(),
                          ChipItem(),
                          ChipItem(),
                          ChipItem(),
                          ChipItem(),
                          ChipItem(),
                          ChipItem(),
                          ChipItem(),
                          ChipItem(),
                          ChipItem(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Say something, start recording.',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: kcTextDarkColor,
                        ),
                      ),
                      verticalSpaceTiny,
                      Text(
                        'Already know what to speak, just go ahead and record!',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: kcTextDarkColor,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 13, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                              fit: BoxFit.cover,
                              height:
                                  screenHeightFraction(context, dividedBy: 4),
                              filterQuality: FilterQuality.high,
                              repeat: true,
                              reverse: true,
                              "assets/lottie/mic_animation.json"),

                          // FlutterFlowIconButton(
                          //   borderColor: Color(0xFF387FCE),
                          //   borderRadius: 40,
                          //   borderWidth: 4,
                          //   buttonSize: 64,
                          //   fillColor: Color(0xFF4487D1),
                          //   hoverColor: Color(0xFF6699EE),
                          //   icon: Icon(
                          //     Icons.mic,
                          //     color: Colors.white,
                          //     size: 36,
                          //   ),
                          //   onPressed: () {
                          //     print('IconButton pressed ...');
                          //   },
                          // ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 0),
                            child: Text(
                              'Tap the mic to speak',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, -1),
                        child: Container(
                          width: 100,
                          height: 31,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: Color(0xFF696969),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // FaIcon(
                                //   FontAwesomeIcons.crown,
                                //   color: FlutterFlowTheme.of(context)
                                //       .secondaryText,
                                //   size: 20,
                                // ),
                                Text(
                                  '23',
                                  style: GoogleFonts.montserrat(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                        child: Text(
                          'Hours of Voice',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Container(
                          width: 100,
                          height: 31,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: Color(0xFF696969),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.stars_rounded,
                                  color: kcMediumGrey,
                                  size: 24,
                                ),
                                Text(
                                  '234',
                                  style: GoogleFonts.montserrat(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                        child: Text(
                          'Credit Score',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DashboardViewModel();
}
