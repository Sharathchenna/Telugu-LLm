import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/primary_button/primary_button.dart';

import 'my_app_bar_model.dart';

class MyAppBar extends StackedView<MyAppBarModel>
    implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  void onViewModelReady(MyAppBarModel viewModel) {
    viewModel.networkService.initConnectivity();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    MyAppBarModel viewModel,
    Widget? child,
  ) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(color: kcDarkGreyColor, height: 0.6),
      ),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: viewModel.navigateToMemoScreen,
        child: const Icon(
          Icons.menu,
          color: kcPrimaryBlueColor,
        ),
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
            'Telugu Corpus',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: kcPrimaryBlueColor,
              fontSize: getResponsiveFontSize(context, fontSize: 40),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        viewModel.networkWidget,
        horizontalSpaceSmall,
        PrimaryButton(onTapHandler: () {}, iconData: FontAwesome.a_solid),
        horizontalSpaceSmall,
      ],
    );
  }

  @override
  MyAppBarModel viewModelBuilder(
    BuildContext context,
  ) =>
      MyAppBarModel();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
