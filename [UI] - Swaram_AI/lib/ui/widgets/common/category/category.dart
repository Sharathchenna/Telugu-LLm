import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'category_model.dart';

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
            'What do you want to speak about?',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        FittedBox(
          child: Text(
            'Select a category to get topic ideas, and start recording',
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
            child: Wrap(
              spacing: screenWidthFraction(context, dividedBy: 20),
              runSpacing: 15,
              children: viewModel.getCategoryData(),
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
