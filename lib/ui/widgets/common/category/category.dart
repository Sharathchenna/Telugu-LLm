import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/chip_item/chip_item.dart';

import 'category_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Category extends StackedView<CategoryModel> {
  const Category({super.key});

  @override
  Widget builder(
    BuildContext context,
    CategoryModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            AppLocalizations.of(context)!.dashBoardHeading,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        FittedBox(
          child: Text(
            AppLocalizations.of(context)!.dashBoardSubHeading,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        verticalSpaceMedium,
        SizedBox(
          height: screenHeightFraction(
            context,
            dividedBy: 3,
          ),
          child: SingleChildScrollView(
            child: FutureBuilder<List<ChipItem>>(
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kcPrimaryBlueColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return Wrap(
                      spacing: screenWidthFraction(context, dividedBy: 20),
                      runSpacing: 15,
                      children: snapshot.data!);
                }
              },
              future: viewModel.getCategoryData(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  CategoryModel viewModelBuilder(
    BuildContext context,
  ) =>
      CategoryModel();
}
