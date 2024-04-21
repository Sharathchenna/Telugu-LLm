import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/category/category.dart';
import 'package:swaram_ai/ui/widgets/common/recording/recording.dart';
import 'package:swaram_ai/ui/widgets/common/timer/timer.dart';

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
              Expanded(
                flex: 4,
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 2),
                  child: viewModel.isRecordStarted
                      ? const Timer()
                      : const Category(),
                ),
              ),
              const Expanded(
                flex: 3,
                child: Recording(),
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
