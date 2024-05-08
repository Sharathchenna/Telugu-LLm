import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/my_app_bar/my_app_bar.dart';
import 'package:swaram_ai/ui/widgets/common/primary_button/primary_button.dart';

import 'memo_viewmodel.dart';

class MemoView extends StackedView<MemoViewModel> {
  const MemoView({super.key});

  @override
  Widget builder(
    BuildContext context,
    MemoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: viewModel.refreshItems,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PrimaryButton(
                    onTapHandler: viewModel.navigateBack,
                    iconData: Icons.arrow_back_ios_new,
                  ),
                  horizontalSpaceSmall,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recordings",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: kcTextDarkColor),
                      ),
                      Text(
                        "When online your recordigs will upload to cloud automatically",
                        overflow: TextOverflow.clip,
                        maxLines: null,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize:
                                getResponsiveFontSize(context, fontSize: 19),
                            color: kcDarkGreyColor),
                      )
                    ],
                  )
                ],
              ),
              verticalSpaceSmall,
              Expanded(
                child: FutureBuilder<Iterable<Recording>>(
                  future: viewModel.getRecordings(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("$snapshot.error");
                    } else {
                      return ListView.builder(
                        // padding: const EdgeInsets.only(left: 20),
                        itemBuilder: (_, index) {
                          return ListTile(
                            shape: const Border(
                                bottom: BorderSide(
                                    width: 0.3, color: kcDarkGreyColor)),
                            trailing: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: kcPrimaryBlueColor,
                            ),
                            leading: const Icon(
                              Icons.cloud_off,
                              color: kcMediumGrey,
                              size: 17,
                            ),
                            title: Text(
                              snapshot.data!.elementAt(index).name,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            subtitle: Text(
                              snapshot.data!.elementAt(index).status,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: kcDarkGreyColor,
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  @override
  MemoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MemoViewModel();
}
